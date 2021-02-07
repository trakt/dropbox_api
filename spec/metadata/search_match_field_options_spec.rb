# frozen_string_literal: true

context DropboxApi::Metadata::SearchMatchFieldOptions do
  it 'can be initialized empty' do
    options = DropboxApi::Metadata::SearchMatchFieldOptions.new({})

    expect(options).to be_a(DropboxApi::Metadata::SearchMatchFieldOptions)
    expect(options.to_hash).to eq({})
  end

  it 'can be initialized and set to include highlights' do
    options = DropboxApi::Metadata::SearchMatchFieldOptions.new({ 'include_highlights' => true })

    expect(options).to be_a(DropboxApi::Metadata::SearchMatchFieldOptions)
    expect(options.include_highlights).to be_truthy
  end
end
