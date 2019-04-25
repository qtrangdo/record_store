class RefreshController < ApplicationController
  before_action :authorize_refresh_by_access_request!

  def create
    session = JWTSession::Session.new(payload: claimless_payload, refresh_by_accesss_allowed: true)
    tokens = session.refresh_by_accesss_allowed do
      raise JWTSession::Errors::Unauthorized, "Something not right here"
    end
    response.set_cookie(
      JWTSession.access_cookie,
      value: tokens[:access],
      httponly: true,
      secure: Rails.env.production?
    )
    render json: { csrf: tokens[:csrf] }
  end
end