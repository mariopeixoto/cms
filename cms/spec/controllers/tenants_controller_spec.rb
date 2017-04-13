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

    it "redirects to sign in when it's not authenticated" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "GET #show" do

    it "responds successfully with an HTTP 200 status code" do
      tenant1 = create(:tenant)
      user = create :user
      sign_in user

      get :show, id: tenant1.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      tenant1 = create(:tenant)
      user = create :user
      sign_in user

      get :show, id: tenant1.id
      expect(response).to render_template("show")
    end

    it "loads the condo requested into @condo" do
      tenant1, tenant2 = create(:tenant), create(:tenant)
      user = create :user
      sign_in user

      get :show, id: tenant1.id

      expect(assigns(:tenant)).to match(tenant1)
    end

    it "redirects to sign in when it's not authenticated" do
      tenant1 = create(:tenant)
      get :show, id: tenant1.id
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

      tenant = build :tenant

      expect {
        post :create, tenant: tenant.attributes
      }.to change(Tenant, :count).by(1)

      expect(assigns(:tenant)).to be_a(Tenant)
      expect(assigns(:tenant)).to be_persisted
    end

    it "does not create the client when there are validation errors" do
      user = create :user
      sign_in user

      tenant = build :tenant

      expect {
        post :create, tenant: tenant.attributes.except('ssn')
      }.to change(Tenant, :count).by(0)

      expect(assigns(:tenant)).to be_a(Tenant)
      expect(assigns(:tenant)).to_not be_persisted
    end

    it "redirects to sign in when it's not authenticated" do
      post :create
      expect(response).to redirect_to new_user_session_path
    end
  end
end
