env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './lib/link'
require './lib/user'
require './lib/chit'

DataMapper.finalize