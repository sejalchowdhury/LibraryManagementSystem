class Member
  include Database
  attr_accessor :id, :name, :member_id, :book_name

  def initialize(id,name,member_id)
    @id = id
    @name = name
    @member_id = member_id
  end

  def saveMember
    client = Database.client
    client.query("INSERT INTO members(name, member_id) VALUES ('#{@name}', #{@member_id})")
  end

  def updateMember(id,name)
    client = Database.client
    @name = name
    client.query("UPDATE members SET name = '#{@name}', member_id = #{@member_id}")
  end

  def book_borrowed(book_name,member_id)
    client = Database.client
    result = client.query("SELECT * FROM MEMBERS where member_id = #{member_id}")
    if result.count==0
      puts "Error not a member"
    else
      client.query("
      UPDATE books
      SET total_count = total_count - 1
      WHERE book_name = '#{book_name}' AND total_count > 0;
    ")
    end
  end

end

