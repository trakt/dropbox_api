# frozen_string_literal: true
describe DropboxApi::Client, "#unshare_file" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "unshares the file", cassette: "unshare_file/success" do
    file = @client.unshare_file("id:xyz123")

    # The endpoint doesn't have any return values, can't test the output!
  end

  it "returns file access permission error", cassette: "unshare_file/error_no_permission" do
    expect {
      @client.unshare_file("id:xyz123")
    }.to raise_error(DropboxApi::Errors::NoPermissionError)
  end

  it "returns email unverified error", cassette: "unshare_file/error_email_unverified" do
    expect {
      @client.unshare_file("id:xyz123")
    }.to raise_error(DropboxApi::Errors::EmailUnverifiedError)
  end
end
