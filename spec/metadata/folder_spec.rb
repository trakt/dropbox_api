# frozen_string_literal: true
context DropboxApi::Metadata::Folder do
  it 'can be initialized from a hash' do
    folder_hash = {
      '.tag' => 'folder',
      'id' => 'id:evvfE6q6cK0AAAAAAAAAS3',
      'name' => 'Holiday Pictures',
      'path_lower' => '/holiday pictures',
      'path_display' => '/Holiday Pictures'
    }

    folder = DropboxApi::Metadata::Folder.new folder_hash
    expect(folder).to be_a(DropboxApi::Metadata::Folder)
    expect(folder.name).to eq('Holiday Pictures')
    expect(folder.path_lower).to eq('/holiday pictures')
    expect(folder.path_display).to eq('/Holiday Pictures')
    expect(folder.id).to eq('id:evvfE6q6cK0AAAAAAAAAS3')
  end

  it 'can be converted back to a hash' do
    folder_hash = {
      '.tag' => 'folder',
      'id' => 'id:evvfE6q6cK0AAAAAAAAAS3',
      'name' => 'Holiday Pictures',
      'path_lower' => '/holiday pictures',
      'path_display' => '/Holiday Pictures'
    }

    folder = DropboxApi::Metadata::Folder.new folder_hash

    expect(folder.to_hash).to eq(folder_hash)
  end
end
