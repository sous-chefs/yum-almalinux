require 'chefspec'
require 'chefspec/berkshelf'

ALL_RESOURCE_NAMES = %w(
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
).freeze

ALL_ALMA_8_REPOS = %w(
  AppStream
  BaseOS
  extras
  HighAvailability
  NFV
  Plus
  PowerTools
  ResilientStorage
  RT
  SAP
  SAPHANA
).freeze

RSpec.configure do |config|
  config.color = true               # Use color in STDOUT
  config.formatter = :documentation # Use the specified formatter
  config.log_level = :error         # Avoid deprecation notice SPAM
end
