# frozen_string_literal: true

context DropboxApi::Metadata::FileCategoriesList do
  it 'can be initialized empty' do
    list = DropboxApi::Metadata::FileCategoriesList.new([])

    expect(list).to be_a(Array)
  end

  it 'can be initialized with some categories' do
    list = DropboxApi::Metadata::FileCategoriesList.new(%w[pdf image])

    expect(list).to be_a(Array)
    expect(list).to include(:pdf)
    expect(list).to include(:image)
  end

  it 'raises if extensions have an invalid value' do
    expect do
      DropboxApi::Metadata::FileCategoriesList.new(['game'])
    end.to raise_error(ArgumentError)
  end
end
