# ActiveModelSerializers::Cancancan

Provides a simple integration between [CanCanCan](https://github.com/CanCanCommunity/cancancan) and [Active Model Serializers](https://github.com/rails-api/active_model_serializers).

## Installation

Add this line to your application's Gemfile:

    gem 'active_model_serializers_cancancan'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_model_serializers_cancancan

## Usage

### Associations

`hasOne` and `hasMany` serializer macros now support an additional property, `authorize`. Associations with this property set to true will be authorized and filtered via CanCan. For example:

```ruby
class PostSerializer < ActiveModel::Serializer
  attributes :title, :content

  has_one :author, authorize: true
  has_many :comments, authorize: true
end
```

### Helpers

Serializers now also have access to the same helpers as controllers, namely `current_ability`, `can?`, and `cannot?`.

### Ability Serialization

Use the `abilities` helper method to add an `abilities` key to the serialized data. For example:

```ruby
class PostSerializer < ActiveModel::Serializer
  attributes :id
  abilities :show, :update
end

@post.as_json # { id: 1, abilities: { show: true, update: false } }
```

#### RESTful Alias

If `:restful` is passed as an ability it will expand to the 7 default
RESTful actions: `:index, :show, :new, :create, :edit, :update, :destroy`

#### Overriding an Ability

Abilities are checked by calling the `can_#{action}?` method.  By overriding this method the result for the ability can be customized. For example:

```ruby
class PostSerializer < ActiveModel::Serializer
  attributes :id
  abilities :show

  def can_show?
    session[:wizard_started] && can?(:show, object)
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
