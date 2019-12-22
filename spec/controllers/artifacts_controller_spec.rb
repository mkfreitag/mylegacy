require 'rails_helper'

RSpec.describe ArtifactsController, type: :controller do
=begin
  describe "artifacts#destroy action" do

    it "should allow a user to destroy artifacts" do
      event = FactoryBot.create(:event)
      artifact = FactoryBot.create(:artifact)

      delete :destroy, params: { event_id: event.id, artifact_id: artifact.id }
      expect(response).to redirect_to event_path(event_id)
      expect(artifact).to eq nil
    end

    it "should return a 404 message if we cannot find an artifact with the id that is specified" do
      user = FactoryBot.create(:user)

      delete :destroy, params: { id: 'SPACEDUCK' }
      expect(response).to have_http_status(:not_found)
    end
  end


  describe "artifacts#update action" do

    it "should allow users to successfully update their artifacts" do
      artifact = FactoryBot.create(:artifact, comment: "lalala")

      patch :update, params: { event_id: artifact.event_id, id: artifact.id, artifact: { comment: 'Changed' } }
      expect(response).to redirect_to redirect_to event_path(@event)
      artifact.reload
      expect(artifact.comment). to eq "Changed"
    end
  end
=end

  describe "artifacts#create action" do
    it "should allow users to create comments on artifacts" do
      event = FactoryBot.create(:event)
      artifact = FactoryBot.create(:artifact)
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { event_id: event.id, artifact: { comment: 'awesome artifact', video: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'small.mp4').to_s, 'video/mp4') } }

      expect(response).to redirect_to event_path(event)
      expect(event.artifacts.length).to eq 1
      expect(event.artifacts.first.comment).to eq "awesome artifact"

    end

    it "should require a user to be logged in to comment on an artifact" do
      event = FactoryBot.create(:event)
      artifact = FactoryBot.create(:artifact)
      user = FactoryBot.create(:user)
      sign_in user
      post :create, params: { event_id: event.id, artifact: { comment: 'awesome artifact' } }
      expect(response.status).to eq(422)
    end
=begin
    it "should return http status code of not found if the artifact isn't found" do
      event = FactoryBot.create(:event)
      artifact = FactoryBot.create(:artifact)
      user = FactoryBot.create(:user)
      sign_in user
      post :create, params: { event_id: 'YOLOSWAG', artifact: { comment: 'awesome artifact', video: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'small.mp4').to_s, 'video/mp4') } }
      expect(response).to have_http_status :not_found
    end
=end

  end
end