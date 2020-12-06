class CreateRoomController < ApplicationController
  def index
    getCourses
    @curr_user_id = current_user.id
  end

  def post
    getCourses
    room = StudyRoom.create(rank: 0, capacity: params[:capacity].to_i, current_number_student:1, major: params[:major], description: params[:description], zoom_link: params[:zoom_link])
    user_id = params[:user_id]
    user = User.find_by(id: user_id)
    room.users << user
    redirect_to root_url
  end

  def getCourses
    puts("inside getCourses\n")
    temp = File.open("#{Rails.root}/mlModel/Courses/output.json").read # relative to current location of file
    # render :json => temp
    data = JSON.parse(temp)
    @courseAbbreviationsAndNames = Hash.new
    data.sort.map do |k, v|
        @courseAbbreviationsAndNames[k] = v
    end

    @courseAbbreviationsAndNames.each do |k, v|
        # puts "key: #{k}"
        # puts("----------------------------------------\n")
        # v.each do |array|
        #     puts "#{array[0]}, #{array[1]}"
        # end
    end
    
    puts("----------------------------------------\n")

  end
end
