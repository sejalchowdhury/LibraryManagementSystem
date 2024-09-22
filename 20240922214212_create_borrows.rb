class CreateBorrows < ActiveRecord::Migration[6.1]
    def change
      create_table :borrows do |t|
        t.integer :member_id
        t.string :book_name
        t.date :borrowed_on
        t.date :returned_on
      end
    end
end
