# frozen_string_literal: true
module DropboxApi
  describe Authenticator do
    before :each do
      # These details belong to an account I manually created for testing
      client_id = "CLIENT_ID"
      client_secret = "CLIENT_SECRET"

      @authenticator = DropboxApi::Authenticator.new(client_id, client_secret)
    end

    it 'successfully generates a short lived token', cassette: 'authenticator/success_with_short_lived_token' do
      # At this point we could get an authorization URL with:
      # `@authenticator.auth_code.authorize_url` # => 'https://www.dropbox...'

      # The URL above gave us the following access code:
      access_code = "ACCESS_CODEhVAVTMlCvO0Qs"

      access_token = @authenticator.auth_code.get_token(access_code)

      expect(access_token).to be_a(OAuth2::AccessToken)
      expect(access_token.token).to eq("MOCK_ACCESS_TOKEN")
      expect(access_token.refresh_token).to be_nil
    end

    it 'successfully generates a refresh token', cassette: 'authenticator/success_with_refresh_token' do
      # We now get an authorization URL with:
      # `@authenticator.auth_code.authorize_url(token_access_type: 'offline')`

      # We got the following access code:
      access_code = "ACCESS_CODEpLfs_y4vgnb3M"

      access_token = @authenticator.auth_code.get_token(access_code)

      expect(access_token).to be_a(OAuth2::AccessToken)
      expect(access_token.token).to eq("MOCK_ACCESS_TOKEN")
      expect(access_token.refresh_token).to eq("MOCK_REFRESH_TOKEN")
    end
  end
end
