set -o pipefail
if [ "$DEBUG" == "true"  ]; then set -x; fi

err() {
    echo -e $@ 1>&2
}

usage() {
    err "Usage: "
    err "\t$0 config"
    err "\t$0 dump"
    exit 1
}

print_error() {
	echo "$@"
	exit 1
}

main() {
	ROUTER_CONTAINER_ID=$(docker ps -a | grep ipsec-router | awk '{print $1}')
    case $1 in
        config)
            "$@"
            ;;
        dump)
            "$@"
            ;;
        *)
            usage
            ;;
    esac
}



