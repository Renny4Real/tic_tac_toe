#!/usr/bin/env ruby -I ../lib -I lib
# coding: utf-8

require 'sinatra'
require 'file_board_gateway'
require 'place_mark'
require 'view_board'
require 'check_game_condition'


  get '/' do
    @board = game_grid
    @status = game_status
    @title = 'Tic-Tac-Toe'
    erb :index
  end

  post '/:row/:cell' do
    @cell = params[:cell].to_i
    @row = params[:row].to_i
    @file_board_gateway = FileBoardGateway.new
    @place_mark = PlaceMark.new(file_board_gateway: @file_board_gateway)
    @place_mark.execute(player: :X, x: @row, y: @cell)
    @status = game_status
    @place_mark.execute(player: :O) if @status == nil
    redirect '/'
  end

  post '/reset' do
    @file_board_gateway = FileBoardGateway.new
    @file_board_gateway.wipe_board
    redirect '/'
  end

  def game_grid
    @file_board_gateway = FileBoardGateway.new
    @view_board = ViewBoard.new(file_board_gateway: @file_board_gateway)
    @game = @view_board.execute
    @game[:board]
  end

  def game_status
    @file_board_gateway = FileBoardGateway.new
    @view_board = ViewBoard.new(file_board_gateway: @file_board_gateway)
    @game = @view_board.execute
    @game[:status]
  end

