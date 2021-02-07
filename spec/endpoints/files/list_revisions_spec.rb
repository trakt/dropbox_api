# frozen_string_literal: true
describe DropboxApi::Client, '#list_revisions' do
  before :each do
    @client = DropboxApi::Client.new
  end

  it 'returns a ListRevisionsResult', cassette: 'list_revisions/success' do
    result = @client.list_revisions '/file.txt'

    expect(result).to be_a(DropboxApi::Results::ListRevisionsResult)
  end

  it "raises an error if the file can't be found", cassette: 'list_revisions/not_found' do
    expect {
      @client.list_revisions '/unexisting_file'
    }.to raise_error(DropboxApi::Errors::NotFoundError)
  end

  it 'returns all revisions as metadata objects', cassette: 'list_revisions/success' do
    result = @client.list_revisions '/file.txt'

    result.entries.each do |resource|
      expect(resource).to be_a(DropboxApi::Metadata::Base)
    end
  end

  it 'indicates if the file has been deleted', cassette: 'list_revisions/success' do
    result = @client.list_revisions '/file.txt'

    expect(result.is_deleted?).to be_truthy
  end
end
