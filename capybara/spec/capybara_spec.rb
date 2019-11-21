require 'capybara'
require 'csv'

class OnlinerParser
  def parse_main_page_for_news(url = 'https://onliner.by')
    @session = Capybara::Session.new(:selenium_chrome)
    @session.visit(url)
    parse_news_page('section.b-main-page-news-2__main-news article div h2 a', 'div.news-header__title h1', 'div.news-text p', 'div.news-header__image')
    puts "__END__OF__SECTION__"
    parse_news_page('section.b-main-page-news-2__secondary-news article h2 a', 'div.news-header__title h1', 'div.news-text p', 'div.news-header__image')
    puts "__END__OF__SECTION__"
    parse_news_page('li.b-teasers-2__teaser a', 'div.news-header__title h1', 'div.news-text p', 'div.news-header__image')
    puts "__END__OF__SECTION__"
    parse_news_page('ul.b-main-page-news-2__news-list li div h3 a', 'div.news-header__title h1', 'div.news-text p', 'div.news-header__image')
    puts "__END__OF__PROCCESSING__"
  end

  private

  def parse_news_page(tag_to_find_news, tag_to_find_title, tag_to_find_text, tag_to_find_image)
    @session.find_all(tag_to_find_news).uniq do |link|
      puts link[:href]
      if link[:href].to_s.match(/(forum)|(kurs)/).nil?
        parse_info(link, tag_to_find_title, tag_to_find_text, tag_to_find_image)
      end
    end
  end

  def parse_info(link, tag_to_find_title, tag_to_find_text, tag_to_find_image)
    session1 = Capybara::Session.new(:selenium_chrome)
    session1.visit(link[:href])
    csv_output(session1.find(tag_to_find_title).text, session1.find_all(tag_to_find_text)[0].text.chars.take(200).join, session1.find(tag_to_find_image)[:style].gsub("background-image: url(", ""))
    session1.driver.quit
  end

  def csv_output(title, description, image)
    CSV.open("answer.csv", "a+") do |csv|
      csv << [title, description, image]
    end
  end
end

OnlinerParser.new.parse_main_page_for_news
