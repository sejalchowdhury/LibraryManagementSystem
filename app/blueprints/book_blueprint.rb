class BookBlueprint < Blueprinter::Base
  identifier :id

  fields :book_name, :author, :title, :total_count
end
