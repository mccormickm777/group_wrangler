class GroupAttributeStringRelationshipsController < ApplicationController
  before_filter :signed_in_user
  #before_filter :admin_user

  def new
    @group = Group.find(params[:group])
    @possible_attribute = PossibleAttribute.find(params[:possible_attribute])
    @group_attribute_string_relationship = GroupAttributeStringRelationship.new
    @group_attribute_string_relationship.group_id = @group.id
    @group_attribute_string_relationship.possible_attribute_id = @possible_attribute.id
    set_title
    render 'edit'
  end

  def create
    @group_attribute_string_relationship = GroupAttributeStringRelationship.new(params[:group_attribute_string_relationship])
    @group = Group.find(@group_attribute_string_relationship.group_id)
    @possible_attribute = PossibleAttribute.find(@group_attribute_string_relationship.possible_attribute_id)
    if @group_attribute_string_relationship.save
      flash[:success] = "Property created!"
      update_group_users(@group)
      redirect_to_show_properties
    else
      set_title
      render 'edit'
    end
  end

  def edit
    @group_attribute_string_relationship = GroupAttributeStringRelationship.find(params[:id])
    @group = Group.find(@group_attribute_string_relationship.group_id)
    @possible_attribute = PossibleAttribute.find(@group_attribute_string_relationship.possible_attribute_id)
    set_title
    render 'edit'
  end

  def update
    @group_attribute_string_relationship = GroupAttributeStringRelationship.find(params[:id])
    @group = Group.find(@group_attribute_string_relationship.group_id)
    @possible_attribute = PossibleAttribute.find(@group_attribute_string_relationship.possible_attribute_id)
    if @group_attribute_string_relationship.update_attributes(params[:group_attribute_string_relationship])
      flash[:success] = "Property updated!"
      update_group_users(@group)
      redirect_to_show_properties
    else
      set_title
      render 'edit'
    end
  end

  def destroy
    @group_attribute_string_relationship = GroupAttributeStringRelationship.find(params[:id])
    @group = Group.find(@group_attribute_string_relationship.group_id)
    @group_attribute_string_relationship.destroy
    flash[:success] = "Property destroyed."
    redirect_to_show_properties
  end

  private

    def correct_group
      @group_attribute_string_relationship = current_group.group_attribute_string_relationships.find_by_id(params[:id])
      @group_attribute_string_relationships = current_group.group_attribute_string_relationships
      render 'index' if @group_attribute_string_relationship.nil?
    end

    def set_title
      @title = "Update #{@group.name}'s #{@possible_attribute.name}"
    end

    def redirect_to_show_properties
      redirect_to :controller => 'groups', :action => 'rules', :id => @group.id
    end
end
