class CreateBooks < ActiveRecord::Migration[7.1]
    def change
      create_table :books do |t|
        t.string :book_name
        t.string :author
        t.string :title
        t.integer :total_count, default: 0

        t.timestamps
      end
    end
end
