# == Class: vlc::install
#
# Installs VLC for OS X.
#
# === Authors
#
# Ryan Skoblenick <ryan@skoblenick.com>
#
# === Copyright
#
# Copyright 2013 Ryan Skoblenick.
#
class vlc::install {
  $mirror = $vlc::mirror
  $version = $vlc::version

  $arch = $::architecture ? {
    /(x86_64|amd64)/ => 'intel64',
    default => fail("Unrecognized architecture: ${::architecture}")
  }

  $os_family = $::osfamily ? {
    'Darwin' => 'macosx',
  }

  $source = $::osfamily ? {
    'Darwin' => "${mirror}/vlc/vlc/${version}/${$os_family}/vlc-${version}.dmg",
  }

  package {"vlc-${version}":
    ensure => installed,
    source => $source,
    provider => appdmg,
  }
}
