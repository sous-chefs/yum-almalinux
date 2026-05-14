# frozen_string_literal: true

include_controls 'common'

control 'default' do
  title 'Verify default repos are enabled'

  os_release = os.release.to_i
  %w(
    baseos
    appstream
    extras
  ).each do |name|
    describe yum.repo name do
      it { should exist }
      it { should be_enabled }
      its('mirrors') { should cmp "https://mirrors.almalinux.org/mirrorlist/#{os_release}/#{name}/" }
    end

    describe yum.repo "#{name}-debuginfo" do
      it { should_not exist }
    end
  end

  %w(
    crb
    highavailability
    nfv
    plus
    powertools
    resilientstorage
    rt
    sap
    saphana
  ).each do |name|
    describe yum.repo name do
      it { should_not exist }
    end

    describe yum.repo "#{name}-debuginfo" do
      it { should_not exist }
    end
  end

  describe yum.repo 'testing' do
    it { should exist }
    it { should_not be_enabled }
  end

  describe file '/etc/yum.repos.d/testing.repo' do
    it { should exist }
  end

  describe yum.repo 'testing-debuginfo' do
    it { should_not exist }
  end

  # Smoke test: confirm dnf can fetch testing metadata when explicitly enabled.
  # Catches DNS, baseurl, and section-name regressions that static file checks miss.
  describe command('dnf -q --enablerepo=testing makecache') do
    its('exit_status') { should eq 0 }
  end
end
