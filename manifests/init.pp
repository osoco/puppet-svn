class svn ($ensure = 'latest', $package = 'subversion') {

    if !defined(Package["$package"]) {
        package { "$package":
            ensure => "$ensure"
        }
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
        timeout => $timeout,
	creates => "$path"
    }
}

define svn::update($path, $username, $password, $trust-cert='true', $timeout=60) {

    if $trust-cert == 'true' {
        $trust-server-cert-option = "--trust-server-cert"
    } else {
        $trust-server-cert-option = ""
    }

    exec {"svn-up-$name":
        command => "/usr/bin/svn --username $username --password $password --non-interactive $trust-server-cert-option up",
        cwd => "$path",
        timeout => $timeout,
        onlyif => "test -d $path/.svn"
    }

}
