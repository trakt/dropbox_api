# frozen_string_literal: true

context DropboxApi::Metadata::FileExtensionsList do
  it 'can be initialized empty' do
    list = DropboxApi::Metadata::FileExtensionsList.new([])

    expect(list).to be_a(Array)
  end

  it 'can be initialized with some extensions' do
    list = DropboxApi::Metadata::FileExtensionsList.new(%w[jpg png xcf])

    expect(list).to be_a(Array)
    expect(list).to include('jpg')
    expect(list).to include('png')
    expect(list).to include('xcf')
  end

  it 'raises if extensions have an invalid value' do
    expect do
      DropboxApi::Metadata::FileExtensionsList.new([1, 2, 3])
    end.to raise_error(ArgumentError)
  end
end
