class UserGroupRelationship < ActiveRecord::Base
  attr_accessible :user_group_relationship_type, :user_id, :group_id

  belongs_to :user
  belongs_to :group

  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :user_group_relationship_type, presence: true

  POSSIBLE_VALUES = ['AUTOMATIC', 'MANUAL', 'FORBIDDEN']
end
