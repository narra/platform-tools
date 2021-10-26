# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

module Narra
  module Extensions
    module Thumbnail

      def url_thumbnail
        url_thumbnails.first
      end

      def url_thumbnails
        # get thumbnail if not resolved yet
        self.thumbnails
      end
    end
  end
end
