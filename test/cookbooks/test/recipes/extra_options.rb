# frozen_string_literal: true

passthrough_props = {
  'exclude' => 'abc efg',
  'priority' => '10',
}

%w(
  appstream
  baseos
  extras
  ha
  nfv
  plus
  powertools
  rt
  sap
  saphana
).each do |name|
  declare_resource(:"yum_alma_#{name}", 'default') do
    # some properties that need to be passed through to the yum_repository resources
    extra_options passthrough_props
  end
end

if node['platform_version'].to_i < 10
  yum_alma_resilientstorage 'default' do
    extra_options passthrough_props
  end
end

yum_alma_testing 'default' do
  extra_options passthrough_props
end
