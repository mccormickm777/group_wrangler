class UserAttributeStringRelationship < ActiveRecord::Base
  attr_accessible :value, :user_id, :possible_attribute_id

  belongs_to :user
  belongs_to :possible_attribute
  
  validates :user_id, presence: true
  validates :possible_attribute_id, presence: true
  validates :value, presence: true
end
