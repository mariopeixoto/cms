require "rails_helper"

RSpec.describe CondosController, :type => :controller do
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

    it "loads all of the condos into @condos" do
      user = create :user
      sign_in user

      condo1, condo2 = create(:condo), create(:condo)
      get :index

      expect(assigns(:condos)).to match_array([condo1, condo2])
    end
  end
end
