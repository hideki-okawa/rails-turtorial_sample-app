module ApplicationHelper
  # titleを作成するカスタムヘルパー（共通で使える関数）
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
