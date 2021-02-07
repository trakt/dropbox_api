# frozen_string_literal: true
describe DropboxApi::Client, '#get_preview' do
  before :each do
    @client = DropboxApi::Client.new
  end

  it 'returns the file', cassette: 'get_preview/success' do
    file = @client.get_preview('/file.docx')

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq('file.docx')
  end

  it 'raises an error if the name is invalid', cassette: 'get_preview/not_found' do
    expect {
      @client.get_preview('/unknown_file.jpg')
    }.to raise_error(DropboxApi::Errors::NotFoundError)
  end
end
