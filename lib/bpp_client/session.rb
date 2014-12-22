class BppClient::Session < ActiveResource::Base
  class InvalidCredentials < StandardError; end

  self.site = "http://localhost:3000/api/v2"
  self.collection_name = "authentication"

  attr_reader :token

  def save
    response = create.body
    token = JSON.parse(response)["token"]
  rescue ActiveResource::ResourceInvalid
    raise InvalidCredentials
  end
end