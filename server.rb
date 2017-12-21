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

# Serializers
class RestaurantSerializer
	def initialize(restaurant)
		@restaurant = restaurant
	end

	def as_json(*)
		data = {
			id: @restaurant.id.to_s,
			name: @restaurant.name
		}
	end
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

		restaurants.map { |restaurant| RestaurantSerializer.new(restaurant) }.to_json
	end
end