class Author < ApplicationRecord
  include PgSearch::Model

  attr_writer :book_source

  validates :name, presence: true

  has_many :books, -> { order(created_at: :desc) }

  pg_search_scope :search_name,
                  against: :name,
                  using: {
                    trigram: { threshold: 0.3 },
                    dmetaphone: { any_word: true, sort_only: true }
                  }
  scope :filter_by_name, lambda { |name|
    search_name(name).order(created_at: :desc) if name.present?
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
