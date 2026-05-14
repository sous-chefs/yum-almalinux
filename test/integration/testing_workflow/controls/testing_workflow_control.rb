# frozen_string_literal: true

include_controls 'common'

control 'testing_workflow' do
  title 'Verify testing repo state after almalinux-release-testing pre-install'

  # The upstream RPM stays installed; we only manage the .repo file.
  describe package('almalinux-release-testing') do
    it { should be_installed }
  end

  # The Chef-managed file is on disk, the RPM-shipped one is gone (the latter
  # is also asserted by the included `common` controls, but it's worth being
  # explicit here since it's the whole point of this suite).
  describe file '/etc/yum.repos.d/testing.repo' do
    it { should exist }
  end

  describe file '/etc/yum.repos.d/almalinux-testing.repo' do
    it { should_not exist }
  end

  describe yum.repo 'testing' do
    it { should exist }
    it { should_not be_enabled }
  end

  # End-to-end check: repo metadata fetches successfully when explicitly
  # enabled. Note we use --enablerepo=testing (the cookbook-managed repo id),
  # not --enablerepo=almalinux-testing (the id used by the upstream RPM).
  describe command('dnf -q --enablerepo=testing makecache') do
    its('exit_status') { should eq 0 }
  end
end
