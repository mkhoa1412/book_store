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

  subject       { Author.new(books: books) }
  let(:books) { [] }

  it 'has no books' do
    expect(subject.books).to be_empty
  end

  describe '#to_s' do
    it 'retun correct name' do
      subject.name = 'Tommy'
      expect(subject.to_s).to eq('Tommy')
    end
  end

  describe '#new_book' do
    let(:new_book) { OpenStruct.new }

    before do
      subject.book_source = -> { new_book }
    end

    it 'returns a new book' do
      expect(subject.new_book).to eq(new_book)
    end

    it "sets the book's author reference to itself" do
      expect(subject.new_book.author).to eq(subject)
    end
  end

  describe '#write_book' do
    it 'adds the book to the author' do
      book = build_stubbed(:book)
      allow(book).to receive(:save).and_return(true)
      subject.write_book(book)

      expect(subject.books.size).to eq(1)
    end
  end

  describe '#filter_by_name' do
    before do
      @batman = create(:author, name: 'Batman')
      @batgirl = create(:author, name: 'Batgirl')
      @robin = create(:author, name: 'Robin')
    end
    it 'whose name starts with' do
      expect(subject.class.filter_by_name('bat')).to eq([@batman, @batgirl])
    end
  end
end
