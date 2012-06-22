# encoding: utf-8

require 'rack/websocket'
require "rubytorrent-allspice"

# Main Class
class TransfersController < ApplicationController
  def index
    # Get selected item by using URL parameter value
    @fn = params[:fileName]
    @ex = params[:ex]
    $path = "public/files/" + @fn + "." + @ex
  end
end

# WebSocket Class
class SocketApp < Rack::WebSocket::Application
  def on_open(env) # When the Websocket connected
    puts 'Client connected'
  end
  def on_close(env) # When the WebSocket connection closed
    puts 'Client disconnected'
  end
  def on_message(env, message) # When the WebSocket received message
    if (message.include? ".")
      # Setting up a RubyTorrent Object
      
      mi = RubyTorrent::MetaInfo.from_location($path)
      package = RubyTorrent::Package.new(mi, "public/files/ubuntu.iso")
      $bt = RubyTorrent::BitTorrent.new(mi, package)
      
    end
    if (message == 'refreshData')
    send_data "#{$bt.percent_completed}%"
    end    
    $bt.on_event(self, :added_peer) { puts peer }
    
  end
  
end