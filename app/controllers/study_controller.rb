class StudyController < ApplicationController

    def index

        if !current_user
            redirect_to new_user_session_path
            return
        end

        @rooms = contact_python(cmd: "fetchStudy", user: current_user.id)

        @rooms = StudyRoom.order('created_at DESC')
        cnt = 0
        @rooms.each do |room|
            cnt = cnt+1
        end    
        @room = Array.new(cnt)
        @rooms.each do |t|
            i = 0
            while i<cnt && @room[i] != nil
                if @room[i].rank>=t.rank
                    tmp = @room[i]
                    @room[i] = t
                    t = tmp
                    i = i+1
                else
                    i = i+1
                end    
            end 
            @room[i] = t   
        end    
    end

end
