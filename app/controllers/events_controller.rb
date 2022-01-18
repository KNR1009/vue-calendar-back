class EventsController < ApplicationController
  before_action :event_params, only:["create"]
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

  private 

  def event_params
    params.permit(:name, :start, :end, :timed, :description, :color)
  end
end
