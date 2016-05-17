class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  belongs_to :group_creator_id, class_name: 'User'
end
