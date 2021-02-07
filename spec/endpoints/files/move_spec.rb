# frozen_string_literal: true
describe DropboxApi::Client, "#move" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns the moved file on success", cassette: "move/success_file" do
    file = @client.move("/img.png", "/image.png")

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq("image.png")
  end

  it "returns the moved folder on success", cassette: "move/success_folder" do
    file = @client.move("/folder", "/test/folder")

    expect(file).to be_a(DropboxApi::Metadata::Folder)
    expect(file.name).to eq("folder")
  end

  it "renames the moved file if required", cassette: "move/success_rename" do
    file = @client.move("/a.jpg", "/photo.jpg", autorename: true)

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq("photo (1).jpg")
  end

  it "raises an error if the file can't be found", cassette: "move/not_found" do
    expect {
      @client.move("/z.jpg", "/b.jpg")
    }.to raise_error(DropboxApi::Errors::NotFoundError)
  end
end
