class CreateFinances < ActiveRecord::Migration
  def change
    create_table :finances do |t|
      t.date :process_date
      t.float :amount
      t.string :particulars
      t.string :type
      t.string :remarks
      t.timestamps
    end
  end
end
