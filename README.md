# multiserverauth
Squid Auth Multi-Server

It allows to connect up to two servers in multiple authentication, if the first one fails it's going to try the next one.

## Requires

* IO::Handle;
* Authen::Simple::ActiveDirectory;
* Authen::Simple::LDAP;

### Installing Requirements 

* `perl -MCPAN -e shell`
* cpan[1]> `install Authen::Simple::ActiveDirectory`
* cpan[2]> `install Authen::Simple::LDAP`

## Uses

Use in your squid configuration as same as squid_auth.pl, but not necessary send any parameter.



