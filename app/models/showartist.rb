class ShowArtist < ActiveRecord::Base
  belongs_to :show
  belongs_to :artist

end
