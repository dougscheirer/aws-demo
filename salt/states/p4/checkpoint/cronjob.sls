cronjob:
  file.managed:
    - name:   /etc/cron.daily/perforce-checkpoint
    - user:   root
    - group:  root
    - mode:   555
    - contents:
      - "#!/bin/bash"
