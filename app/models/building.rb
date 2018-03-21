class Building < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::KlassMethods

  has_many :rooms
  has_many :containers, through: :rooms
  has_many :things, through: :containers
  belongs_to :user

  def create_room_no_duplication(name:)
    room = Room.new(name: name)
    if !self.rooms.include?(room)
      self.rooms.create(name: name)
    end
  end

end
