require 'bundler'
Bundler.require

require_relative './controller'

# a router
class Router

  def initialize
    @controller = Controller.new
  end

  def perform
    puts 'Bienvenue dans the gossip project !'
    puts '----------------------------------'
    while true
      # display menu
      puts "Tu veux faire quoi jeune mouss' ?"
      puts '1. Je veux créer un gossip'
      puts '2. Afficher tous les potins'
      puts '3. Détruire un potin'
      puts "4. Je veux quitter l'app"
      choice = gets.chomp.to_i

      case choice
      when 1
        puts 'Tu as choisi de créer un gossip'
        puts
        @controller.create_gossip

      when 2
        puts "Tu as choisi d'afficher tous les potins"
        puts
        @controller.index_gossips

      when 3
        puts 'Tu as choisi de détruire un potin'
        puts
        @controller.destroy_gossip

      when 4
        puts 'Salut !'
        break
      else
        puts
        puts "Ce choix n'existe pas, réessaye !"
      end
    end
  end
end
