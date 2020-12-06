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

User.create!(email: "alsdddj@gmail.com", password: "111111", category1: 0, category2: 0, category3: 0, category4: 0, category5: 5, category6: 0, category7: 0, category8: 0, category9: 0, category10: 0, category11: 0, category12: 0, name: "George", gradYear: 2023, subject1: "Mathmatics (MATH)", course1: "221", subject2: "Mathmatics (MATH)", course2: "212", subject3: "", course3: "", subject4: "", course4: "", subject5: "", course5: "", hometown: "Durham", club1: "Advocates for MD/PhD Women in Science", club2: "Alpha Delta Phi", club3: "eNable - Duke University Chapter", club4: "eNable - Duke University Chapter", club5: "eNable - Duke University Chapter", major: "Arabic (ARABIC)", study_room_id: nil)
User.create!(email: "alsdj@gmail.com", password: "111111", category1: 0, category2: 0, category3: 0, category4: 0, category5: 5, category6: 0, category7: 0, category8: 0, category9: 0, category10: 0, category11: 0, category12: 0, name: "Felix", gradYear: 2023, subject1: "Mathmatics (MATH)", course1: "218", subject2: "Mathmatics (MATH)", course2: "340", subject3: "", course3: "", subject4: "", course4: "", subject5: "", course5: "", hometown: "Charlotte", club1: "Advocates for MD/PhD Women in Science", club2: "Alpha Delta Phi", club3: "eNable - Duke University Chapter", club4: "eNable - Duke University Chapter", club5: "eNable - Duke University Chapter", major: "Arabic (ARABIC)", study_room_id: nil)

a = Tutor.create(subject: "MATH", number: "221", grade: "A", availability: "3", pay: "15")
b = Tutor.create(subject: "CS", number: "221", grade: "A", availability: "3", pay: "15")
c = Tutor.create(subject: "PHILO", number: "221", grade: "A", availability: "3", pay: "15")
User.first.tutors << a
User.first.tutors << b
User.first.tutors << c
User.first.save

a =Tutor.create(subject: "CHEM", number: "201", grade: "A", availability: "3", pay: "15")
b = Tutor.create(subject: "CHINESE", number: "201", grade: "A", availability: "3", pay: "15")
c = Tutor.create(subject: "THEATERST", number: "145", grade: "A", availability: "3", pay: "15")
User.second.tutors << a
User.second.tutors << b
User.second.tutors << c
User.second.save

StudyRoom.create(rank: 3, capacity: 5, current_number_student: 4, major: "Mathematics", description:"Problem session on abstract algebra and representation theory")
StudyRoom.create(rank: 2, capacity: 5, current_number_student: 2, major: "Mathematics", description:"Discussion on linear algebra, fundamental calculus and their applications in real life")
StudyRoom.create(rank: 5, capacity: 5, current_number_student: 1, major: "Computer Science", description:"Discussion on competitive programming techniques, including dynamic programming and flows")
StudyRoom.create(rank: 7, capacity: 5, current_number_student: 2, major: "Computer Science", description:"Discussion on this week's Compsci 250 assignment which asks to build a CPU")
StudyRoom.create(rank: 10, capacity: 5, current_number_student: 3, major: "Psychology", description:"Small talks in social psychology about how people tend to perceive others in a foreign environment")
StudyRoom.create(rank: 9, capacity: 5, current_number_student: 2, major: "Anthropology", description:"Discussion on the new theory about how people evolved and migrated")
StudyRoom.create(rank: 6, capacity: 10, current_number_student: 3, major: "Computer Science", description:"Problem sessions for Computer Science 201 about tree and heap")
StudyRoom.create(rank: 4, capacity: 10, current_number_student: 7, major: "Physics", description:"Discussion of this week's homework of Physics 590D")
StudyRoom.create(rank: 1, capacity: 10, current_number_student: 2, major: "Mathematics", description:"Discussion of frequently seen proving skills in real analysis and measure theory")
StudyRoom.create(rank: 8, capacity: 10, current_number_student: 3, major: "Economy", description:"Review session for the coming second midterm")

# StudyRoom.create(rank: 5, number_student: 10)
