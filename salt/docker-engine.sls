/etc/yum.repos.d/docker.repo:
  file.managed:
    - source: salt://files/docker.repo

docker-engine:
  pkg:
    - installed

docker:
  service.running: []