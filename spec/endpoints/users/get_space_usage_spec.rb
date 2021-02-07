# frozen_string_literal: true
describe DropboxApi::Client, "#get_current_account" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns the account usage information", cassette: "get_space_usage/success" do
    space_usage = @client.get_space_usage

    expect(space_usage).to be_a(DropboxApi::Metadata::SpaceUsage)
  end
end
