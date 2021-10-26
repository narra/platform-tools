# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/cache'

module Narra
  module Tools
    class Settings
      # default values
      cattr_accessor :defaults, :cache, :keys

      # default values init
      self.defaults = Narra::Tools::DefaultsHash.new

      # default cache init
      self.cache = ActiveSupport::Cache::NullStore.new

      # getter
      def self.get(name)
        _get_value(name)
      end

      # setter
      def self.set(name, value)
        _set_value(name, value)
      end

      # get hash with all settings stored
      def self.all
        # hash store
        result = {}
        # resolve cache keys
        if self.cache.kind_of?(ActiveSupport::Cache::RedisCacheStore)
          _keys = self.cache.redis.keys.select { |key| key.start_with?('narra_settings') }.collect { |key| key.split(':').last }
        else
          _keys = self.cache.instance_variable_get(:@data).keys
        end
        # get values
        (_keys | self.defaults.keys).each do |key|
          result[key] = self.get(key)
        end
        # return
        result
      end

      # get or set a variable with the variable as the called method
      def self.method_missing(method, *args)
        if self.respond_to?(method)
          super
        else
          # get method name
          method_name = method.to_s
          # set a value for a variable
          if method_name =~ /=$/
            # get property name
            name = method_name.gsub('=', '')
            # get value to be set
            value = args.first
            # set value
            _set_value(name, value)
          else
            # retrieve value
            _get_value(method_name)
          end
        end
      end

      private

      def self._get_value(name)
        # get from cache
        self.cache.fetch(name) do
          # get default value
          defaults[name]
        end
      end

      def self._set_value(name, value)
        # set value to the cache if not the same as default
        unless value == defaults[name]
          self.cache.write(name, value)
        end
      end
    end
  end
end
