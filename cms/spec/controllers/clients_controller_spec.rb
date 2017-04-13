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

    it "redirects to sign in when it's not authenticated" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "GET #show" do

    it "responds successfully with an HTTP 200 status code" do
      client1 = create(:client)
      user = create :user
      sign_in user

      get :show, id: client1.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      client1 = create(:client)
      user = create :user
      sign_in user

      get :show, id: client1.id
      expect(response).to render_template("show")
    end

    it "loads the client requested into @client" do
      client1, client2 = create(:client), create(:client)
      user = create :user
      sign_in user

      get :show, id: client1.id

      expect(assigns(:client)).to match(client1)
    end

    it "redirects to sign in when it's not authenticated" do
      client1 = create(:client)
      get :show, id: client1.id
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

      client = build :client

      expect {
        post :create, client: client.attributes
      }.to change(Client, :count).by(1)

      expect(assigns(:client)).to be_a(Client)
      expect(assigns(:client)).to be_persisted
    end

    it "does not create the client when there are validation errors" do
      user = create :user
      sign_in user

      client = build :client

      expect {
        post :create, client: client.attributes.except('name')
      }.to change(Client, :count).by(0)

      expect(assigns(:client)).to be_a(Client)
      expect(assigns(:client)).to_not be_persisted
    end

    it "redirects to sign in when it's not authenticated" do
      post :create
      expect(response).to redirect_to new_user_session_path
    end
  end
end
