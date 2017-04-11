require "rails_helper"

RSpec.describe UnitsController, :type => :controller do
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

    it "loads all of the units into @units" do
      user = create :user
      sign_in user

      unit1, unit2 = create(:unit), create(:unit)
      get :index

      expect(assigns(:units)).to match_array([unit1, unit2])
    end
  end
end
