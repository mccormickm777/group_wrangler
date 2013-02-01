class PossibleAttribute < ActiveRecord::Base
  attr_accessible :name, :attribute_type

  has_many :user_attribute_string_relationships, dependent: :destroy
  has_many :users, through: :user_attribute_string_relationships
  has_many :group_attribute_string_relationships, dependent: :destroy
  has_many :groups, through: :group_attribute_string_relationships
  has_many :possible_attribute_values, dependent: :destroy

  validates :attribute_type, presence: true
  validates :name, presence: true,  length: { maximum: 140 },
    uniqueness: { case_sensitive: false }

  POSSIBLE_VALUES = ['Text', 'Whole Number', 'Positive Whole Number', 'Decimal Number', 'Positive Decimal Number', 'Date', 'Time', 'Yes/No', 'Money']
end
