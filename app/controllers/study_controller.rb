class StudyController < ApplicationController

    def index
        @rooms = StudyRoom.order('created_at DESC')
        cnt = 0
        @rooms.each do |room|
            cnt = cnt+1
        end    
        room = Array.new(cnt)

    end

end
