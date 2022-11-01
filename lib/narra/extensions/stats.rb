# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

module Narra
  module Extensions
    module Stats
      extend ActiveSupport::Concern
      include Narra::Extensions::Meta

      included do
        after_create :narra_stats_initialize
      end

      def name
        # get public meta
        meta = get_meta(name: 'stats')
        # return
        meta.nil? ? { items: 0 } : meta.value
      end

      def stats=(stats)
        self.update_meta(name: stats, value: stats)
      end

      # update stats field
      def update_stats
        self.stats = { items: self.items.count }
      end

      protected

      def narra_stats_initialize
        self.add_meta(name: 'stats', value: { items: 0 }, hidden: false, public: true)
      end
    end
  end
end
