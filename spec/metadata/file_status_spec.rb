# frozen_string_literal: true

context DropboxApi::Metadata::FileStatus do
  it 'can be initialized from a symbol' do
    option = DropboxApi::Metadata::FileStatus.new :active

    expect(option).to eq(:active)
  end

  it 'raises if initialized with an invalid value' do
    expect do
      DropboxApi::Metadata::FileStatus.new :invalid
    end.to raise_error(ArgumentError)
  end
end
