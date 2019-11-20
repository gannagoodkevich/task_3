require 'capybara'
#visit(visit_uri) ⇒ Object
session = Capybara::Session.new(:selenium_chrome)
session.visit('https://onliner.by')
#session.click_link('Новости')

session.find_all('section.b-main-page-news-2__main-news article div h2 a span').uniq do |link|
  puts link.text
end

session.find_all('section.b-main-page-news-2__secondary-news article h2 a').uniq do |link|
  puts link.text
end

session.find_all('li.b-teasers-2__teaser a div span').uniq do |link|
  puts link.text
end

session.find_all('ul.b-main-page-news-2__news-list li div h3 a').uniq do |link|
  puts link.text
end