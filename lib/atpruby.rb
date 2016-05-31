require 'active_record'
require 'active_record_union'

require "atpruby/version"
require "atpruby/match"
require "atpruby/player"
require "atpruby/ranking"

# Assuming dump file has been populated into a postgres DB called atpdatabase
ActiveRecord::Base.establish_connection adapter: 'postgresql', database: 'atpdatabase'

module Atpruby
  # Your code goes here...
end
