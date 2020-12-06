class BecomeTutorController < ApplicationController
    # GET /assist
    def index
        # called before form is filled out
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
