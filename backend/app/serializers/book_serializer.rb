class BookSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :publisher, :genre, :pages
  belongs_to :author
end
