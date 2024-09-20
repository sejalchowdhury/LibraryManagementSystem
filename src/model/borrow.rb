require 'active_record'
require './config/database_config'
require 'action_controller'

class Borrow < ActiveRecord::Base
  validates :member_id, :book_name, :borrowed_on, presence: true

  # Associations
  belongs_to :member
  belongs_to :books

  after_save :update_book_count
  # after_save :send_message_to_kafka

  # Lock needs to be added here
  def update_book_count
    ActiveRecord::Base.transaction do
      book = Books.lock.find_by(book_name: book_name)
      if book
        book.total_count -= 1
        book.save
        puts "Updated book count for '#{book_name}' to #{book.total_count}"
      else
        puts "Error: Book '#{book_name}' not found."
      end
    end
  end

  def send_message_to_kafka
    kafka = Kafka.new(["localhost:9092"])
    producer = kafka.producer
    producer.produce({
                       event_type: "BOOK_BORROWED",
                       member_id: member_id,
                       book_name: book_name,
                       borrowed_on: borrowed_on,
                       returned_on: returned_on
                     }.to_json, topic: "library_events")
    producer.deliver_messages
    puts "Kafka event sent for borrowing book #{book_name} by member #{member_id}"
  end
end
