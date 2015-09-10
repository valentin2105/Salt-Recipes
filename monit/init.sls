# Monit service and config files
/etc/monit/monitrc:
  file.managed:
    - source: salt://monit/conf/monitrc

/etc/monit/conf.d/fs:
  file.managed:
    {% if grains['virtual'] == 'xen' %}
    - source: salt://monit/conf/conf.d/fs-dom0
    {% else %}
    - source: salt://monit/conf/conf.d/fs
    {% endif %}


/etc/monit/conf.d/salt-minion:
  file.managed:
    - source: salt://monit/conf/conf.d/salt-minion

/etc/monit/conf.d/system:
  file.managed:
    - source: salt://monit/conf/conf.d/system

/etc/monit/conf.d/ssh:
  file.managed:
    - source: salt://monit/conf/conf.d/ssh

/etc/monit/conf.d/disk:
  file.managed:
    - source: salt://monit/conf/conf.d/disk

monit:
  pkg:
    - installed
  service.running:
    - require:
      - pkg: monit
      - file: /etc/monit/monitrc
      - file: /etc/monit/conf.d/fs      
      - file: /etc/monit/conf.d/salt-minion
      - file: /etc/monit/conf.d/system
      - file: /etc/monit/conf.d/ssh
      - file: /etc/monit/conf.d/disk
    - watch:
      - file: /etc/monit/monitrc
      - file: /etc/monit/conf.d/fs      
      - file: /etc/monit/conf.d/salt-minion
      - file: /etc/monit/conf.d/system
      - file: /etc/monit/conf.d/ssh
      - file: /etc/monit/conf.d/disk


