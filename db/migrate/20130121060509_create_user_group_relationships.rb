class CreateUserGroupRelationships < ActiveRecord::Migration
  def change
    create_table :user_group_relationships do |t|
    	t.string :user_group_relationship_type
    	t.string :user_id
    	t.string :group_id

      t.timestamps
    end
  end
end
