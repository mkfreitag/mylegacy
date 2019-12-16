require 'rails_helper'

RSpec.describe ArtifactsController, type: :controller do

  describe "artifacts#destroy action" do

    it "should allow a user to destroy artifacts" do
      event = FactoryBot.create(:event)
      artifact = FactoryBot.create(:artifact, comment: "lalala")

      sign_in artifact.user
#colon infront of something makes it a symbol, symbol then a colon can be used as an KEY in a hash
      delete :destroy, params: { event_id: event.id }
      expect(response).to redirect_to event_path(event_id)
      expect(artifact).to eq nil
    end

    it "should return a 404 message if we cannot find an artifact with the id that is specified" do
      user = FactoryBot.create(:user)
      sign_in user
      delete :destroy, params: { id: 'SPACEDUCK' }
      expect(response).to have_http_status(:not_found)
    end
  end


  describe "artifacts#update action" do

    it "should allow users to successfully update their artifacts" do
      artifact = FactoryBot.create(:artifact, comment: "lalala")

      sign_in artifact.event.user

      patch :update, params: { event_id: artifact.event_id, id: artifact.id, artifact: { comment: 'Changed' } }
      expect(response).to redirect_to redirect_to event_path(@event)
      artifact.reload
      expect(artifact.comment). to eq "Changed"
    end
  end


=begin

  describe "artifacts#create action" do
    it "should allow users to create comments on events" do
      event = FactoryBot.create(:event)

      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { event_id: event.id, artifact: { comment: 'awesome artifact' } }

      expect(response).to redirect_to event_path(event)
      expect(event.artifacts.length).to eq 1
      expect(event.artifacts.first.comment).to eq "awesome artifact"

    end

    it "should require a user to be logged in to comment on a event" do
      event = FactoryBot.create(:event)
      post :create, params: { event_id: event.id, artifact: { comment: 'awesome artifact' } }
      expect(response).to redirect_to new_user_session_path

    end

    it "should return http status code of not found if the event isn't found" do
      user = FactoryBot.create(:user)
      sign_in user
      post :create, params: { event_id: 'YOLOSWAG', artifact: { comment: 'awesome artifact' } }
      expect(response).to have_http_status :not_found
    end

  end
=end
end