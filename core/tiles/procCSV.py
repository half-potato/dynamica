import csv, json
from icecream import ic

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

with open("materials.csv", "r") as f:
    reader = csv.reader(f, quotechar='"')
    header_slices = []
    header = []
    materials = {}
    for i, row in enumerate(reader):
        if i == 0:
            # Parse header
            header_slices = parseHeader(row)
            header = [j.strip() for j in row]
        else:
            # Iterate over slices
            for sl in header_slices:
                if not materials.get(row[sl.start]):
                    materials[row[sl.start]] = {}
                # Iterate over items in slice
                if row[sl.start] == "Aluminum":
                    ic(row)
                    ic(sl)
                for j in range(sl.start+1, sl.stop):
                    v = parseNumbers(row[j])
                    if not materials[row[sl.start]].get(header[j]) and v:
                        materials[row[sl.start]][header[j]] = v

    materials.pop('')

    #ic(converted)
    with open("materials.json", "w+") as f:
        f.write(json.dumps(materials, indent=4, sort_keys=True))
