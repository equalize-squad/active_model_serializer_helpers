# ActiveModelSerializerHelpers

Some Active Model Serializer RSpec Helpers and Matchers

[![CircleCI](https://circleci.com/gh/roalcantara/active_model_serializer_helpers/tree/master.svg?style=shield)](https://circleci.com/gh/roalcantara/active_model_serializer_helpers/tree/master)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_model_serializer_helpers'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_model_serializer_helpers

## Configuration

On `spec/active_model_serializer_helpers.rb`:

```ruby
RSpec.configure do |config|
  config.include ActiveModelSerializerHelpers, type: :serializer

  # set `:type` for serializers directory
  config.define_derived_metadata(file_path: Regexp.new("/spec/serializers")) do |metadata|
    metadata[:type] = :serializer
  end
end
```

## Usage

Given the model `app/models/user.rb`:

```ruby
class User < ApplicationRecord
end
```

The serializer `app/serializers/user_serializer.rb`:

```ruby
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name
end
```

And the controller `app/controllers/user_controller.rb`: 

```ruby
class UsersController < ApplicationController
  def show
    respond_to do |format|
      format.json do
        render json: @user, root: false
      end
    end
  end
end
```

Then, you can have `spec/serializers/user_serializer_spec.rb`:

```ruby
require "rails_helper"

RSpec.describe User do
  it { is_expected.to be_serializable }
end
```

And `spec/serializers/user_serializer_spec.rb`:

```ruby
require "rails_helper"

RSpec.describe UserSerializer do
  let(:user) { create :user }
  subject { serialize(user) }

  it { is_expected.to include(id: user.id, name: user.name) }
end
```

And `spec/controllers/user_controller_spec.rb`:

```ruby
require "rails_helper"

RSpec.describe UserController do
  describe "GET #show" do
    context "with format :json" do
      subject { get :show, params: { name: nil }, format: :json }

      it { expect(subject.body).to be_a_serialized(user).with(root: false) }
    end
  end  
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/active_model_serializer_helpers. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
