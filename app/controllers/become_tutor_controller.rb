class BecomeTutorController < ApplicationController
    def index
    end

    def post
    end

    def getCourses
        temp = File.open("#{Rails.root}/mlModel/Parsers/clubs.json").read # relative to current location of file
        # render :json => temp
        data = JSON.parse(temp)
        @categoryAndClubs = data
        @clubs = Array.new
        data.each do |k,v|
          # puts "key: #{k} value: #{v}"
          v.each do |c|
            # puts c
            @clubs << c
          end
        end
        
        puts("----------------------------------------\n")
        puts("inside getClubs\n")
        @clubs.each do |c|
          # puts c
        end
        @clubs.sort!
        @clubs.uniq!
      end
end
