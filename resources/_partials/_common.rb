unified_mode true

property :gpgkey, String, default: lazy { alma_gpg_key }
property :gpgcheck, [true, false], default: true
property :enabled, [true, false], default: true
property :debug_enabled, [true, false], default: false
