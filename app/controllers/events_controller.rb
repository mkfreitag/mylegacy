class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def index
  end

  def create
    @event = Event.create(event_params)
    if @event.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:title)
  end
  
end
