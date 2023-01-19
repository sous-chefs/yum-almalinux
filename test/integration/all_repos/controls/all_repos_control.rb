include_controls 'common'

control 'all_repos' do
  title 'Test all AlmaLinux repositories'

  os_release = os.release.to_i

  %w(
  baseos
  appstream
  extras
  plus
  highavailability
  nfv
  powertools
  resilientstorage
  rt
  sap
  saphana
).each do |name|
  describe yum.repo name do
    it { should exist }
    it { should be_enabled }
    its('mirrors') { should cmp "https://mirrors.almalinux.org/mirrorlist/#{os_release}/#{name}/" }
  end

  describe yum.repo "#{name}-debuginfo" do
    it { should exist }
    it { should_not be_enabled }
    its('mirrors') { should cmp "https://mirrors.almalinux.org/mirrorlist/#{os_release}/#{name}-debuginfo/" }
  end
end
end
