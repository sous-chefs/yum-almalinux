require 'spec_helper'

describe 'yum-almalinux::default' do
  step_into :yum_alma_baseos
  step_into :yum_alma_appstream
  step_into :yum_alma_extras

  %w(8).each do |v|
    context "almalinux-#{v}" do
      platform 'almalinux', v
      %w(contrib cr debuginfo fasttrack plus powertools).each do |repo|
        it do
          expect(chef_run).to_not create_yum_repository(repo)
        end
      end
      case v.to_i
      when 8
        it do
          expect(chef_run).to create_yum_repository('baseos')
            .with(mirrorlist: 'https://mirrors.almalinux.org/mirrorlist/8/baseos/')
        end
        it do
          expect(chef_run).to create_yum_repository('appstream')
            .with(mirrorlist: 'https://mirrors.almalinux.org/mirrorlist/8/appstream/')
        end
        it do
          expect(chef_run).to create_yum_repository('extras')
            .with(mirrorlist: 'https://mirrors.almalinux.org/mirrorlist/8/extras/')
        end
      when 9
        it do
          expect(chef_run).to create_yum_repository('base')
            .with(mirrorlist: 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=BaseOS')
        end
        it do
          expect(chef_run).to create_yum_repository('appstream')
            .with(mirrorlist: 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=AppStream')
        end
        it do
          expect(chef_run).to create_yum_repository('extras')
            .with(mirrorlist: 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras')
        end
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
