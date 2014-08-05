Exec { 
  path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ]
}

exec { 'yum-update':
  command => '/usr/bin/yum -y update'
}

exec { 'yum-groupinstall': 
  command => '/usr/bin/yum -y groupinstall "Development Tools"'
}

class { 'webdriver':
  doc_root => '/vagrant'
}
