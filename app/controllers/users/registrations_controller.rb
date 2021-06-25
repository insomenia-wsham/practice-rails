module Users
  class RegistrationsController < Devise::RegistrationsController
    include JWTSessions::RailsAuthorization
    protect_from_forgery with: :exception
    skip_before_action :authenticate_scope!, only: [:update]
    skip_before_action :verify_authenticity_token

    # before_action :current_api_user

    def create
      super do |user|
        if user.persisted?
          if resource.active_for_authentication?
            payload = { user_id: user.id, user: PayloadSerializer.new.serialize(user) }
            session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
            tokens = session.login

            response.set_cookie(
              JWTSessions.access_cookie,
              value: tokens[:access],
              httponly: true,
              secure: Rails.env.production?
            )

            render json: { csrf: tokens[:csrf], token: tokens[:access] } and return
          else
            render json: { error: I18n.t("devise.registrations.signed_up_but_inactive") }, status: :locked and return
          end
        else
          render json: user.errors.full_messages.join(" "), status: :unprocessable_entity and return
        end
      end
    end
    def update
      authorize_access_request!
      current_api_user ||= User.find(payload["user_id"])

      self.resource = current_api_user
    
        prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    
        resource_updated = update_resource(resource, account_update_params)

        yield resource if block_given?

        
        render json: { error: resource.errors.full_messages.first, status: 400 } and return if resource.errors.any?
      

        if resource_updated
          set_flash_message_for_update(resource, prev_unconfirmed_email)
          bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
    
          render json: { resource: resource }
        else
          clean_up_passwords resource
          set_minimum_password_length
          render json: { resource: resource }
        end

    end
  end

  private
  def current_api_user
    begin
      current_api_user ||= User.find(payload["user_id"])
    rescue StandardError => e
      current_api_user = nil
    end
  end

end
