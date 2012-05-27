class svn ($ensure = "latest") {

    package { subversion:
        ensure => $ensure
    }

}

define svn::checkout($username,$password,$url,$path,$trust-cert='true',$timeout=60) {

    if $trust-cert == 'true' {
        $trust-server-cert-option = "--trust-server-cert"
    } else {
        $trust-server-cert-option = ""
    }

    exec {"svn-co-$name":
        command => "/usr/bin/svn --username $username --password $password --non-interactive $trust-server-cert-option checkout $url $path",
        timeout => $timeout
    }
}
