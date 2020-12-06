# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



User.create(email: "hi@gmail.com")
Tutor.create(subject: "MATH", number: "221", grade: "A", availability: "3", pay: "15")
Tutor.create(subject: "CS", number: "221", grade: "A", availability: "3", pay: "15")
Tutor.create(subject: "PHILO", number: "221", grade: "A", availability: "3", pay: "15")
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
