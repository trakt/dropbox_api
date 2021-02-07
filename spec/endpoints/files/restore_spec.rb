# frozen_string_literal: true
describe DropboxApi::Client, "#restore" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns the restored file on success", cassette: "restore/success" do
    # "/file.txt" has two revisions: ["1a6b24061bdd", "1a6a24061bdd"]
    file = @client.restore("/file.txt", "1a6a24061bdd")

    expect(file).to be_a(DropboxApi::Metadata::File)
  end

  it "raises an error with an invalid revision", cassette: "restore/invalid_revision" do
    expect {
      file = @client.restore("/file.txt", "1a6a24061000")
    }.to raise_error(DropboxApi::Errors::InvalidRevisionError)
  end
end
