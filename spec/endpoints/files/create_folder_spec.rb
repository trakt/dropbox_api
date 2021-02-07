# frozen_string_literal: true
describe DropboxApi::Client, '#create_folder' do
  before :each do
    @client = DropboxApi::Client.new
  end

  it 'returns the new folder on success', cassette: 'create_folder/success' do
    folder = @client.create_folder('/arizona_baby')

    expect(folder).to be_a(DropboxApi::Metadata::Folder)
    expect(folder.name).to eq('arizona_baby')
  end

  it 'raises an error if the name is invalid', cassette: 'create_folder/malformed_path' do
    expect {
      @client.create_folder('/arizona\\baby')
    }.to raise_error(DropboxApi::Errors::MalformedPathError)
  end

  it 'raises an error if the resource causes a conflict', cassette: 'create_folder/conflict' do
    expect {
      @client.create_folder('/b.jpg')
    }.to raise_error(DropboxApi::Errors::FileConflictError)
  end
end
