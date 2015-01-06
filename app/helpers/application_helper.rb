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
      "#{icon('info-circle fa-fw', message)}".html_safe
    elsif flash[:alert]
      "#{icon('exclamation-triangle fa-fw', message)}".html_safe
    end
  end

  def show_time_stamp(datetime)
    iso_time = datetime.strftime('%F')
    print_time = datetime.strftime('%-d %b %Y')
    content_tag(:time, "#{print_time}",
                datetime: "#{iso_time}",
                class: 'pull-right')
  end
end
