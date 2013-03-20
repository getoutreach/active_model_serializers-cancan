# ActiveModelSerializers::Cancan

Provides a simple integration between [CanCan](https://github.com/ryanb/cancan) and [Active Model Serializers](https://github.com/josevalim/active_model_serializers).

## Installation

Add this line to your application's Gemfile:

    gem 'active_model_serializers-cancan'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_model_serializers-cancan

## Usage

`hasOne` and `hasMany` serializer macros now support an additional property, `authorize`. Associations with this property set to true will be authorized and filtered via CanCan. For example:

```ruby
class PostSerializer < ActiveModel::Serializer
  attributes :title, :content

  has_one :author, authorize: true
  has_many :comments, authorize: true
end

```

Serializers now also have access to the same helpers as controllers, namely `current_ability`, `can?`, and `cannot?`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
