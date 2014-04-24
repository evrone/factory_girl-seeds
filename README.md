[![Build Status](https://travis-ci.org/evrone/factory_girl-seeds.svg?branch=master)](https://travis-ci.org/evrone/factory_girl-seeds)
[![Code Climate](https://codeclimate.com/github/evrone/factory_girl-seeds.png)](https://codeclimate.com/github/evrone/factory_girl-seeds)

# FactoryGirl Seeds

Don't like factory_girl because it is slow? Do you know that creating records in DB through factory_girl can take up to 50% of total spec run time? And even more!

This tiny gem helps fix that problem by reusing data preloaded before running test suite.

![](seed.jpg)

## Benchmark

Without seeds:

```
Finished in 4 minutes 38.7 seconds
1402 examples, 0 failures, 0 pending
```

With seeds:

```
Finished in 2 minutes 40.6 seconds
1402 examples, 0 failures, 0 pending
```

```ruby
>> (2.minutes + 40.6.seconds) / (4.minutes + 38.7.seconds)
=> 0.5762468604233943
```

So it is just about 58% of time before seeds optimization :)

## Installation

Add this line to your application's Gemfile:

```ruby
group :test do
  gem 'factory_girl-seeds'
end
```

## Usage

### 1. Create records before test suite

```ruby
FactoryGirl::SeedGenerator.create(:user, name: "Carlos Castaneda")
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

### 4. Using Factory Girl traits

You can create models via factories and traits (like `create(:user, admin)`), but you *can not* obtain it with the `seed(:user, :admin)`. To be able to obtain a record it is recommended to define specific factories with a set of tratis and unique names just like in the example in [Getting stated](https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md#traits) guide:

```ruby
factory :user do
  name "Friendly User"
  login { name }

  trait :male do
    name   "John Doe"
    gender "Male"
  end

  trait :female do
    name   "Jane Doe"
    gender "Female"
  end

  trait :admin do
    admin true
  end

  factory :male_admin,   traits: [:male, :admin]
  factory :female_admin, traits: [:admin, :female]
end
```

When factories declared in this manner, you can obtain a record with `seed(:male_admin)`

## How it works?

```FactoryGirl::SeedGenerator.create``` method creates record in DB before transaction begins. Then ```it``` block starts transaction so when you update record returned by ```FactoryGirl.seed``` it is wrapped in transaction. This guarantees that every ```it``` block works with clean record.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
