class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :update_to_student, on: [:update ]
  
  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
   # byebug
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :age, :kind)
    end

    def update_to_student
      if params['user']
        if @user.kind == 1 && params['user']['kind'].to_i == 0
        error_message = @user.errors.add(:base, 'Kind can not be student because is teaching in at least one program')
          respond_to do |format|
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: error_message, status: :unprocessable_entity } 
          end
        elsif @user.kind == 0 && params['user']['kind'].to_i == 1
          error_message = @user.errors.add(:base, 'Kind can not be teacher because is studying in at least one program')
          respond_to do |format|
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: error_message, status: :unprocessable_entity } 
          end
        end
      end 
    end
end
