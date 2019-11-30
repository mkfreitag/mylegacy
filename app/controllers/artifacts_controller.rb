class ArtifactsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find_by_id(params[:event_id])
    return render_not_found if @event.blank?


    @event.artifacts.create(artifact_params.merge(user: current_user))
    redirect_to event_path(@event)
  end

  private

  def artifact_params
    params.require(:artifact).permit(:comment)
  end

end