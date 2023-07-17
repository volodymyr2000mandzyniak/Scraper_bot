require 'capybara/dsl'
require 'selenium-webdriver'
require 'nokogiri'
require 'capybara'

Capybara.app_host = 'https://rezka.ag'
Capybara.javascript_driver = :chrome
Capybara.configure do |config|
  config.default_max_wait_time = 10
  config.default_driver = :selenium
end

class RezkaPars
  include Capybara::DSL

  def initialize
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, browser: :chrome)
    end
  end


  def login(username, password)
    visit('/')
    click_on('Вход')

    fill_in('login_name', with: username)
    fill_in('login_password', with: password)

    click_on('Войти')
  end


  def search_films_and_click_play(text)
    find('.b-search__submit').click
    find('.b-search__field').set(text)
    find('.b-search__submit').click

    inline_items = all('.b-content__inline_items .b-content__inline_item')
    total_items = inline_items.count

    (0...total_items).each do |index|
      inline_items = all('.b-content__inline_items .b-content__inline_item')

      inline_item = inline_items[index]
      inline_item.find('.b-content__inline_item-cover a').click
      find('.b-sidelinks__icon_play').click
      sleep(2)

      close_button = find('#ps-close', visible: false)
      close_button.click if close_button.visible?

      add_comment

      go_back
    end

    endline_items = all('.b-content__inline_items .b-content__inline_item')
  end


  def add_comment
    comments = File.readlines('data/comments.txt', chomp: true)
    random_comment = comments.sample

    find('textarea.b-field.b-area').click

    if has_selector?('.ps-agreement-buttons button.btn.btn-action.btn-small')
      button = find('.ps-agreement-buttons button.btn.btn-action.btn-small')
      button.click
    end

    execute_script("document.querySelector('textarea.b-field.b-area').value = '#{random_comment}'")
    sleep(2)

    click_on('Добавить')

    File.open('data/comments.txt', 'a') { |file| file.puts(random_comment) }
  end
end
