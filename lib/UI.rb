#!/usr/bin/env ruby -I ../lib -I lib
# coding: utf-8

require 'sinatra'
require 'file_board_gateway'
require 'place_mark'
require 'view_board'
require 'check_game_condition'

before do
  @file_board_gateway = FileBoardGateway.new
  @place_mark = PlaceMark.new(file_board_gateway: @file_board_gateway)
  @view_board = ViewBoard.new(file_board_gateway: @file_board_gateway)
  @game = @view_board.execute
end

  get '/' do
    reset_board
    erb :setup
  end

  get '/play' do
    @title = 'Tic-Tac-Toe'
    erb :index, locals: { board: game_grid, status: game_status }
  end

  post '/:row/:cell' do
    cell = params[:cell].to_i
    row = params[:row].to_i
    @place_mark.execute(player: :X, x: row, y: cell)
    @place_mark.execute(player: :O) if game_status == nil
    redirect '/play'
  end

  post '/reset' do
    reset_board
    redirect '/play'
  end

  post '/playagain' do
    redirect '/'
  end

  post '/computerplays' do
    @place_mark.execute(player: :O) if game_status == nil
    redirect '/play'
  end

  post '/humanplays' do
    redirect '/play'
  end


  def reset_board
    @file_board_gateway.wipe_board
  end

  def game_grid
    @game[:board]
  end

  def game_status
    @game[:status]
  end

