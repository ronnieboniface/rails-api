class AuthorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name
  has_many :books

  attribute :num_of_books do |object|
    object.books.length
  end
end
