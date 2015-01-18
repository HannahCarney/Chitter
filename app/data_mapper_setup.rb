env = ENV['RACK_ENV'] || 'development'

configure :development do
 DataMapper.setup(:default, "postgresql://#{Dir.pwd}/development.db")
end
configure :production do
 DataMapper.setup(:default, ENV['DATABASE_URL'])
end


require './lib/link'
require './lib/user'
require './lib/peep'

DataMapper.finalize