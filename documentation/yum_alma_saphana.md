[Back to resource list](../README.md#resources)

# `yum_alma_saphana`

Adds the `SAPHANA` repo to the YUM / DNF repo list.

## Actions

| Action    | Description                    |
| --------- | ------------------------------ |
| `:create` | Creates the repo configuration |

## Properties

These properties are passed directly through to `yum_repository`. More information on these properties can be found on [the Chef docs for `yum_repository`](https://docs.chef.io/resources/yum_repository/).

| Name                | Type            | Default                                                                                    |
| ------------------- | --------------- | ------------------------------------------------------------------------------------------ |
| `baseurl`           | `String`        | `https://repo.almalinux.org/...`, see [`alma_repo_baseurl`](../libraries/helpers.rb)       |
| `mirrorlist`        | `String`        | `https://mirrors.almalinux.org/...`, see [`alma_repo_mirrorlist`](../libraries/helpers.rb) |
| `description`       | `String`        | See [`alma_repo_description`](../libraries/helpers.rb)                                     |
| `enabled`           | `true`, `false` | `true`                                                                                     |
| `debug_baseurl`     | `String`        | `https://repo.almalinux.org/...`, see [`alma_repo_baseurl`](../libraries/helpers.rb)       |
| `debug_description` | `String`        | See [`alma_repo_description`](../libraries/helpers.rb)                                     |
| `debug_enabled`     | `true`, `false` | `false`                                                                                    |
| `gpgkey`            | `String`        | `https://repo.almalinux.org/...`, see [`alma_gpg_key`](../libraries/helpers.rb)            |
| `gpgcheck`          | `true`, `false` | `true`                                                                                     |

The `passthrough` property allows setting additional settings on the internal `yum_repository` resources.

| Name          | Type | Default |
| ------------- | ---- | ------- |
| `passthrough` | Hash | {}      |

## Examples

```ruby
yum_alma_saphana 'default'
```

Setting passthrough properties:

```ruby
yum_alma_saphana 'default' do
  # don't install 'some-package' from this repo
  passthrough ({ 'exclude' => 'some-package' })
end
```
