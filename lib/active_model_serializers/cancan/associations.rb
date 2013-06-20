module ActiveModel
  class Serializer
    class Association #:nodoc:

      def authorize?
        !!options[:authorize]
      end

      class HasMany #:nodoc:

        def serialize_with_cancan
          return serialize_without_cancan unless authorize?
          object.select {|item| find_serializable(item).can?(:read, item) }.map do |item|
            find_serializable(item).serializable_hash
          end
        end
        alias_method_chain :serialize, :cancan

      end

      class HasOne #:nodoc:

        def serialize_with_cancan
          serializer = find_serializable(object)
          return nil unless !authorize? || serializer && serializer.can?(:read, object)
          serialize_without_cancan
        end
        alias_method_chain :serialize, :cancan

      end
    end
  end
end
