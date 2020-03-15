---
layout: post
title:  Jekyll as a docker command
description: Howto and script to kickstart jekyll page creation
date:   2020-03-13 10:00:00 +0100
categories: jekyll docker
---

TLDR;
-----

- Download complete [jekyll.sh script]({{ site.url }}/assets/files/jekyll.sh)  `curl {{site.url}}/assets/files/jekyll.sh --output jekyll.sh`
- Put script inside new empty dir  
- Check contents of file - you wouldn't trust random file from internet, right? :)
- Init jekyll site by: `jekyll.sh new --force .`  
- Serve site by running 'jekyll.sh serve'

Jekyll as Docker Command
=======================

Start working with a Jekyll the easy way, given that you have configured docker on your machine :).
If you don't, follow the instructions for your OS on the [docker install page][https://docs.docker.com/get-docker/]

The big advantage of that approach is that you don't have to setup ruby env and the upgrade patch is easy to do.

To start, create a directory and cd into it:

```bash
mkdir ~/home/mypage
cd ~/home/mypage
```

This is the directory where Jekyll will install dependencies. We will mount that dir as a volume into a docker container, so we persist dependencies between `docker run` and save a lot of time.

Now let's create sh script that will run Jekyll inside a container. Create `./jekyll.sh` file and put the following contents:

```bash
LOCALPORT=4000
DIRECTORY=$(cd `dirname $0` && pwd)

mkdir -p "$DIRECTORY/vendor/bundle"
docker run --rm -p "$LOCALPORT:4000" -v "$DIRECTORY/vendor/bundle:/usr/local/bundle" -v "$DIRECTORY:/srv/jekyll" -it jekyll/jekyll:latest jekyll "$@"
```

If you plan to use Jekyll with GitHub pages, change docker tag from `jekyll:latest` to `jekyll:3.8.5` or [whatever version GitHub pages runs on](https://pages.github.com/versions/)

This command will:
- find a directory of the script (so you don't have to cd to the dir to run in properly)
- mount local project directory to docker so Jekyll runs with our disk code
- create and mount vendor/bundle dir to gem bundler directory to prevent installing them on each run
- expose port 4000 by LOCALPORT var
- run any Jekyll subcommand ($@ variable)

Now, to start enjoying working with Jekyll init the page:
```bash
jekyll.sh new --force .
```

Wait for install and then:
```bash
jekyll.sh serve
```

**Done!**


#### More to read on other sites:
- [jekyll docker image page](https://github.com/envygeeks/jekyll-docker/blob/master/README.md)
- [bash script directory](https://electrictoolbox.com/bash-script-directory/)
- [passing bash parameters around](https://wiki.bash-hackers.org/scripting/posparams#mass_usage)