class BorrowBlueprint < Blueprinter::Base
  identifier :id

  fields :member_id, :book_name, :borrowed_on, :returned_on
end

