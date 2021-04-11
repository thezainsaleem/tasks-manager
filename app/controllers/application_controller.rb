class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    render json: { error: "not_found" }, status: :not_found
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
