# yum-almalinux CHANGELOG

This file is used to list changes made in each version of the yum-almalinux cookbook.

## 1.2.1 - *2025-09-04*

## 1.2.0 - *2024-10-25*

- Add synergy repo
- Fix repo name setting in `yum_alma_powertools` by moving to a helper method
- Enable AlmaLinux 9 spec tests

## 1.1.7 - *2024-05-03*

## 1.1.6 - *2023-12-21*

## 1.1.5 - *2023-11-01*

## 1.1.4 - *2023-10-24*

- Standardise files with files in the repo-management

## 1.1.3 - *2023-09-29*

## 1.1.2 - *2023-09-04*

- Standardise files with files in the repo-management

## 1.1.1 - *2023-07-11*

- Standardise files with files in the repo-management

## 1.1.0 - *2023-05-26*

- Skip creating disabled debug repos if set to false
- Fix MDL
- Update actions

## 1.0.1 - *2023-05-26*

- Add renovate.json

## 1.0.0 - *2023-02-02*

Initial release. Adds resources for the following AlmaLinux repositories:

- BaseOS
- AppStream
- Extras
- HighAvailability
- NFV
- Plus
- PowerTools
- ResilientStorage
- RT
- SAP
- SAPHANA

Adds default recipe which adds default repos (BaseOS, AppStream, Extras)
