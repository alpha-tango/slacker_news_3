require 'sinatra'
require 'pg'
require 'pry'
require 'sinatra/reloader'

############################
# METHODS
############################

def db_connection
  begin
    connection = PG.connect(dbname: 'slacker_news')

    yield(connection)

  ensure
    connection.close
  end
end

def fetch_data(query)
  result = db_connection do |conn|
    conn.exec(query)
  end
  data = result.to_a
end

def push_data(query, param_array)
  db_connection do |conn|
    conn.exec_params(query, param_array)
  end
end

def valid_input?(form)
#checks that the input isn't tomfoolery
end

def existing_article?(url)
#checks for article's url in database
end

def save_submission
  sql='INSERT INTO articles (url, title, description, created_at) VALUES ($1, $2, $3, now());'
  push_data(sql, @submission.values)
end

##########################
# RENDERING / ROUTING
##########################

get '/' do
  redirect '/articles'
end

get '/articles' do
  sql = 'SELECT * FROM articles ORDER BY created_at DESC;'
  @articles = fetch_data(sql)
  erb :article_index
end


get '/articles/new' do

erb :new_article
end

post '/articles/new' do
  @submission = {url: params[:url], title: params[:title], description: params[:description] }

  # if existing_article?(@submission[:url])
  #   #flash: already exists
  # end

  # if valid_input?(@submission)
    save_submission
    redirect '/articles'
    #@submission = {}
  # else
    #flash
  # end
end

get '/articles/:article_id' do

erb :article_show
end

get '/articles/:article_id/comments' do

erb :article_comments
end
