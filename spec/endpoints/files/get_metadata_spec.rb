# frozen_string_literal: true
describe DropboxApi::Client, '#get_metadata' do
  let(:path_prefix) { DropboxScaffoldBuilder.prefix_for :get_metadata }
  before :each do
    @client = DropboxApi::Client.new
  end

  it 'may return a `File`', cassette: 'get_metadata/success_file' do
    file = @client.get_metadata("#{path_prefix}/file.txt")

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq('file.txt')
  end

  it 'will parse time specific fields', cassette: 'get_metadata/success_file' do
    file = @client.get_metadata("#{path_prefix}/file.txt")

    expect(file.client_modified).to eq(Time.new(1988, 12, 8, 1, 1, 0, '+00:00'))
  end

  it 'may return a `Folder`', cassette: 'get_metadata/success_folder' do
    folder = @client.get_metadata("#{path_prefix}/folder")

    expect(folder).to be_a(DropboxApi::Metadata::Folder)
    expect(folder.name).to eq('folder')
  end

  it 'raises an error if the path is wrong', cassette: 'get_metadata/not_found' do
    expect {
      @client.get_metadata("#{path_prefix}/unexisting_folder")
    }.to raise_error(DropboxApi::Errors::NotFoundError)
  end

  it 'raises an error if an invalid option is given' do
    expect {
      @client.get_metadata("#{path_prefix}/file.txt", invalid_option: true)
    }.to raise_error ArgumentError
  end

  context 'on a deleted file' do
    it 'raises an error', cassette: 'get_metadata/deleted' do
      expect {
        @client.get_metadata("#{path_prefix}/deleted_file.txt")
      }.to raise_error(DropboxApi::Errors::NotFoundError)
    end

    it 'with `:include_deleted`, returns a `File`', cassette: 'get_metadata/success_deleted' do
      file = @client.get_metadata("#{path_prefix}/deleted_file.txt", include_deleted: true)

      expect(file).to be_a(DropboxApi::Metadata::Deleted)
      expect(file.name).to eq('deleted_file.txt')
    end
  end
end
