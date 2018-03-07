class Building < ActiveRecord::Base
  has_many :rooms
  has_many :containers, through: :rooms
  has_many :things, through: :containers
  belongs_to :user
end
