# frozen_string_literal: true
describe DropboxApi::Metadata::WriteMode do
  describe '#to_hash' do
    it 'works with :add as parameter' do
      mode = DropboxApi::Metadata::WriteMode.new :add

      expect(mode.to_hash)
        .to eq({'.tag' => :add})
    end

    it 'works with "add" as parameter' do
      mode = DropboxApi::Metadata::WriteMode.new 'add'

      expect(mode.to_hash)
        .to eq({'.tag' => :add})
    end

    it 'works with :overwrite as parameter' do
      mode = DropboxApi::Metadata::WriteMode.new :overwrite

      expect(mode.to_hash)
        .to eq({'.tag' => :overwrite})
    end

    it 'works with :update as parameter' do
      mode = DropboxApi::Metadata::WriteMode.new :update, 'a1c10ce0dd78'

      expect(mode.to_hash)
        .to eq({'.tag' => :update, 'update' => 'a1c10ce0dd78'})
    end

    it 'fails with :update without rev' do
      expect {
        DropboxApi::Metadata::WriteMode.new :update
      }.to raise_error(ArgumentError)
    end
  end
end
