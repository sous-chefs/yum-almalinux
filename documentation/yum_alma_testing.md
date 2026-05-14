# `yum_alma_testing`

[Back to resource list](../README.md#resources)

Adds the `almalinux-testing` repo to the YUM / DNF repo list.

This repo is hosted on the AlmaLinux vault (`vault.almalinux.org`) and is **disabled by default**.

## When to use it

The testing repo holds package builds that have not yet been promoted to the primary AlmaLinux
repositories. Two common reasons to pull from it:

* **Apply a fix before it reaches the primary repo.** When AlmaLinux ships a security fix or
  bug fix to testing first (commonly announced via the AlmaLinux blog or release notes), declare
  this resource to make the repo available, then enable it per-command:

  ```sh
  sudo dnf update '<package-glob>' --enablerepo=testing
  ```

* **Help AlmaLinux validate testing builds.** Installing testing packages on representative
  hosts and reporting results back to the AlmaLinux community (via the [AlmaLinux chat](https://chat.almalinux.org/),
  [bug tracker](https://bugs.almalinux.org/), or
  [GitHub](https://github.com/AlmaLinux/)) improves the quality of the next stable release.
  Keeping the repo configured but disabled lets you opt machines into a test run without
  reconfiguring repositories each time.

## Repo ID note

The cookbook writes the repo section as `[testing]` in `/etc/yum.repos.d/testing.repo`, so the
ID passed to `--enablerepo` is `testing`. This differs from the upstream `almalinux-release-testing`
RPM, which uses `[almalinux-testing]`. The baseurl and package set are the same.

## Actions

| Action    | Description                    |
| --------- | ------------------------------ |
| `:create` | Creates the repo configuration |
| `:delete` | Removes the repo configuration |

## Properties

These properties are passed directly through to `yum_repository`. More information on these properties can be found on [the Chef docs for `yum_repository`](https://docs.chef.io/resources/yum_repository/).

| Name                | Type            | Default                                                                                  |
| ------------------- | --------------- | ---------------------------------------------------------------------------------------- |
| `baseurl`           | `String`        | `https://vault.almalinux.org/...`, see [`alma_testing_baseurl`](../libraries/helpers.rb) |
| `description`       | `String`        | See [`alma_testing_description`](../libraries/helpers.rb)                                |
| `enabled`           | `true`, `false` | `false`                                                                                  |
| `debug_baseurl`     | `String`        | `https://vault.almalinux.org/...`, see [`alma_testing_baseurl`](../libraries/helpers.rb) |
| `debug_description` | `String`        | See [`alma_testing_description`](../libraries/helpers.rb)                                |
| `debug_enabled`     | `true`, `false` | `false`                                                                                  |
| `gpgkey`            | `String`        | `https://repo.almalinux.org/...`, see [`alma_gpg_key`](../libraries/helpers.rb)          |
| `gpgcheck`          | `true`, `false` | `true`                                                                                   |

Unlike the per-channel resources, `yum_alma_testing` does not expose a `mirrorlist` property because
the upstream testing repo is served only from `vault.almalinux.org`.

The `extra_options` property allows setting additional settings on the internal [`yum_repository`](https://docs.chef.io/resources/yum_repository/) resources.

| Name            | Type | Default |
| --------------- | ---- | ------- |
| `extra_options` | Hash | {}      |

## Examples

Make the testing repo available but disabled, so it can be opted into per-command:

```ruby
yum_alma_testing 'default'
```

Permanently enable the testing repo:

```ruby
yum_alma_testing 'default' do
  enabled true
end
```

Remove the repo configuration entirely:

```ruby
yum_alma_testing 'default' do
  action :delete
end
```
