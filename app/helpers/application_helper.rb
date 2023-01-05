module ApplicationHelper
  BASE_TITLE = "BIGBAG Store".freeze

  def full_page_title(page_title)
    page_title.present? ? "#{page_title} - #{BASE_TITLE}" : BASE_TITLE
  end
end
