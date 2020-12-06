class BecomeTutorController < ApplicationController
    def index
        getCourses
    end

    def post
    end

    def getCourses
        puts("inside getCourses\n")
        temp = File.open("#{Rails.root}/mlModel/Courses/output.json").read # relative to current location of file
        render :json => temp
        data = JSON.parse(temp)
        @courseAbbreviationsAndNames = data

        @courseAbbreviationsAndNames.each do |k, v|
            puts "key: #{k}"
            puts("----------------------------------------\n")
            v.each do |array|
                puts "#{array[0]}, #{array[1]}"
            end
        end
        
        puts("----------------------------------------\n")

      end
end
