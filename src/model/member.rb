require 'active_record'

class Member < ActiveRecord::Base
  validates :id, :name, :member_id, presence: true

  # One member can borrow many books
  has_many :borrows

  def self.all_members
    all
  end
end
