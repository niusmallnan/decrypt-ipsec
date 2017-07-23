set -o pipefail
if [ "$DEBUG" == "true"  ]; then set -x; fi

err() {
    echo -e $@ 1>&2
}

usage() {
    err "Usage: "
    err "\t$0 config <router-container-id>"
    err "\t$0 dump <router-container-id>"
    exit 1
}

print_error() {
	echo "$@"
	exit 1
}

main() {
	ROUTER_CONTAINER_ID="$2"
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



