# frozen_string_literal: true

provides :yum_alma_nvidia
unified_mode true

include YumAlmaChef::Cookbook::Helpers

property :baseurl, [String, nil], default: lazy { alma_nvidia_baseurl }
property :description, String, default: lazy { alma_nvidia_description }
property :enabled, [true, false], default: true
property :gpgkey, [String, Array], default: lazy { alma_nvidia_gpgkeys }
property :gpgcheck, [true, false], default: true

property :debug_baseurl, [String, nil], default: lazy { alma_nvidia_baseurl(true) }
property :debug_description, String, default: lazy { alma_nvidia_description(true) }
property :debug_enabled, [true, false], default: false

property :extra_options, Hash, default: {}

action_class do
  include YumAlmaChef::Cookbook::Helpers
end

action :create do
  create_alma_nvidia_repo
end

action :delete do
  delete_alma_nvidia_repo
end
