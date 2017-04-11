require "rails_helper"

RSpec.describe ClientsController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      user = create :user
      sign_in user

      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      user = create :user
      sign_in user

      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the clients into @clients" do
      user = create :user
      sign_in user

      client1, client2 = create(:client), create(:client)
      get :index

      expect(assigns(:clients)).to match_array([client1, client2])
    end
  end
end
