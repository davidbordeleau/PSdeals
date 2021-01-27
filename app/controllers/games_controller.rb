class GamesController < ApplicationController
  def index
    @games = Game.order(:name).first(6)
  end

  def all_games
    @games = Game.order(:name).page(params[:page])
  end
end
