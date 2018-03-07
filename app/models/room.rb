class Room < ActiveRecord::Base
  belongs_to :building
  has_many :containers
  has_many :things, through: :containers
end
