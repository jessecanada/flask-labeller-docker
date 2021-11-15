# Flask Labeller => now dockerized!

### A light-weight image labelling tool for creating segmentation datasets.
#### Originally created by [Britefury](https://github.com/Britefury/django-labeller).
#### This is the light weight Flask only version, now dockerized! Simply build and run with docker!

- polygon, box, point and oriented ellipse annotations supported
- polygonal labels can have disjoint regions and can be editing using paintng and boolean operations; provided by
  [polybooljs](https://github.com/voidqk/polybooljs)
- can use the [DEXTR](http://people.ee.ethz.ch/~cvlsegmentation/dextr/) algorithm to automatically generate
  polygonal outlines of objects identified by the user with a few clicks; provided by the
  [dextr](https://github.com/Britefury/dextr) library
  
## How to run Flask Labeller?
### Requirements
- docker and git should be properly configured
- the docker image is 11.4GB
- assumes you have at least one nvidia GPU that supports CUDA 11.1; if not, skip `--gpus all` and CPU will be used for inference

### Option 1
1. `git clone` this project
2. `cd` into the flask-labeller directory
3. `docker build -t flasklabeller .`
4. `cd` into "images"
5. ```shell script
    $ docker run -dp 5000:5000 \
      --name flasklabeller \
      -v "$(pwd)":/flask_labeller/images \
      --gpus all \
      flasklabeller
    ```
***note*** At this point the default U-net with ResNet101 convolutional blocks trained on the Pascal-VOC-2012 dataset provided by the dextr library will be downloaded.***
6. navigate to 'localhost:5000' in your browser, your docker app should be up and running
7. to stop the container, 'docker rm -f flasklabeller'

### Option 2
1. `docker build https://github.com/jessecanada/flask-labeller-docker.git`
- now follow steps 4 through 6 as above