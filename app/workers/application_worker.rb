class ApplicationWorker
  include Sidekiq::Worker

  # Add any common configuration or behavior for all workers here

  # Optional method
  def self.before_perform(*args)
    # You can add any shared setup or logic here
  end
end