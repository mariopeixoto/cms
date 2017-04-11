require "rails_helper"

RSpec.describe DebtsController, :type => :controller do
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

    it "loads all of the debts into @debts" do
      user = create :user
      sign_in user

      debt1, debt2 = create(:debt), create(:debt)
      get :index

      expect(assigns(:debts)).to match_array([debt1, debt2])
    end
  end
end
