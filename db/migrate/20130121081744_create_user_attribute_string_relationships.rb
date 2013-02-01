class CreateUserAttributeStringRelationships < ActiveRecord::Migration
  def change
    create_table :user_attribute_string_relationships do |t|
      t.string :value
      t.string :user_id
      t.string :possible_attribute_id

      t.timestamps
    end
  end
end
