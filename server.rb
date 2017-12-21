require 'sinatra'
require 'sinatra/namespace'
require 'mongoid'

# DB Setup
Mongoid.load! 'mongoid.config'

# Models
class Restaurant
	include Mongoid::Document

	field :name, type: String

	scope :name, -> (name) { where(name: /^#{name}/i)}
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
		restaurants = Restaurant.all

		[:name].each do |filter|
			restaurants = restaurants.send(filter, params[filter]) if params[filter]
		end

		restaurants.to_json
	end
end