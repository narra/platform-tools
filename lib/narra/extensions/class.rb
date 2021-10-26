# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

module Narra
  module Extensions
    module Class

      def self.class_name_to_s(class_object)
        class_object.name.split('::').last.downcase
      end

      def self.class_name_to_sym(class_object)
        class_name_to_s(class_object).to_sym
      end

      def self.class_from_string(class_string)
        class_string.split('::').inject(Object) do |mod, class_name|
          mod.const_get(class_name)
        end
      end

      def self.descendants
        ObjectSpace.each_object(Class).select { |c| c < self }
      end
    end
  end
end
