require "rails_helper"

RSpec.describe TenantsController, :type => :controller do
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

    it "loads all of the tenants into @tenants" do
      user = create :user
      sign_in user

      tenant1, tenant2 = create(:tenant), create(:tenant)
      get :index

      expect(assigns(:tenants)).to match_array([tenant1, tenant2])
    end
  end
end
