class PlacesController < ApplicationController

	def index
		@places = Place.all.limit(100)
	end

	def show
		@place = Place.find_by(:id => params["id"])

		if @place != nil
			render "show"
		else
			redirect_to "/", notice: "Place not found in this app!"
		end
	end

	def new

	end

	def edit
		@place = Place.find_by(:id=> params["id"])

		if @place != nil
			render "edit"
		else
			redirect_to "/", notice: "Place not found in this app!"
		end
	end

	def update
		p = Place.find_by(:id=> params["id"])

		if p != nil
			p.title = params['title']
			p.photo_url = params['photo_url']
			p.admission_price = params['admission_price']
			p.description = params['description']
			p.save
			redirect_to "/"
		else
			redirect_to "/", notice: "Place not found in this app!"
		end
	end

	def create
		p = Place.new
		p.title = params['title']
		p.photo_url = params['photo_url']
		p.admission_price = params['admission_price']
		p.description = params['description']
		p.save
		redirect_to "/"
	end

	def delete
		@place = Place.find_by(:id => params["id"])

		if @place != nil
			title = @place.title
			@place.delete
			redirect_to "/", notice: title + " was deleted!"
		else
			redirect_to "/", notice: "Place not found in this app!"
		end
	end

end