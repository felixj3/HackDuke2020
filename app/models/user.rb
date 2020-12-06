class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :tutors
  # belongs_to :study_room

    def self.getCategories
        temp = File.open("#{Rails.root}/mlModel/Parsers/clubs.json").read # relative to current location of file
        # render :json => temp
        data = JSON.parse(temp)
        return data
    end

    def self.getClubs(data)
        clubs = Array.new
        data.each do |k,v|
        # puts "key: #{k} value: #{v}"
        v.each do |c|
            # puts c
            clubs << c
        end
        end
        
        puts("----------------------------------------\n")
        puts("inside getClubs\n")
        clubs.each do |c|
        # puts c
        end
        clubs.sort!
        clubs.uniq!
    end

    def self.test
        puts "hello"
        User.create(email: "TESTWorked@gmail.com")
    end
end
