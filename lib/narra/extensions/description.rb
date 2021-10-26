# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

require 'narra/extensions'
require 'active_support/concern'

module Narra
  module Extensions
    module Description
      extend ActiveSupport::Concern
      include Narra::Extensions::Meta

      included do
        after_create :narra_description_initialize
      end

      def description
        # get public meta
        meta = get_meta(name: 'description')
        # return
        meta.nil? ? '' : meta.value
      end

      def description=(description)
        self.update_meta(name: 'description', value: description)
      end

      protected

      def narra_description_initialize
        self.add_meta(name: 'description', value: '', hidden: false, public: true)
      end
    end
  end
end
