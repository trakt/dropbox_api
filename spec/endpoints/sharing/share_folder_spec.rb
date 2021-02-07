# frozen_string_literal: true
describe DropboxApi::Client, "#share_folder" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns the shared folder", :cassette => "share_folder/success" do
    folder = @client.share_folder("/folder_k")

    expect(folder).to be_a(DropboxApi::Metadata::SharedFolder)
  end

  it "returns the shared folder, even if already shared", :cassette => "share_folder/bad_path" do
    folder = @client.share_folder("/already_shared")

    expect(folder).to be_a(DropboxApi::Metadata::SharedFolder)
  end

  it "contains a shared folder id", :cassette => "share_folder/success" do
    folder = @client.share_folder("/folder_k")

    expect(folder.shared_folder_id.to_s)
      .to eq("1236414195") # taken from fixture (share_folder/success.yml)
  end
end
