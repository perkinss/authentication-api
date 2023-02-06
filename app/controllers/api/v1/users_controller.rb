class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # POST  /api/v1/users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: { message: "#{@user.username} created" }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/<username>
  def update
    if @user.update(user_params)
      render json: { message: "#{@user.username} updated" }, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/<username>
  # Destroys the user (TODO: and all their sessions when we implement cascading deletes in our redis)
  def destroy
    @user.destroy
  end

  private
  def set_user
    @user = User.find(params[username])
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end


end
