import csv, json
from icecream import ic

t1,t2,t3,t4 = {},{},{},{}

def parseNumbers(string):
    arr = string.split(" ")
    out = []
    for i in arr:
        try:
            out.append(float(i))
        except:
            continue
    # if the value is a single dash return 0
    if len(arr) == 1 and "-" in arr[0]:
        return [0]
    return out

with open("materials.csv", "r") as f:
    reader = csv.reader(f, quotechar='"')
    header = []
    for i, row in enumerate(reader):
        if i == 0:
            header = row[0:3] + row[5:5] + row[7:8] + row[10:12]
            ic(header)
            header = ["material", "density", "melting_point", "thermal_expansion", "yield_stress", "ultimate_stress"]
            continue
        t1[row[0]] = row[1:3]
        t2[row[4]] = row[5:5]
        t3[row[6]] = row[7:8]
        t4[row[9]] = row[10:12]

    combined = {}

    for k in t1:
        if t2.get(k) != None and t3.get(k) != None and t4.get(k) != None:
            combined[k] = t1[k] + t2[k] + t3[k] + t4[k]

    classified = {}

    for mat in combined:
        classified[mat] = {}
        for i, val in enumerate(combined[mat]):
            vals = parseNumbers(val)
            classified[mat][header[i+1]] = sum(vals) / len(vals)

    #ic(classified)
    with open("materials.json", "w+") as f:
        f.write(json.dumps(classified, indent=4, sort_keys=True))
