control 'common' do
  title 'Common controls'

  %w(
    crb
    ha
    nfv
    plus
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
end
