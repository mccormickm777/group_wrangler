class CreateGroupAttributeStringRelationships < ActiveRecord::Migration
  def change
    create_table :group_attribute_string_relationships do |t|
      t.string :value
      t.string :string_operator
      t.string :group_id
      t.string :possible_attribute_id

      t.timestamps
    end
  end
end
