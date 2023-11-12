---
# group vars

ip_address:
%{ for iscsi-server in iscsi-servers ~}
  ${ iscsi-server["name"] }: ${ iscsi-server.network_interface[0].ip_address }
%{ endfor ~}
%{ for pcs-server in pcs-servers ~}
  ${ pcs-server["name"] }: ${ pcs-server.network_interface[0].ip_address }
%{ endfor ~}


domain: "mydomain.test"
ntp_timezone: "UTC"
pcs_password: "strong_pass"
sha512_pcs_password: "$6$738ALo23dL0GMKRe$0.stjbDQRZxwXoPXwIe4RRU3eWT8bTOpS5bKvOqjXzwdtbdwIDoKWTq5TYfwJyK12Wx2.GECFK9xiObQs16UP0"
cluster_name: "hacluster"
subnet_cidrs: "{ %{ for subnet_cidr in subnet_cidrs ~} ${ subnet_cidr }, %{ endfor ~} }"