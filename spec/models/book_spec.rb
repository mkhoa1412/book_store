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

  describe '#filter_by_author_name' do
    before do
      @book_1 = create(:book, author: create(:author, name: 'Jonh Smith'))
      @book_2 = create(:book, author: create(:author, name: 'Tom Cruse'))
      @book_3 = create(:book, author: create(:author, name: 'Aamir Khan'))
    end
    it 'list book of author' do
      expect(Book.filter_by_author_name('amir')).to eq([@book_3])
    end
  end
end
