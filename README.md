yumrepo-builder
===============

Easily build, update and customize your yum repository via **Puppet** manifest.

Why use this?
--------------

Standing up a yum repo can have a lot of moving parts, especially if you're trying to scale or new to the process of standing up a repo.

Requirements
------------
  * RHEL 5-6
  * Puppet client
  * Nginx or use python SimpleHTTPServer
  * createrepo (package - yum install createrepo)

Usage
-----
    manifest/
             init.pp - Manifest to call bash scripts and setup directories
        
    files/
          update_repo.sh - Updates the repo with all of the OS & Updated packages
          createrepo.sh - Creates the repo after update_repo.sh runs
          rm_repo_packages.sh - Remove unwanted packages from repo, keeping it secure
          rm_list - Flat file with all packages with REGEX to determine what's being removed
        
Help & Feedback
---------------
You can email (timski@linux.com) me directly if you need help, submit an issue or pull request.  Fork it.
