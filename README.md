# decrypt-ipsec

### Get the IPSec-Router container
```
$ docker ps
....
77d3b59709c6        rancher/net:v0.11.3    ....      r-ipsec-ipsec-router-1-7c40d515
....
```

### Get the pcap file by tcpdump
```
$ ./decrypt-ipsec.sh dump 77d3b59709c6

Dump traffic packets by tcpdump!
You can use like: ip netns 77d3b59709c6 exec tcpdump -i eth0 -venn -w ~/test.cap
```

### Get the configration for Wireshack 
```
$ ./decrypt-ipsec.sh config 77d3b59709c6

Get Net NameSpace: /var/run/netns/77d3b59709c6
######################################
####Get ESP config for WireShack!####
######################################
src 10.42.97.15 dst 172.31.2.184
SPI: 0xc150f464}
Encryption: rfc4106(gcm(aes))
Encryption key: 0xc4cfa585815121012e244734b33c095d78b3ffa0
Authentication: Any 128 bit authentication
=========================
src 172.31.2.184 dst 10.42.97.15
SPI: 0xc7bf85c9}
Encryption: rfc4106(gcm(aes))
Encryption key: 0x958818184a3b8b6eb161e2a9e45f49e4652ad16a
Authentication: Any 128 bit authentication
=========================
```

### Open wireShack to set ESP protocol decoding information
Open wireShack: `Edit -> Preferences -> Protocol -> ESP`
![](https://ws1.sinaimg.cn/large/006tNc79ly1fhtub2l506j30le08ut9a.jpg)
![](https://ws3.sinaimg.cn/large/006tNc79ly1fhtubipqgrj31au07kq3y.jpg)
