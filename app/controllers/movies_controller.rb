class MoviesController < ApplicationController
    before_action :restrict_access, only: [:new, :create, :edit, :update, :destroy]

      def index
        @movies = Movie.all
      end

      def show
        @movie = Movie.find(params[:id])
      end

      def new
        restrict_access
        @movie = Movie.new
      end

      def edit
        restrict_access
        @movie = Movie.find(params[:id])
      end

      def create
        restrict_access
        img_selector
        @movie = Movie.new(movie_params)
        img_selector
        if @movie.save
          redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
        else
          render :new
        end
      end

      def update
        restrict_access
        @movie = Movie.find(params[:id])

        if @movie.update_attributes(movie_params)
          redirect_to movie_path(@movie)
        else
          render :edit
        end
      end

      def destroy
        restrict_access
        @movie = Movie.find(params[:id])
        @movie.destroy
        redirect_to movies_path
      end

      def review_average
        reviews.size != 0 ? reviews.sum(:rating_out_of_ten)/reviews.size : "No reviews so far!"
      end

      protected

      def img_selector
        params[:movie][:remote_image_url] = nil if params[:movie][:image] != '' && params[:movie][:remote_image_url] != ''
      end

      def movie_params
        params.require(:movie).permit(
          :title, :release_date, :director, :runtime_in_minutes, :description, :image, :remote_image_url
        )
      end

    end