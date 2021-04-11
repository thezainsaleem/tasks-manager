class Api::V1::TagsController < ApplicationController
  before_action :tag_params, only: [:create, :update]

  def index
    render json: Tag.all.to_json
  end

  def show
    render json: Tag.find(params[:id]).to_json
  end

  def create
    if (tag = Tag.create(tag_params)) && tag.persisted?
      render json: tag.to_json
    else
      render json: { errors: tag.errors }, status: :unprocessable_entity
    end
  end

  def update
    tag = Tag.find(params[:id])
    if tag.update_attributes(tag_params)
      render json: tag.to_json
    else
      render json: { errors: tag.errors }, status: :unprocessable_entity
    end
  end

  private
  def tag_params
    params.require(:data).require(:attributes).permit(:title)
  end
end
