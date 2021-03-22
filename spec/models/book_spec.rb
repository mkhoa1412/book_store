require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    @author = create(:author)
  end

  describe '#publish valid book' do
    before do
      @it = Book.new({ title: 'Title Abc', price: '20.2' })
      @it.author = @author
    end

    it 'adds the book to the author' do
      expect(@it.publish).to equal(true)
    end
  end

  describe '#publish invalid book' do
    before do
      @it = Book.new({ title: '', price: '20.2' })
      @it.author = @author
    end

    it 'adds the book to the author' do
      expect(@it.publish).to equal(false)
    end
  end
end
