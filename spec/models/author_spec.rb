require 'rails_helper'

RSpec.describe Author, type: :model do
  it 'is valid name' do
    name = 'john'
    it = build_stubbed(:author, name: name)
    expect(it).to be_valid
  end

  it 'is invalid name' do
    name = ''
    it = build_stubbed(:author, name: name)
    it.valid?
    expect(it.errors).to have_key(:name)
  end

  it '#to_s retun correct name' do
    it = build_stubbed(:author, name: 'Tommy')
    expect(it.to_s).to eq('Tommy')
  end
end
