class GroupsController < ApplicationController
  before_filter :signed_in_user, 
                only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:new, :create, :edit, :update, :destroy]

  def index
    @groups = Group.paginate(page: params[:page])
    @title = "All groups"
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      flash[:success] = "Group created"
      update_group_users(@group)
      redirect_to @group
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      flash[:success] = "Profile updated"
      redirect_to @group
    else
      render 'edit'
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    flash[:success] = "Group destroyed."
    redirect_to groups_url
  end

  def rules
    @group = Group.find(params[:id])
    @title = "#{@group.name}'s Rules"
    @possible_attributes = PossibleAttribute.all
    @group_attribute_string_relationships = @group.group_attribute_string_relationships
    render 'show_rules'
  end

  def users
    @group = Group.find(params[:id])
    @title = "#{@group.name}'s Users"
    @users = @group.users.paginate(page: params[:page])
    render 'users/index'
  end

  private

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end