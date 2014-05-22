module ActiveModel
  class Serializer
    module Associations
      class Config
        def authorize?
          !!options[:authorize]
        end
      end

      class HasMany
        def serialize_with_cancan
          return serialize_without_cancan unless authorize?
          associated_object.select {|item| find_serializable(item).can?(:read, item) }.map do |item|
            find_serializable(item).serializable_hash
          end
        end
        alias_method_chain :serialize, :cancan
      end

      class HasOne
        def serialize_with_cancan
          unless authorize?
            return serialize_without_cancan 
          end
          object = associated_object
          serializer = find_serializable(object)
          if serializer && serializer.can?(:read, object)
            serialize_without_cancan
          else
            nil
          end
        end
        alias_method_chain :serialize, :cancan
      end
    end
  end
end

