# frozen_string_literal: true
describe DropboxApi::Client, '#list_folder_continue' do
  before :each do
    @client = DropboxApi::Client.new
  end

  before :each do
    VCR.use_cassette('list_folder_continue/list_folder') do
      result = @client.list_folder '/folder'
      expect(result.has_more?).to be_truthy
      @cursor = result.cursor
    end
  end

  it 'returns a ListFolderResult', cassette: 'list_folder_continue/success' do
    result = @client.list_folder_continue(@cursor)

    expect(result).to be_a(DropboxApi::Results::ListFolderResult)
  end
end
