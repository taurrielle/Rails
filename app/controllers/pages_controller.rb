class PagesController < ApplicationController
	before_action :authenticate_user!, :except => [:home]

	def home

	end

	def accounts

	end

  def transactions

  end
end
