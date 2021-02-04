class Api::OutlinesController < ApiController
    before_action :set_outline, only: [:update, :destroy]

    def index
        @outlines = Outline.all
        render json: @outlines
    end

    def create
        @outline = Outline.new(outline_params)
        @outline[:plan_id] = params[:plan_id]
        if @outline.save
            render json: @outline, status: :created
        else
            render json: @outline.errors.full_messages, status: :not_found
        end
    end

    def update
        if @outline.update(outline_params)
            render json: @outline
        else
            render json: @outline.errors.full_messages, status: :not_found
        end
    end

    def destroy
        @outline.destroy!
        head :no_content
    end

    def sort
        params[:outlines].each_with_index do |outline, i|
            @outline = Outline.find(outline[:id])
            @outline.update(sort: i)
        end
    end

    private
        def set_outline
            @outline = Outline.find(params[:id])
        end

        def outline_params
            params.permit(:date, :time, :schedule, :note, :plan_id)
        end
end
