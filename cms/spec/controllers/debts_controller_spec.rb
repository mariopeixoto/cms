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

    it "redirects to sign in when it's not authenticated" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "GET #show" do

    it "responds successfully with an HTTP 200 status code" do
      debt1 = create(:debt)
      user = create :user
      sign_in user

      get :show, id: debt1.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      debt1 = create(:debt)
      user = create :user
      sign_in user

      get :show, id: debt1.id
      expect(response).to render_template("show")
    end

    it "loads the condo requested into @condo" do
      debt1, debt2 = create(:debt), create(:debt)
      user = create :user
      sign_in user

      get :show, id: debt1.id

      expect(assigns(:debt)).to match(debt1)
    end

    it "redirects to sign in when it's not authenticated" do
      debt1 = create(:debt)
      get :show, id: debt1.id
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "GET #new" do

    it "responds successfully with an HTTP 200 status code" do
      user = create :user
      sign_in user

      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      user = create :user
      sign_in user

      get :new
      expect(response).to render_template("new")
    end

    it "redirects to sign in when it's not authenticated" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "POST #create" do

    it "creates the client successfully when valid params are provided" do
      user = create :user
      sign_in user

      debt = build :debt

      expect {
        post :create, debt: debt.attributes
      }.to change(Debt, :count).by(1)

      expect(assigns(:debt)).to be_a(Debt)
      expect(assigns(:debt)).to be_persisted
    end

    it "does not create the client when there are validation errors" do
      user = create :user
      sign_in user

      debt = build :debt

      expect {
        post :create, debt: debt.attributes.except('original_amount')
      }.to change(Debt, :count).by(0)

      expect(assigns(:debt)).to be_a(Debt)
      expect(assigns(:debt)).to_not be_persisted
    end

    it "redirects to sign in when it's not authenticated" do
      post :create
      expect(response).to redirect_to new_user_session_path
    end
  end
end
