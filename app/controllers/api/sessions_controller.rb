class Api::SessionsController < ApiController
    include JwtAuthenticator

    def create
        @current_user = User.find_by(email: params[:email])
        if @current_user && @current_user.authenticate(params[:password])
            encoded_token = encode(@current_user.id)
            render json: { user: @current_user, token: encoded_token }
        else
            render json: @current_user.errors.full_messages, status: :unauthorized
        end
    end
end
