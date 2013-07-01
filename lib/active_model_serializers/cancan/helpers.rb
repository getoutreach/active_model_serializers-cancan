module ActiveModel
  class Serializer
    module CanCan
      module Helpers
        def current_ability
          Ability.new(options[:scope])
        end

        def can?(*args)
          current_ability.can? *args
        end

        def cannot?(*args)
          current_ability.cannot? *args
        end
      end
    end
  end
end

ActiveModel::Serializer.send :include, ActiveModel::Serializer::CanCan::Helpers
