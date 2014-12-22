require "spec_helper"

describe BppClient::Session do
  let(:email) { "teste@bpp.com.br" }
  let(:password) { "password" }
  let(:session_repository) { instance_spy BppClient::Session::Repository }

  subject { BppClient::Session.new(email: email, password: password) }

  before { allow(subject).to receive(:repository).and_return session_repository }

  it "has a blank token" do
    expect(subject).to respond_to(:token)
    expect(subject.token).to be_nil
  end

  describe "#save" do
    context "with valid credentials" do
      let(:token) { "abc123" }
      let(:valid_response) { double Net::HTTPResponse, body: { "token" => token }.to_json }

      before do
        allow(session_repository).to receive(:save).and_return valid_response
        subject.save
      end

      it "saves the token" do
        expect(subject.token).to eq token
      end
    end

    context "with invalid credentials" do
      before do
        allow(session_repository).to receive(:save).and_raise ActiveResource::ResourceInvalid.new("Error")
      end

      it "raises InvalidCredentials error" do
        expect { subject.save }.to raise_error(BppClient::Session::InvalidCredentials)
      end
    end
  end
end
