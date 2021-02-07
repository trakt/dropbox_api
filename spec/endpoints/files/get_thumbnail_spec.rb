# frozen_string_literal: true
describe DropboxApi::Client, '#get_thumbnail' do
  before :each do
    @client = DropboxApi::Client.new
  end

  it 'returns a file', cassette: 'get_thumbnail/success' do
    file = @client.get_thumbnail '/img.png'

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq('img.png')
  end

  it "raises an error if the file can't be found", cassette: 'get_thumbnail/not_found' do
    expect {
      @client.get_thumbnail '/unknown_file.jpg'
    }.to raise_error(DropboxApi::Errors::NotFoundError)
  end

  it 'raises an argument error with invalid options' do
    expect {
      @client.get_thumbnail '/img.png', invalid_arg: 'value'
    }.to raise_error(ArgumentError)
  end
end
