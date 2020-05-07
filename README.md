# Openstack Config and scripts

## Custom Config

### Manila

- ceph.client.manila.keyring

### designate

<https://bugs.launchpad.net/kolla-ansible/+bug/1855877>

- in designate-worker container remove id from /etc/designate/pools.yaml
- `designate-manage pool upgrade --dry_run DRY_RUN` to get pool id
- replace designate_pool_id in passwords.yaml
- `reconfigure -t designate`
