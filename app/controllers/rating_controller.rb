class RatingController < ApplicationController
  
  def post
    params.each do |k, v|
      puts k, v
    end  
    feedback = Feedback.create(courseDis:5, homeDis:5, majorDis:5, gradDis:5, involvDot:5, rating:params[:rating].to_f)
    redirect_to root_url
  end

  def index
  end

end
