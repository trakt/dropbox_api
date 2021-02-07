# frozen_string_literal: true

context DropboxApi::Metadata::SearchOrderBy do
  it 'can be initialized from a symbol' do
    option = DropboxApi::Metadata::SearchOrderBy.new :relevance

    expect(option).to eq(:relevance)
  end

  it 'raises if initialized with an invalid value' do
    expect do
      DropboxApi::Metadata::SearchOrderBy.new :invalid
    end.to raise_error(ArgumentError)
  end
end
