class EventsController < ApplicationController
  before_action :event_params, only:[:create, :update]
  def index
    events = Event.all
    render json: events
  end

  def show
    event = Event.find(params[:id])
    render json: event
  end

  def create
    event = Event.new(event_params)

    if event.save
      render json: {name: event.name, message: "保存をしました"}, status:200
    else
      render json: {message: "保存できませんでした", errors: event.erros.messages}, status:400
    end
  end

  def update
    event = Event.find(params[:id])
    
    if event.update(event_params)
      render json: {name: event.name, message: "更新しました"}, status:200
    else
      render json: {message: "更新できませんでした", errors: event.erros.messages}, status:400
    end
  end

  def destroy
    # 指定したidのイベントデータを削除する
    event = Event.find(params[:id])
    event.destroy!
    render json: event
  end

  private 

  def event_params
    params.permit(:id, :name, :start, :end, :timed, :description, :color)
  end
end
