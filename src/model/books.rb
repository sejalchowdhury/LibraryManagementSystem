require 'active_record'

class Books < ActiveRecord::Base


  validates :book_name, :author, :title, presence: true

  #What if book_name or any varchar exceeds limit ?
  # Soln: Add Length validators
  validates :book_name, length: { maximum: 255 } # adjust the limit as needed
  validates :author, length: { maximum: 100 }
  validates :title, length: { maximum: 255 }

  has_many :borrows

  after_save :fetch_books_by_author
  def description
    "#{title} by #{author}"
  end

  def self.get_books_by_author(author, limit, offset)
    where(author: author).limit(limit).offset(offset)
  end

  def book_exists?
    Books.exists?(book_name: book_name)
  end

  def fetch_books_by_author
    books = Books.get_books_by_author(self.author, 2, 0)
    puts "Books by #{self.author}:"
    books.each do |book|
      puts book.description
    end
  end
end
