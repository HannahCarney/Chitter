env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/chitter_#{env}")

require './lib/user'
require './lib/peep'

DataMapper.finalize

DataMapper.auto_upgrade!