source ~/.bash_profile

alias dc="docker-compose"

dcf() {
	if [ -z "$1" ]; then
		echo "Selected compose file: ${DOCKER_COMPOSE_YML}"
	else
		echo "Updating the docker-compose YML file to be used to $1"
		local current_file=${DOCKER_COMPOSE_YML}
		local new_file=$1
		export DOCKER_COMPOSE_YML=$new_file
		sed -i -n "s/$current_file/$new_file/" ~/.bash_profile
	fi
}

dcps() {
	dc -f $DOCKER_COMPOSE_YML ps
}

dcu() {
	local containe="$1"
	local detach="$2"
	echo "$detach $container"
	dc -f $DOCKER_COMPOSE_YML up $detach $containe
}

dcd() {
	dc down
}

dcs() {
	if [ -z "$1" ]; then
		echo "Stopping all conatainers"
	else
		echo "Stopping container [$1]"
	fi
	dc -f $DOCKER_COMPOSE_YML stop $1
}

dcrm() {
	dc -f $DOCKER_COMPOSE_YML rm -sfv
}
