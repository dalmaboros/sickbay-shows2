class Artist < ActiveRecord::Base

  has_many :show_artists
  has_many :shows, through: :show_artists

  has_many :venues, through: :shows

end
