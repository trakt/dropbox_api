# frozen_string_literal: true
describe DropboxApi::Client, "#search" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns a list of matching results", :cassette => "search/success" do
    result = @client.search("image.png")

    expect(result).to be_a(DropboxApi::Results::SearchResult)
    file = result.matches.first.resource
    expect(file.name).to eq("image.png")
  end

  it "raises an error if the file can't be found", :cassette => "search/not_found" do
    expect {
      @client.search("/image.png", "/bad_folder")
    }.to raise_error(DropboxApi::Errors::NotFoundError)
  end
end
