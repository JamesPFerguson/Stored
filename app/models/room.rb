class Room < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::KlassMethods

  belongs_to :building
  belongs_to :user
  has_many :containers
  has_many :things, through: :containers
end
