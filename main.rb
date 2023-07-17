require 'dotenv/load'
require_relative 'lib/rezka_pars.rb'

pars = RezkaPars.new
pars.login(ENV['REZKA_USERNAME'], ENV['REZKA_PASSWORD'])
search_text = ARGV[0]
pars.search_films_and_click_play(search_text)
