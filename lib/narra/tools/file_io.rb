# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

module Narra
  module Tools
    class FileIO < StringIO

      # attributes
      attr_reader :original_filename

      # constructor
      def initialize(stream, filename)
        # delegate to upstream
        super(stream)
        # save filename
        @original_filename = filename
      end
    end
  end
end
