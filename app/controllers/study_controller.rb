class StudyController < ApplicationController

    def index
        @rooms = StudyRoom.order('created_at DESC')
    end

end
