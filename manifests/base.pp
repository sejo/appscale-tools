Exec { path => ["/usr/bin", "/usr/local/bin", "/usr/sbin", "/bin", "/sbin"] }

class box_cleanup {
  exec { "fix_hosts":
    command => "sed -i -e 's/127.0.1.1.*/127.0.1.1 lucid64/' /etc/hosts",
    onlyif => "grep comcast /etc/hosts",
  }
}

class appscale_dependencies {
  exec { "apt-get update": }

  package { ["build-essential", "debhelper", "dh-make", "dupload", "fakeroot", "lintian", "gnupg", "pbuilder",
             "ec2-api-tools", "openjdk-6-jdk", "vim", "openssh-server", "git-core", "tcsh", "python-sphinx"]:
    ensure => present,
    require => Exec["apt-get update"],
    before => [File["/usr/lib/jvm/java-6-openjdk/lib/security"], File["/usr/lib/jvm/java-6-openjdk/lib/cacerts"]],
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

  file { "/etc/dupload.conf":
    ensure => present,
    source => "/srv/appscale/repo/appscale-tools/files/etc/dupload.conf",
  }
}

class appscale_tools {
  exec { "package_appscale_tools":
    command => "make deb",
    cwd => "/srv/appscale/repo/appscale-tools",
    unless => "test -e /srv/appscale/repo/appscale-tools*deb",
    logoutput => "on_failure",
  }

  exec { "appscale_tools_deps":
    command => "apt-get install -y $(grep '^Depends' /srv/appscale/repo/appscale-tools/debian/control | sed -e 's/.*Depends: //' -e 's/,//g')",
    require => [Exec["apt-get update"], Exec["package_appscale_tools"]],
    logoutput => "on_failure",
  }

  exec { "install_appscale_tools":
    command => "dpkg -i appscale-tools*deb",
    cwd => "/srv/appscale/repo",
    require => Exec["appscale_tools_deps"],
    logoutput => "on_failure",
  }
}

class appscale {
  file { "/etc/apt/sources.list.d/appscale.list":
    ensure => present,
    source => "/srv/appscale/repo/appscale-tools/files/etc/apt/sources.list.d/appscale.list",
  }

  exec { "add_appscale_key_to_apt":
    command => "gpg --export 'AppScale Releases' | apt-key add -",
    unless => "sudo apt-key list | grep AppScale",
  }
}

include box_cleanup
include appscale_dependencies
include appscale_development
include appscale
include appscale_tools
