Exec { path => ["/usr/bin", "/usr/local/bin", "/bin"] }

class appscale_dependencies {
  exec { "apt-get update": }

  package { ["openjdk-6-jdk", "vim", "openssh-server", "git-core", "tcsh"]:
    ensure => present,
    require => Exec["apt-get update"],
  }
}

include appscale_dependencies
