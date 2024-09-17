require_relative 'model/books'
require_relative 'sqlconnect'
class Update_book
  include Database
  def getUpdateDetails(my_book,modified_book)
    if modified_book
      my_book.book_name = modified_book.book_name
      my_book.author = modified_book.author
      my_book.title = modified_book.title
      "#{my_book.book_name}, #{my_book.title} by #{my_book.author}"
    end
  end

end
