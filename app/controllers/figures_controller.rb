class FiguresController < ApplicationController
  # add controller methods

  get "/figures" do
    @figures = Figure.all
    erb :"/figures/index"
  end

  get "/figures/new" do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"/figures/new"
  end

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :"/figures/show"
  end

  get "/figures/:id/edit" do
    @titles = Title.all
    @landmarks = Landmark.all
    @figure = Figure.find(params[:id])
    erb :"/figures/edit"
  end

  post "/figures" do
    @figure = Figure.create(params["figure"])
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(:name => params["title"]["name"])
    end
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(:name => params["landmark"]["name"])
    end
  end

  patch "/figures/:id" do
    figure = Figure.find(params[:id])
    figure.update(params["figure"])
    figure.landmarks << Landmark.create(:name => params["landmark"]["name"])
    redirect "/figures/#{figure.id}"
  end
end
