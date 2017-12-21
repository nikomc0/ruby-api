# On My Wait List: Restaurant API

This api will be used to populate a react-native front end for users to choose
restaurants in their area to put their names down on the waitlist before leaving the house.

## Dependencies

- gem 'sinatra'
- gem 'sinatra-contrib'
- gem 'mongoid'

### DEFAULT Scoping by name
To allow for easy search by name which is case insensitive, and allows for partials

``` ruby
scope :name, -> (name) { where(name: /^#{name}/i)}
```

### Current Status
Currently in development and I have the Index and Show endpoints created.
