# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

module Narra
  module Extensions
    module Name
      extend ActiveSupport::Concern
      include Narra::Extensions::Meta

      included do
        after_create :narra_name_initialize
      end

      def name
        # get public meta
        meta = get_meta(name: 'name')
        # return
        meta.nil? ? '' : meta.value
      end

      def name=(name)
        self.update_meta(name: 'name', value: name)
      end

      protected

      def narra_name_initialize
        self.add_meta(name: 'name', value: '', hidden: false, public: true)
      end
    end
  end
end
