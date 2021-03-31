module ApplicationHelper
  def header(text)
    content_for(:header) { text.to_s }
  end

  def sort_link(column, title = nil)
    title ||= column.titleize
    direction = column == User.sort_column(params[:column]) && User.sort_direction(params[:direction]) == "asc" ? "desc" : "asc"
    icon = User.sort_direction(params[:direction]) == "asc" ? "glyphicon glyphicon-chevron-up" : "glyphicon glyphicon-chevron-down"
    icon = column == User.sort_column(params[:column]) ? icon : ""
    link_to "#{title} <span class='#{icon}'></span>".html_safe, { column: column, direction: direction }
  end

  def country_name(country_code)
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.name
  end
  
  def get_class(application, attribute)
    return 'success' if application.steps[attribute].present?
  
    'default'
  end
end
