# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# cat = User.getCategories
# club = User.getClubs(cat)
# club.each do |k, v|
#     puts "#{k}, #{v}"
# end
# User.test


User.create(email: "hi@gmail.com")

User.create(email: "alsdj@gmail.com", category1: 0, category2: 0, category3: 0, category4: 0, category5: 5, category6: 0, category7: 0, category8: 0, category9: 0, category10: 0, category11: 0, category12: 0, name: "Felix", gradYear: 2023, subject1: "Asian & Middle Eastern Studies (AMES)", course1: "13", subject2: nil, course2: "", subject3: nil, course3: "", subject4: nil, course4: "", subject5: nil, course5: "", hometown: "pdf", club1: "Advocates for MD/PhD Women in Science", club2: "Alpha Delta Phi", club3: "eNable - Duke University Chapter", club4: "eNable - Duke University Chapter", club5: "eNable - Duke University Chapter", major: "Arabic (ARABIC)", study_room_id: nil)

Tutor.create(subject: "MATH", number: "221", grade: "A", availability: "3", pay: "15")
Tutor.create(subject: "CS", number: "221", grade: "A", availability: "3", pay: "15")
Tutor.create(subject: "PHILO", number: "221", grade: "A", availability: "3", pay: "15")
# StudyRoom.create(rank: 5, number_student: 10)
