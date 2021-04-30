require 'bundler'
Bundler.require

require_relative './gossip'
require_relative './view'

# a controller
class Controller

  attr_accessor :gossip

  def initialize
    @view = View.new
  end

  def create_gossip
    params = @view.create_gossip
    @gossip = Gossip.new(params['author'],params['content'])
    @gossip.save
  end

  def index_gossips
    gossips = Gossip.all
    @view.index_gossips(gossips)
  end

  def destroy_gossip
    gossips = Gossip.all
    to_destroy = @view.destroy_gossip(gossips)
    Gossip.destroy(to_destroy)
  end
end
