class AddColumnsOrgNameAndTypOfServiceToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :organization_name, :string
    add_column :contacts, :type_of_service, :string
    add_column :contacts, :exp_price_range, :string
    add_column :contacts, :type_of_organization, :string
    add_column :contacts, :service_convinced, :string
    add_column :contacts, :process_line, :string
    add_column :contacts, :remarks, :string
  end
end
