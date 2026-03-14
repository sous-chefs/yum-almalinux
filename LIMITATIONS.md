# Limitations

## Platform Support

This cookbook manages AlmaLinux YUM repositories and is **only supported on AlmaLinux 8 and 9**.

On non-RHEL platform families (e.g. Debian, Ubuntu), all resources in this cookbook are no-ops — the
`:create` action returns early via `return unless platform_family?('rhel')`. This means it is safe to
include this cookbook in a run list that targets multiple platform families, but no repositories will
be configured on non-RHEL nodes.

## Repository Management

- All resources remove existing `/etc/yum.repos.d/almalinux*` repo files before creating new ones to
  avoid conflicts with AlmaLinux-shipped repo configurations.
- Debug repositories (e.g. `baseos-debuginfo`) are **not** enabled by default. Set `debug_enabled true`
  on the resource to enable them.
- The `synergy` repository is not present on AlmaLinux 9. Attempting to use `yum_alma_synergy` on
  AlmaLinux 9 may fail if the repository is not available upstream.

## PowerTools / CRB

The `yum_alma_powertools` resource manages different repository names depending on the AlmaLinux version:

- **AlmaLinux 8**: `powertools`
- **AlmaLinux 9**: `crb`

This is handled automatically by the `alma_powertools_repo_name` helper.
