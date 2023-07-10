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

  def search_and_add_text(text)
    find('.b-search__submit').click
    find('.b-search__field').set(text)
    find('.b-search__submit').click

    inline_items = all('.b-content__inline_items .b-content__inline_item')
    total_items = inline_items.count

    (0...total_items).each do |index|
      inline_items = all('.b-content__inline_items .b-content__inline_item')

      inline_item = inline_items[index]
      inline_item.find('.b-content__inline_item-cover a').click
      # find('.b-sidelinks__icon_play').click

    find('textarea.b-field.b-area').click

    button = find('.ps-agreement-buttons').find('button.btn.btn-action.btn-small')
    page.execute_script("arguments[0].click();", button)

    execute_script("document.querySelector('textarea.b-field.b-area').value = 'Цей фільм захоплює з перших хвилин. Сюжет викликає напруження і тримає в напрузі до кінця.'")
    sleep(2)

    click_on('Добавить')

      go_back
      endline_items = all('.b-content__inline_items .b-content__inline_item')
    end
  end
end

pars = RezkaPars.new
pars.login('hdrezka_pars', 'C2j85@Pi.zJDnm-')
search_text = ARGV[0]
pars.search_and_add_text(search_text)



