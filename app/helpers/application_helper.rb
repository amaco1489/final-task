module ApplicationHelper
  def full_page_title(page_title)
    base_title = "BIGBAG Store"
    page_title.present? ? "#{page_title} - #{base_title}" : base_title
  end
end
