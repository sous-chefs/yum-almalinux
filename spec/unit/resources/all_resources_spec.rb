# frozen_string_literal: true

require 'spec_helper'

describe 'All Resources' do
  ALL_RESOURCE_NAMES.each do |name|
    step_into :"yum_alma_#{name}"
  end
  step_into :yum_alma_testing

  %w(8 9 10).each do |v|
    context "almalinux-#{v} default-properties" do
      cached(:subject) { chef_run }
      platform 'almalinux', v

      recipe do
        ALL_RESOURCE_NAMES.each do |name|
          declare_resource(:"yum_alma_#{name}", 'default')
        end
      end

      ALL_REPOS_BY_ALMA_VERSION[v.to_i].each do |repo|
        it do
          expect(chef_run).to create_yum_repository(repo.downcase)
            .with(
              mirrorlist: "https://mirrors.almalinux.org/mirrorlist/#{v}/#{repo.downcase}/",
              baseurl: "https://repo.almalinux.org/almalinux/#{v}/#{repo}/$basearch/os/",
              enabled: true,
              gpgcheck: true,
              gpgkey: "https://repo.almalinux.org/almalinux/RPM-GPG-KEY-AlmaLinux-#{v}"
            )
        end
        it do
          expect(chef_run).to_not create_yum_repository("#{repo.downcase}-debuginfo")
            .with(
              mirrorlist: "https://mirrors.almalinux.org/mirrorlist/#{v}/#{repo.downcase}-debuginfo/",
              baseurl: "https://repo.almalinux.org/almalinux/#{v}/#{repo}/debug/$basearch/os/",
              enabled: false,
              gpgcheck: true,
              gpgkey: "https://repo.almalinux.org/almalinux/RPM-GPG-KEY-AlmaLinux-#{v}"
            )
        end
      end

      if v.to_i >= 10
        it do
          expect(chef_run).to_not create_yum_repository('resilientstorage')
        end
      end
    end

    context "almalinux-#{v} testing default-properties" do
      platform 'almalinux', v
      cached(:subject) { chef_run }

      recipe do
        yum_alma_testing 'default'
      end

      it do
        expect(chef_run).to create_yum_repository('testing')
          .with(
            baseurl: "https://vault.almalinux.org/#{v}/testing/$basearch/os/",
            description: "AlmaLinux #{v} - Testing",
            enabled: false,
            gpgcheck: true,
            gpgkey: "https://repo.almalinux.org/almalinux/RPM-GPG-KEY-AlmaLinux-#{v}"
          )
      end

      it do
        expect(chef_run).to_not create_yum_repository('testing-debuginfo')
      end
    end

    context "almalinux-#{v} testing changed-properties" do
      platform 'almalinux', v
      cached(:subject) { chef_run }

      recipe do
        yum_alma_testing 'default' do
          baseurl 'test-base-url/testing'
          description 'test description for testing'
          enabled true
          gpgkey 'a-fake-key'
          gpgcheck false
          debug_enabled true
          debug_baseurl 'debug-base-url/testing'
          debug_description 'debug description for testing'
          extra_options({ 'exclude' => 'excluded-package' })
        end
      end

      it do
        expect(chef_run).to create_yum_repository('testing')
          .with(
            baseurl: 'test-base-url/testing',
            description: 'test description for testing',
            enabled: true,
            gpgcheck: false,
            gpgkey: 'a-fake-key',
            exclude: 'excluded-package'
          )
      end

      it do
        expect(chef_run).to create_yum_repository('testing-debuginfo')
          .with(
            baseurl: 'debug-base-url/testing',
            description: 'debug description for testing',
            enabled: true,
            gpgcheck: false,
            gpgkey: 'a-fake-key',
            exclude: 'excluded-package'
          )
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

      ALL_REPOS_BY_ALMA_VERSION[v.to_i].each do |repo|
        # we aren't using the stylized name for any parts of these tests so downcase the repo name
        repo = repo.downcase
        repo_name = repo

        # highavailability => ha
        # crb => powertools
        if repo == 'highavailability'
          repo = 'ha'
        elsif repo == 'crb'
          repo = 'powertools'
        end

        it do
          expect(chef_run).to create_yum_repository(repo_name)
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
          expect(chef_run).to create_yum_repository("#{repo_name}-debuginfo")
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
