module ActiveModel
  class Serializer
    module Associations #:nodoc:

      class Config #:nodoc:

        def authorize?
          !!options[:authorize]
        end
      end

      class HasMany #:nodoc:

        def serialize_with_cancan
          return serialize_without_cancan unless authorize?
          associated_object.select {|item| find_serializable(item).can?(:read, item) }.map do |item|
            find_serializable(item).serializable_hash
          end
        end
        alias_method_chain :serialize, :cancan

      end

      class HasOne #:nodoc:

        def serialize_with_cancan
          object = associated_object
          serializer = find_serializable(object)
          #p !authorize?, serializer, serializer.can?(:read, object)
          return nil unless !authorize? || serializer && serializer.can?(:read, object)
          serialize_without_cancan
        end
        alias_method_chain :serialize, :cancan

      end
    end
  end
end
