require 'sinatra'
require 'sinatra/namespace'
require 'mongoid'

# DB Setup
Mongoid.load! 'mongoid.config'

# Models
class Restaurant
	include Mongoid::Document

	field :name, type: String
end

# Endpoints
get '/' do
	'Welcome to On My Wait List'
end

namespace '/api/v1' do
	before do 
		content_type 'application/json'
	end

	get '/restaurants' do
		Restaurant.all.to_json
	end
end