require 'uri'

class ScrapePageWorker
  include Sidekiq::Worker

  def perform(page_id)
    page = Page.find(page_id)
    link = page.link

    return unless has_html_elements?(link)

    begin
      page_name, url = extract_page_info(link)
      scrape_links(page, url)

      total_links = page.links.count
      page.update(total_links: total_links, done: true, title: page_name)
    rescue StandardError => e
      Rails.logger.error "Error scraping page id: #{page_id} - #{e.message}"
      raise e
    end
  end

  private

  def extract_page_info(link)
    doc = Nokogiri::HTML(link)
    data = doc.at('a')
    url = data['href']
    page_name = data.css('*').empty? ? data.inner_html.strip : Nokogiri::HTML(doc.children.inner_html).text.strip

    [page_name, url]
  end

  def scrape_links(page, url)
    response = HTTParty.get(url)
    scrape_page = Nokogiri::HTML(response.body)

    scrape_page.css('a').each do |link|
      name = link.text
      url = link['href']

      if url && (url.start_with?('http://') || url.start_with?('https://'))
        puts url
        puts name
        Link.create(page: page, name: name, url: url)
      end
    end
  end

  def has_html_elements?(text)
    !text.scan(/<[^>]+>/).empty?
  end
end
