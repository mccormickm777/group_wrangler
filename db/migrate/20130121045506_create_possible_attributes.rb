class CreatePossibleAttributes < ActiveRecord::Migration
  def change
    create_table :possible_attributes do |t|
      t.string :name
      t.string :attribute_type

      t.timestamps
    end
  end
end
