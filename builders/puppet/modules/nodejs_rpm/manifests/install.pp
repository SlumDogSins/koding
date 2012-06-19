# Class: nodejs_rpm::install
#
#
class nodejs_rpm::install {
    

    $coffee_version = '1.2.0'
    
    package { "nodejs":
        ensure => installed,
        alias  => 'nodejs'
    }
    
    file {"/usr/bin/node":
         ensure  => symlink,
         target  => "/usr/bin/nodejs",
         require => Package["nodejs"]
     }
    
    package { "npm":
        ensure  => installed,
        require => Package["nodejs"],
    }
    
    exec { "coffee-script":
        command => "npm -g install coffee-script@${coffee_version}",
        require => Package["npm"],
        path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        user    => "root",
        group   => "root",
        onlyif  => '/usr/bin/test ! -e  /usr/bin/coffee'
    }
}