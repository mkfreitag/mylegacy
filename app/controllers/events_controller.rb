class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.create(event_params)
    if @event.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @event = Event.find_by_id(params[:id])
    return render_not_found if @event.blank?

    @artifact = Artifact.new

  end


  def edit
    @event = Event.find_by_id(params[:id])
    return render_not_found if @event.blank?
    return render_not_found(:forbidden) if @event.user != current_user

  end

  def update
    @event = Event.find_by_id(params[:id])
    return render_not_found if @event.blank?

    return render_not_found(:forbidden) if @event.user != current_user



    @event.update_attributes(event_params)

    if @event.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find_by_id(params[:id])
    return render_not_found if @event.blank?
    return render_not_found(:forbidden) if @event.user != current_user

    @event.destroy
    redirect_to root_path
  end


  private

  def event_params
    params.require(:event).permit(:title, :date, :picture)
  end
  
end
