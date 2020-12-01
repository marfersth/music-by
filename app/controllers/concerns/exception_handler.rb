# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from Exception do |exception|
      render json: { errors: exception.message }, status: :internal_server_error
    end
  end
end
