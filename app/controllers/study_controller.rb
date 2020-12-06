class StudyController < ApplicationController

    def index
        @rooms = StudyRoom.order('created_at DESC')
        cnt = 0
        @rooms.each do |room|
            cnt = cnt+1
        end    
        @room = Array.new(cnt)
        @rooms.each do |t|
            i = 0
            while i<cnt && @room[i] != nil
                if @room[i].rank<=t.rank
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
