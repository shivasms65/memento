class ContactDatatable < AjaxDatatablesRails::Base
  # uncomment the appropriate paginator module,
  # depending on gems available in your project.
  # include AjaxDatatablesRails::Extensions::Kaminari
  # include AjaxDatatablesRails::Extensions::WillPaginate
  # include AjaxDatatablesRails::Extensions::SimplePaginator

  def_delegators :@view, :link_to, :admin_contact_path

  def sortable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    @sortable_columns ||= ['contacts.name', 'contacts.email', 'contacts.mobile', 'contacts.note', "contacts.note"]
  end

  def searchable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    @searchable_columns ||= ['contacts.name', 'contacts.email', 'contacts.mobile', 'contacts.note', "contacts.note"]
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.name,
        record.email,
        record.mobile,
        record.note,
        link_to("Destroy",admin_contact_path(record), :method => "delete")
      ]
    end
  end

  def paginate_records(records)
    records = records.page(page).per_page(per_page)
    records
  end

  def get_raw_records
    # insert query here
    Contact.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
