module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def update_user_groups(user)
  	groups = Group.all
  	groups.each do |group|
  	  update_relationship(user, group)
  	end
  end

  def update_group_users(group)
  	users = User.all
  	users.each do |user|
  	  update_relationship(user, group)
  	end
  end

  def update_relationship(user, group)
    counter = 0
	  existing_relationship = UserGroupRelationship.find_by_user_id_and_group_id(user.id, group.id)
	  group_rules = group.group_attribute_string_relationships
  	group_rules.each do |group_rule|
  	  user_properties = user.user_attribute_string_relationships
  	  user_properties.each do |user_property|
  	    if (group_rule.possible_attribute_id == user_property.possible_attribute_id &&
  	        group_rule.value == user_property.value)
  	      counter += 1
  	    if (existing_relationship.nil? && counter == group_rules.count)
  	      create_relationship(user, group, "AUTOMATIC")
  	    end
  	  end
  	end
  	if (existing_relationship && counter < group_rules.count)
  	  destroy_relationship(existing_relationship)
  	end
  	end
  end

  def create_relationship(user, group, relationship_type)
	new_relationship = UserGroupRelationship.new
    new_relationship.user_id = user.id
    new_relationship.group_id = group.id
    new_relationship.user_group_relationship_type = relationship_type
    new_relationship.save
  end

  def destroy_relationship(relationship)
	  relationship.destroy
  end
end
