# Codebook
### In this file I explain how I wrote my code and what the varables are

## Variables

1. **Subject:** This variable is the number assigned to the person who participated in the experiment. This variable goes from 1 to 30.
2. **Activity:** This is the name of the activity performed by the subject, it can be Laying, Sitting, Standing, Walking, Walk downstairs and Walk upstaris.
3. **Measurement:** This is the description of what was measured, there are 66 measurements per activity per subject. I found that trying to simplify the names of the measurements lost some information, so I kept it as the _features.txt_ file mentioned. 
* If the measurement starts with **t** it is measured in time, with **f** it is measured in frequency.
* Now the signal comes from acceleration of **Body** or **Gravity**.
* Then the instrument that got the measurement **Acc** for accelerometer or **Gyro** for gyroscope.
* If is is a **Jerk** signal.
* The magnitud if it is measured with Euclidian **Mag**.
* Is specifies it is the **mean** or **std**.
* Finaly if it is measured in axis, which axis it belongs to **X**, **Y**, **Z**.
4. **Mean** is the mean for each measurement.

## The table looks like this
```
head(final_tidy)
Subject Activity       Measurement        Mean
1       1   Laying tBodyAcc-mean()-X  0.22159824
2       1   Laying tBodyAcc-mean()-Y -0.04051395
3       1   Laying tBodyAcc-mean()-Z -0.11320355
4       1   Laying  tBodyAcc-std()-X -0.92805647
5       1   Laying  tBodyAcc-std()-Y -0.83682741
6       1   Laying  tBodyAcc-std()-Z -0.82606140
```


## The structure of the data set

```
str(final_tidy)
'data.frame':	11880 obs. of  4 variables:
 $ Subject    : num  1 1 1 1 1 1 1 1 1 1 ...
 $ Activity   : Factor w/ 6 levels "Laying","Sitting",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Measurement: Factor w/ 66 levels "fBodyAccJerk-mean()-X",..: 37 38 39 40 41 42 61 62 63 64 ...
 $ Mean       : num  0.2216 -0.0405 -0.1132 -0.9281 -0.8368 ... 
```
