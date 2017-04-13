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

    it "redirects to sign in when it's not authenticated" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "GET #show" do

    it "responds successfully with an HTTP 200 status code" do
      condo1 = create(:condo)
      user = create :user
      sign_in user

      get :show, id: condo1.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      condo1 = create(:condo)
      user = create :user
      sign_in user

      get :show, id: condo1.id
      expect(response).to render_template("show")
    end

    it "loads the condo requested into @condo" do
      condo1, condo2 = create(:condo), create(:condo)
      user = create :user
      sign_in user

      get :show, id: condo1.id

      expect(assigns(:condo)).to match(condo1)
    end

    it "redirects to sign in when it's not authenticated" do
      condo1 = create(:condo)
      get :show, id: condo1.id
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

      condo = build :condo

      expect {
        post :create, condo: condo.attributes
      }.to change(Condo, :count).by(1)

      assigns(:condo).should be_a(Condo)
      assigns(:condo).should be_persisted
    end

    it "does not create the client when there are validation errors" do
      user = create :user
      sign_in user

      condo = build :condo

      expect {
        post :create, condo: condo.attributes.except('name')
      }.to change(Condo, :count).by(0)

      assigns(:condo).should be_a(Condo)
      assigns(:condo).should_not be_persisted
    end

    it "redirects to sign in when it's not authenticated" do
      post :create
      expect(response).to redirect_to new_user_session_path
    end
  end
end
