# frozen_string_literal: true
module DropboxApi::Results
  class SearchResult < DropboxApi::Results::Base
    # A list (possibly empty) of matches for the query.
    def matches
      @matches ||= @data['matches'].map do |match|
        DropboxApi::Results::Search::Match.new match
      end
    end

    # Used for paging. Value to set the start argument to when calling search
    # to fetch the next page of results.
    def start
      @data['start'].to_i
    end

    # Used for paging. If true, indicates there is another page of results
    # available that can be fetched by calling search again.
    def has_more?
      @data['more'].to_s == 'true'
    end
  end
end
