# frozen_string_literal: true

# Pre-install the upstream RPM that drops /etc/yum.repos.d/almalinux-testing.repo.
# The cookbook should then cleanly take over: nuke the RPM-shipped file and write
# its own /etc/yum.repos.d/testing.repo with the section disabled by default.
package 'almalinux-release-testing'

yum_alma_baseos 'default'
yum_alma_appstream 'default'
yum_alma_extras 'default'
yum_alma_testing 'default'
