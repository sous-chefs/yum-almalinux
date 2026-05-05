# Limitations

## Package Availability

### DNF/YUM (AlmaLinux)

This cookbook manages AlmaLinux DNF/YUM repository files only. It does not install packages, build
software from source, or configure APT/Zypper repositories.

AlmaLinux currently supports these major releases:

* AlmaLinux 8: supported until May 2029
* AlmaLinux 9: supported until May 2032
* AlmaLinux 10: supported until May 2035

The cookbook test matrix covers AlmaLinux 8, 9, and 10 with Dokken images.

## Architecture Limitations

AlmaLinux 8 and 9 repository content is published for `x86_64`, `aarch64`, `ppc64le`, and `s390x`.
AlmaLinux 10 repository content is published for `x86_64`, `x86_64_v2`, `aarch64`, `ppc64le`, and
`s390x`. AlmaLinux 10 does not provide 32-bit `i686` packages.

## Repository Management

* All resources remove existing `/etc/yum.repos.d/almalinux*` repo files before creating new ones to
  avoid conflicts with AlmaLinux-shipped repo configurations.
* Debug repositories, such as `baseos-debuginfo`, are not enabled by default. Set
  `debug_enabled true` on a resource to enable its debug repository.
* AlmaLinux 10 does not publish a `ResilientStorage` repository in the standard release repository
  tree. `yum_alma_resilientstorage` is a no-op on AlmaLinux 10 and newer.

## PowerTools / CRB

The `yum_alma_powertools` resource manages different repository names depending on the AlmaLinux
major version:

* AlmaLinux 8: `powertools`
* AlmaLinux 9 and 10: `crb`

This is handled automatically by the `alma_powertools_repo_name` helper.

## Source/Compiled Installation

Not applicable. The cookbook only manages AlmaLinux repository definitions.

## Sources

* [AlmaLinux FAQ](https://wiki.almalinux.org/FAQ)
* [AlmaLinux 10.1 Release Notes](https://wiki.almalinux.org/release-notes/10.1.html)
* [AlmaLinux 10 repository mirror listing](https://mirror.hnd.cl/almalinux/10/)
* [Dokken images](https://hub.docker.com/u/dokken)
