require 'active_model_serializer_helpers/version'
require 'active_model_serializer_helpers/matchers'

module ActiveModelSerializerHelpers
  def serialize(obj, opts = {})
    serializer = opts.delete(:serializer_class)
    serializer = "#{obj.class.name}Serializer".constantize if serializer.nil?
    serializer = serializer.send(:new, obj)
    serializer.serializable_hash.with_indifferent_access
  end
end
