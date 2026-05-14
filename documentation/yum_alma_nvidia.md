# `yum_alma_nvidia`

[Back to resource list](../README.md#resources)

Adds the AlmaLinux NVIDIA CUDA & driver repo to the YUM / DNF repo list.

## Availability

This resource is supported on AlmaLinux 9 and 10. On AlmaLinux 8 the resource is a no-op because
the `almalinux-release-nvidia-driver` package — the only source of the NVIDIA-CUDA GPG key —
does not exist for AlmaLinux 8.

## GPG keys

CUDA packages are signed with NVIDIA's GPG key, which is not served over HTTPS — it ships only on
disk via the `almalinux-release-nvidia-driver` package at
`/etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA-CUDA-$releasever`. The resource installs that package as
part of its `:create` action so the keys are available before any CUDA install attempts. The
upstream `.repo` file the package drops at `/etc/yum.repos.d/almalinux-nvidia.repo` is replaced
by the Chef-managed `/etc/yum.repos.d/nvidia.repo`.

## Repo ID note

The cookbook writes the section as `[nvidia]` rather than `[almalinux-nvidia]` (the id used by
the upstream release RPM), so `--enablerepo` / `--disablerepo` commands need `nvidia`:

```sh
sudo dnf install --enablerepo=nvidia cuda-toolkit
```

## Actions

| Action    | Description                                                                   |
| --------- | ----------------------------------------------------------------------------- |
| `:create` | Installs `almalinux-release-nvidia-driver` and creates the repo configuration |
| `:delete` | Removes the repo configuration (does not uninstall the release package)       |

## Properties

These properties are passed directly through to `yum_repository`. More information on these properties can be found on [the Chef docs for `yum_repository`](https://docs.chef.io/resources/yum_repository/).

| Name                | Type            | Default                                                                                                  |
| ------------------- | --------------- | ------------------------------------------------------------------------------------------------------   |
| `baseurl`           | `String`        | `https://nvidia.repo.almalinux.org/cuda/...`, see [`alma_nvidia_baseurl`](../libraries/helpers.rb)       |
| `description`       | `String`        | See [`alma_nvidia_description`](../libraries/helpers.rb)                                                 |
| `enabled`           | `true`, `false` | `true`                                                                                                   |
| `debug_baseurl`     | `String`        | `https://vault.almalinux.org/almalinux-nvidia/...`, see [`alma_nvidia_baseurl`](../libraries/helpers.rb) |
| `debug_description` | `String`        | See [`alma_nvidia_description`](../libraries/helpers.rb)                                                 |
| `debug_enabled`     | `true`, `false` | `false`                                                                                                  |
| `gpgkey`            | `Array`         | Two `file:///` paths (AlmaLinux + NVIDIA-CUDA), see [`alma_nvidia_gpgkeys`](../libraries/helpers.rb)     |
| `gpgcheck`          | `true`, `false` | `true`                                                                                                   |

Unlike the per-channel resources, `yum_alma_nvidia` does not expose a `mirrorlist` property
because the upstream repo has no mirrorlist.

The `extra_options` property allows setting additional settings on the internal [`yum_repository`](https://docs.chef.io/resources/yum_repository/) resources.

| Name            | Type | Default |
| --------------- | ---- | ------- |
| `extra_options` | Hash | {}      |

## Examples

Enable the NVIDIA CUDA & driver repo (and install the release package that ships the GPG key):

```ruby
yum_alma_nvidia 'default'
```

Configure the repo but leave it disabled (opt in per-command with `--enablerepo=nvidia`):

```ruby
yum_alma_nvidia 'default' do
  enabled false
end
```

Remove the repo configuration entirely (does not uninstall `almalinux-release-nvidia-driver`):

```ruby
yum_alma_nvidia 'default' do
  action :delete
end
```
