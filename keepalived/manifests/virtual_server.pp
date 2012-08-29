# Define : keepalived::virtual_server
#
# Define a virtual server. 
#
# Parameters :
#        state : MASTER or BACKUP
#        virtual_router_id
#        virtual_ipaddress
#        virtual_dev = which device to start VIP on
#        interface = 'eth0'
#        priority = '' : If not set, BACKUP will take 100 and MASTER 200

define keepalived::virtual_server ( 
	$state, 
	$virtual_router_id, 
	$virtual_ipaddress,
        $virtual_dev,
        $auth_pass,
	$interface = 'eth0',
        $order = '20',
	$priority = '' ) {

	#Variables manipulations
	$real_priority = $priority ? {
		'' => $state ? {
			'MASTER' => '200',
			'BACKUP' => '100',
		      },
		default => $priority,
	}

	#Construct /etc/keepalived/keepalived.conf
        concat::fragment { "${name}_keepalived_member":
          order   => $order,
          target  => '/etc/keepalived/keepalived.conf',
          content => template('keepalived/virtual_server.erb'),
        }
}
