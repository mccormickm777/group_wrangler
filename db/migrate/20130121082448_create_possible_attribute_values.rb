class CreatePossibleAttributeValues < ActiveRecord::Migration
  def change
    create_table :possible_attribute_values do |t|
      t.string :name
      t.string :possible_attribute_id

      t.timestamps
    end
  end
end
