# frozen_string_literal: true
describe DropboxApi::Metadata::UploadSessionCursor do
  it 'can be initialized from a Hash' do
    cursor_hash = {
      'session_id' => '2c824061bdd',
      'offset' => 1136802
    }

    cursor = described_class.new cursor_hash
    expect(cursor.session_id).to eq('2c824061bdd')
    expect(cursor.offset).to eq(1136802)
  end

  it 'can have its offset modified' do
    cursor = described_class.new(
      'session_id' => '2c824061bdd',
      'offset' => 0
    )

    expect { cursor.offset = 42 }
      .to change { cursor.offset }.from(0).to(42)
  end
end
