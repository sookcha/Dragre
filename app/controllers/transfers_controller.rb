# encoding: utf-8

require 'rack/websocket'
require "rubytorrent-allspice"

# Main Class
class TransfersController < ApplicationController
  def index
    # URL 파라메터로 선택된 항목을 알아낸다
    @fn = params[:fileName]
    @ex = params[:ex]
    $path = "public/files/" + @fn + "." + @ex
  end
end

# WebSocket Class
class SocketApp < Rack::WebSocket::Application
  def on_open(env) # WebSocket이 연결되었을때
    puts 'Client connected'
  end

  def on_close(env) # WebSocket 연결이 닫혔을 때
    puts 'Client disconnected'
  end

  def on_message(env, message) # WebSocket에서 뭔가 메시지를 받았을 때
    if (message.include? ".")
      # RubyTorrent 객체 설정
      name = "public/files/" + message
      mi = RubyTorrent::MetaInfo.from_location($path)
      package = RubyTorrent::Package.new(mi, name)
      $bt = RubyTorrent::BitTorrent.new(mi, package)
    end
    if (message.include? 'refreshData')
      send_data "#{$bt.percent_completed}%"
    end
    $bt.on_event(self, :added_peer) { puts peer }
  end
end