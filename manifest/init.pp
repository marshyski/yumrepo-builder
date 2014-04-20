## SETUP YUM REPO DIRECTORIES FOR MGT SERVERS
## DEPENDENT ON NGINX MODULE / SETUP

class yumrepo(
  $repo_user  = 'root',
  $repo_group = 'root',
  $repo_dir   = '/usr/share/nginx/html/CentOS',
  $os_ver     = '6.4',){

# Install pacakages to manage repo
  package { 'createrepo':
           [
	     'createrepo',
	     'rpmbuild',
	   ]:
      	     ensure => installed;
  }

# Setup yum repo directories
  file {
	[
	  $repo_dir,
	  "${repo_dir}/${os_ver}",
	  "${repo_dir}/${os_ver}/os",
	  "${repo_dir}/${os_ver}/updates",
	  "${repo_dir}/${os_ver}/os/x86_64",
	  "${repo_dir}/${os_ver}/os/x86_64/repodata",
	  "${repo_dir}/${os_ver}/updates/x86_64",
	  "${repo_dir}/${os_ver}/updates/x86_64/repodata",
	  "${repo_dir}/${os_ver}/os/x86_64/Packages",
	  "${repo_dir}/${os_ver}/updates/x86_64/Packages",
	]:
      	  ensure  => directory,
      	  owner   => $repo_user,
      	  group   => $repo_group,
      	  mode    => '0755',
      	  require => Class['nginx'];
    }

## CREATE DIRECTORY
file { '/root/scripts':
	ensure  => directory,
        owner   => $repo_user,
        group   => $repo_group,
        mode    => '0700',
	require => Class['nginx'];
     }

## CREATE DIRECTORY
file { '/root/scripts/configs':
        ensure  => directory,
        owner   => $repo_user,
        group   => $repo_group,
        mode    => '0700',
        require => File['/root/scripts'];
     }

## PUSH SCRIPT TO MGT SERVER
file { '/root/scripts/rm_repo_packages.sh':
        ensure  => present,
        owner   => $repo_user,
        group   => $repo_group,
        mode    => '0700',
	source  => 'puppet:///modules/yumrepo/rm_repo_packages.sh',
	require => File['/root/scripts'];
     }

## PUSH RPM REMOVE LIST TO MGT SERVER
file { '/root/scripts/configs/rm_list':
        ensure  => present,
        owner   => $repo_user,
        group   => $repo_group,
        mode    => '0600',
        source  => 'puppet:///modules/yumrepo/rm_list',
        require => File['/root/scripts/configs'];
     }

## EXECUTE SCRIPT TO REMOVE UNWANTED PACKAGES
exec {'rm_repo_packages.sh':
	command => '/root/randomz/rm_repo_packages.sh',
	user	=> $repo_user,
	require => File['/root/randomz/configs/rm_list'];
     }

}
