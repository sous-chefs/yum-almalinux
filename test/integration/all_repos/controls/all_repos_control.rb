# frozen_string_literal: true

include_controls 'common'

control 'all_repos' do
  title 'Test all AlmaLinux repositories'

  os_release = os.release.to_i

  repos = %w(
    appstream
    baseos
    extras
    highavailability
    nfv
    plus
    rt
    sap
    saphana
    synergy
  )

  repos.append('resilientstorage') if os_release < 10

  # add the correct powertools/crb repo for each version
  case os_release
  when 8
    repos.append('powertools')
  when 9, 10
    repos.append('crb')
  end

  repos.each do |name|
    describe yum.repo name do
      it { should exist }
      it { should be_enabled }
      its('mirrors') { should cmp "https://mirrors.almalinux.org/mirrorlist/#{os_release}/#{name}/" }
    end

    describe yum.repo "#{name}-debuginfo" do
      it { should_not exist }
      it { should_not be_enabled }
    end
  end

  describe yum.repo 'testing' do
    it { should exist }
    it { should_not be_enabled }
  end

  describe yum.repo 'testing-debuginfo' do
    it { should_not exist }
  end
end
