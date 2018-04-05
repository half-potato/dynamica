import json
import cv2, math
import numpy as np

spritesheet_width = 10
texture_width = 16
texture_height = 16

spritesheet_index = {}

with open("spritesheet_location.json", "r") as f:
    locations = json.load(f)
    print(len(locations))
    height = int(math.ceil(len(locations)/spritesheet_width))
    print(height)
    spritesheet = np.zeros((texture_height*height, spritesheet_width*texture_width, 3))
    print(spritesheet.shape)
    for i, key in enumerate(locations):
        tex = cv2.imread(locations[key])
        x = i%spritesheet_width
        y = int(math.floor(i/spritesheet_width))
        x *= texture_width
        y *= texture_height
        spritesheet[y:y+texture_height,x:x+texture_width, :] = tex
        spritesheet_index[key] = i

    #cv2.imshow("Spritesheet", spritesheet)
    #cv2.waitKey(0)
    cv2.imwrite("spritesheet.png", spritesheet)
with open("spritesheet.json", "w+") as f:
    f.write(json.dumps(spritesheet_index, indent=4))
