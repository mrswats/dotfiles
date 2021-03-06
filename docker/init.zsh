# Docker CLI Configuration

export DOCKER_BUILDKIT=1

# Alias docker commands
if [ "$(command -v docker)" ]
then
    docker () {
        if [[ $@ == "ps" ]]; then
            command docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}\t{{.Networks}}\t{{.Ports}}"
        elif [[ $@ == "stop all" ]]; then
            command docker stop $(docker ps -q)
        else
            command docker "$@"
        fi
    }
fi
