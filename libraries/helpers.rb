module YumAlmaChef
  module Cookbook
    module Helpers
      def alma_gpg_key
        "https://repo.almalinux.org/almalinux/RPM-GPG-KEY-AlmaLinux-#{node['platform_version'].to_i}"
      end

      def alma_repo_baseurl(repo_slug, debug = false)
        repo_slug = debug ? "#{repo_slug}/debug" : repo_slug
        "https://repo.almalinux.org/almalinux/#{node['platform_version'].to_i}/#{repo_slug}/$basearch/os/"
      end

      def alma_repo_mirrorlist(repo_slug, debug = false)
        repo_slug = debug ? "#{repo_slug}-debuginfo" : repo_slug
        "https://mirrors.almalinux.org/mirrorlist/#{node['platform_version'].to_i}/#{repo_slug.downcase}/"
      end

      def alma_repo_description(repo_slug, debug = false)
        repo_slug = debug ? "#{repo_slug}-debuginfo" : repo_slug
        "AlmaLinux #{node['platform_version'].to_i} - #{repo_slug}"
      end
    end
  end
end

Chef::Resource.include ::YumAlmaChef::Cookbook::Helpers
