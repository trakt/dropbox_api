# frozen_string_literal: true
describe DropboxApi::Client, "#upload_session_finish" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "will create a file", cassette: "upload_session_finish/success" do
    cursor = @client.upload_session_start("Hello Dropbox!")
    commit = DropboxApi::Metadata::CommitInfo.new({
      "path" => "/Homework/math/Matrices.txt",
      "mode" => :add
    })

    file = @client.upload_session_finish(cursor, commit)

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq("Matrices.txt")
  end
end
