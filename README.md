[![Code Climate](https://codeclimate.com/github/evrone/factory_girl-seeds.png)](https://codeclimate.com/github/evrone/factory_girl-seeds)

# FactoryGirl Seeds

Do you know that creating records in DB through factory_girl can take up to 50% of total spec run time? And even more!

This tiny gem helps fix that problem by reusing data preloaded before running test suite.

## Installation

Add this line to your application's Gemfile:

```ruby
group :test do
  gem 'factory_girl-seeds', github: 'evrone/factory_girl-seeds'
end
```

## Usage

### 1. Create records before test suite

```ruby
FactoryGirl::SeedGenerator.create(:user, name: "John Appleseed")
```

For example if you are using rspec then add this to ```config.before(:suite)```.

### 2. Use in factory definitions

This is the most important step because most of time factory_girl spends on creating associations which in turn also create associations and so on recursively.

```ruby
FactoryGirl.define do
  factory :post do
    title "Demo"
    user { seed(:user) }
  end
end
```

### 3. Use in `it` blocks.

Also if you need standard factory without overriding attributes then do not create records. Just use one from preloaded seeds.

```ruby
it "should do something" do
  user = FactoryGirl.seed(:user)

  # your code here
end
```

Short DSL also available:

```ruby
user = seed(:user)
```

## How it works?

```FactoryGirl::SeedGenerator.create``` method creates record in DB before transaction begins. Then ```it``` block starts transaction so when you update record returned by ```FactoryGirl.seed``` it is wrapped in transaction. This guarantees that every ```it``` block works with clean record.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
