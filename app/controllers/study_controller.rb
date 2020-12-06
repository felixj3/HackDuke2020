class StudyController < ApplicationController
    def index
        @rooms = Tutor.order('created_at DESC')
    end    
end
