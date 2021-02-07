# frozen_string_literal: true
describe DropboxApi::Client, "#get_account_batch" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns account information of all given IDs", :cassette => "get_account_batch/success" do
    test_accounts = {
      "dbid:AACiYqkuK0t_wIvlr9BduHKdhzk_H28Dg0U" => "Antonio Hidalgo",
      "dbid:AAAKVPLEKkkccsZMFkkZNXFeyXrPPhrtFxs" => "Jesus Burgos"
    }
    accounts = @client.get_account_batch test_accounts.keys

    accounts.each do |account|
      expect(account).to be_a(DropboxApi::Metadata::BasicAccount)
      expect(account.name.display_name)
        .to eq(test_accounts[account.account_id])
    end
  end

  it "raises an error if one account can't e found", :cassette => "get_account_batch/no_account" do
    account_ids = %w(
      dbid:AAAKVPLEKkkccsZMFkkZNXFeyXrPPhrtXXX
      dbid:AAAKVPLEKkkccsZMFkkZNXFeyXrPPhrtFxs
    )

    expect {
      @client.get_account_batch account_ids
    }.to raise_error(DropboxApi::Errors::NoAccountError)
  end
end
