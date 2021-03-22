class BookSerializer
  include JSONAPI::Serializer

  attributes :id, :title, :price
  belongs_to :author
end
