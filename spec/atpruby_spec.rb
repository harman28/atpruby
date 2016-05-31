require 'spec_helper'

describe Atpruby do
  it 'Has a version number' do
    expect(Atpruby::VERSION).not_to be nil
  end

  it 'Scopes for Matches work' do
    finalists = Match.in_2007.slams.finals.sample.players.pluck(:lastname)
    expect(finalists).to include('Federer')
  end

  it 'Associations for Matches work' do
    winner = Match.in_1969.slams.finals.sample.winner.lastname
    expect(winner).to eq('Laver')
  end

  it 'Slam_finals (using union) for Players works' do
    borg = Player.find_by(lastname:'Borg')
    firstfinal = borg.slam_finals.order(:match_date).first.tourney_id
    expect(firstfinal).to eq('1974-520')
  end

  it 'Matches method (using union) for Players works' do
    connors = Player.find_by(lastname:'Connors')
    lastmatch = connors.matches.order(:match_date).last
    expect(lastmatch.match_date.year).to eq(1996)
    expect(lastmatch.tourney_name).to eq('Atlanta')
  end

  it 'H2H methods for Players work' do
    mcenroe = Player.find_by(lastname:'Mcenroe')
    borg=Player.find_by(lastname:'Borg')
    lastwinner = borg.h2h_details(mcenroe).order(:match_date).last.winner.lastname
    h2h = borg.h2h(mcenroe)
    expect(lastwinner).to eq(mcenroe.lastname)
    expect(h2h.split('-')).to contain_exactly('7','7')
  end

  it 'Rankings assoc for Players works' do
    lendl = Player.find_by(lastname:'Lendl')
    lastyear = lendl.rankings.where(pos:1).order(:ranking_date).last.ranking_date.year
    expect(lastyear).to eq(1990)
  end
end
