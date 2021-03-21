module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |ex|
      exception_response(ex, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |ex|
      exception_response(ex, :unprocessable_entity)
    end

    rescue_from ArgumentError do |ex|
      exception_response(ex, :unprocessable_entity)
    end

    rescue_from Pagy::OverflowError do |ex|
      exception_response(ex, :forbidden)
    end
  end
end
