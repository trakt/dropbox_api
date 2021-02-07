# frozen_string_literal: true
require 'dropbox_api'
require 'support/vcr'
require 'tempfile'
require File.expand_path('../support/dropbox_scaffold_builder', __FILE__)

ENV['DROPBOX_OAUTH_BEARER'] ||= 'MOCK_AUTHORIZATION_BEARER'
