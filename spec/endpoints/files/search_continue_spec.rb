# frozen_string_literal: true
describe DropboxApi::Client, '#search_continue' do
  before :each do
    @client = DropboxApi::Client.new
  end

  before :each do
    VCR.use_cassette('search_continue/search') do
      result = @client.search '/folder'
      expect(result.has_more?).to be_truthy
      @cursor = result.cursor
    end
  end

  it 'returns a SearchResult', cassette: 'search_continue/success' do
    result = @client.search_continue(@cursor)

    expect(result).to be_a(DropboxApi::Results::SearchResult)
  end
end
