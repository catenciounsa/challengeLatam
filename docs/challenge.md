# DISCUSSION
### What methods would you use to verify the reliability of the labels?
I considered two ways to detect mislabeled classes in figures containing more than one labeled class:
1. Check if the labels are equal by comparing their coordinates and using a tolerance. For example, if a person and a loader have the same size and coordinates, there is a plausible error.

2. The next way is to check for labels that are nested within others and compare them based on the real size of the objects. For example, a person is smaller than an forklift(2), but if we find that the excavator is inside the box labeled for the person, this could indicate an error in the dataset.

# DISCUSSION - TRAINING
### Why did you choose these hyperparameters?  
EPOCHS should keep a low number since it is working on a pre-defined model (YOLO).
IMGSZ should be big (e.g. 1024) because there are little objects compared to the rest of the image, nevertheless my PC had problems with the GPU and there deadline was burning, so I prefered to use the value of 320
### How do they affect training time, GPU/CPU usage, and accuracy?  
BATCH has a similiar story about the before. My PC made me put a low number (8)
The most important parameter is IMGSZ, a higher value would mean a better performance.


### What would you try differently if you had more time or resources?
I would have fixed the problem with my NVIDIA driver and could have run more tests to identify better trends for IMGSZ and BATCH. With more time and resources, I would have run the tests with the parameters: IMGSZ=1024 and BATCH=128.


# METRICS INTERPRETATION AND ANALYSIS

## Quantitative Summary:

### What are your mAP50 and mAP50-95 values?
#### Which classes achieved the highest and lowest detection performance?

| Clase             | mAP50     | mAP50-95   |
| ----------------- | --------- | ---------- |
| all               | **0.101** | **0.0616** |
| forklift          | **0.902** | **0.623**  |
| person            | **0.595** | **0.315**  |
| traffic cone      | 0.037     | 0.0181     |
| car               | 0.0597    | 0.02       |
| cardboard box     | 0.00759   | 0.00344    |
| freight container | 0.000643  | 0.000475   |
| safety vest       | 0.00207   | 0.000414   |
| truck             | 0.00135   | 0.000857   |
| wood pallet       | 0.00573   | 0.00401    |
| gloves            | 0         | 0          |
| helmet            | 0         | 0          |
| ladder            | 0         | 0          |
| license plate     | 0         | 0          |
| road sign         | 0         | 0          |
| traffic light     | 0         | 0          |
| van               | 0         | 0          |

Forklift (0.90 mAP50 ) and Person (~0.59 mAP50) are well trained. For the rest, the system did not learn appropriately.

## Qualitative Analysis:
### Describe common failure cases (e.g., small objects missed, overlapping detections, background confusion).
### Were there any label quality issues or inconsistencies you observed?
* The main problem with the dataset is the umbalancing of classes. Another problem was the big number of little objects.
* I mentioned before that some of the labels were the same. I used a little threshold (2) to compare it. It gave me the number of 411 incidences.


## Improvement proposal
## Suggest at least two improvements (data augmentation, loss tuning, class balancing, etc.).
## How would you validate whether these changes actually help?

I think the correct approach is to address class imbalance, and to do so, we can use different data augmentation techniques.

- Take the less common classes and start creating synthetic images from them:
    -  Rotation at different angles
    - Mirroring
    - Add noise to the less common images:
    - This noise could be salt and pepper
    - Gaussian noise and others

- It's also possible to copy some regions with the corresponding labels to different images.

- Finally, it would be interesting to add DALL-E or another tool that can generate variations of an image.

- After data augmentation, accuracy will increase; however, the focus is on the F-score, which is a combination of accuracy and recall.