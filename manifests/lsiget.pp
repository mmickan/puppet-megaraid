# == Class: megaraid::lsiget
#
# installs the `lsiget` utility for LSI MegaRAID controllers
#
# See: http://mycusthelp.info/LSI/_cs/AnswerDetail.aspx?inc=8264
#
#
# === Parameters
#
# Accepts no parameters.
#
#
# === Examples
#
#    class{ 'megaraid::lsiget': }
#
#
# === Authors
#
# Joshua Hoblitt <jhoblitt@cpan.org>
#
#
# === Copyright
#
# Copyright (C) 2013 Joshua Hoblitt
#

class megaraid::lsiget {
  include wget

  $unzip_path       = '/opt/lsi'
  $package_tardir   = 'lsigetlinux_080416'
  $package_filename = "lsigetlinux_latest.tgz"
  $package_url      = "ftp://tsupport:tsupport@ftp0.broadcom.com/outgoing_perm/CaptureScripts/${package_filename}"

  file { $unzip_path:
    ensure => directory,
  }

  wget::fetch { $package_filename:
    source      => $package_url,
    destination => "${unzip_path}/${package_filename}",
    timeout     => 30,
    require     => File[$unzip_path],
  } ->
  exec { "tar -xf ${package_filename}":
    path    => ['/bin', '/usr/bin'],
    cwd     => $unzip_path,
    creates => "${unzip_path}/${package_tardir}/lsigetlunix.sh",
  }

}
