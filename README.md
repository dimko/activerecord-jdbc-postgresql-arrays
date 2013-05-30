## ActiveRecord JDBC PostgreSQL Arrays [![Build Status](https://travis-ci.org/dimko/activerecord-jdbc-postgresql-arrays.png?branch=master)](https://travis-ci.org/dimko/activerecord-jdbc-postgresql-arrays)

This library adds ability to use PostgreSQL array types with ActiveRecord.

### Queries

```ruby
User.find(:all, :conditions => ['arr @> ?', [1,2,3].pg])
#  SELECT * FROM "users" WHERE ('arr' @> E'{"1", "2", "3"}')
User.find(:all, :conditions => ['arr @> ?', [1,2,3].pg(:integer)])
#  SELECT * FROM "users" WHERE (arr @> '{1,2,3}')
User.find(:all, :conditions => ['arr @> ?', [1,2,3].pg(:float)])
#  SELECT * FROM "users" WHERE (arr @> '{1.0,2.0,3.0}')
u = User.find(1)
#  SELECT * FROM "users" WHERE ("users"."id" = 1)
#=> #<User id: 1, ..., arr: [1,2]>
u.arr = [3,4]
u.save
#  UPDATE "users" SET "db_ar" = '{3.0,4.0}' WHERE "id" = 19
User.find(:all, :conditions => { :arr => [3,4].pg })
#  SELECT * FROM "users" WHERE ("users"."arr" = E'{"3", "4"}')
User.find(:all, :conditions => { :arr => [3,4].search_any(:float) })
#  SELECT * FROM "users" WHERE ("users"."arr" && '{3.0,4.0}')
User.find(:all, :conditions => { :arr => [3,4].search_all(:integer) })
#  SELECT * FROM "users" WHERE ("users"."arr" @> '{3,4}')
User.find(:all, :conditions => { :arr => [3,4].search_subarray(:safe) })
#  SELECT * FROM "users" WHERE ("users"."arr" <@ '{3,4}')
```

### Migrations

```ruby
class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer_array :int_ar
    end
    add_column :users, :fl_ar, :float_array
  end
end
```

### Installation

Add this line to your application's Gemfile:

    gem 'ar_jdbc_pg_array'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ar_jdbc_pg_array

### Credits

Copyright (c) 2010-2013 Sokolov Yura aka funny_falcon, released under the MIT license.
