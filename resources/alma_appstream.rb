# frozen_string_literal: true

provides :yum_alma_appstream
unified_mode true

include YumAlmaChef::Cookbook::Helpers

use '_partial/_common'

repo_name = 'AppStream'

property :baseurl, [String, nil], default: lazy { alma_repo_baseurl(repo_name) }
property :mirrorlist, [String, nil], default: lazy { alma_repo_mirrorlist(repo_name) }
property :description, String, default: lazy { alma_repo_description(repo_name) }

property :debug_baseurl, [String, nil], default: lazy { alma_repo_baseurl(repo_name, true) }
property :debug_mirrorlist, [String, nil], default: lazy { alma_repo_mirrorlist(repo_name, true) }
property :debug_description, String, default: lazy { alma_repo_description(repo_name, true) }

action_class do
  include YumAlmaChef::Cookbook::Helpers
end

action :create do
  create_alma_repo(repo_name)
end

action :delete do
  delete_alma_repo(repo_name)
end
