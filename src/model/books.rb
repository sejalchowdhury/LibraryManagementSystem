require_relative '../sqlconnect'
class Books
  include Database
  attr_accessor :book_name,:author,:title

  def initialize(book_name, author, title)
    @book_name = book_name
    @author = author
    @title = title
  end

  def saveToDB
    client = Database.client
    client.query("
    INSERT INTO books (book_name, author, title)
    VALUES ('#{book_name}', '#{author}', '#{title}');
  ")
    update_book_count(1)
  end

  def eraseOldBook(book_name)
    client = Database.client
    client.query("DELETE FROM books WHERE book_name = '#{book_name}'")
    update_book_count(-1)
  end
  def description
    "#{title} by #{author}"
  end

  def getBooks
    client = Database.client
    results = client.query("
        SELECT * FROM books")
    results.each do |row|
      puts "ID: #{row['id']}, Book Name: #{row['book_name']}, Author: #{row['author']}, Title: #{row['title']}"
    end
  end

  def update_book_count(count)
    client = Database.client
    current_count=client.query("SELECT COUNT(*) AS count FROM books").first['count']
    client.query("UPDATE books SET total_count = #{current_count}")
  end

  def get_books_by_author(author, limit, offset)
    client = Database.client
    results = client.query("
    SELECT * FROM books
    WHERE author = '#{author}'
    LIMIT #{limit}
    OFFSET #{offset};
  ")
    results.each do |row|
      puts "ID: #{row['id']}, Book Name: #{row['book_name']}, Author: #{row['author']}, Title: #{row['title']}"
    end
  end


end

