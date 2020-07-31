require_relative '../config/environment'
require 'pry'
require 'rest-client'

app = Controller.new
app.run