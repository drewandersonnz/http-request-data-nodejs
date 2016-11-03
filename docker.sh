#!/bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

#set -vx

cd ${DIR}

export NAMESPACE="drewandersonnz"
export PROJECT="nodejs-test"
export NAME="${PROJECT}-latest"

# export OPT_RESTART=''

case ${1} in
    start)
        COMMAND="sudo docker start ${NAME}"
        ;;
    stop)
        COMMAND="sudo docker stop ${NAME}"
        ;;
    rm)
        COMMAND="sudo docker rm ${NAME}"
        ;;
    bash)
        COMMAND="sudo docker exec -it ${NAME} bash"
        ;;
    dev)
        COMMAND="""
            sudo docker run -it --rm
            -v `pwd`:/usr/src/app
            -w /usr/src/app
            --publish 8888
            ${NAMESPACE}/${PROJECT}:latest
            bash
        """
        ;;
    build)
        COMMAND="""
            sudo docker build
            -t ${NAMESPACE}/${PROJECT}:`date +%Y%m%d-%H%M%S`
            -t ${NAMESPACE}/${PROJECT}:latest
            .
        """
        ;;
    run)
        COMMAND="""
            sudo docker run
            --detach
            --name=${NAME}
            -v `pwd`:/usr/src/app
            -w /usr/src/app
            --publish 8888
            ${NAMESPACE}/${PROJECT}:latest
        """
            #--privileged
            #--restart=always
        ;;
    help)
        # Illegal option passed
        echo "stop | rm | build | run | start | bash"
        exit 1
        ;;
esac

echo ${COMMAND}
${COMMAND}
