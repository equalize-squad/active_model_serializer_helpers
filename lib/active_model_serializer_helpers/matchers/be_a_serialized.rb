require "rspec/core"

RSpec::Matchers.define :be_a_serialized do |object|
  match do |actual|
    serialized_json(object) == actual
  end

  chain :with do |options = {}|
    @options = options
  end

  description do
    "be a serialized #{name(object)} using " \
    "#{ActiveModel::Serializer.serializer_for(model(object))} with #{@options}"
  end

  def name(object)
    model(object).model_name.human
  end

  def model(object)
    return object.first if object.is_a?(Array)
    object
  end

  failure_message do |actual|
    "expected #{actual} to be_serialized as #{serialized_json(object)}, " \
    "got #{actual}"
  end

  def serialized_json(object)
    adapted = ActiveModelSerializers::SerializableResource.new(object, @options)
    adapted.serializable_hash.to_json
  end
end
