# frozen_string_literal: true
describe DropboxApi::Client, "#add_file_member" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "adds 1 member to a file", :cassette => "add_file_member/success_1" do
    file = "/bsd.pdf"
    members = @client.add_file_member(file, "a@test.com")

    expect(members)
      .to be_a(DropboxApi::Results::AddFileMemberResultList)
    expect(members.first)
      .to be_a(DropboxApi::Metadata::AddFileMemberResult)
    expect(members.first.result)
      .to eq(:viewer)
  end

  it "adds 2 members to a file", :cassette => "add_file_member/success_2" do
    file = "/bsd.pdf"
    members = @client.add_file_member(file, %w(a@test.com b@test.com))

    expect(members)
      .to be_a(DropboxApi::Results::AddFileMemberResultList)
    expect(members.map(&:class).uniq)
      .to eq([DropboxApi::Metadata::AddFileMemberResult])
    expect(members.map(&:result).uniq)
      .to eq([:viewer])
  end

  it "adds a member with comment", :cassette => "add_file_member/success_comment" do
    file = "/bsd.pdf"
    members = @client.add_file_member file,
                                      "a@test.com",
                                      :custom_message => "See my file down here."

    expect(members)
      .to be_a(DropboxApi::Results::AddFileMemberResultList)
  end

  it "adds a member with access level", :cassette => "add_file_member/error_no_permission" do
    file = "/bsd.pdf"

    # Using :viewer_no_comment as access level will fail with no_permission.
    expect {
      @client.add_file_member file,
                              "a@test.com",
                              :access_level => :viewer_no_comment
    }.to raise_error(DropboxApi::Errors::NoPermissionError)
  end
end
