# Migration Guide

## Migrating to resource-only usage

This cookbook no longer provides root recipes. Replace `yum-almalinux::default` in run lists with
explicit repository resources in your own cookbook recipes.

Before:

```ruby
include_recipe 'yum-almalinux::default'
```

After:

```ruby
yum_alma_baseos 'default'
yum_alma_extras 'default'
yum_alma_appstream 'default'
```

The old default recipe created the BaseOS, Extras, and AppStream repositories with default settings.
The replacement resources expose those settings as properties so each repository can be customized
directly.

## Property-based configuration

Use resource properties instead of cookbook recipes or node attributes:

```ruby
yum_alma_baseos 'default' do
  enabled true
  gpgcheck true
  debug_enabled false
  extra_options(
    'priority' => '10'
  )
end
```

## Test cookbook examples

The cookbook's integration test cookbook shows the supported resource-only patterns:

* `test/cookbooks/test/recipes/default.rb` creates the default repositories.
* `test/cookbooks/test/recipes/all_repos.rb` declares each supported repository.
* `test/cookbooks/test/recipes/extra_options.rb` passes through additional
  `yum_repository` options.

## Breaking changes

* `recipes/default.rb` has been removed.
* The `yum-almalinux::default` run-list entry is no longer valid.
* Repository configuration is now managed through custom resources only.
* AlmaLinux 10 is included in the supported platform matrix. `yum_alma_resilientstorage` is a no-op
  on AlmaLinux 10 and newer because the standard AlmaLinux 10 repository tree does not publish
  `ResilientStorage`.
