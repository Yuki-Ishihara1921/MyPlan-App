class Api::PlansController < ApiController
    include JwtAuthenticator
    before_action :set_current_user, only: [:index, :create]
    before_action :set_plan, only: [:show, :update, :destroy]
    before_action :plan_params, only: [:create, :update]

    def index
        @plans = Plan.where(user_id: @current_user_id).order('updated_at desc')
        render json: @plans
    end

    def show
        render json: @plan, :include => [:outlines, :details]
    end

    def create
        @plan = Plan.new(plan_params)
        @plan.user = @current_user
        if @plan.save
            render json: @plan, status: :created
        else
            render json: @plan.errors.full_messages, status: :not_found
        end
    end

    def update
        if @plan.update(plan_params)
            render json: @plan
        else
            render json: @plan.errors.full_messages, status: :not_found
        end
    end

    def destroy
        if @plan.destroy
            head :no_content
        else
            render json: @plan.errors.full_messages, status: :not_found
        end
    end

    private
        def set_current_user
            decoded_id = decode(request.headers['Authorization'])
            @current_user_id = decoded_id['user_id']
            @current_user = User.find(@current_user_id)
        end

        def set_plan
            @plan = Plan.find(params[:id])
        end

        def plan_params
            params.permit(:name, :start, :end, :days)
        end
end