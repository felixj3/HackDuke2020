from tika import parser

def getDigitalPDFText(path):
    return parser.from_file(path)["content"]

txt = getDigitalPDFText('2020-21 Undergraduate Bulletin.pdf')


with open('courses.txt', 'w') as f:
    f.write(txt)
