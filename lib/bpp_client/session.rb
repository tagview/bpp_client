class BppClient::Session
  class InvalidCredentials < StandardError; end
  class Repository < ActiveResource::Base
    self.site = "#{BppClient.configuration.base_host}/api/v2"
    self.collection_name = "authentication"

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
  end
end
