# frozen_string_literal: true
describe DropboxApi::Client, "#download" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns the file", :cassette => "download/success" do
    file = @client.download "/file.txt"

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq("file.txt")
  end

  it "yields the file contents", :cassette => "download/success" do
    file_contents = ""
    file = @client.download "/file.txt" do |chunk|
      file_contents << chunk
    end

    expect(file_contents).to eq("Viva Rusia!\n")
  end

  it "raises an error if the name is invalid", :cassette => "download/not_found" do
    expect {
      @client.download("/c.jpg")
    }.to raise_error(DropboxApi::Errors::NotFoundError)
  end
end
