# Setup yum repo directories for yum repo server
# Dependencies: NGINX or use ''python -m SimpleHTTPServer 80 2>&1 nohup &''

class yumrepo-builder(
  $repo_user  = 'root',
  $repo_group = 'root',
  $repo_dir   = '/usr/share/nginx/html/CentOS',
  $os_ver     = '6.5',){

# Install pacakages to manage repo
  package { 'createrepo':
           [
	     'createrepo',
	     'rpmbuild',
	   ]:
      	     ensure => latest,
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
  }

# Create staged directory
  file { '/root/scripts':
	ensure  => directory,
        owner   => $repo_user,
        group   => $repo_group,
        mode    => '0700',
  }

# Create staged directory
  file { '/root/scripts/configs':
        ensure  => directory,
        owner   => $repo_user,
        group   => $repo_group,
        mode    => '0700',
        require => File['/root/scripts'],
  }

# Push remove package script to yum repo server
  file { '/root/scripts/rm_repo_packages.sh':
        ensure  => present,
        owner   => $repo_user,
        group   => $repo_group,
        mode    => '0700',
	source  => 'puppet:///modules/yumrepo-builder/rm_repo_packages.sh',
	require => File['/root/scripts'],
  }

# Push package remove list to yum repo server
  file { '/root/scripts/configs/rm_list':
        ensure  => present,
        owner   => $repo_user,
        group   => $repo_group,
        mode    => '0600',
        source  => 'puppet:///modules/yumrepo-builder/rm_list',
        require => File['/root/scripts/configs'],
   }

# Push package remove list to yum repo server
  file { '/root/scripts/update_repo.sh':
        ensure  => present,
        owner   => $repo_user,
        group   => $repo_group,
        mode    => '0700',
        source  => 'puppet:///modules/yumrepo-builder/update_repo.sh',
        require => File['/root/scripts'],
   }

# Push package remove list to yum repo server
  file { '/root/scripts/createrepo.sh':
        ensure  => present,
        owner   => $repo_user,
        group   => $repo_group,
        mode    => '0700',
        source  => 'puppet:///modules/yumrepo-builder/createrepo.sh',
        require => File['/root/scripts'],
   }

# Execute script to remove unwanted packages
  exec {'rm_repo_packages.sh':
	command => '/root/scripts/rm_repo_packages.sh',
	user	=> $repo_user,
	require => Cron['yumsync'],
  }

# Crontab for updating the repo first monday of the month
  cron { 'yumsync':
        command  => '/root/scripts/update_repo.sh && /root/scripts/createrepo.sh',
        user     => root,
	weekday  => '01',
	month    => '*',
	monthday => '1-7',
        hour     => '00',
        minute   => '00',
        require  => [File['/root/scripts/update_repo.sh'],File['/root/scripts/createrepo.sh']];
  }

}
