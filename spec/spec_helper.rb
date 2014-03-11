require 'factory_girl'
require 'active_record'
require 'factory_girl-seeds'

ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('test')

ActiveRecord::Migration.verbose = false
ActiveRecord::Schema.define(version: 0) do
  create_table "users", force: true do |t|
    t.string   "name"
  end
end

class User < ActiveRecord::Base;end

FactoryGirl.define do
  factory :user do
    name "AB"

    trait :david do
      name 'David'
    end
  end
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
