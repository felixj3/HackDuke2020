class HomeController < ApplicationController
  def index
  end

  def profile
    # occurs when someone presses profile button on nav bar
    puts("----------------------------------------\n")
    puts("pre")
    getClubs
  end

  def post
    # called once they press submit
    puts("----------------------------------------\n")
    params.each do |k,v|
        puts "key: #{k} value: #{v}"
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
