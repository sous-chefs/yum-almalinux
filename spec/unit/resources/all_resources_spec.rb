require 'spec_helper'

describe 'All Resources' do
  ALL_RESOURCE_NAMES.each do |name|
    step_into :"yum_alma_#{name}"
  end

  # TODO: AlmaLinux 9 isn't in fauxhai-ng yet, add tests for 9 once it is added
  %w(8).each do |v|
    context "almalinux-#{v} default-properties" do
      platform 'almalinux', v
      cached(:subject) { chef_run }

      recipe do
        ALL_RESOURCE_NAMES.each do |name|
          declare_resource(:"yum_alma_#{name}", 'default')
        end
      end

      case v.to_i
      when 8
        ALL_ALMA_8_REPOS.each do |repo|
          it do
            expect(chef_run).to create_yum_repository(repo.downcase)
              .with(
                mirrorlist: "https://mirrors.almalinux.org/mirrorlist/8/#{repo.downcase}/",
                baseurl: "https://repo.almalinux.org/almalinux/8/#{repo}/$basearch/os/",
                enabled: true,
                gpgcheck: true,
                gpgkey: 'https://repo.almalinux.org/almalinux/RPM-GPG-KEY-AlmaLinux-8'
              )
          end
          it do
            expect(chef_run).to create_yum_repository("#{repo.downcase}-debuginfo")
              .with(
                mirrorlist: "https://mirrors.almalinux.org/mirrorlist/8/#{repo.downcase}-debuginfo/",
                baseurl: "https://repo.almalinux.org/almalinux/8/#{repo}/debug/$basearch/os/",
                enabled: false,
                gpgcheck: true,
                gpgkey: 'https://repo.almalinux.org/almalinux/RPM-GPG-KEY-AlmaLinux-8'
              )
          end
        end
      end
    end

    context "almalinux-#{v} changed-properties" do
      platform 'almalinux', v
      cached(:subject) { chef_run }

      recipe do
        ALL_RESOURCE_NAMES.each do |name|
          declare_resource(:"yum_alma_#{name}", 'default') do
            baseurl "test-base-url/#{name}"
            mirrorlist "test-mirror-list/#{name}"
            description "test description for #{name}"
            enabled false
            gpgkey 'a-fake-key'
            gpgcheck false
            debug_enabled true
            debug_baseurl "debug-base-url/#{name}"
            debug_mirrorlist "debug-mirror-list/#{name}"
            debug_description "debug description for #{name}"
            extra_options({ 'exclude' => 'excluded-package' })
          end
        end
      end

      case v.to_i
      when 8
        ALL_ALMA_8_REPOS.each do |repo|
          # we aren't using the stylized name for any parts of these tests so downcase the repo name
          repo = repo.downcase
          repoName = repo

          # highavailbility => ha
          # only repo where the resource and repo names differ, so switch for ease of testing
          if repo == 'highavailability'
            repo = 'ha'
          end

          it do
            expect(chef_run).to create_yum_repository(repoName)
              .with(
                mirrorlist: "test-mirror-list/#{repo}",
                baseurl: "test-base-url/#{repo}",
                description: "test description for #{repo}",
                enabled: false,
                gpgcheck: false,
                gpgkey: 'a-fake-key',
                exclude: 'excluded-package'
              )
          end
          it do
            expect(chef_run).to create_yum_repository("#{repoName}-debuginfo")
              .with(
                mirrorlist: "debug-mirror-list/#{repo}",
                baseurl: "debug-base-url/#{repo}",
                description: "debug description for #{repo}",
                enabled: true,
                gpgcheck: false,
                gpgkey: 'a-fake-key',
                exclude: 'excluded-package'
              )
          end
        end
      end
    end
  end
end
