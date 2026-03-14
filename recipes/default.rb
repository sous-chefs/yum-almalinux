# frozen_string_literal: true

#
# Author:: Ethan Hampton (<hamptone@osuosl.org>)
# Cookbook:: yum-almalinux
# Recipe:: default
#
# Copyright:: 2023, Oregon State University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

Chef.deprecated(:generic, 'The yum-almalinux::default recipe is deprecated and will be removed in a future major version. Use the yum_alma_baseos, yum_alma_extras, and yum_alma_appstream resources directly.')

yum_alma_baseos 'default'
yum_alma_extras 'default'
yum_alma_appstream 'default'
