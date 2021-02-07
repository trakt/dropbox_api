# frozen_string_literal: true
describe DropboxApi::Client, "#get_temporary_link" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns a GetTemporaryLinkResult with file and link", cassette: "get_temporary_link/success" do
    result = @client.get_temporary_link "/img.png"

    expect(result).to be_a(DropboxApi::Results::GetTemporaryLinkResult)
    expect(result.file.name).to eq("img.png")
  end

  it "raises an error if the file can't be found", cassette: "get_temporary_link/not_found" do
    expect {
      @client.get_preview "/unknown_file.jpg"
    }.to raise_error(DropboxApi::Errors::NotFoundError)
  end
end
