import csv, json, re
from icecream import ic

min_props = 5

def parseNumbers(string):
    arr = string.split(" ")
    out = []
    for i in arr:
        try:
            out.append(float(i))
        except:
            continue
    # if the value is a single dash return 0
    if len(out) == 0 or "-" in arr[0]:
        return None
    return sum(out) / len(out)

def parseHeader(arr):
    headers = []
    last_ind = 0
    sum_ind = 0
    while(True):
        try:
            index = arr[1:].index("Material")+1
            #ic(arr)
            #ic(index)
            headers.append(slice(last_ind, last_ind+index))
            last_ind += index
            arr = arr[index:]
            if(len(arr) == 0):
                return headers
        except:
            return headers
def stripName(name, maxDangling):
    name = " " + name + " "
    for i in range(maxDangling):
        for j in range(4):
            search = r' '+'[^ ]'*(i+1)+' '
            name = re.sub(search, " ", name)
    name = re.sub(r'\(.*\)', '', name)
    name = name.strip()
    return name

with open("materials.csv", "r") as f:
    reader = csv.reader(f, quotechar='"')
    header_slices = []
    header = []
    materials = {}
    for i, row in enumerate(reader):
        if i == 0:
            # Parse header
            header_slices = parseHeader(row)
            header = [stripName(j, 2) for j in row]
        else:
            # Iterate over slices
            for sl in header_slices:
                mat_name = row[sl.start].strip()
                if not materials.get(mat_name):
                    materials[mat_name] = {}
                # Iterate over items in slice
                for j in range(sl.start+1, sl.stop):
                    v = parseNumbers(row[j])
                    if not materials[mat_name].get(header[j]) and v:
                        materials[mat_name][header[j]] = v

    materials.pop('')
    remove_list = []
    for key in materials:
        if len(materials[key]) < min_props:
            remove_list.append(key)

    for key in remove_list:
        del materials[key]

    #ic(converted)
    with open("materials.json", "w+") as f:
        mat_json = json.dumps(materials, indent=4, sort_keys=True)
        mat_json = re.sub(r'},', "},\n", mat_json)
        f.write(mat_json)
