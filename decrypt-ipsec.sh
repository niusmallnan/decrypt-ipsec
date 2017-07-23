#!/bin/bash

set -e

source $(dirname $0)/common.sh

config() {
    check_param
    load_ns

    echo "######################################"
    echo "####Get ESP config for WireShack!####"
    echo "######################################"

    BASE_CMD="ip netns exec ${ROUTER_CONTAINER_ID} ip xfrm stat"

    SPI_LIST=$(${BASE_CMD} | grep  "spi " | awk '{print $4}')
    for SPI in $SPI_LIST
    do
        data=$(${BASE_CMD} list spi ${SPI})
        echo -n "${data}\n" | head -1
        echo "SPI: ${SPI}"
        echo "Encryption: $(echo -n "${data}\n" | grep "rfc" | awk '{print $2}')"
        echo "Encryption key: $(echo -n "${data}\n" | grep "rfc" | awk '{print $3}')"
        echo "Authentication: Any $(echo -n "${data}\n" | grep "rfc" | awk '{print $4}') bit authentication"
        echo "========================="
    done
}


dump() {
    check_param
    echo "Dump traffic packets by tcpdump!"

    echo "You can use like: ip netns exec ${ROUTER_CONTAINER_ID} tcpdump -i eth0 -venn -w ~/test.cap"
}

load_ns() {
    NETNS_BASE="/var/run/netns/"
    if [ ! -d ${NETNS_BASE} ]; then
        mkdir -p ${NETNS_BASE}
    fi

    CONTAINER_NETNS=${NETNS_BASE}${ROUTER_CONTAINER_ID}
    if [ ! -f $CONTAINER_NETNS ]; then
        ln -sv /proc/$(docker inspect -f '{{.State.Pid}}' ${ROUTER_CONTAINER_ID})/ns/net ${CONTAINER_NETNS}
    fi

    echo "Get Container NameSpace: ${CONTAINER_NETNS}"
}

check_param() {
    if [ -z "$ROUTER_CONTAINER_ID" ]; then
        print_error "Must specific ROUTER_CONTAINER_ID"
    fi
}

main "$@"
