require 'mysql2'

module Database
  def self.client
    @client ||= Mysql2::Client.new(
      host: 'localhost',
      username: 'root',
      password: 'newpassword',
      database: 'book_library'
    )
  end

# Create the books table
client.query("
  CREATE TABLE IF NOT EXISTS books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_name VARCHAR(255),
    author VARCHAR(255),
    title VARCHAR(255)
  );
")

  client.query("CREATE TABLE IF NOT EXISTS members (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  member_id VARCHAR(255)
)")

  client.query("CREATE TABLE IF NOT EXISTS borrows (id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_name VARCHAR(255),
    borrowed_on DATE,
    returned_on DATE
  )")

end



