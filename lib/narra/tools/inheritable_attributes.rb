# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

module Narra
  module Tools
    module InheritableAttributes

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def inheritable_attributes(*args)
          @inheritable_attributes ||= []
          @inheritable_attributes += args
          args.each do |arg|
            class_eval %( class << self; attr_accessor :#{arg} end )
          end
          @inheritable_attributes
        end

        def inherited(subclass)
          @inheritable_attributes.each do |inheritable_attribute|
            instance_var = "@#{inheritable_attribute}"
            subclass.instance_variable_set(instance_var, instance_variable_get(instance_var))
          end
        end
      end
    end
  end
end
