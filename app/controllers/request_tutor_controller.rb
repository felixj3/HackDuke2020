class RequestTutorController < ApplicationController
    def post
        puts("----------------------------------------\n")
        puts("hi")
        params.each do |k,v|
            puts "key: #{k} value: #{v}"
        end
        puts(params[:name])
        
        
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
