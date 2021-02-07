# frozen_string_literal: true
describe DropboxApi::Client, "#list_folder_get_latest_cursor" do
  before :each do
    @client = DropboxApi::Client.new
  end

  before :each do
    VCR.use_cassette "list_folder_get_latest_cursor/list_folder" do
      result = @client.list_folder "/folder"
      @cursor = result.cursor
    end
  end

  it "returns a ListFolderGetLatestCursorResult", :cassette => "list_folder_get_latest_cursor/success" do
    result = @client.list_folder_get_latest_cursor :path => "/folder"

    expect(result)
      .to be_a(DropboxApi::Results::ListFolderGetLatestCursorResult)
  end
end
