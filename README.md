# Openstack Config and scripts

## Custom Config

### Manila

- ceph.client.manila.keyring

### designate

- <https://bugs.launchpad.net/kolla-ansible/+bug/1855877>
- <https://docs.openstack.org/kolla-ansible/train/reference/networking/designate-guide.html>

- in designate-worker container remove id from /etc/designate/pools.yaml
- `designate-manage pool update`
- `designate-manage pool update --dry_run DRY_RUN` to get pool id
- replace designate_pool_id in passwords.yaml
- `reconfigure -t designate`
- `openstack zone create --email tentoe86@gmail.com local.kurz.site.`
