# yum-almalinux Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/yum-almalinux.svg)](https://supermarket.chef.io/cookbooks/yum-almalinux)
[![CI State](https://github.com/sous-chefs/yum-almalinux/workflows/ci/badge.svg)](https://github.com/sous-chefs/yum-almalinux/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit sous-chefs.org or come chat with us on the Chef Community Slack in #sous-chefs.

## Overview

The yum-almalinux cookbook takes over management of the default and optional repositoryids that ship with AlmaLinux systems.

Below is a table showing which repositoryids we can manage that are shipped by default with AlmaLinux:

| Repo ID         | Resource Name                                                           |
| --------------- | :---------------------------------------------------------------------: |
| appstream       |[yum\_alma\_appstream](documentation/yum_alma_appstream.md)              |
| baseos          |[yum\_alma\_base](documentation/yum_alma_baseos.md)                      |
| extras          |[yum\_alma\_extras](documentation/yum_alma_extras.md)                    |
| highavailability|[yum\_alma\_ha](documentation/yum_alma_ha.md)                            |
| nfv             |[yum\_alma\_nfv](documentation/yum_alma_nfv.md)                          |
| plus            |[yum\_alma\_plus](documentation/yum_alma_plus.md)                        |
| powertools/crb  |[yum\_alma\_powertools](documentation/yum_alma_powertools.md)            |
| realtime        |[yum\_alma\_rt](documentation/yum_alma_rt.md)                            |
| resilientstorage|[yum\_alma\_resilientstorage](documentation/yum_alma_resilientstorage.md)|
| rt              |[yum\_alma\_rt](documentation/yum_alma_rt.md)                            |
| saphana         |[yum\_alma\_saphana](documentation/yum_alma_saphana.md)                  |
| sap             |[yum\_alma\_sap](documentation/yum_alma_sap.md)                          |
| synergy         |[yum\_alma\_synergy](documentation/yum_alma_synergy.md)                  |

## Requirements

### Platforms

- AlmaLinux 8, 9

### Chef

- Chef 16.10+

### Cookbooks

- none

## Recipes

It is _highly recommended_ to use the resources directly instead of the recipe. The recipes are only included to ease
adoption and use, however if customization is needed, you _must_ use the custom resource.

- `yum-almalinux::default` - Generates `yum_repository` configs for latest AlmaLinux release using default settings. By
  default the `base`, `extras`, and `appstream` repos are enabled on AlmaLinux 8/9.

## Resources

[See resource table in overview](#overview)

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
