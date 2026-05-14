# frozen_string_literal: true

provides :yum_alma_powertools
unified_mode true

include YumAlmaChef::Cookbook::Helpers

use '_partial/_common'

property :baseurl, [String, nil], default: lazy { alma_repo_baseurl(alma_powertools_repo_name) }
property :mirrorlist,  [String, nil], default: lazy { alma_repo_mirrorlist(alma_powertools_repo_name) }
property :description, String, default: lazy { alma_repo_description(alma_powertools_repo_name) }

property :debug_baseurl, [String, nil], default: lazy { alma_repo_baseurl(alma_powertools_repo_name, true) }
property :debug_mirrorlist,  [String, nil], default: lazy { alma_repo_mirrorlist(alma_powertools_repo_name, true) }
property :debug_description, String, default: lazy { alma_repo_description(alma_powertools_repo_name, true) }

action_class do
  include YumAlmaChef::Cookbook::Helpers
end

action :create do
  create_alma_repo(alma_powertools_repo_name)
end

action :delete do
  delete_alma_repo(alma_powertools_repo_name)
end
