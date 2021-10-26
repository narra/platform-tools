# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

module Narra
  module Extensions
    module Progress

      def event=(event)
        @event = event
      end

      def event
        @event
      end

      def set_progress(progress, message = nil)
        # cache progress locally
        @progress ||= 0.0
        # if changed more than 2% push it
        if (progress - @progress) >= 0.02 || (progress - @progress) < 0
          # update event
          event.set_progress(progress)
          # update cache
          @progress = progress
        end
        # set up message if entered
        @event.update_attribute(:message, message) if message
      end
    end
  end
end
