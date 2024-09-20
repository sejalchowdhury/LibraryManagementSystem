require_relative '../model/books.rb'
require './config/database_config.rb'
require_relative '../../app/serializer/book_serializer.rb'

class BooksController
  def perform_add_and_delete_books
    save_or_update_book("ABCD", "Oriely", "Programming")
    books = Books.get_books_by_author("Sejal", 2, 2)
    render_books(books)
    render_books_blueprint(books)
  end

  def save_or_update_book(book_name, author, title)
    book = Books.find_by(book_name: book_name)
    if book
      puts "Book already exists. Updating the count."
      book.total_count += 1
      if book.save
        puts "Book count updated successfully to #{book.total_count}"
      else
        puts "Failed to update book count: #{book.errors.full_messages.join(', ')}"
      end
    else
      new_book = Books.new(book_name: book_name, author: author, title: title, total_count: 1)
      if new_book.save
        puts "Book created successfully: #{new_book.description} with count #{new_book.total_count}"
      else
        puts "Failed to create book: #{new_book.errors.full_messages.join(', ')}"
      end
    end
  end

  def render_books(books)
    puts ActiveModelSerializers::SerializableResource.new(books).as_json
  end
  def delete_book(book_name)
    book = Books.find_by(book_name: book_name)
    if book
      book.destroy
      puts "Book deleted successfully."
    else
      puts "Book not found."
    end
  end

  def display_all_books
    books = Book.all
    render_books(books)
  end
  def render_books_blueprint(books)
    puts BookBlueprint.render(books)
  end

end
