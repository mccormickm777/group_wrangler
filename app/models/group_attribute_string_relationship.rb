class GroupAttributeStringRelationship < ActiveRecord::Base
  attr_accessible :value, :string_operator, :group_id, :possible_attribute_id

  belongs_to :group
  belongs_to :possible_attribute
  
  validates :group_id, presence: true
  validates :possible_attribute_id, presence: true
  validates :value, presence: true
  validates :string_operator, presence: true

  POSSIBLE_VALUES = ['MATCHES', 'CONTAINS']
end
