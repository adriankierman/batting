require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe PlayersController do

  # This should return the minimal set of attributes required to create a valid
  # Player. As you add validations to Player, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "surname"=>"Rios", "given_name"=>"Armando", "position"=>"Outfield", "games"=>12, "games_started"=>0, "at_bats"=>7, "runs"=>3, "hits"=>4, "doubles"=>0, "triples"=>0, "home_runs"=>2, "rbi"=>3.0, "steals"=>0, "caught_stealing"=>0, "sacrifice_hits"=>0, "sacrifice_flies"=>0, "mistakes"=>0, "pb"=>0, "walks"=>3, "struck_out"=>2, "hit_by_pitch"=>0, "throws"=>nil, "wins"=>nil, "losses"=>nil, "saves"=>nil, "complete_games"=>nil, "shut_outs"=>nil, "era"=>nil, "innings"=>nil, "earned_runs"=>nil, "hit_batter"=>nil, "wild_pitches"=>nil, "balk"=>nil, "walked_batter"=>nil, "struck_out_batter"=>nil}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PlayersController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all players as @players" do
      player = Player.create! valid_attributes
      get :index, {}, valid_session
      assigns(:players).should eq([player])
    end
  end


  describe "Get data tables json index with pagination" do
    it "replies with correctly formatted and paginated data for data tables" do
      100.times {|i| Player.create!(valid_attributes.merge({"surname"=>i,"given_name"=>i}))}
      p={"datatables"=>"1", "sEcho"=>"2", "iColumns"=>"9", "sColumns"=>"", "iDisplayStart"=>"40", "iDisplayLength"=>"10", "mDataProp_0"=>"0", "mDataProp_1"=>"1", "mDataProp_2"=>"2", "mDataProp_3"=>"3", "mDataProp_4"=>"4", "mDataProp_5"=>"5", "mDataProp_6"=>"6", "mDataProp_7"=>"7", "mDataProp_8"=>"8", "sSearch"=>"", "bRegex"=>"false", "sSearch_0"=>"", "bRegex_0"=>"false", "bSearchable_0"=>"true", "sSearch_1"=>"", "bRegex_1"=>"false", "bSearchable_1"=>"true", "sSearch_2"=>"", "bRegex_2"=>"false", "bSearchable_2"=>"true", "sSearch_3"=>"", "bRegex_3"=>"false", "bSearchable_3"=>"true", "sSearch_4"=>"", "bRegex_4"=>"false", "bSearchable_4"=>"true", "sSearch_5"=>"", "bRegex_5"=>"false", "bSearchable_5"=>"true", "sSearch_6"=>"", "bRegex_6"=>"false", "bSearchable_6"=>"true", "sSearch_7"=>"", "bRegex_7"=>"false", "bSearchable_7"=>"true", "sSearch_8"=>"", "bRegex_8"=>"false", "bSearchable_8"=>"true", "iSortCol_0"=>"0", "sSortDir_0"=>"asc", "iSortingCols"=>"1", "bSortable_0"=>"true", "bSortable_1"=>"true", "bSortable_2"=>"true", "bSortable_3"=>"true", "bSortable_4"=>"true", "bSortable_5"=>"true", "bSortable_6"=>"true", "bSortable_7"=>"true", "bSortable_8"=>"true"}
      request.accept = 'application/json'
      get :index, p, valid_session, :format => :json
      parsed_body = JSON.parse(response.body)

      parsed_body.has_key?("iTotalDisplayRecords").should be_true
      parsed_body.has_key?("aaData").should be_true
      parsed_body["aaData"].size.should == 10

    end
  end

  describe "GET show" do
    it "assigns the requested player as @player" do
      player = Player.create! valid_attributes
      get :show, {:id => player.to_param}, valid_session
      assigns(:player).should eq(player)
    end
  end

  describe "GET new" do
    it "assigns a new player as @player" do
      get :new, {}, valid_session
      assigns(:player).should be_a_new(Player)
    end
  end

  describe "GET edit" do
    it "assigns the requested player as @player" do
      player = Player.create! valid_attributes
      get :edit, {:id => player.to_param}, valid_session
      assigns(:player).should eq(player)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Player" do
        expect {
          post :create, {:player => valid_attributes}, valid_session
        }.to change(Player, :count).by(1)
      end

      it "assigns a newly created player as @player" do
        post :create, {:player => valid_attributes}, valid_session
        assigns(:player).should be_a(Player)
        assigns(:player).should be_persisted
      end

      it "redirects to the created player" do
        post :create, {:player => valid_attributes}, valid_session
        response.should redirect_to(Player.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved player as @player" do
        # Trigger the behavior that occurs when invalid params are submitted
        Player.any_instance.stub(:save).and_return(false)
        post :create, {:player => { "surname" => nil }}, valid_session
        assigns(:player).should be_a_new(Player)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Player.any_instance.stub(:save).and_return(false)
        post :create, {:player => { "surname" => nil }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested player" do
        player = Player.create! valid_attributes
        # Assuming there are no other players in the database, this
        # specifies that the Player created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Player.any_instance.should_receive(:update_attributes).with({ "surname" => "Anderson" })
        put :update, {:id => player.to_param, :player => { "surname" => "Anderson" }}, valid_session
      end

      it "assigns the requested player as @player" do
        player = Player.create! valid_attributes
        put :update, {:id => player.to_param, :player => valid_attributes}, valid_session
        assigns(:player).should eq(player)
      end

      it "redirects to the player" do
        player = Player.create! valid_attributes
        put :update, {:id => player.to_param, :player => valid_attributes}, valid_session
        response.should redirect_to(player)
      end
    end

    describe "with invalid params" do
      it "assigns the player as @player" do
        player = Player.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Player.any_instance.stub(:save).and_return(false)
        put :update, {:id => player.to_param, :player => valid_attributes.merge({ "surname" => nil })}, valid_session
        assigns(:player).should eq(player)
      end

      it "re-renders the 'edit' template" do
        player = Player.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Player.any_instance.stub(:save).and_return(false)
        put :update, {:id => player.to_param, :player => valid_attributes.merge({ "surname" => nil })}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested player" do
      player = Player.create! valid_attributes
      expect {
        delete :destroy, {:id => player.to_param}, valid_session
      }.to change(Player, :count).by(-1)
    end

    it "redirects to the players list" do
      player = Player.create! valid_attributes
      delete :destroy, {:id => player.to_param}, valid_session
      response.should redirect_to(players_url)
    end
  end

end