---
ip_address:
%{ for nginx-server in nginx-servers ~}
  ${ nginx-server["name"] }: ${ nginx-server.network_interface[0].ip_address }
%{ endfor ~}
%{ for backend-server in backend-servers ~}
  ${ backend-server["name"] }: ${ backend-server.network_interface[0].ip_address }
%{ endfor ~}
%{ for iscsi-server in iscsi-servers ~}
  ${ iscsi-server["name"] }: ${ iscsi-server.network_interface[0].ip_address }
%{ endfor ~}
%{ for db-server in db-servers ~}
  ${ db-server["name"] }: ${ db-server.network_interface[0].ip_address }
%{ endfor ~}


domain: "mydomain.test"
ntp_timezone: "UTC"
pcs_password: "strong_pass"
sha512_pcs_password: "$6$738ALo23dL0GMKRe$0.stjbDQRZxwXoPXwIe4RRU3eWT8bTOpS5bKvOqjXzwdtbdwIDoKWTq5TYfwJyK12Wx2.GECFK9xiObQs16UP0"
cluster_name: "hacluster"
subnet_cidrs: "{ %{ for subnet_cidr in subnet_cidrs ~} ${ subnet_cidr }, %{ endfor ~} }"
wp_db_name: "wordpress"
wp_db_user: "wordpress"
wp_db_pass: "str0ng_pass"
wp_db_host: "%{ for db-server in db-servers ~} ${ db-server.network_interface[0].ip_address } %{ endfor ~}"