provides :yum_alma_extras
unified_mode true

use '_partials/_common'

repo_name = 'extras'

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
  return unless platform_family?('rhel')

  # remove existing repo configs
  ::Dir['/etc/yum.repos.d/almalinux*'].each do |f|
    file f do
      action :delete
    end
  end

  yum_repository repo_name.downcase do
    baseurl new_resource.baseurl
    mirrorlist new_resource.mirrorlist
    description new_resource.description
    enabled new_resource.enabled
    gpgcheck new_resource.gpgcheck
    gpgkey new_resource.gpgkey
    new_resource.passthrough.each do |key, value|
      send(key.to_sym, value)
    end
  end

  yum_repository "#{repo_name.downcase}-debuginfo" do
    baseurl new_resource.debug_baseurl
    mirrorlist new_resource.debug_mirrorlist
    description new_resource.debug_description
    enabled new_resource.debug_enabled
    gpgcheck new_resource.gpgcheck
    gpgkey new_resource.gpgkey
    new_resource.passthrough.each do |key, value|
      send(key.to_sym, value)
    end
  end
end
