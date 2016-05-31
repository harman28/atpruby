class Match < ActiveRecord::Base

  self.primary_key = 'id'

  has_one :winner, :foreign_key => "player_id", primary_key: "winner_id", class_name: "::Player"
  has_one :loser, :foreign_key => "player_id", primary_key: "loser_id", class_name: "::Player"

  (Constants::START_YEAR..Constants::END_YEAR).each do |year|
    scope "in_#{year}".intern, -> { where("extract(year from match_date)=#{year}") }
  end

  scope :slams, -> { where(tourney_level:'G') }
  scope :finals, -> { where(round:'F') }

  def players
    ::Player.where(player_id:[winner_id,loser_id])
  end

  def self.select_compact
    select(:id, :tourney_id, :tourney_name, :surface, :tourney_level, :round,
            :minutes, :winner_id, :winner_name, :loser_id, :loser_name, :score)
  end
end