# Docker stuff
# Need to 'eval' docker-machine env vars for each new shell

if [[ "$(docker-machine status default)" == "Running" ]]; then
  eval "$(docker-machine env default)"
fi
