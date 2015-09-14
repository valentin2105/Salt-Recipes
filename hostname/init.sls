/etc/hostname:
  file.managed:
    - source: salt://hostname/hostname
    - template: jinja
    - user: root
    - group: root
    - mode: 755
