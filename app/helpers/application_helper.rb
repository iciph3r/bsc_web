module ApplicationHelper

  # Returns full title based on if the page provides one.
  def full_title(page_title = '')
    base_title = 'Black Shadow Clan'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def display_flash(message)
    if flash[:notice]
      "#{icon('info-circle', message)}".html_safe
    elsif flash[:alert]
      "#{icon('exclamation-triangle', message)}".html_safe
    end
  end
end
