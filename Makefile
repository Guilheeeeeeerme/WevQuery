clean:
    docker images -f "dangling=true" -q | xargs docker image rm