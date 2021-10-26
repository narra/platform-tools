# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

module Narra
  module Extensions
    module Options

      def self.included base
        base.extend ClassMethods
      end

      module ClassMethods
        def parse_options(name, options = {})
          # get value
          value = options[name.to_s].nil? ? self.options[name.to_sym] : options[name.to_s]
          # parse value
          if value.to_s.include?(',')
            # return array value
            return value.split(',').collect { |item| item.strip }
          elsif ['true', 'false'].include?(value.to_s)
            # return boolean value
            return value == 'true'
          end
          # just return value
          return value
        end

        def to_array(value)
          value.kind_of?(Array) ? value : [value].reject { |item| item.empty? }
        end
      end
    end
  end
end
