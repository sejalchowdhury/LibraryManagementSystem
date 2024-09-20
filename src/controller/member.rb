require_relative '../model/member'
require './config/database_config.rb'
require_relative '../../app/serializer/member_serializer.rb'
require_relative '../../app/serializer/borrower_serializer.rb'
class MemberController
  def add_new_member
    new_member = Member.new(id: "111", name: "Sejal", member_id: "111")
    if new_member.save
      puts "Member created successfully"
    else
      puts "Error while saving the member details"
    end
  end

  def display_all_members
    members = Member.all_members
    if members.any?
      members.each do |member|
        puts "ID: #{member.id}, Name: #{member.name}, Member ID: #{member.member_id}"
      end
    else
      puts "No members found"
    end
    render_member(members)
  end

  def delete_member(member_id)
    member = Member.find_by(member_id: member_id)
    render_members_blueprint(members)
    if member
      member.delete
      puts "Member deleted successfully."
    else
      puts "Member not found."
    end
  end

  def update_member(member_id, updated_attributes)
    member = Member.find_by(member_id: member_id)
    if member
      if member.update(updated_attributes)
        puts "Member updated successfully."
      else
        puts "Error while updating the member details."
      end
    else
      puts "Member not found."
    end
  end

  def render_member(members)
    puts ActiveModelSerializers::SerializableResource.new(members).as_json
  end

  def render_members_blueprint(members)
    puts MemberBlueprint.render(members)
  end
end
