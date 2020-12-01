# frozen_string_literal: true

module Request
  module Helpers
    module_function

    def json
      raise 'Response is nil. Are you sure you made a request?' unless response

      JSON.parse(response.body).with_indifferent_access
    end

    def base64_image
      "data:image/jpeg;base64,#{Base64.strict_encode64(File.open('public/sample_image.jpeg').read)}"
    end
  end
end
