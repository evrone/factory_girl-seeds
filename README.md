[![Code Climate](https://codeclimate.com/github/evrone/factory_girl-seeds.png)](https://codeclimate.com/github/evrone/factory_girl-seeds)

# FactoryGirl Seeds

Make your test suite run time upto 2x faster and even more! factory_girl is a very usefull gem
for creating records in your DB easily but also is very sloooow. This small repo helps fix that problem.

## Installation

Add this line to your application's Gemfile:

    gem 'factory_girl-seeds', github: 'evrone/factory_girl-seeds'

And then execute:

    $ bundle

## Usage

Create records before test suite:

```ruby
FactoryGirl::SeedGenerator.create(:user, name: "John Appleseed")
```

And then use in other factory definitions

```ruby
FactoryGirl.define do
  factory :post do
    title "Demo"
    user { seed(:user) }
  end
end
```

or in specs

```ruby
@user = seed(:user)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
