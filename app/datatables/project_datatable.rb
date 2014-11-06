class ProjectDatatable < AjaxDatatablesRails::Base
  # uncomment the appropriate paginator module,
  # depending on gems available in your project.
  # include AjaxDatatablesRails::Extensions::Kaminari
  # include AjaxDatatablesRails::Extensions::WillPaginate
  # include AjaxDatatablesRails::Extensions::SimplePaginator

  def_delegators :@view, :link_to, :admin_project_path, :edit_admin_project_path

  def sortable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    @sortable_columns ||= ['projects.name', 'projects.process_line', 'projects.effective_date', 'projects.expected_end_date', 'projects.meeting_time
', 'projects.remarks']
  end

  def searchable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    @searchable_columns ||= ['projects.name', 'projects.process_line', 'projects.effective_date', 'projects.expected_end_date', 'projects.meeting_time', 'projects.remarks']
  end

  private

  def data
    records.map do |record|
      [
          # comma separated list of the values for each cell of a table row
          # example: record.attribute,
          record.name,
          record.process_line,
          record.effective_date.blank? ? "" : record.effective_date.strftime("%m/%d/%Y"),
          record.expected_end_date.blank? ? "" : record.expected_end_date.strftime("%m/%d/%Y"),
          record.meeting_time.blank? ? "" : record.meeting_time.strftime("%m/%d/%Y %R %p"),
          record.remarks,
          # link_to("Edit","javascript:void(0)") + "   " + link_to("Destroy",admin_contact_path(record), :method => "delete")
          link_to("Edit", edit_admin_project_path(record)) + " |  " + link_to("Destroy",admin_project_path(record), :method => "delete")
      ]
    end
  end

  def paginate_records(records)
    records = records.page(page).per_page(per_page)
    records
  end

  def get_raw_records
    # insert query here
    Project.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
