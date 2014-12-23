class BppClient::Session
  class SessionError < StandardError; end
  class InvalidCredentials < StandardError; end
  class Repository < ActiveResource::Base
    self.collection_name = "authentication"

    def initialize(**kwargs)
      self.class.site = "#{BppClient.configuration.base_host}/api/v2"
      super
    end

    def save
      create
    end
  end

  attr_reader :token

  def initialize(email:, password:)
    @email = email
    @password = password
  end

  def repository
    @repository = Repository.new(email: @email, password: @password)
  end

  def save
    response = repository.save
    @token = JSON.parse(response.body)["token"]
  rescue ActiveResource::ResourceInvalid
    raise InvalidCredentials
  rescue ActiveResource::ClientError => e
    raise SessionError, e.message
  end
end
