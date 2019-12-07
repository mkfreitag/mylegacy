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
    @artifact = Artifact.find_by_id(params[:id])

    return render_not_found if @artifact.blank?
    return render_not_found(:forbidden) if @artifact.user != current_user
  end

  def update
    @event = Event.find_by_id(params[:event_id])
    @artifact = Artifact.find_by_id(params[:id])

    return render_not_found if @artifact.blank?

    @artifact.update_attributes(artifact_params)

    if @artifact.valid?
      redirect_to event_path(@event)
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find_by_id(params[:event_id])
    @artifact = Artifact.find_by_id(params[:id])

    return render_not_found if @artifact.blank?
    return render_not_found(:forbidden) if @artifact.user != current_user


    @artifact.destroy
    redirect_to event_path(@event)
  end

  private

  def artifact_params
    params.require(:artifact).permit(:comment)
  end

end