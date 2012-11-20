Exec { path => ["/usr/bin", "/usr/local/bin", "/usr/sbin", "/bin", "/sbin"] }

class box_cleanup {
  exec { "fix_hosts":
    command => "sed -i -e 's/127.0.1.1.*/127.0.1.1 lucid64/' /etc/hosts",
    onlyif => "grep comcast /etc/hosts",
  }

  file { "/home/vagrant/appscale":
    ensure => directory,
    mode => 0755,
    owner => vagrant,
    group => vagrant,
  }
}

class appscale_dependencies {
  exec { "apt-get update": }

  package { ["build-essential", "debhelper", "dh-make", "fakeroot", "lintian", "gnupg", "pbuilder",
             "ec2-api-tools", "openjdk-6-jdk", "vim", "openssh-server", "git-core", "tcsh", "python-sphinx"]:
    ensure => present,
    require => Exec["apt-get update"],
  }

  file { "/usr/lib/jvm/java-6-openjdk/lib/security":
    ensure => directory,
    recurse => true,
    mode => 0775,
    owner => root,
    group => root,
  }

  file { "/usr/lib/jvm/java-6-openjdk/lib/cacerts":
    ensure => present,
    recurse => true,
    mode => 0664,
    owner => root,
    group => root,
  }
}

class appscale_development {
  file { "/home/vagrant/.devscripts":
    ensure => link,
    target => "/home/vagrant/.appscale-tools/devscripts",
  }
}

class appscale_tools {
  exec { "package_appscale_tools":
    command => "make deb",
    cwd => "/home/vagrant/appscale/appscale-tools",
    unless => "test -e /home/vagrant/appscale/appscale-tools*deb",
    logoutput => "on_failure",
  }

  exec { "appscale_tools_deps":
    command => "apt-get install -y $(grep '^Depends' /home/vagrant/appscale/appscale-tools/debian/control | sed -e 's/.*Depends: //' -e 's/,//g')",
    require => [Exec["apt-get update"], Exec["package_appscale_tools"]],
    logoutput => "on_failure",
  }

  exec { "install_appscale_tools":
    command => "dpkg -i appscale-tools*deb",
    cwd => "/home/vagrant/appscale",
    require => Exec["appscale_tools_deps"],
    logoutput => "on_failure",
  }
}

include box_cleanup
include appscale_dependencies
include appscale_development
include appscale_tools
