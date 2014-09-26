class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :process_line
      t.date :effective_date
      t.date :expected_end_date
      t.datetime :meeting_time
      t.string :remarks
      t.timestamps
    end
  end
end
