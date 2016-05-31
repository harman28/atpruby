# Atpruby

Ruby wrap for working with [Jeff Sackmann's tennis_atp database](https://github.com/JeffSackmann/tennis_atp). You can set it up in Postgres by cloning [this fork](https://github.com/harman28/tennis_atp/tree/psql_support) and running `bash setup/PostgreSQL/convert_postgres.sh`. More instructions for doing that are [here](https://github.com/harman28/tennis_atp/blob/psql_support/setup/PostgreSQL/README.md).

Once you've done that, use this gem to write ruby scripts to query the DB.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'atpruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install atpruby

## Usage
Who won the first match of 2014?
````
[1] pry(main)> Match.in_2014.order(:match_date).first.winner.name
=> "Donald Young"
````
List all the left-handed Grand Slam winners.
````
[2] pry(main)> Match.slams.finals.joins(:winner).where(players:{hand:'L'}).pluck("distinct lastname")
=> ["Mcenroe", "Orantes", "Korda", "Laver", "Tanner", "Muster", "Connors", "Nadal", "Gomez", "Ivanisevic", "Vilas"]
````
How many Grand Slam finals has Murray been in?
````
[3] pry(main)> Player.find_by(firstname:'andy',lastname:'Murray').slam_finals.count
=> 8
````
Which players younger than himself has Djokovic lost to in finals?
````
[4] pry(main)> Player.joins(:losses).where(lastname:'Djokovic').where("winner_age<loser_age").where("round='F'").pluck("distinct winner_name")
=> []
````
When was the last time Federer was World #1?
````
[5] pry(main)> Player.find_by(lastname:'Federer').rankings.where(pos:1).order(:ranking_date).last.ranking_date
=> Mon, 29 Oct 2012
````
Which Slams has seen the most five-setters?
````
[6] pry(main)> Match.slams.where("score ilike '%-%-%-%-%-%'").group(:tourney_name).order("count desc").pluck("tourney_name,count(tourney_name)")
=> [["Wimbledon", 1194], ["Roland Garros", 1043], ["US Open", 1023], ["Australian Open", 877], ["Australian Chps.", 13]]
````

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/harman28/atpruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

