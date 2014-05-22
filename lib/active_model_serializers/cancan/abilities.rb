module ActiveModel
  class Serializer
    module CanCan
      module Abilities
        extend ActiveSupport::Concern

        included do
          class_attribute :cancan_actions
        end

        def can
          cancan_actions.inject({}) do |hash, action|
            hash[action] = send("can_#{action}?")
            hash
          end
        end

        module ClassMethods
          def abilities(*actions)
            self.cancan_actions = expand_cancan_actions(actions)
            cancan_actions.each do |action|
              method = "can_#{action}?".to_sym
              unless method_defined?(method)
                define_method method do
                  can? action, object
                end
              end
            end
            attributes :can
          end

          private
          def expand_cancan_actions(actions)
            if actions.include? :restful
              actions.delete :restful
              actions |= [:index, :show, :new, :create, :edit, :update, :destroy]
            end
            actions
          end
        end

      end
    end
  end
end

ActiveModel::Serializer.send :include, ActiveModel::Serializer::CanCan::Abilities

