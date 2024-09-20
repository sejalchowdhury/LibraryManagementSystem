require 'active_model_serializers'
class MemberSerializer < ActiveModel::Serializer
  attributes :id, :name, :member_id
  has_many :borrows
end

