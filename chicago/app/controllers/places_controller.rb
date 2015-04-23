# This is the Places controller class.
# References
# 1. How to order an active record response
# http://guides.rubyonrails.org/active_record_querying.html#ordering

class PlacesController < ApplicationController

	# This method defines the index page and retrieves up to 100 places from the model
	def index
		@places = Place.all.limit(100)
	end

	# This method retrieves the requested place (if it exists) and also pulls the reviews associated with the place
	def show
		@place = Place.find_by(:id => params["id"])
		@reviews = Review.where(:place_id => params["id"]).order(id: :desc)

		if @place != nil
			render "show"
		else
			redirect_to "/", notice: "Place not found in this app!"
		end
	end

	def new

	end

	# This method is used to direct the user to edit the page
	def edit
		@place = Place.find_by(:id=> params["id"])

		if @place != nil
			render "edit"
		else
			redirect_to "/", notice: "Place not found in this app!"
		end
	end

	# This method is used to update the page with modifications from edit
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

	# This method is used to create a new place and save it to the model
	def create
		p = Place.new
		p.title = params['title']
		p.photo_url = params['photo_url']
		p.admission_price = params['admission_price']
		p.description = params['description']
		p.save
		redirect_to "/"
	end

	# This method is used to delete a place and remove it from the model
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

	# This method is used to create a new review, save it, and redirect to the appropriate places page
	def review
		@place = Place.find_by(:id => params["id"])

		if @place != nil
			r = Review.new
			r.place_id = params["id"]
			r.title = params['rtitle']
			r.rating = params['rating']
			r.description = params['description']
			r.save
			redirect_to "/places/#{@place.id}"
		else
			redirect_to "/", notice: "Place not found in this app!"
		end
	end

end