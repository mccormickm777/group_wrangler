class UserAttributeStringRelationshipsController < ApplicationController
  before_filter :signed_in_user
  #before_filter :admin_user

  def new
    @user = User.find(params[:user])
    @possible_attribute = PossibleAttribute.find(params[:possible_attribute])
    @user_attribute_string_relationship = UserAttributeStringRelationship.new
    @user_attribute_string_relationship.user_id = @user.id
    @user_attribute_string_relationship.possible_attribute_id = @possible_attribute.id
    set_title
    render 'edit'
  end

  def create
    @user_attribute_string_relationship = UserAttributeStringRelationship.new(params[:user_attribute_string_relationship])
    @user = User.find(@user_attribute_string_relationship.user_id)
    @possible_attribute = PossibleAttribute.find(@user_attribute_string_relationship.possible_attribute_id)
    if @user_attribute_string_relationship.save
      flash[:success] = "Property created!"
      update_user_groups(@user)
      redirect_to_show_properties
    else
      set_title
      render 'edit'
    end
  end

  def edit
    @user_attribute_string_relationship = UserAttributeStringRelationship.find(params[:id])
    @user = User.find(@user_attribute_string_relationship.user_id)
    @possible_attribute = PossibleAttribute.find(@user_attribute_string_relationship.possible_attribute_id)
    set_title
    render 'edit'
  end

  def update
    @user_attribute_string_relationship = UserAttributeStringRelationship.find(params[:id])
    @user = User.find(@user_attribute_string_relationship.user_id)
    @possible_attribute = PossibleAttribute.find(@user_attribute_string_relationship.possible_attribute_id)
    if @user_attribute_string_relationship.update_attributes(params[:user_attribute_string_relationship])
      flash[:success] = "Property updated!"
      update_user_groups(@user)
      redirect_to_show_properties
    else
      set_title
      render 'edit'
    end
  end

  def destroy
    @user_attribute_string_relationship = UserAttributeStringRelationship.find(params[:id])
    @user = User.find(@user_attribute_string_relationship.user_id)
    @user_attribute_string_relationship.destroy
    flash[:success] = "Property destroyed."
    redirect_to_show_properties
  end

  private

    def correct_user
      @user_attribute_string_relationship = current_user.user_attribute_string_relationships.find_by_id(params[:id])
      @user_attribute_string_relationships = current_user.user_attribute_string_relationships
      render 'index' if @user_attribute_string_relationship.nil?
    end

    def set_title
      @title = "Update #{@user.name}'s #{@possible_attribute.name}"
    end

    def redirect_to_show_properties
      redirect_to :controller => 'users', :action => 'properties', :id => @user.id
    end
end
