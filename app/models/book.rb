class Book < ApplicationRecord
  LIMIT_DEFAULT = 20

  belongs_to :author

  monetize :price_cents

  validates :title, presence: true

  scope :filter_by_title, lambda { |title|
    where(name: title).order(created_at: :desc) if title.present?
  }

  def self.find_by_id(id)
    super(id)
  end

  def to_s
    title
  end

  def publish
    return false unless valid?

    author.write_book(self)
  end
end
