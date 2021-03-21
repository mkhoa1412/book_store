class Author < ApplicationRecord
  include Filterable

  validates :name, presence: true

  scope :filter_by_name, ->(name) { where(name: name) }

  def to_s
    name
  end
end
