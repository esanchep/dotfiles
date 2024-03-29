source ~/.bash_profile

alias dc="docker-compose"

dci() {
	echo "dc -> docker-compose shorthand"
	echo "---------------"
	echo "dcf -> prints the value of the actual compose file used"
	echo "dcf <filename> -> updates the compose file to be used"
	echo "---------------"
	echo "dcps -> docker-compose ps"
	echo "---------------"
	echo "dcu -> docker-compose up"
	echo "	param1 ->	<container_name> -> docker-compose up <container_name>"
	echo "	param2 ->	-d -> docker-compose up -d <container_name>"
	echo "---------------"
	echo "dcd -> docker-compose down"
	echo "---------------"
	echo "dcs -> docker-compose stop"
	echo "dcs <container_name> -> docker-compose stop <container_name>"
	echo "---------------"
	echo "dcrm -> docker-compose rm -sfv (stops+removes all containers and volumes)"
}

dcf() {
	if [ -z "$1" ]; then
		echo "Selected compose file: ${DOCKER_COMPOSE_YML}"
	else
		echo "Updating the docker-compose YML file to be used to $1"
		local current_file=${DOCKER_COMPOSE_YML}
		local new_file=$1
		export DOCKER_COMPOSE_YML=$new_file
		sed -i "s/$current_file/$new_file/" ~/.bash_profile
	fi
}

dcps() {
	dc -f $DOCKER_COMPOSE_YML ps
}

dcu() {
	local container="$1"
	local detach="$2"
	dc -f $DOCKER_COMPOSE_YML up $detach $container
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
