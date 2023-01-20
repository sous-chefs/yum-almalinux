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
  resilientstorage
  rt
  sap
  saphana
).each do |name|
  declare_resource(:"yum_alma_#{name}", 'default') do
    # some properties that need to be passed through to the yum_repository resources
    passthrough passthrough_props
  end
end
