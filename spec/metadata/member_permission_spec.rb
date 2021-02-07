# frozen_string_literal: true
context DropboxApi::Metadata::MemberPermission do
  it 'can be initialized from a hash' do
    hash = {
      'action' => {
        '.tag' => 'remove'
      },
      'allow' => false,
      'reason' => {
        '.tag' => 'target_is_self'
      }
    }

    member_permission = DropboxApi::Metadata::MemberPermission.new hash

    expect(member_permission).to be_a(DropboxApi::Metadata::MemberPermission)
    expect(member_permission.action).to eq(:remove)
    expect(member_permission.allow).to be_falsey
  end
end
