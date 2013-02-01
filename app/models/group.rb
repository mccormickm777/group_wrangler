class Group < ActiveRecord::Base
  attr_accessible :name, :group_id, :possible_attribute_id

  has_many :user_group_relationships, dependent: :destroy
  has_many :users, through: :user_group_relationships
  has_many :group_attribute_string_relationships, dependent: :destroy
  has_many :possible_attributes, through: :group_attribute_string_relationships

  validates :name, presence: true,  length: { maximum: 140 },
    uniqueness: { case_sensitive: false }
end
