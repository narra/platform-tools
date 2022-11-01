# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

require 'json'

module Narra
  module Extensions
    module Stats
      extend ActiveSupport::Concern
      include Narra::Extensions::Meta

      included do
        after_create :narra_stats_initialize
      end

      def stats
        # get public meta
        meta = get_meta(name: 'stats')
        # return
        meta.nil? ? { 'items': 0 } : JSON.parse(meta.value)
      end

      # update stats field
      def update_stats
        self.update_meta(name: 'stats', value: { items: self.items.count }.to_json)
      end

      protected

      def narra_stats_initialize
        self.add_meta(name: 'stats', value: { items: 0 }.to_json, hidden: true, public: false)
      end
    end
  end
end
