class PossibleAttributeValue < ActiveRecord::Base
  attr_accessible :name, :possible_attribute_id

  belongs_to :possible_attribute

  validates :possible_attribute_id, presence: true
  validates :name, presence: true,  length: { maximum: 140 },
    uniqueness: { case_sensitive: false }
end
