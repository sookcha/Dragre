class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def edit
    @user = User.find(params[:id])
  end
  def show
    @user = User.find(params[:id])
    redirect_to '/users'
  end
  
  def new
    @user = User.new
  end
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
  def destroy
    if current_user
    if current_user.admin
    
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
    format.html { redirect_to(users_url) }
    format.xml  { head :ok }
  end
end
  end
  end
end
  