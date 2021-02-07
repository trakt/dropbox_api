# frozen_string_literal: true

context DropboxApi::Metadata::SearchOptions do
  it 'can be initialized empty' do
    options = DropboxApi::Metadata::SearchOptions.new({})

    expect(options).to be_a(DropboxApi::Metadata::SearchOptions)
    expect(options.to_hash).to eq({})
  end

  it 'can be initialized with path' do
    options = DropboxApi::Metadata::SearchOptions.new({ 'path' => '/folder' })

    expect(options).to be_a(DropboxApi::Metadata::SearchOptions)
    expect(options.path).to eq('/folder')
  end

  it 'can be initialized with several values' do
    options = DropboxApi::Metadata::SearchOptions.new(
      {
        'path' => '/folder',
        'max_results' => 42,
        'file_status' => :deleted,
        'filename_only' => true,
        'file_extensions' => %w[jpg png],
        'file_categories' => %w[folder paper]
      }
    )

    expect(options).to be_a(DropboxApi::Metadata::SearchOptions)
    expect(options.path).to eq('/folder')
    expect(options.max_results).to eq(42)
    expect(options.file_status).to eq(:deleted)
    expect(options.filename_only).to eq(true)
  end
end
