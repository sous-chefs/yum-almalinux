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
    resilientstorage
    rt
    sap
    saphana
    synergy
  )

  # add the correct of powertools/crb repo for each version
  case os_release
  when 8
    repos.append('powertools')
  when 9
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
end
