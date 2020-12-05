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

dataByMajors = reSplit(r'^Courses in .*?\(.+\)\n', data)

majors = []


for majorStr in dataByMajors:

    title = re.match(r'Courses in (.*?)\n', majorStr)

    majorInfo = [title.group(1), []]

    majors.append(majorInfo)

    courses = reSplit(r'^\d{3}\S*?\.', majorStr)
    # coursesIdx = []

    # majorStr += '\n999.'

    # for i in re.finditer(r'\n\d{3}.*?\.', majorStr):
    #     coursesIdx.append(i.regs[0][0] + 1)

    # for i in range(len(coursesIdx) - 1):
    #     courses.append(majorStr[coursesIdx[i] : coursesIdx[i+1]])

    for i in courses:
        q = re.match(r'(\d{3}\S*?)\. (.*?\.)', i)

        if q:

            info = [q.group(1), q.group(2)]

            majorInfo[1].append(info)




with open('mlModel/Courses/output.json', 'w') as f:
    json.dump(majors, f)

pass