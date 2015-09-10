#!jinja|yaml

{% set install = [ 'snmpd', 'xinetd', 'ntp', 'wget', 'curl', 'git', 'locales', 'sudo', 'python-pip', 'man-db', 'etckeeper', 'screen', 'dbus', 'iptables', 'htop', 'ccze' ] %}

{% for pkg in install %}
{{ pkg }}:
  pkg:
    - latest
{% endfor %}