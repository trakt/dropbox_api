require 'byebug'

# frozen_string_literal: true
describe DropboxApi::Client, '#list_folder_longpoll' do
  let(:path_prefix) { DropboxScaffoldBuilder.prefix_for :list_folder_longpoll }
  before :each do
    @client = DropboxApi::Client.new
  end

  before :each do
    VCR.use_cassette('list_folder_longpoll/list_folder') do
      @cursor = @client.list_folder(path_prefix).cursor
    end
  end

  it 'returns a ListFolderLongpollResult', cassette: 'list_folder_longpoll/success' do
    result = nil
    [
      Thread.new {
        result = @client.list_folder_longpoll @cursor
      },
      Thread.new {
        sleep 1 # make sure the other request had time to start
        @client.upload("#{path_prefix}/duck.txt", 'Quack!')
      }
    ].each(&:join)

    expect(result).to be_a(DropboxApi::Results::ListFolderLongpollResult)
    expect(result.changes).to be_truthy
  end

  it 'raises an error with an invalid cursor', cassette: 'list_folder_longpoll/reset' do
    expect {
      @client.list_folder_longpoll 'I believe in the blerch'
    }.to raise_error DropboxApi::Errors::HttpError
  end
end
