require 'rubygems'
require 'rspec'
require 'active_record'

$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__) + '/fixtures')

require 'active_record/fixtures'
require 'active_record/connection_adapters/jdbcpostgresql_adapter'

begin
  require 'arel'
rescue LoadError
  require 'fake_arel'
  class ActiveRecord::Base
    named_scope :joins, lambda { |*join| { :joins => join } if join[0]}
  end
end

require 'cancan'
require 'cancan/matchers'
require 'ar_jdbc_pg_array'

ActiveRecord::Base.establish_connection \
  :adapter => 'postgresql',
  :database => 'postgres',
  :encoding => 'utf8'

begin
  ActiveRecord::Base.connection.create_database('test_pg_array', :encoding => 'utf8')
rescue
  # Database already exists
end

ActiveRecord::Base.establish_connection \
  :adapter => 'postgresql',
  :database => 'test_pg_array',
  :encoding => 'utf8'

# ActiveRecord::Base.logger = Logger.new(STDOUT) # if $0 == 'irb'

require 'tag'
require 'item'
require 'bulk'
require 'unrelated'

ActiveRecord::Base.silence do
  ActiveRecord::Migration.verbose = false

  # load schema
  load File.join('spec/fixtures/schema.rb')
  # load fixtures
  Fixtures = ActiveRecord::Fixtures  unless defined?(Fixtures)
  Fixtures.create_fixtures('spec/fixtures', ActiveRecord::Base.connection.tables)
end
