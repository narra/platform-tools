# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

require 'wisper'

module Narra
  module Tools
    class Logger
      include Singleton
      include Wisper::Publisher

      def log(level, message, name = 'system')
        broadcast(:narra_system_log, { level: level, message: "#{name} # #{message}" })
      end

      def log_info(message, name = 'system')
        log(:info, message, name)
      end

      def log_error(message, name = 'system')
        log(:error, message, name)
      end

      def log_debug(message, name = 'system')
        log(:debug, message, name)
      end
    end
  end
end
