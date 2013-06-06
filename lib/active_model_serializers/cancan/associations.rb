module ActiveModel
  class Serializer
    module Associations #:nodoc:
      class Config #:nodoc:

        def authorize?
          !!option(:authorize)
        end

      end

      class HasMany #:nodoc:

        def serialize_with_cancan
          return serialize_without_cancan unless authorize?
          associated_object.select{|o| source_serializer.can?(:read, o)}.map do |item|
            find_serializable(item).serializable_hash
          end
        end
        alias_method_chain :serialize, :cancan

      end

      class HasOne #:nodoc:

        def serialize_with_cancan
          return nil unless !authorize? || source_serializer.can?(:read, associated_object)
          serialize_without_cancan
        end
        alias_method_chain :serialize, :cancan

      end
    end
  end
end
