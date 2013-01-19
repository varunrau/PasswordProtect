
module ApplicationHelper

  def sortable(column, title = nil)
    direction = ( column == sort_column && sort_direction == 'asc') ? 'desc' : 'asc'
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    link_to title, {:sort => column, :direction => direction}, { :class => css_class }
  end

  def sort_column
    Login.column_names.include?(params[:sort]) ? params[:sort] : 'org'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def scrambled_password
    random_string = SecureRandom.hex(16)
    return random_string
  end

end
