require 'sinatra'
require 'mongoid'

Mongoid.load! 'mongoid.config'

class Restaurant
	include Mongoid::Document

	field :name, type: String

end

get '/' do
	'Welcome to On My Wait List'
end