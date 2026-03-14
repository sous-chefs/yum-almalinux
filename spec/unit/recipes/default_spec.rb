# frozen_string_literal: true

require 'spec_helper'

describe 'yum-almalinux::default' do
  step_into :yum_alma_baseos
  step_into :yum_alma_appstream
  step_into :yum_alma_extras

  %w(8 9).each do |v|
    context "almalinux-#{v}" do
      platform 'almalinux', v
      %w(contrib cr debuginfo fasttrack plus powertools).each do |repo|
        it do
          expect(chef_run).to_not create_yum_repository(repo)
        end
      end
      it do
        expect(chef_run).to create_yum_repository('baseos')
          .with(mirrorlist: "https://mirrors.almalinux.org/mirrorlist/#{v}/baseos/")
      end
      it do
        expect(chef_run).to create_yum_repository('appstream')
          .with(mirrorlist: "https://mirrors.almalinux.org/mirrorlist/#{v}/appstream/")
      end
      it do
        expect(chef_run).to create_yum_repository('extras')
          .with(mirrorlist: "https://mirrors.almalinux.org/mirrorlist/#{v}/extras/")
      end
    end
  end
  # Make sure we don't break non-RHEL systems which simply include this cookbook
  context 'ubuntu' do
    platform 'ubuntu'
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    it do
      expect(chef_run).to_not create_yum_repository('baseos')
    end
    it do
      expect(chef_run).to_not create_yum_repository('appstream')
    end
    it do
      expect(chef_run).to_not create_yum_repository('extras')
    end
  end
end
