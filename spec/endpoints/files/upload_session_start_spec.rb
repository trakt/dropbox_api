# frozen_string_literal: true
describe DropboxApi::Client, "#upload_session_start" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns a session", :cassette => "upload_session_start/success" do
    cursor = @client.upload_session_start("Hello Dropbox!")

    expect(cursor).to be_a(DropboxApi::Metadata::UploadSessionCursor)
    expect(cursor.session_id).to eq("AAAAAAAMOCK_SESSION_ID")
  end
end
