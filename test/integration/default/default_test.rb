%w(
  plus
  ha
  nfv
  powertools
  resilientstorage
  rt
  sap
  saphana
).each do |name|
  describe file "/etc/yum.repos.d/almalinux-#{name}.repo" do
    it { should_not exist }
  end
end

describe file '/etc/yum.repos.d/almalinux.repo' do
  it { should_not exist }
end

os_release = os.release.to_i

describe yum.repo 'baseos' do
  it { should exist }
  it { should be_enabled }
  its('mirrors') { should cmp "https://mirrors.almalinux.org/mirrorlist/#{os_release}/baseos/" }
end

describe yum.repo 'extras' do
  it { should exist }
  it { should be_enabled }
  its('mirrors') { should cmp "https://mirrors.almalinux.org/mirrorlist/#{os_release}/extras/" }
end

describe yum.repo 'appstream' do
  it { should exist }
  it { should be_enabled }
  its('mirrors') { should cmp "https://mirrors.almalinux.org/mirrorlist/#{os_release}/appstream/" }
end

%w(centosplus fasttrack cr debuginfo).each do |repo|
  describe yum.repo repo do
    it { should_not exist }
    it { should_not be_enabled }
  end
end
