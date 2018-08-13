#frozen_string_literal: true

require 'spec_helper'
require 'json'
require 'uri'

describe 'Views' do  
  def app
    Sinatra::Application
  end

  context 'Initial setup /' do
    let(:response) { get '/' }
    
    it 'returns status 200 OK' do
      expect(response.status).to eq(200)
    end

    it 'has a button which links to /computerplays' do
      expect(response.body).to have_tag 'form', :with => { :action => "/computerplays", :method => 'post' }
    end

    it 'has a button which links to /humanplays' do
      expect(response.body).to have_tag 'form', :with => { :action => "/humanplays", :method => 'post' }
    end

    it 'clears the grid ' do
      board = [['X', '-', 'O'], ['-', 'O', 'X'], ['X', 'X', '-']]

      File.open('gamestate.json', 'w') do |file|
        file.write({ board: board }.to_json)
      end

      post_page = get '/'

      file = File.read('gamestate.json')

      expect(file).to eq('')
    end
  end

  context 'computer plays' do
    let(:response) { post '/computerplays' }

    it 'returns status 302 OK' do
      expect(response.status).to eq(302)
    end

    it 'gets computer to play a mark' do

      board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]

      File.open('gamestate.json', 'w') do |file|
        file.write({ board: board }.to_json)
      end

      post_page = post '/computerplays'

      file = File.read('gamestate.json')
      data = JSON.parse(file, symbolize_names: true)

      expect(data).to eq({board:[["-","-","-"],["-","O","-"],["-","-","-"]]})
    end

  end

  context 'human plays' do
    let(:response) { post '/humanplays' }

    it 'returns status 302 OK' do
      expect(response.status).to eq(302)
    end
  end

  context 'page /play' do
    let(:response) { get '/play' }

    it 'returns status 200 OK' do
      expect(response.status).to eq(200)
    end

    it ' contains a 3 by 3 game grid' do

      expect(response.body).to have_tag 'div', :with => {:class => "cell"}
    end

    it 'has a middle cell which link to /1/1' do
      board = [[:X, '-', '-'], ['-', '-', '-'], ['-', '-', '-']]

      File.open('gamestate.json', 'w') do |file|
        file.write({ board: board }.to_json)
      end

      expect(response.body).to have_tag 'form', :with => { :action => "/1/1", :method => 'post' }
    end

    it 'has to a reset button linking to /reset' do
      expect(response.body).to have_tag 'form', :with => { :action => "/reset", :method => 'post' }
    end
  end

  xcontext 'Cell clicked  /1/1 ' do

    let(:response) { post '/1/1', :cell => '1', :row => '1' }

    it 'returns status 302 OK' do
      expect(response.status).to eq(302)
    end

    it 'calls place mark' do

      board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]

      File.open('gamestate.json', 'w') do |file|
        file.write({ board: board }.to_json)
      end

      post_page = post '/1/1'

      file = File.read('gamestate.json')
      data = JSON.parse(file, symbolize_names: true)
      board = data[:board].flatten
      expect(true).to eq(board.include?('X')) 
    end

    it 'gets computer to play a mark before human places another' do

      board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]

      File.open('gamestate.json', 'w') do |file|
        file.write({ board: board }.to_json)
      end

      post_page = post '/0/0'

      file = File.read('gamestate.json')
      data = JSON.parse(file, symbolize_names: true)

      expect(data).to eq({board:[["X","-","-"],["-","O","-"],["-","-","-"]]})
    end
  end

  context 'reset button /reset' do
    let(:response) { post '/reset' }

    it 'returns status 302 OK' do
      expect(response.status).to eq(302)
    end

    it 'resets the grid to empty spaces after reset button is pressed' do
      board = [['X', 'O', '-'], ['-', 'X', '-'], ['-', '-', 'O']]

      File.open('gamestate.json', 'w') do |file|
        file.write({ board: board }.to_json)
      end

      reset = post '/reset'

      file = File.read('gamestate.json')

      expect(file).to eq('')
    end
  end

  context 'play again button /playagain' do
    let(:response) { post '/playagain' }

    it 'returns status 302 OK' do
      expect(response.status).to eq(302)
    end

    xit 'resets to index page' do
      # check redirects 
    end
  end

end