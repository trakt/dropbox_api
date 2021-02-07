# frozen_string_literal: true
context DropboxApi::Metadata::Resource do
  context "with metadata from a file" do
    it "initializes a File" do
      metadata = {
        ".tag" => "file",
        "name" => "visrez-video.mp4",
        "path_lower" => "/visrez-video.mp4",
        "path_display" => "/visrez-video.mp4",
        "id" => "id:ARSNw7QJjrAAAAAAAAAAAQ",
        "client_modified" => "2016-05-22T09:31:26Z",
        "server_modified" => "2016-05-22T09:31:26Z",
        "rev" => "2c824061bdd",
        "size" => 1136802
      }

      resource = DropboxApi::Metadata::Resource.new metadata

      expect(resource).to be_a(DropboxApi::Metadata::File)
    end
  end

  context "with metadata from a folder" do
    it "initializes a Folder" do
      metadata = {
        ".tag" => "folder",
        "id" => "id:evvfE6q6cK0AAAAAAAAAS3",
        "name" => "Holiday Pictures",
        "path_lower" => "/holiday pictures",
        "path_display" => "/Holiday Pictures"
      }

      resource = DropboxApi::Metadata::Resource.new metadata

      expect(resource).to be_a(DropboxApi::Metadata::Folder)
    end
  end
end
