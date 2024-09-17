require 'kafka'

class Borrowers
  include Database
  attr_accessor :member_id,:name,:bookName,:borrowed_on,:returned_on,:total_books

  def initialize(member_id,name,book_name,borrowed_on,returned_on=nil)
    @member_id=member_id
    @name=name
    @book_name=book_name
    @borrowed_on=borrowed_on
    @returned_on=returned_on
  end

  def save
    client = Database.client
    if @id.nil?
      returned_on_value = @returned_on ? "'#{@returned_on.strftime('%Y-%m-%d')}'" : "NULL"
      client.query("
        INSERT INTO borrows (member_id, book_name, borrowed_on, returned_on)
        VALUES ('#{@member_id}', '#{@book_name}', '#{@borrowed_on.strftime('%Y-%m-%d')}', #{returned_on_value})
      ")
    else
      returned_on_value = @returned_on ? "'#{@returned_on.strftime('%Y-%m-%d')}'" : "NULL"
      client.query("
        UPDATE borrows
        SET book_name = '#{@book_name}', borrowed_on = '#{@borrowed_on.strftime('%Y-%m-%d')}', returned_on = #{returned_on_value}
        WHERE id = #{@id}
      ")
    end
    send_message_to_kafka
  end
  def send_message_to_kafka
    kafka = Kafka.new(["localhost:9092"])
    producer = kafka.producer
    producer.produce({
      event_type:"BOOK_BORROWED",
      member_id: @member_id,
      book_name: @book_name,
      borrowed_on: @borrowed_on,
      returned_on: @returned_on
    }.to_json,topic: "library_events")
    producer.deliver_messages
    puts "Kafka event sent for borrowing book #{@book_name} by member #{@member_name}"
  end
end

