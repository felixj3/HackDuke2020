class HomeController < ApplicationController
  def index
  end

  # GET /profile
  def profile
    # occurs when someone presses profile button on nav bar
    puts("----------------------------------------\n")
    puts("pre")
    getClubs

    # can only access session info during a GET request
    puts("----------------------------------------\n")
    # need to find current user
    puts current_user.id

    puts("----------------------------------------\n")
  end

  # POST /profile
  def post
    # called once they press submit
    puts("----------------------------------------\n")
    # need to find current user
    puts session["session_id"]
    session.each do |k,v|
      puts "key: #{k} value: #{v}"
    end
    puts("----------------------------------------\n")
    @userClubs = Array.new
    params.each do |k,v|
        puts "key: #{k} value: #{v}"
        if v != "" and k.to_s.include? "club"
          puts "#{v} is not null and is a club"
          @userClubs << v
        end
    end


    puts(params[:name])

  end


  def getClubs
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
