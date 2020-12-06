class BecomeTutorController < ApplicationController
    # GET /assist
    def index
        # called before form is filled out
        if !current_user
            redirect_to new_user_session_path
            return
        end

        user = getCurrentUser
        puts user.name
        getCourses
        @curr_user_id = current_user.id
    end

    # POST /assist
    def post
        params.each do |k,v|
            puts "key: #{k}, value: #{v}"
        end
        getCourses
        keys = @courseAbbreviationsAndNames.keys
        tutor = Tutor.create(subject: keys[params[:subject].to_i], number: params[:courseNum], grade: params[:Grade], availability: params[:availability], pay: params[:Pay])
        user = User.find_by(id: params[:user_id])
        user.tutors << tutor # relation between tutor and user
        # render :controller => 'home', :action => 'index'
        redirect_to root_url
    end

    
end
