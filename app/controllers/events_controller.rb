class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def destroy
    @event = Event.find_by_id(params[:id])
    return render_not_found if @event.blank?
    @event.destroy
    redirect_to root_path
  end

  def update
    @event = Event.find_by_id(params[:id])
    return render_not_found if @event.blank?


    @event.update_attributes(event_params)

    if @event.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def new
    @event = Event.new
  end

  def index
    @events = Event.all
  end

  def show
    @event = Event.find_by_id(params[:id])
    return render_not_found if @event.blank?
  end

  def edit
    @event = Event.find_by_id(params[:id])
    return render_not_found if @event.blank?
  end

  def create
    @event = current_user.events.create(event_params)
    if @event.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :date, :picture)
  end

  def render_not_found
    render plain: 'Not Found :(', status: :not_found
  end
  
end
