module Api
  class TagsController < ApplicationController
    def index
      tags = Tag.arel_table
      @tags = Tag.where(tags[:title].matches("%#{params[:term]}%"))

      render json: TagBlueprinter.render(@tags) # http://localhost:3000/api/tags.json

      # respond_to do |format|
      #   format.json
      # end
    end
  end
end


