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
    clubIndex = 1
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
    courseNames = @courseAbbreviationsAndNames.keys
    userCourses = ["", "", "", "", "", "", "", "", "", ""]
    # userCourses[2i] = subject(i+1)
    # userCourses[2i+1] = course(i+1)
    currNum = 1
    second = false #since there is course1 and courseNum1, after the 1 is used twice, increment it
    params.each do |k, v|
      puts "key: #{k}, value: #{v}"
      if k.to_s.include? "course"
        if !second
          if v.to_i != -1
            userCourses[(currNum-1)*2] = courseNames[v.to_i]
          else
            userCourses[(currNum-1)*2] = user.attributes["subject#{currNum}"]
          end
          second = true
        else
          userCourses[(currNum-1)*2 + 1] = v
          currNum = currNum + 1
          second = false
        end
      end
    end

    user.update(subject1: userCourses[0], course1: userCourses[1], subject2: userCourses[2], course2: userCourses[3], subject3: userCourses[4], course3: userCourses[5], subject4: userCourses[6], course4: userCourses[7], subject5: userCourses[8], course5: userCourses[9])

    userCourses.each do |c|
      puts c
    end

    if params[:major].to_i != -1
      user.update(major: courseNames[params[:major].to_i])
    end

    if params[:gradYear] != ""
      user.update(gradYear: params[:gradYear])
    end
    

    user.save
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
