# frozen_string_literal: true
require 'oauth2'

module DropboxApi
  class Authenticator < OAuth2::Client
    extend Forwardable

    def initialize(client_id, client_secret)
      @auth_code = OAuth2::Client.new(client_id, client_secret, {
        authorize_url: 'https://www.dropbox.com/oauth2/authorize',
        token_url: 'https://api.dropboxapi.com/oauth2/token'
      }).auth_code
    end

    def_delegators :@auth_code, :authorize_url, :get_token
  end
end
