class BppClient
  class Configuration
    attr_accessor :base_host

    def initialize
      @base_host = "http://0.0.0.0:3000"
    end
  end

  def self.configuration
    @@configuration ||= Configuration.new
  end

  def self.config
    yield(configuration)
  end
end
