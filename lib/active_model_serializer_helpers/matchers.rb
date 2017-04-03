require 'active_model_serializer_helpers/matchers/be_serializable'
require 'active_model_serializer_helpers/matchers/be_a_serialized'

module ActiveModelSerializerHelpers
  module Matchers
    class << self
      # @private
      attr_accessor :assertion_exception_class
    end
  end
end
