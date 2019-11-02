require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "devents#index" do
    it "should successflly show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
