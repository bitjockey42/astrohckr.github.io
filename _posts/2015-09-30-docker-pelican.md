---
layout: post
title: Docker Pelican
date: 2015-09-30 16:55
tags: pelican, docker, site
---

I've been doing a lot of work lately to move my development workflow to a Docker-based one, and it's paid off quite a bit. I use the [Docker toolbox](https://www.docker.com/toolbox) for development, which includes with it an installation of Virtualbox, `docker-machine`, and `docker-compose`.

(I'd recommend reading [_What is docker?_](https://www.docker.com/whatisdocker) if you're uncertain as to what it is, exactly).

Moving the local development version of this blog to a `docker`-based flow was a fairly simple affair, given this blog does not have a particularly complicated setup. The full source of the blog is over on [Github](https://github.com/astrohckr/blog-src).

I've based the container on the official [Python](https://hub.docker.com/_/python/) images. Since I use a simple `requirements.txt` file to manage `pip` dependencies, I just had to run `pip install` on that within the container.

The `Dockerfile` for this blog:

{% highlight docker linenos=table %}
FROM python:2.7.10

ENV APP_HOME /blog
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD requirements.txt $APP_HOME/
RUN pip install -r requirements.txt

ADD . $APP_HOME
{% endhighlight %}


And the `docker-compose.yml`:

{% highlight yaml linenos=table %}
pelican:
  build: .
  command: make serve
  ports:
    - "8000:8000"
  volumes:
    - .:/blog
{% endhighlight %}

The `ports` attribute sets up what ports in the container map to the host. Since `pelican`'s server runs on port `8000`, we expose that to the host.

Initial setup simply required me to run:

```
docker-compose build
```

This command will pull the necessary images from the Docker hub and setup the container within which `pelican` will run. That is, it will also run `pip install -r requirements.txt` from within the container.

Now when I need to generate the `output` folder for this site, I simply run:

```
docker-compose run pelican make html
```

To serve up the `output` folder:

```
docker-compose up
```
