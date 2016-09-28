/dev/sdb:
  lvm.pv_present

metadata_vg:
  lvm.vg_present:
{% if grains['os'] == 'Amazon' %}
    - devices: /dev/xvdm
{% else %}
    - devices: /dev/sdb
{% endif %}

metadata_lv:
  lvm.lv_present:
    - vgname: metadata_vg
    - extents: 100%FREE

metadata_volume:
  blockdev.formatted:
    - name: /dev/metadata_vg/metadata_lv
    - fs_type: xfs

/dev/sdc:
  lvm.pv_present

p4data_vg:
  lvm.vg_present:
{% if grains['os'] == 'Amazon' %}
    - devices: /dev/xvdp
{% else %}
    - devices: /dev/sdc
{% endif %}

p4data_lv:
  lvm.lv_present:
    - vgname: p4data_vg
    - extents: 100%FREE

p4data_volume:
  blockdev.formatted:
    - name: /dev/p4data_vg/p4data_lv
    - fs_type: xfs
