class SearchesController < ApplicationController
  def index
    q = params[:search]
    @tours = Tour.search(name_cont: q).result.
      page(params[:page]).per Settings.tour
    @search= Tour.search(params[:q])
    @search.build_sort
  end
end
