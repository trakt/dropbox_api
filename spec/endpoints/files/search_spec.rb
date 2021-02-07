# frozen_string_literal: true
describe DropboxApi::Client, '#search' do
  before :each do
    @client = DropboxApi::Client.new
  end

  it 'returns a list of matching results', cassette: 'search/success' do
    result = @client.search('findable_file')

    expect(result).to be_a(DropboxApi::Results::SearchV2Result)
    match = result.matches.first
    expect(match.resource.name).to eq('findable_file.txt')
    expect(match.match_type).to eq(:filename)
  end

  it "raises an error if the file can't be found",
     cassette: 'search/not_found' do
    options = DropboxApi::Metadata::SearchOptions.new(
      { 'path' => '/bad_folder' }
    )

    result = @client.search('/image.png', options)
    expect(result.matches).to be_empty
  end
end
