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

    it "redirects to sign in when it's not authenticated" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "GET #show" do

    it "responds successfully with an HTTP 200 status code" do
      unit1 = create(:unit)
      user = create :user
      sign_in user

      get :show, id: unit1.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      unit1 = create(:unit)
      user = create :user
      sign_in user

      get :show, id: unit1.id
      expect(response).to render_template("show")
    end

    it "loads the condo requested into @condo" do
      unit1, unit2 = create(:unit), create(:unit)
      user = create :user
      sign_in user

      get :show, id: unit1.id

      expect(assigns(:unit)).to match(unit1)
    end

    it "redirects to sign in when it's not authenticated" do
      unit1 = create(:unit)
      get :show, id: unit1.id
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

    it "creates the unit successfully when valid params are provided" do
      user = create :user
      sign_in user

      unit = build :unit

      expect {
        post :create, unit: unit.attributes
      }.to change(Unit, :count).by(1)

      expect(assigns(:unit)).to be_a(Unit)
      expect(assigns(:unit)).to be_persisted
    end

    it "does not create the unit when there are validation errors" do
      user = create :user
      sign_in user

      unit = build :unit

      expect {
        post :create, unit: unit.attributes.except('number')
      }.to change(Unit, :count).by(0)

      expect(assigns(:unit)).to be_a(Unit)
      expect(assigns(:unit)).to_not be_persisted
    end

    it "redirects to sign in when it's not authenticated" do
      post :create
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "GET #edit" do

    it "responds successfully with an HTTP 200 status code" do
      unit1 = create(:unit)
      user = create :user
      sign_in user

      get :edit, id: unit1.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(assigns(:unit)).to be_a(Unit)
      expect(assigns(:unit)).to match(unit1)
    end

    it "renders the edit template" do
      unit1 = create(:unit)
      user = create :user
      sign_in user

      get :edit, id: unit1.id
      expect(response).to render_template("edit")
      expect(assigns(:unit)).to be_a(Unit)
      expect(assigns(:unit)).to match(unit1)
    end

    it "redirects to sign in when it's not authenticated" do
      unit1 = create(:unit)
      get :edit, id: unit1.id
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "PUT #update" do

    it "creates the unit successfully when valid params are provided" do
      unit1 = create(:unit)
      user = create :user
      sign_in user

      unit_new = build :unit

      put :update, id: unit1.id, unit: unit_new.attributes

      expect(assigns(:unit)).to be_a(Unit)
      expect(assigns(:unit)).to be_persisted
      expect(assigns(:unit)).to have_attributes(:number => unit_new.number)
    end

    it "does not update the unit when there are validation errors" do
      unit1 = create(:unit)
      user = create :user
      sign_in user

      put :update, id: unit1.id, unit: {number: ""}

      expect(response).to render_template("edit")
    end

    it "redirects to sign in when it's not authenticated" do
      unit1 = create(:unit)
      put :update, id: unit1.id
      expect(response).to redirect_to new_user_session_path
    end
  end
end
