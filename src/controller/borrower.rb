require_relative '../model/borrow.rb'
require './config/database_config.rb'
require_relative '../../app/serializer/borrower_serializer.rb'
class BorrowerController < ActionController::Base

  before_action :check_member_existence, only: [:borrow_book]

  def borrow_book(member_id, book_name)
    check_member_existence(member_id)
    borrow_status = Borrow.new(member_id: member_id, book_name: book_name, borrowed_on: Date.today)
    render_borrow(borrow_status)
    if borrow_status.save
      puts "Book borrowed successfully by member"
    else
      puts "Book cannot be borrowed"
    end
  end


  private

  #Push it on a filter
  def check_member_existence(member_id)
    member = Member.find_by(member_id: member_id)
    if member.nil?
      puts "Error: Member with ID '#{member_id}' does not exist!"
      exit
    end
  end

  def display_all_borrows
    borrows = Borrow.all
    render_borrows_blueprint(borrows)
  end

  def render_borrows_blueprint(borrows)
    puts BorrowBlueprint.render(borrows)
  end
  def render_borrow(borrow_status)
    puts ActiveModelSerializers::SerializableResource.new(borrow_status).as_json
  end
end
