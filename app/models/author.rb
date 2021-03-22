class Author < ApplicationRecord
  attr_writer :book_source

  validates :name, presence: true

  has_many :books, -> { order(created_at: :desc) }

  scope :filter_by_name, lambda { |name|
    where(name: name).order(created_at: :desc) if name.present?
  }

  def to_s
    name
  end

  # Fetch a book by ID
  def book(id)
    books.find_by_id(id)
  end

  def new_book(*args)
    book_source.call(*args).tap do |p|
      p.author = self
    end
  end

  def write_book(book)
    books << book
    true
  end

  def book_source
    @book_source ||= Book.public_method(:new)
  end
end
