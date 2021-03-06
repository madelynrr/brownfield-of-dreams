class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if tutorial.videos.count > 0
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    elsif current_user.role == "admin"
      redirect_to "/admin/tutorials/#{tutorial.id}/edit"
    else
      flash[:error] = 'This tutorial is still in progress.'
      redirect_to '/tutorials'
    end
  end

  def index
    @tutorials = Tutorial.all
  end
end
