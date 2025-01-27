# README

## Building image

```
docker build \
  --build-arg SECRET_KEY_BASE=<RAILS_SECRET_KEY_BASE> \
  --build-arg EPPO_SDK_KEY=<EPPO_SDK_KEY> \
  -t rails-eppo-example .
```

## Running

```
docker run --rm -p 3000:3000 rails-eppo-example
```

The website should then be running on http://localhost:3000
