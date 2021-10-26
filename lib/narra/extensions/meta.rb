# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

module Narra
  module Extensions
    module Meta

      def autosave
        true
      end

      def add_meta(options)
        # input check
        return if options[:name].nil? || options[:value].nil?
        # check generator
        if options[:generator].nil? && model.kind_of?(Narra::Item)
          if self.kind_of?(Narra::SPI::Generator)
            options[:generator] = self.class.identifier
          else
            return
          end
        end
        # create meta if model supports
        if model.respond_to?('meta')
          meta = model.meta.new(options)
          # autosave
          model.save if autosave
          # return new meta
          return meta
        end
        # return nil
        return
      end

      def update_meta(options)
        # input check
        return if options[:name].nil? || options[:value].nil?
        # retrieve meta
        meta = get_meta(name: options[:name], generator: options[:generator])
        # update value when the meta is founded
        unless meta.nil?
          meta.update_attributes(value: options[:value])
          # check for new generator field
          meta.update_attributes(generator: options[:new_generator]) unless options[:new_generator].nil?
        end
        # return meta
        meta
      end

      def get_meta(options)
        # do a query
        Meta.get_meta(model, options)
      end

      def self.get_meta(model, options)
        # check for model
        return nil if model.nil? and !model.respond_to?('meta')
        # do a query
        model.meta.find_by(options)
      end
    end
  end
end
