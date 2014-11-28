# Allison Browne
# Recipe-Box Systems Check
# 11/28/14
# First Commit

require 'pg'
require 'sinatra'
require 'pry'
require 'sinatra/reloader'

def db_connection
  begin

    connection = PG.connect(dbname: 'recipes')

    yield(connection)
    # allows this method to accept a block
    # of code (in the form of a do..end or {..} block) that can be run in the middle of the method.

  ensure
    connection.close
  end
end


get '/recipes' do

  db_connection do |conn|
    @recipes = conn.exec_params('SELECT recipes.id, recipes.name FROM recipes ORDER BY recipes.name')
  end

  erb :'index'
end
