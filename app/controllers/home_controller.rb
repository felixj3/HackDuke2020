class HomeController < ApplicationController
  def index
  end

  # GET /profile
  def profile
    # occurs when someone presses profile button on nav bar
    puts("----------------------------------------\n")
    puts("pre")
    getClubs
    getCourses

    # can only access session info during a GET request
    puts("----------------------------------------\n")
    # need to find current user, can do it in a GET request
    puts current_user.id

    puts("----------------------------------------\n")

    # I pass this value to the form and then back after the form is submitted in order to get the post request method to see this id
    @curr_user_id = current_user.id
  end

  # POST /profile
  def post
    # called once they press submit
    # they can edit clubs and it still works
    puts("----------------------------------------\n")
    # need to find current user
    puts session["session_id"]
    session.each do |k,v|
      puts "key: #{k} value: #{v}"
    end
    puts("----------------------------------------\n")
    @userClubs = Array.new
    user_id = params[:user_id]
    params.each do |k,v|
        puts "key: #{k} value: #{v}"
        if v != "" and k.to_s.include? "club"
          puts "#{v} is not null and is a club"
          @userClubs << v
        end
    end

    getClubs
    categories = [0,0,0,0,0,0,0,0,0,0,0,0] # how many clubs user has under each category
    @categoryAndClubs.each_with_index do |(category, clubs), index|
      @userClubs.each do |club|
        # puts club
        # puts @clubs[club.to_i]
        # puts "felix"
        if clubs.include? @clubs[club.to_i]
          categories[index] = categories[index] + 1
        end
      end
    end
    categories.each do |v|
      # puts v
    end
    # above code puts how many clubs the user does in each category, using the categories array
    user = User.find_by(id: user_id)
    user.update(category1: categories[0], category2: categories[1], category3: categories[2], category4: categories[3], category5: categories[4], category6: categories[5], category7: categories[6], category8: categories[7], category9: categories[8], category10: categories[9], category11: categories[10], category12: categories[11], name: params[:name])

    getCourses
    # @courseAbbreviationsAndNames
    params.each do |k, v|
      puts "key: #{k}, value: #{v}"
    end

    # user.update(subject1: , course1: )

    redirect_to root_url
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
