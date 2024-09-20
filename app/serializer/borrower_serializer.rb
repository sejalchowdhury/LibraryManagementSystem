require 'active_model_serializers'
class BorrowerSerializer < ActiveModel::Serializer
  attributes :member_id, :book_name, :borrowed_on, presence: true
  belongs_to :member
  belongs_to :books
end


