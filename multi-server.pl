#!/usr/bin/perl
#
# /*
#  * Copyright 2013
#  * O Script é um software livre; você pode redistribuí-lo e/ou modificá-lo dentro dos termos
#  * da Licença Pública Geral GNU como publicada pela Fundação do Software Livre (FSF); na versão
#  * 2 da Licença.
#  *
#  * Este programa é distribuído na esperança que possa ser útil, mas SEM NENHUMA GARANTIA; sem
#  * uma garantia implícita de ADEQUAÇÃO a qualquer MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a
#  * Licença Pública Geral GNU/GPL em português para maiores detalhes.
#  * Você deve ter recebido uma cópia da Licença Pública Geral GNU, sob o título "LICENCA.txt",
#  * junto com este programa, se não, acesse o Portal do Software Público Brasileiro no endereço
#  * www.softwarepublico.gov.br ou escreva para a Fundação do Software Livre(FSF)
#  * Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301, USA
#  * */

#/**
# *
# * Script de Autenticação para Multi-Server SQUID
# *
# * @subpackage Perl Script
# * @name multi-server.pl
# * @author Fabio Lima <fabioolima at gmail.com>
# * @since 2015-08-25
# * @version 1.0.0
# */

use strict;
use warnings;
use IO::Handle;
use Authen::Simple::ActiveDirectory;
use Authen::Simple::LDAP;

STDOUT->autoflush(1);
STDERR->autoflush(1);

my $ldap131 = Authen::Simple::LDAP->new(
    host    => '<host_ip_1>',
    basedn  => 'dc=local,dc=com',
    binddn  => 'cn=sysadmin,cn=users,dc=local,dc=com',
    bindpw  => '<sysadmin_passwd>',
    filter  => '(sAMAccountName=%s)'
);

my $ldap133 = Authen::Simple::LDAP->new(
    host    => '<host_ip_2',
    basedn  => 'dc=local,dc=com',
    binddn  => 'cn=sysadmin,cn=users,dc=local,dc=com',
    bindpw  => '<sysadmin_passwd>',
    filter  => '(sAMAccountName=%s)'
);

sub isValid {
    chomp;
    my ($username, $password) = split;
    if ( ($username eq '') or ($password eq '') ) {
        return 0;
    } else {
        if ( $ldap131->authenticate( $username, $password ) ) {
            return 1;
        } elsif ( $ldap133->authenticate( $username, $password ) ) {
            return 1;
        } else {
            return 0;
        }
    }
}

while (<>) {
     my ( $user, $passwd ) = m{^(\S+)(?:\s+(.+))?$};
     print isValid( $user, $passwd ) ? qq{OK\n} : qq{ERR\n};
}
__END__
