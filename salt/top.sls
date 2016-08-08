base:
  '*':
    - docker-engine

  'p4d-host':
    - zfs

  'app-host':
    - docker-swarm
    - docker-hws
    - docker-admin

  'master':
    - docker-haproxy
    - docker-p4broker
    