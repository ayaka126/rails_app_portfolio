class HomesController < ApplicationController
  def top
    @facilities = Facility.all
  end
end
