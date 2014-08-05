class webdriver(
    $doc_root = '/home/vagrant/',
    $java_package = ['java-1.7.0-openjdk', 'java-1.7.0-openjdk-devel'],
    $others_package = ['firefox', 'xorg-x11-server-Xvfb'],
  ) {

  package { $java_package:
    ensure => 'installed',
  }

  package { $others_package:
    ensure => 'installed',
    require => Package[$java_package]
  }

  file { "/home/vagrant/.bashrc":
    ensure => 'present',
    content => template('webdriver/java.erb'),
    require => Package[$java_package],
  }

  file { "/usr/local/apache-maven":
    ensure => "directory",
  }

  exec{'download_maven':
    require => File['/usr/local/apache-maven'],
    cwd => '/usr/local/apache-maven',
    command => '/usr/bin/wget -q http://ftp.unicamp.br/pub/apache/maven/maven-3/3.2.2/binaries/apache-maven-3.2.2-bin.tar.gz',
  }

  exec{'extract_maven':
    require => Exec['download_maven'],
    cwd => '/usr/local/apache-maven',
    command=> 'tar xvf apache-maven-3.2.2-bin.tar.gz',
  }

  exec{'remove_maven_tar':
    require => Exec['extract_maven'],
    cwd => '/usr/local/apache-maven',
    command=> 'rm apache-maven-3.2.2-bin.tar.gz',
  }
}


