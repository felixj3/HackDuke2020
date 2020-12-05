class RequestTutorController < ApplicationController
    def post
        puts("----------------------------------------\n")
        puts("hi")
        params.each do |k,v|
            puts "key: #{k} value: #{v}"
        end
        puts(params[:name])
        
    end
end
