require 'uri'
class ScrapePageWorker
  include Sidekiq::Worker

  def perform(page_id)
    page = Page.find(page_id)

    if !has_html_elements?(page.link)
      puts "Page #{page_id} is not HTML elements, skipping"
      return
    end

    begin
      doc = Nokogiri::HTML(page.link)
      data = doc.at('a')
      url = data['href']
      page_name = !data.css('*').empty? ? data.inner_html.strip :  Nokogiri::HTML(doc.children.inner_html).text.strip

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
      total_links = page.links.count
      page.update(total_links: total_links, done: true, title: page_name)
    rescue StandardError => e
      Rails.logger.error "Error scraping page id: #{page_id} - #{e.message}"
      raise e
    end
  end

  def has_html_elements?(text)
    html_tag_pattern = /<[^>]+>/

    html_tags = text.scan(html_tag_pattern)

    !html_tags.empty?
  end
end
