require_relative 'controller/books.rb'
require_relative 'controller/member.rb'
require_relative 'update_book.rb'
require_relative 'controller/borrower.rb'
require_relative 'sqlconnect'
require_relative 'model/member.rb'
require_relative 'model/borrow.rb'
require 'Date'
require 'kafka'
require_relative 'kafka_consumer.rb'
require_relative '../config/application'
require_relative  '../app/serializer/book_serializer.rb'
require_relative  '../app/serializer/member_serializer.rb'
require_relative  '../app/serializer/borrower_serializer.rb'

LibraryManagementSystem::Application.initialize!


#Create/Update a new book
BooksController.new.perform_add_and_delete_books

#Delete a book
# BooksController.new.delete_book("ABCD")

#Create a new member
# MemberController.new.add_new_member

#Display all members
MemberController.new.display_all_members

#Delete a member
# MemberController.new.delete_member("1")

#Update the member
# MemberController.new.update_member("10",{ name: "Prakash Singh"})

#Borrow a book
BorrowerController.new.borrow_book(1,"SDSDSD")








# Review:
# add to record instead of sql => Finished
# callbacks in borrow after a book is borrowed a call back needs to be called => Finished
# Segregate the controller do not keep all operations on main (book,member) we can add
# the check if the person is a member of the library if not then we cannot lend book => Finished
# filters in controller why and where can you use in this system
# Scaffolding => (optional finish all of the above first then explore)


# New Tasks
# All the callbacks in the model => model hooks and validation
# All the filters for controller =>
# Association Call => Fetch the list of members and books and borrowers => Finished
# 2 logical issues in functions of book and borrower fix that
# CRUD add all 4 in all 3 models
# Serializer and blueprints => What are they and where they are used and why ?