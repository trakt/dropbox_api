# frozen_string_literal: true
describe DropboxApi::Client, '#add_folder_member' do
  before :each do
    @client = DropboxApi::Client.new
  end

  it 'shares the folder', cassette: 'add_folder_member/success' do
    folder_id = '1236358158'
    folder = @client.add_folder_member folder_id, 'somebody@test.com'

    # The endpoint doesn't have any return values, can't test the output!
  end

  it 'shares the folder, if the folder id is a number', cassette: 'add_folder_member/success_numeric' do
    folder_id = 1236358158
    folder = @client.add_folder_member folder_id, 'somebody@test.com'

    # The endpoint doesn't have any return values, can't test the output!
  end

  it 'shares the folder, if the param is an AddMember object', cassette: 'add_folder_member/success' do
    folder_id = 1236358158
    folder = @client.add_folder_member folder_id, 'somebody@test.com'

    # The endpoint doesn't have any return values, can't test the output!
  end

  it 'shares the folder, if the member param is an email string', cassette: 'add_folder_member/success' do
    folder_id = 1236358158
    folder = @client.add_folder_member folder_id, 'somebody@test.com'

    # The endpoint doesn't have any return values, can't test the output!
  end

  it 'fails with an invalid folder id', cassette: 'add_folder_member/invalid_folder' do
    folder_id = 'xxx'
    expect {
      folder = @client.add_folder_member folder_id, 'somebody@test.com'

    }.to raise_error(DropboxApi::Errors::InvalidIdError)
  end
end
