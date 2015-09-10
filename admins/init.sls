#!jinja|yaml

{% from 'admins/defaults.yaml' import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('admins:lookup')) %}

include: {{ datamap.sls_include|default([]) }}
extend: {{ datamap.sls_extend|default({}) }}

{%- macro set_p(paramname, dictvar) -%}
  {%- if paramname in dictvar -%}
- {{ paramname }}: {{ dictvar[paramname] }}
  {%- endif -%}
{%- endmacro -%}


{% set admins = salt['pillar.get']('admins:manage', []) %}

{% for u in admins %}
group_{{ u.name }}:
  group.present:
    - name: {{ u.name }}
    - gid: {{ u.gid }}
    - system: False


user_{{ u.name }}:
  user:
    - present
    - name: {{ u.name }}
{{ set_p('fullname', u)|indent(4, True) }}
{{ set_p('uid', u)|indent(4, True) }}
{{ set_p('gid', u)|indent(4, True) }}
{{ set_p('groups', u)|indent(4, True) }}
{{ set_p('optional_groups', u)|indent(4, True) }}
{{ set_p('home', u)|indent(4, True) }}
{{ set_p('shell', u)|indent(4, True) }}
{{ set_p('createhome', u)|indent(4, True) }}
{{ set_p('password', u)|indent(4, True) }}
{{ set_p('system', u)|indent(4, True) }}
#    - require:
#      - group: {{ u.name }}
#  group:
#    - present
#    - name: {{ u.name }}
#{{ set_p('gid', u)|indent(4, True) }}
#{{ set_p('system', u)|indent(4, True) }}


user_{{ u.name }}_sshdir:
  file:
    - directory
    - name: {{ salt['user.info'](u.name).home|default('/home/' ~ u.name) }}/.ssh
    - mode: 700
    - user: {{ u.name }}
    - group: {{ u.name }}
    - require:
      - user: user_{{ u.name }}


  {% for k in u.sshpubkeys|default([]) %}
user_{{ u.name }}_ssh_auth_{{ k.key[-20:] }}:
  ssh_auth:
    - {{ k.ensure|default('present') }}
    - name: {{ k.key }}
    - user: {{ u.name }}
    - enc: {{ k.enc|default('ssh-rsa') }}
{{ set_p('comment', k)|indent(4, True) }}
{{ set_p('options', k)|indent(4, True) }}
  {% endfor %}
{% endfor %}
