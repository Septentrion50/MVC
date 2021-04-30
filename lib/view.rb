require 'bundler'
Bundler.require

require_relative './controller'

# a viewer object
class View
  def create_gossip
    params = Hash.new
    puts 'auteur :'
    auth = gets.chomp
    puts 'message :'
    mess = gets.chomp
    params['author'] = auth
    params['content'] = mess
    params
  end

  def index_gossips(gossips)
    gossips.each do |g|
      puts g.author
      puts g.content
    end
    puts
  end

  def destroy_gossip(gossips)
    puts 'Quelle rumeur veux-tu détruire ?'
    gossips.each_with_index do |g, index|
      puts "#{index} : #{g.content} - #{g.author}"
    end
    ans = gets.chomp.to_i
  end
end
