module AdminsHelper

  def get_contacts_for_layout
    contacts = Contact.find_by_sql("select * from contacts order by created_at desc limit 3")
  end
end
