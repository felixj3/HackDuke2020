import re, json
def reSplit(query, text):
    occu = []
    for i in re.finditer(query, text, re.M):
        occu.append(i.regs[0][0])
    out = []
    occu.append(None)
    for i in range(len(occu)-1):
        out.append(text[occu[i] : occu[i+1]])
    return out


with open('mlModel/Courses/courses.txt') as f:
    data = f.read()

dataByMajors = reSplit(r'^Courses in .*?\(.+\)\s*\n', data)

majors = []


for majorStr in dataByMajors:

    title = re.match(r'Courses in (.*?)\s*\n', majorStr)

    majorInfo = [title.group(1), []]

    majors.append(majorInfo)

    courses = reSplit(r'^\d{2,3}\S*?\.\s', majorStr)
    # coursesIdx = []

    # majorStr += '\n999.'

    # for i in re.finditer(r'\n\d{3}.*?\.', majorStr):
    #     coursesIdx.append(i.regs[0][0] + 1)

    # for i in range(len(coursesIdx) - 1):
    #     courses.append(majorStr[coursesIdx[i] : coursesIdx[i+1]])

    lastCourseNum = 0

    for i in courses:
        q = re.match(r'(\d{2,3}\S*?)\. (.*?\.\s)', i)

        if q:

            if q.group(2)[:-1].startswith('Instructor'):
                continue

            courseNum = int(re.match(r"^[0-9]+", q.group(1)).group(0))
            if lastCourseNum > courseNum:
                print(title.group(1), q.group(2)[:-1])
            lastCourseNum = courseNum

            info = [q.group(1), q.group(2)[:-1]]

            majorInfo[1].append(info)




with open('mlModel/Courses/output.json', 'w') as f:
    json.dump(majors, f)

pass