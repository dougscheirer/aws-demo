docker-repo:
  pkgrepo.managed:
    - humanname: Docker Repository
    - baseurl: https://yum.dockerproject.org/repo/main/centos/7/
    - gpgcheck: 1
    - gpgkey: https://yum.dockerproject.org/gpg

docker-engine:
  pkg:
    - installed

docker:
  service.running: []