# frozen_string_literal: true
describe DropboxApi::Client, "#get_account" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns the account information", :cassette => "get_account/success" do
    account = @client.get_account "dbid:AAAKVPLEKkkccsZMFkkZNXFeyXrPPhrtFxs"

    expect(account).to be_a(DropboxApi::Metadata::BasicAccount)
  end

  it "raises an error if the account can't be found", :cassette => "get_account/no_account" do
    expect {
      @client.get_account "dbid:AAAKVPLEKkkccsZMFkkZNXFeyXrPPhrtXXX"
    }.to raise_error(DropboxApi::Errors::NoAccountError)
  end
end
