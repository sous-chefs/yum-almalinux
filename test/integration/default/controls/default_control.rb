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
    it { should exist }
    it { should_not be_enabled }
    its('mirrors') { should cmp "https://mirrors.almalinux.org/mirrorlist/#{os_release}/#{name}-debuginfo/" }
  end
end

  %w(
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
      it { should_not exist }
    end

    describe yum.repo "#{name}-debuginfo" do
      it { should_not exist }
    end
  end
end
