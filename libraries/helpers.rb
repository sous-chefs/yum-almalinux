# frozen_string_literal: true

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

      def alma_powertools_repo_name
        node['platform_version'].to_i == 8 ? 'PowerTools' : 'CRB'
      end

      def create_alma_repo(repo_name)
        return unless platform_family?('rhel')

        # remove existing repo configs shipped by AlmaLinux
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
          new_resource.extra_options.each do |key, value|
            send(key.to_sym, value)
          end
        end

        return unless new_resource.debug_enabled

        yum_repository "#{repo_name.downcase}-debuginfo" do
          baseurl new_resource.debug_baseurl
          mirrorlist new_resource.debug_mirrorlist
          description new_resource.debug_description
          enabled new_resource.debug_enabled
          gpgcheck new_resource.gpgcheck
          gpgkey new_resource.gpgkey
          new_resource.extra_options.each do |key, value|
            send(key.to_sym, value)
          end
        end
      end

      def delete_alma_repo(repo_name)
        yum_repository repo_name.downcase do
          action :remove
        end

        yum_repository "#{repo_name.downcase}-debuginfo" do
          action :remove
        end
      end

      def alma_testing_baseurl(debug = false)
        path = debug ? 'testing/debug/$basearch/' : 'testing/$basearch/os/'
        "https://vault.almalinux.org/#{node['platform_version'].to_i}/#{path}"
      end

      def alma_testing_description(debug = false)
        suffix = debug ? ' debuginfo' : ''
        "AlmaLinux #{node['platform_version'].to_i} - Testing#{suffix}"
      end

      def create_alma_testing_repo
        return unless platform_family?('rhel')

        # remove existing repo configs shipped by AlmaLinux
        ::Dir['/etc/yum.repos.d/almalinux*'].each do |f|
          file f do
            action :delete
          end
        end

        # Resource name is intentionally 'testing' (not 'almalinux-testing'):
        # yum_repository derives the filename from the resource name, and the
        # broader cleanup glob above matches /etc/yum.repos.d/almalinux*.
        # Using 'almalinux-testing' would put the file in the glob's path and
        # break idempotency across converges.
        yum_repository 'testing' do
          baseurl new_resource.baseurl
          description new_resource.description
          enabled new_resource.enabled
          gpgcheck new_resource.gpgcheck
          gpgkey new_resource.gpgkey
          new_resource.extra_options.each do |key, value|
            send(key.to_sym, value)
          end
        end

        return unless new_resource.debug_enabled

        yum_repository 'testing-debuginfo' do
          baseurl new_resource.debug_baseurl
          description new_resource.debug_description
          enabled new_resource.debug_enabled
          gpgcheck new_resource.gpgcheck
          gpgkey new_resource.gpgkey
          new_resource.extra_options.each do |key, value|
            send(key.to_sym, value)
          end
        end
      end

      def delete_alma_testing_repo
        yum_repository 'testing' do
          action :remove
        end

        yum_repository 'testing-debuginfo' do
          action :remove
        end
      end
    end
  end
end
