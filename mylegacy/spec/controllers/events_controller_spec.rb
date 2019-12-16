=begin
require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  describe "events#destroy action" do

    it "shouldn't allow users who didn't create the event to destroy it" do
      event = FactoryBot.create(:event)
      user = FactoryBot.create(:user)
      sign_in user
      delete :destroy, params: { id: event.id }
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticated users destroy an event" do
      event = FactoryBot.create(:event)
      delete :destroy, params: { id: event.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "should allow a user to destroy events" do
      event = FactoryBot.create(:event)
      sign_in event.user
      delete :destroy, params: { id: event.id }
      expect(response).to redirect_to root_path
      event = Event.find_by_id(event.id)
      expect(event).to eq nil
    end

    it "should return a 404 message if we cannot find an event with the id that is specified" do
      user = FactoryBot.create(:user)
      sign_in user
      delete :destroy, params: { id: 'SPACEDUCK' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "events#update action" do

    it "shouldn't let users who didn't create the event update it" do
      event = FactoryBot.create(:event)
      user = FactoryBot.create(:user)
      sign_in user
      patch :update, params: { id: event.id, event: { title: 'wahoo' } }
      expect(response).to have_http_status(:forbidden)


    end

    it "shouldn't let unauthenticated users update an event" do
      event = FactoryBot.create(:event)
      patch :update, params: { id: event.id, event: { title: "Hello" } }
      expect(response).to redirect_to new_user_session_path
    end

    it "should allow users to successfully update their events" do
      event = FactoryBot.create(:event, title: "Initial Value")
      sign_in event.user

      patch :update, params: { id: event.id, event: { title: 'Changed' } }
      expect(response).to redirect_to root_path
      event.reload
      expect(event.title). to eq "Changed"
    end

    it "should have http 404 error if the event cannot be found" do
      user = FactoryBot.create(:user)
      sign_in user

      patch :update, params: { id: "YOLOSWAG", event: { title: 'Changed' } }
      expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with an http status of unprocessable_entity" do
      event = FactoryBot.create(:event, title: "Initial Value")
      sign_in event.user


      patch :update, params: { id: event.id, event: { title: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      event.reload
      expect(event.title).to eq "Initial Value"
    end
  end

  describe "events#edit action" do

    it "shouldn't let a user who did not create the event edit an event" do
      event = FactoryBot.create(:event)
      user = FactoryBot.create(:user)
      sign_in user
      get :edit, params: { id: event.id }
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticated users edit an event" do
      event = FactoryBot.create(:event)
      get :edit, params: { id: event.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the edit form if the event is found" do
      event = FactoryBot.create(:event)
      sign_in event.user

      get :edit, params: { id: event.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error message if the event is not found" do
      user = FactoryBot.create(:user)
      sign_in user

      get :edit, params: { id: 'SWAG'}
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "events#show action" do
    it "should successfully show the page if the event is found" do
      user = FactoryBot.create(:user)
      sign_in user
      event = FactoryBot.create(:event)
      get :show, params: { id: event.id }
      expect(response).to have_http_status(:success)

    end

    it "should return a 404 error if the event is not found" do
      user = FactoryBot.create(:user)
      sign_in user
      get :show, params: { id: 'TACOCAT' }
      expect(response).to have_http_status(:not_found)

    end
  end


  describe "events#index action" do
    it "should successfully show the page" do
      user = FactoryBot.create(:user)
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "events#new action" do

    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path

    end

    it "should successfully show the new form" do

      user = FactoryBot.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "events#create action" do

    it "should require users to be logged in" do
      post :create, params: { event: { title: "Hello" } }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new event in our database" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { event: { title: 'Hello!', date: Date.new(), picture: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'picture.png').to_s, 'image/png') } }
      expect(response).to redirect_to root_path

      event = Event.last
      expect(event.title).to eq("Hello!")
      expect(event.user).to eq(user)
    end

    it "should properly deal with validation errors" do
      user = FactoryBot.create(:user)
      sign_in user

      event_count = Event.count
      post :create, params: { event: { title: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(event_count).to eq Event.count
    end
  end
end
=end