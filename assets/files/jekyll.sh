LOCALPORT=4000
DIRECTORY=$(cd `dirname $0` && pwd)

mkdir -p "$DIRECTORY/vendor/bundle"
docker run --rm -p "$LOCALPORT:4000" -v "$DIRECTORY/vendor/bundle:/usr/local/bundle" -v "$DIRECTORY:/srv/jekyll" -it jekyll/jekyll:3.8.5 jekyll "$@"

