# yum-almalinux CHANGELOG

This file is used to list changes made in each version of the yum-almalinux cookbook.

## [1.2.2](https://github.com/sous-chefs/yum-almalinux/compare/1.2.1...v1.2.2) (2025-10-16)


### Bug Fixes

* **ci:** Update workflows to use release pipeline ([#22](https://github.com/sous-chefs/yum-almalinux/issues/22)) ([26383e8](https://github.com/sous-chefs/yum-almalinux/commit/26383e8c41248beddf3ecc4caaa9a5ab3e1d6283))

## 1.2.0 - *2024-10-25*

* Add synergy repo
* Fix repo name setting in `yum_alma_powertools` by moving to a helper method
* Enable AlmaLinux 9 spec tests

## 1.1.4 - *2023-10-24*

* Standardise files with files in the repo-management

## 1.1.2 - *2023-09-04*

* Standardise files with files in the repo-management

## 1.1.1 - *2023-07-11*

* Standardise files with files in the repo-management

## 1.1.0 - *2023-05-26*

* Skip creating disabled debug repos if set to false
* Fix MDL
* Update actions

## 1.0.1 - *2023-05-26*

* Add renovate.json

## 1.0.0 - *2023-02-02*

Initial release. Adds resources for the following AlmaLinux repositories:

* BaseOS
* AppStream
* Extras
* HighAvailability
* NFV
* Plus
* PowerTools
* ResilientStorage
* RT
* SAP
* SAPHANA

Adds default recipe which adds default repos (BaseOS, AppStream, Extras)
