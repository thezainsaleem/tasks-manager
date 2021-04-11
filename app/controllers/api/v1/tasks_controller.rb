class Api::V1::TasksController < ApplicationController
  before_action :create_params, only: [:create]
  before_action :update_params, only: [:update]

  def index
    render json: Task.all.to_json
  end

  def show
    render json: Task.find(params[:id]).to_json
  end

  def create
    if (task = Task.create(create_params)) && task.persisted?
      render json: task.to_json
    else
      render json: { errors: task.errors }, status: :unprocessable_entity
    end
  end

  def update
    task = Task.find(params[:id])
    if task.update_attributes(update_params)
      render json: task.to_json
    else
      render json: { errors: task.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    task = Task.find(params[:id])
    if task.destroy.destroyed?
      render json: task.to_json
    else
      render json: { errors: task.errors }, status: :unprocessable_entity
    end    
  end

  private
  def create_params
    params.require(:data).require(:attributes).permit(:title)
  end

  def update_params
    task_params = params.require(:data).require(:attributes).permit(:title, tags: [])
    return task_params if task_params[:tags].blank?
    task_params[:tags_attributes] = task_params[:tags].collect { |tag|  { title: tag } }
    task_params.delete(:tags)
    task_params
  end
end
