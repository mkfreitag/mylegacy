class ArtifactsController < ApplicationController
  before_action :authenticate_user!

  def new
    @artifact = Artifact.new
  end

  def create
    @event = Event.find_by_id(params[:event_id])
    @artifact = Artifact.find_by_id(params[:id])
    return render_not_found if @event.blank?


    @event.artifacts.create(artifact_params.merge(user: current_user))
    redirect_to event_path(@event)
  end

  def edit
    @event = Event.find_by_id(params[:event_id])
    @artifact = Artifact.find_by_id(params[:id])

    return render_not_found if @event.artifacts.blank?
    return render_not_found(:forbidden) if @event.user != current_user
  end

  def update
    @event = Event.find_by_id(params[:event_id])
    @artifact = Artifact.find_by_id(params[:id])

    return render_not_found if @event.artifacts.blank?

    @event.artifact.update_attributes(artifact_params)

    if @event.artifacts.valid?
      redirect_to event_artifact_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find_by_id(params[:event_id])
    @artifact = Artifact.find_by_id(params[:id])

    return render_not_found @event.artifacts.blank?
    return render_not_found(:forbidden) if @event.user != current_user

    @event.artifacts.destroy
    redirect_to event_artifact_path
  end

  private

  def artifact_params
    params.require(:artifact).permit(:comment)
  end

end