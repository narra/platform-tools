# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

require 'active_support/core_ext/hash/indifferent_access'

module Narra
  module Tools
    class   DefaultsHash < ActiveSupport::HashWithIndifferentAccess
      def []=(key, val)
        # persist if there is no already
        if Narra::Tools::Settings.get(convert_key(key)).nil?
          Narra::Tools::Settings.set(convert_key(key), convert_value(val))
        end

        # call parent
        super(key, val)
      end
    end
  end
end
