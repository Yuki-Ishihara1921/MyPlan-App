class Api::DetailsController < ApiController
    before_action :set_detail, only: [:update, :destroy]

    def index
        @details = Detail.all
        render json: @details
    end

    def create
        @detail = Detail.new(detail_params)
        @detail[:plan_id] = params[:plan_id]
        if @detail.save
            render json: @detail, status: :created
        else
            render json: @detail.errors.full_messages, status: :not_found
        end
    end

    def update
        if @detail.update(detail_params)
            render json: @detail
        else
            render json: @outline.errors.full_messages, status: :not_found
        end
    end

    def destroy
        @detail.destroy!
        head :no_content
    end

    def sort
        params[:details].each_with_index do |detail, i|
            @detail = Detail.find(detail[:id])
            @detail.update(sort: i)
        end
    end

    private
        def set_detail
            @detail = Detail.find(params[:id])
        end

        def detail_params
            params.permit(:date, :time, :schedule, :note, :plan_id)
        end
end
