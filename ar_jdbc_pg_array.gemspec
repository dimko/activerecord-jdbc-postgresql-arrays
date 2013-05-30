# encoding: utf-8
Gem::Specification.new do |gem|
  gem.name          = 'ar_jdbc_pg_array'
  gem.version       = '0.1.0'
  gem.platform      = 'java'

  gem.authors       = ['Sokolov Yura', 'Dimko']
  gem.email         = ['deemox@gmail.com']
  gem.description   = "ar_jdbc_pg_array includes support of PostgreSQL's int[], float[], text[], timestamptz[] etc. into ActiveRecord. You could define migrations for array columns, query on array columns."
  gem.summary       = 'Use power of PostgreSQL Arrays in ActiveRecord'
  gem.homepage      = 'https://github.com/dimko/activerecord-jdbc-postgresql-arrays'

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'activerecord', '~> 3.1'
  gem.add_dependency 'activerecord-jdbcpostgresql-adapter', '~> 1.2.9'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'cancan'
  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rspec',   '~> 2.5'
end
