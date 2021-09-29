# frozen_string_literal: true
module DropboxApi
  describe Client do
    it 'can have custom connection middleware' do
      # Mock middleware
      MiddlewareStart = Class.new
      MiddlewareMiddle = Class.new
      MiddlewareEnd = Class.new

      # Attach a dummy endpoint that will return the internal connection builder
      connection_builder_endpoint = Struct.new(:connection_builder)
      Client.add_endpoint :connection_builder, connection_builder_endpoint

      client = Client.new

      # Configure middleware
      client.middleware.prepend { |faraday| faraday.use MiddlewareStart }
      client.middleware.append { |faraday| faraday.use MiddlewareEnd }
      client.middleware.adapter = :net_http_persistent

      # Insert middleware as an endpoint might
      connection = client.connection_builder.build('http://example.org') do |faraday|
        faraday.use MiddlewareMiddle
      end

      expect(connection.builder).to eq(Faraday::RackBuilder.new(
        [
          DropboxApi::MiddleWare::PathRoot,
          MiddlewareStart,
          MiddlewareMiddle,
          MiddlewareEnd
        ],
        Faraday::Adapter::NetHttpPersistent
      ))
    end

    it 'will raise on 401 if there is no refresh token', cassette: 'client/raise_on_401' do
      client = Client.new("MOCK_EXPIRED_AUTHORIZATION_BEARER")

      expect do
        client.list_folder ""
      end.to raise_error(DropboxApi::Errors::ExpiredAccessTokenError)
    end
  end
end
