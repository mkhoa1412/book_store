module Response
  def success_response(resource, status = :ok)
    render json: resource, status: status
  end

  def error_response(resource = { error: 'failed' }, status = :bad_request)
    error = if resource.respond_to?(:errors)
              resource.errors.full_messages.to_sentence
            else
              resource[:error]
            end
    render json: { error: error }, status: status
  end

  def exception_response(exception, status = :internal_server_error)
    render json: { error: exception.message }, status: status
  end
end
