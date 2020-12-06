class RequestTutorController < ApplicationController
    def post
        puts("-------------------HEY THERE---------------------\n")
        puts("hi")
        params.each do |k,v|
            puts "key: #{k} value: #{v}"
        end
        getCourses
        filter
        render "index"
    end

    def filter
        
        @tutorsFiltered = Array.new
        @tutors = Tutor.order('created_at DESC')
        @tutors.each do |tutor|
            @tutorsFiltered << tutor if (tutor.subject == @courseAbbreviationsAndNames.keys[params[:searchCourseMajor].to_i]) && (tutor.number == params[:searchCourseNumber])
        end
        if @tutorsFiltered.count != 0
            
            @tutors = @tutorsFiltered
        end
        puts("-------------------FINISH THERE---------------------\n")
    end 

    def index
        @tutors = Tutor.order('created_at DESC')
        getCourses
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
