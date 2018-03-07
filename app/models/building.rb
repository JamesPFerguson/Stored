class Building < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::KlassMethods

  has_many :rooms
  has_many :containers, through: :rooms
  has_many :things, through: :containers
  belongs_to :user
end
