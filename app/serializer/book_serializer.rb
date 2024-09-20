require 'active_model_serializers'
class BookSerializer < ActiveModel::Serializer
  attributes :id, :book_name, :author, :title, :total_count
  has_many :borrows
end
