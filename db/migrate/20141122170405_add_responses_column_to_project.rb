class AddResponsesColumnToProject < ActiveRecord::Migration
  def change
    add_column :projects, :responsibilities, :string
    add_column :projects, :mng_responses, :string
  end
end
