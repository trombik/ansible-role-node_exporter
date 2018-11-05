# Ansible role `node_exporter`


Configures `node_exporter`.

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `node_exporter_user` | User name of `node_exporter` | `{{ __node_exporter_user }}` |
| `node_exporter_group` | Group name of `node_exporter` | `{{ __node_exporter_group }}` |
| `node_exporter_service` | Service name of `node_exporter` | `{{ __node_exporter_service }}` |
| `node_exporter_package` | Package name of `node_exporter` | `{{ __node_exporter_package }}` |
| `node_exporter_flags` | Flags to pass `node_exporter` (FreeBSD only at the moment) | `""` |


## Debian

| Variable | Default |
|----------|---------|
| `__node_exporter_user` | `prometheus` |
| `__node_exporter_group` | `prometheus` |
| `__node_exporter_service` | `prometheus-node-exporter` |
| `__node_exporter_package` | `prometheus-node-exporter` |

## FreeBSD

| Variable | Default |
|----------|---------|
| `__node_exporter_user` | `nobody` |
| `__node_exporter_group` | `nobody` |
| `__node_exporter_service` | `node_exporter` |
| `__node_exporter_package` | `node_exporter` |

# Dependencies

None

# Example Playbook

```yaml
- hosts: localhost
  roles:
    - ansible-role-node_exporter
  vars:
    flags_map:
      FreeBSD: |
        node_exporter_args='--log.format="logger:stderr"'
    node_exporter_flags: "{{ flags_map[ansible_os_family] }}"
```

# License

```
Copyright (c) 2018 Tomoyuki Sakurai <y@trombik.org>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <y@trombik.org>

This README was created by [qansible](https://github.com/trombik/qansible)
