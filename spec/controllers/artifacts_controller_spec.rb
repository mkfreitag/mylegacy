require 'rails_helper'

RSpec.describe ArtifactsController, type: :controller do
  describe "artifacts#create action" do
    it "should allow users to create comments on events" do
      event = FactoryBot.create(:event)

      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { event_id: event.id, artifact: { comment: 'awesome event' } }

      expect(response).to redirect_to root_path
      expect(event.artifacts.length).to eq 1
      expect(event.artifacts.first.comment).to eq "awesome event"

    end

    it "should require a user to be logged in to comment on a event" do
      event = FactoryBot.create(:event)
      post :create, params: { event_id: event.id, artifact: { comment: 'awesome event' } }
      expect(response).to redirect_to new_user_session_path

    end

    it "should return http status code of not found if the event isn't found" do
      user = FactoryBot.create(:user)
      sign_in user
      post :create, params: { event_id: 'YOLOSWAG', artifact: { comment: 'awesome event' } }
      expect(response).to have_http_status :not_found
    end

  end
end
