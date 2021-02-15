class Api::UsersController < ApiController
    include JwtAuthenticator

    def create
        @user = User.new(user_params)
        if @user.save
            encoded_token = encode(@user.id)
            render json: { user: @user, token: encoded_token }
        else
            render json: @user.errors.full_messages, status: :unauthorized
        end
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            render json: @user
        else
            render json: @user.errors.full_messages, status: :not_found
        end
    end

    private
        def user_params
            params.permit(:name, :email, :password, :password_confirmation)
        end
end
