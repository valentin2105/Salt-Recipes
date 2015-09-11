/etc/snmp/snmpd.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://observium/snmpd.conf

/etc/xinetd.d/observium_agent_xinetd:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://observium/observium_agent_xinetd

/usr/local/bin/distro:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://observium/distro

/usr/local/bin/observium_agent:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://observium/observium_agent

/usr/lib/observium_agent/local/dpkg:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://observium/dpkg
    - makedirs: True


/usr/lib/observium_agent/local/dmi:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://observium/dmi
    - makedirs: True

/usr/lib/observium_agent/local/unbound:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://observium/unbound
    - makedirs: True
