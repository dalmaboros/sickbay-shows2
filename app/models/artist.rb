class Artist < ActiveRecord::Base
  validates :name, presence: true

  has_many :show_artists
  has_many :shows, through: :show_artists
  has_many :venue_artists
  has_many :venues, through: :venue_artists

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end
