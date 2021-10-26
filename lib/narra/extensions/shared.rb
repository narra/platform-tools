# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

module Narra
  module Extensions
    module Shared
      extend ActiveSupport::Concern
      include Narra::Extensions::Meta

      included do
        after_create :narra_shared_initialize
      end

      def is_shared?
        # get public meta
        meta = get_meta(name: 'shared')
        # resolve
        meta.nil? ? false : meta.value == 'true'
      end

      def shared=(shared)
        self.update_meta(name: 'shared', value: shared)
      end

      protected

      def narra_shared_initialize
        self.add_meta(name: 'shared', value: false, hidden: true, public: false)
      end
    end
  end
end
