# frozen_string_literal: true

include_controls 'common'

control 'extra_options' do
  title 'Test extra_options properties'

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
    end

    describe parse_config_file("/etc/yum.repos.d/#{name}.repo") do
      its(name) { should include({ 'exclude' => 'abc efg', 'priority' => '10' }) }
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

  describe parse_config_file('/etc/yum.repos.d/testing.repo') do
    its('testing') { should include({ 'exclude' => 'abc efg', 'priority' => '10' }) }
  end

  describe yum.repo 'testing-debuginfo' do
    it { should_not exist }
  end

  if os_release >= 9
    describe yum.repo 'nvidia' do
      it { should exist }
      it { should be_enabled }
    end

    describe parse_config_file('/etc/yum.repos.d/nvidia.repo') do
      its('nvidia') { should include({ 'exclude' => 'abc efg', 'priority' => '10' }) }
    end

    describe yum.repo 'nvidia-debuginfo' do
      it { should_not exist }
    end
  end
end
