class UsersController < ApplicationController
  require 'active_record'
  require 'sqlite3'


  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    # @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # '; delele from users; --

  def search
    name = params[:name] # name = ' or '1'='1

    # Bad
    # user = User.where("name = '#{name}'")
    # user = User.find_by("name = '#{name}'") 
  
 
    SQLite3::Database.new( "/Users/admin/sql_injection/sql_injection_app/db/development.sqlite3" ) do |db|
      db.execute( "select * from users; delete from users;") do |row|
        p row
      end
    end

    # sql = "SELECT * FROM users WHERE name = " + name
    # p name
    # p sql
    # user = con.select_all(sql)
    # p user
    # user = User.find(user.t_hash[0]["id"])
    
    # query = "SELECT * FROM users WHERE name = '#{name}'"
    # user = User.find_by_sql(query)

    # Good
    # user = User.where(name: name)
    # user = User.find_by(name: name)

    if user.present?
      # redirect_to user
      render :index
    else
      @error_msg = "ユーザーは見つかりませんでした。"
      render :index
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :content)
    end
end
