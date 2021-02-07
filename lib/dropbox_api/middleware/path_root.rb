# frozen_string_literal: true
module DropboxApi::MiddleWare
  class PathRoot < Faraday::Middleware
    HEADER_NAME = 'Dropbox-API-Path-Root'

    def initialize(app, options = {})
      super(app)
      @options = options
    end

    def namespace_id
      if options[:namespace_id].nil?
        return nil
      else
        return options[:namespace_id]
      end
    end

    def call(env)
      if !namespace_id.nil?
        # TODO serialize properly...
        env[:request_headers][HEADER_NAME] ||= "{\".tag\": \"namespace_id\", \"namespace_id\": \"#{namespace_id}\"}"
      end

      @app.call env
    end
  end
end
