require 'kafka'

class KafkaConsumer
  def initialize
    @kafka = Kafka.new(["localhost:9092"])
  end

  def start
    consumer = @kafka.consumer(group_id: "library_system_group")
    consumer.subscribe("library_events")
    consumer.each_message do |message|
      process_event(message)
    end
  end

  def process_event(message)
    event = JSON.parse(message.value)
    case event["event_type"]
    when "BOOK_BORROWED"
      puts "Book borrowed event received: Member ID #{event['member_id']} borrowed #{event['book_name']} on #{event['borrowed_on']}"
    end
    end
end
