# frozen_string_literal: true
describe DropboxApi::Client, "#list_folder_longpoll" do
  before :each do
    @client = DropboxApi::Client.new
  end

  before :each do
    VCR.use_cassette("list_folder_longpoll/list_folder") do
      @cursor = @client.list_folder("").cursor
    end
  end

  it "returns a ListFolderLongpollResult", cassette: "list_folder_longpoll/success" do
    result = @client.list_folder_longpoll @cursor

    expect(result).to be_a(DropboxApi::Results::ListFolderLongpollResult)
  end

  it "indicates if there're changes", cassette: "list_folder_longpoll/success" do
    result = @client.list_folder_longpoll @cursor

    expect(result.changes).to be_truthy
  end

  it "raises an error with an invalid cursor", cassette: "list_folder_longpoll/reset" do
    expect {
      @client.list_folder_longpoll "I believe in the blerch"
    }.to raise_error DropboxApi::Errors::HttpError
  end
end
