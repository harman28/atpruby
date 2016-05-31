class Match < ActiveRecord::Base

	has_one :winner, :foreign_key => "player_id", primary_key: "winner_id", class_name: "::Player"
	has_one :loser, :foreign_key => "player_id", primary_key: "loser_id", class_name: "::Player"

	(1969..2015).each do |year|
	  scope "in_#{year}".intern, -> { where("extract(year from match_date)=#{year}") }
	end

  scope :slams, -> { where(tourney_level:'G') }
  scope :finals, -> { where(round:'F') }

	def players
		::Player.where(player_id:[winner_id,loser_id])
	end
end