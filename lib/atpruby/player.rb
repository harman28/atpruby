class Player < ActiveRecord::Base

  self.primary_key = 'player_id'

  has_many :wins, :foreign_key => "winner_id", class_name: "::Match"
  has_many :losses, :foreign_key => "loser_id", class_name: "::Match"
  has_many :rankings, :foreign_key => "player_id", class_name: "::Ranking"

  def matches
    wins.union(losses)
  end

  def h2h opponent
    return if opponent.nil?
    w = wins.where(loser_id:opponent.player_id).count
    l = losses.where(winner_id:opponent.player_id).count
    "#{w}-#{l}"
  end

  def h2h_details opponent
    return if opponent.nil?
    w = wins.where(loser_id:opponent.player_id)
    l = losses.where(winner_id:opponent.player_id)
    w.union(l)
  end

  def slams
    wins.where(tourney_level:'G',round:'F')
  end

  def slam_finals
    w = wins.where(tourney_level:'G',round:'F')
    l = losses.where(tourney_level:'G',round:'F')
    w.union(l)
  end
end