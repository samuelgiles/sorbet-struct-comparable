![Sorbet](https://user-images.githubusercontent.com/2643026/84757714-60be0600-afbc-11ea-8c0e-7da839ea1712.png)

![Continuous Integration](https://github.com/tricycle/sorbet-struct-comparable/workflows/Continuous%20Integration/badge.svg)
# Making T::Struct's comparable since 2020

If you just want some simple equality checking on your `T::Struct`'s then you've come to the right place.

Out of the box Sorbet's super useful `T::Struct`'s (<https://sorbet.org/docs/tstruct>) are not comparable meaning two separate instances (i.e. different `#object_id`'s) of a `T::Struct` with identical attributes are not equal.

This behaviour can be confusing at first glance, especially if/when you start using `T::Struct`'s alongside RSpec where expectations such as `it { is_expected.to eq my_expected_struct }` will fail.

It makes sense for this comparable behaviour to not be baked into `T::Struct`'s by default since defining what makes two instances of something equal could be seen by some as business logic, but for the 90% of cases where you just want to run `<=>` over your attributes this mixin is a solution.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sorbet-struct-comparable'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sorbet-struct-comparable

## Usage

Just include `T::Struct::ActsAsComparable` in your struct, done!

```ruby
require 'sorbet-struct-comparable'

class BlogPost < T::Struct
  include T::Struct::ActsAsComparable

  class Topic < T::Enum
    enums do
      Cycling = new
      Music = new
      Walking = new
    end
  end

  const :title, String
  const :topic, Topic
end

blog_post = BlogPost.new(title: 'My Blog Post', topic: BlogPost::Topic::Cycling)
different_blog_post = BlogPost.new(title: 'Another Blog Post', topic: BlogPost::Topic::Walking)
identical_blog_post = BlogPost.new(title: 'My Blog Post', topic: BlogPost::Topic::Cycling)

blog_post == different_blog_post
# => false
blog_post == identical_blog_post
# => true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tricycle/sorbet-struct-comparable.
