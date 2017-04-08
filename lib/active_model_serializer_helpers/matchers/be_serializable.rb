require 'rspec/core'

RSpec::Matchers.define :be_serializable do
  match do |actual|
    ActiveModel::Serializer.serializer_for(actual).present?
  end

  failure_message do |actual|
    "#{actual.class.name}Serializer does not exist"
  end
end
