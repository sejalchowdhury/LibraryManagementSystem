require_relative 'model/books.rb'
require_relative 'update_book.rb'
require_relative 'sqlconnect'
require_relative 'model/member.rb'
require_relative 'model/borrowers.rb'
require 'Date'
require 'kafka'
require_relative 'kafka_consumer.rb'

# Add or delete a new book to the system and save it to db
my_book = Books.new("Alphabets","Shakespeare","Language")
my_book1 = Books.new("C++ in a nutshell","Bjrane","Programming")
puts my_book.description
my_book.saveToDB
my_book1.saveToDB
my_book.eraseOldBook("Alphabets")

# Add/Update a member and keep the records of borrowed books throw error if member is not present
member = Member.new("1","Sejal","1")
member.saveMember
member.book_borrowed("C++ in a nutshell","1")
member.book_borrowed("C++ in a nutshell","3")

# Pagination of books wrt author
books = Books.new("Sample Book", "Author Name", "Sample Title")
author = "Bjrane"
limit = 2
offset = 1
books.get_books_by_author(author, limit, offset)

# Update the details of an existing book
updated_book = Update_book.new
my_book.eraseOldBook(my_book.book_name)
modified_book = Books.new("Sample Book", "Author Name", "Sample Title")
updated_book.getUpdateDetails(my_book,modified_book)
modified_book.saveToDB


# Kafka Queue Integration after borrow event happens
borrow = Borrowers.new(1,"Sejal","C++ in nutshell",Date.today)
borrow.save
consumer = KafkaConsumer.new
consumer.start