![](http://i.imgur.com/KC6TAD3.png)
Jenkins with DooD (Docker outside of Docker)
---
A [Jenkins container](https://registry.hub.docker.com/_/jenkins/) capable of using [Docker](http://docker.com), so you can Docker while you Docker.

* [How to use it](#how-to-use-it)
* [Advantages](#advantages)
* [Disadvantages](#disavantages)
* [Copyright and Licensing](#copyright-and-licensing)

## First of all, WTF is *DooD* supposed to mean?
Long story short, *DooD* (as in *dude*) is the opposite of *[DinD](https://blog.docker.com/2013/09/docker-can-now-run-within-docker/)* and whereas the latter includes a whole Docker installation inside of it, the former just uses its underlying host's Docker installation.


## How to use it
### If you wish to obtain the image, you just have to ...
```bash
docker pull merapar/jenkins-container
```

###However, if you wish to build it instead ...
```bash
git clone https://github.com/merapar/Jenkins-container.git
cd Jenkins-container
docker build -t Jenkins-container .
```

#### You can optionally set `docker-engine` version at build time through the use of the `docker_version` build argument, like so:
```bash
# Default docker_version is 1.11.2
docker build --build-arg docker_version=1.12.0 -t Jenkins-container .
```


### You can easily test it as well with docker-compose
```bash
docker-compose up
```

###Now, time to have fun with it...
```bash
docker run -d -v /var/run/docker.sock:/var/run/docker.sock \
              -v /path/to/your/jenkins/home:/var/jenkins_home \
              -p 8080:8080 \
              merapar/Jenkins-container
```

###Advantages
* No `privileged` mode needed
* Simpler, Jenkins will use it underlying host's Docker installation
* Ability to reuse the image cache from the host
* Any settings in the host's Docker daemon will apply to Jenkins container as well
* Easier to set up, you just need to map the host's Docker executable and daemon socket onto the container
* Your host and your container will use the same version of Docker, always.

###Disadvantages
* Although this image does not require `privileged` mode, it does not make it any safer because it can do `docker` things directly on the host, so you have to be aware of this
* If you want to manage a complete clean Docker environment inside your Jenkins, this one's not for you, you're looking for *DinD*

---


##Copyright and Licensing
Copyright (c) 2015

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
