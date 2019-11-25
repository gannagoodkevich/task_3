require 'rspec'
require 'capybara/rspec'
require 'csv'

describe 'Parse Onliner.by' do
  let(:tag_to_find_title) { 'div.news-header__title h1' }
  let(:tag_to_find_text) { 'div.news-text p' }
  let(:tag_to_find_image) { 'div.news-header__image' }


  scenario "Parse main news" do
    session1 = Capybara::Session.new(:selenium_chrome)
    session1.visit('https://onliner.by')
    session1.find_all('section.b-main-page-news-2__main-news article div h2 a').uniq do |link|
      if link[:href].to_s.match(/(forum)|(kurs)/).nil?
        session1 = Capybara::Session.new(:selenium_chrome)
        session1.visit(link[:href])
        title = session1.find(tag_to_find_title).text
        description = session1.find_all(tag_to_find_text)[0].text.chars.take(200).join
        image = session1.find(tag_to_find_image)[:style].gsub("background-image: url(", "")
        CSV.open("answer.csv", "a+") do |csv|
          csv << [title, description, image]
        end
        expect(session1.current_url).to eql(link[:href])
        session1.driver.quit
      end
    end
    session1.driver.quit
  end

  scenario "Parse secondary news" do
    session1 = Capybara::Session.new(:selenium_chrome)
    session1.visit('https://onliner.by')
    session1.find_all('section.b-main-page-news-2__secondary-news article h2 a').uniq do |link|
      if link[:href].to_s.match(/(forum)|(kurs)/).nil?
        session1 = Capybara::Session.new(:selenium_chrome)
        session1.visit(link[:href])
        title = session1.find(tag_to_find_title).text
        description = session1.find_all(tag_to_find_text)[0].text.chars.take(200).join
        image = session1.find(tag_to_find_image)[:style].gsub("background-image: url(", "")
        CSV.open("answer.csv", "a+") do |csv|
          csv << [title, description, image]
        end
        expect(session1.current_url).to eql(link[:href])
        session1.driver.quit
      end
    end
    session1.driver.quit
  end

  scenario "Parse teaser news" do
    session1 = Capybara::Session.new(:selenium_chrome)
    session1.visit('https://onliner.by')
    session1.find_all('li.b-teasers-2__teaser a').uniq do |link|
      if link[:href].to_s.match(/(forum)|(kurs)/).nil?
        session1 = Capybara::Session.new(:selenium_chrome)
        session1.visit(link[:href])
        title = session1.find(tag_to_find_title).text
        description = session1.find_all(tag_to_find_text)[0].text.chars.take(200).join
        image = session1.find(tag_to_find_image)[:style].gsub("background-image: url(", "")
        CSV.open("answer.csv", "a+") do |csv|
          csv << [title, description, image]
        end
        expect(session1.current_url).to eql(link[:href])
        session1.driver.quit
      end
    end
    session1.driver.quit
  end

  scenario "Parse list news" do
    session1 = Capybara::Session.new(:selenium_chrome)
    session1.visit('https://onliner.by')
    session1.find_all('ul.b-main-page-news-2__news-list li div h3 a').uniq do |link|
      if link[:href].to_s.match(/(forum)|(kurs)/).nil?
        session1 = Capybara::Session.new(:selenium_chrome)
        session1.visit(link[:href])
        title = session1.find(tag_to_find_title).text
        description = session1.find_all(tag_to_find_text)[0].text.chars.take(200).join
        image = session1.find(tag_to_find_image)[:style].gsub("background-image: url(", "")
        CSV.open("answer.csv", "a+") do |csv|
          csv << [title, description, image]
        end
        expect(session1.current_url).to eql(link[:href])
        session1.driver.quit
      end
    end
    session1.driver.quit
  end
end
