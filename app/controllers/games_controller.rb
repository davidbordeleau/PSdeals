class GamesController < ApplicationController
  def index
    @games = Game.fetch_games.first(9)
  end

  def all_games
    @games = Game.order(:name).page(params[:page])
  end
end
