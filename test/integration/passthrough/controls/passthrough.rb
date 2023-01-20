include_controls 'common'

control 'passthrough' do
  title 'Test passthrough properties'

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
    end

    describe parse_config_file("/etc/yum.repos.d/#{name}.repo") do
      its(name) { should include({ 'exclude' => 'abc efg', 'priority' => '10' }) }
    end

    describe yum.repo "#{name}-debuginfo" do
      it { should exist }
      it { should_not be_enabled }
    end

    describe parse_config_file("/etc/yum.repos.d/#{name}-debuginfo.repo") do
      its("#{name}-debuginfo") { should include({ 'exclude' => 'abc efg', 'priority' => '10' }) }
    end
  end
end
