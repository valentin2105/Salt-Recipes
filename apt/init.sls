/etc/apt/sources.list:
  file.managed:
    {% if grains['os'] == 'Debian' %}
    - source: salt://apt/list/debian.list
    {% elif grains['os'] == 'Ubuntu' %}
    - source: salt://apt/list/ubuntu.list
    {% endif %}

/etc/apt/sources.list.d/salt.list:
  file.managed:
    {% if grains['os'] == 'Debian' %}
    - source: salt://apt/list/salt-debian.list
    {% elif grains['os'] == 'Ubuntu' %}
    - source: salt://apt/list/salt-ubuntu.list
    {% endif %}
