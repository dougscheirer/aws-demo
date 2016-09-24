format_depots:
  module.run:
    - name: xfs
    - device: /dev/sdb

format_metdata:
  module.run:
    - name: xfs
    - device: /dev/sdc

/p4/depots:
  mount.mounted:
    - device: /dev/sdb
    - fstype: xfs
    - mkmnt: True
    - opts:
      - defaults

/p4/metadata:
  mount.mounted:
    - device: /dev/sdc
    - fstype: xfs
    - mkmnt: True
    - opts:
      - defaults