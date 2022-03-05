# frozen_string_literal: true
if Gem::Requirement.new('>= 2.0').satisfied_by? Gem.loaded_specs['faraday'].version
  require 'faraday/net_http_persistent'
end


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

      expect(connection.builder.adapter).to eq(Faraday::Adapter::NetHttpPersistent)
      expect(connection.builder.handlers).to eq([
        DropboxApi::MiddleWare::PathRoot,
        MiddlewareStart,
        Faraday::Request::Authorization,
        MiddlewareMiddle,
        MiddlewareEnd
      ])
    end

    describe "Refreshing access tokens" do
      before :each do
        client_id = "CLIENT_ID"
        client_secret = "CLIENT_SECRET"
        @authenticator = DropboxApi::Authenticator.new(client_id, client_secret)
      end

      it 'will raise on 401 if there is no refresh token', cassette: 'client/raise_on_401' do
        client = Client.new("MOCK_EXPIRED_AUTHORIZATION_BEARER")

        expect do
          client.list_folder ""
        end.to raise_error(DropboxApi::Errors::ExpiredAccessTokenError)
      end

      it 'will refresh the access token if expired', cassette: 'client/refresh_token_if_expired' do
        token_hash = {
          "uid" => "44076342",
          "token_type" => "bearer",
          "scope" => "account_info.read account_info.write contacts.read contacts.write file_requests.read file_requests.write files.content.read files.content.write files.metadata.read files.metadata.write sharing.read sharing.write",
          "account_id" => "dbid:AABOLtA1rT6rRK4vakdslWqLZ7wVnV863u4",
          :access_token => "MOCK_ACCESS_TOKEN",
          :refresh_token => "MOCK_REFRESH_TOKEN",
          :expires_at => 1232946918
        }

        access_token = OAuth2::AccessToken.from_hash(@authenticator, token_hash)

        new_token_hash = nil
        client = Client.new(
          access_token: access_token,
          on_token_refreshed: lambda { |token_hash|
            new_token_hash = token_hash
          }
        )
        result = client.list_folder ""

        expect(result).to be_a(DropboxApi::Results::ListFolderResult)
        expect(new_token_hash[:access_token]).to eq("MOCK_ACCESS_TOKEN")
      end

      it 'will refresh the access token on 401', cassette: 'client/refresh_token_on_401' do
        token_hash = {
          "uid" => "44076342",
          "token_type" => "bearer",
          "scope" => "account_info.read account_info.write contacts.read contacts.write file_requests.read file_requests.write files.content.read files.content.write files.metadata.read files.metadata.write sharing.read sharing.write",
          "account_id" => "dbid:AABOLtA1rT6rRK4vajKZrWqLZ7wVnV863u4",
          :access_token => "MOCK_ACCESS_TOKEN",
          :refresh_token => "MOCK_REFRESH_TOKEN",
          :expires_at => 1732948328
        }

        access_token = OAuth2::AccessToken.from_hash(@authenticator, token_hash)

        new_token_hash = nil
        client = Client.new(
          access_token: access_token,
          on_token_refreshed: lambda { |token_hash|
            new_token_hash = token_hash
          }
        )

        # The following uses a VCR recording with a 401, then the client
        # refreshes the token and retries. So it seamlessly works making
        # the refresh unnoticeable.
        result = client.list_folder ""

        expect(result).to be_a(DropboxApi::Results::ListFolderResult)
        # Verify that the callback gets called on token refresh...
        expect(new_token_hash[:access_token]).to eq("MOCK_REFRESHED_ACCESS_TOKEN")
      end
    end
  end
end
