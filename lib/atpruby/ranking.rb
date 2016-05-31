class Ranking < ActiveRecord::Base

  has_one :player, :foreign_key => "player_id", primary_key: "player_id", class_name: "::Player"

end