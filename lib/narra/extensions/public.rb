# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

module Narra
  module Extensions
    module Public
      extend ActiveSupport::Concern
      include Narra::Extensions::Meta

      included do
        after_create :narra_public_initialize
      end

      def is_public?
        # get public meta
        meta = get_meta(name: 'public')
        # resolve
        meta.nil? ? false : meta.value == 'true'
      end

      def public=(public)
        self.update_meta(name: 'public', value: public)
      end

      protected

      def narra_public_initialize
        self.add_meta(name: 'public', value: false, hidden: true, public: false)
      end
    end
  end
end
