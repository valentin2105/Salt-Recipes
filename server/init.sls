## System
en_US.UTF-8:
  file.uncomment:
    - name: /etc/locale.gen
    - regex: en_US.UTF-8 UTF-8
    - char: '# '
    - require:
      - pkg: locales
    - watch_in:
      - cmd: locales
  locale:
    - system

{% if grains['os'] == 'Debian' %}
Pacific/Noumea:
  timezone.system
{% endif %}

/etc/sudoers:
 file.managed:
    - source: salt://server/sudoers
    - user: root
    - group: root
    - mode: 440

/root/.bashrc:
  file.managed:
    - source: salt://server/bashrc
    - user: root
    - group: root
    - mode: 644

## SSH 
sshusers:
  group.present:
    - gid: 1500
    - system: True

/etc/ssh/sshd_config:
 file.managed:
    - source: salt://server/sshd_config
    - user: root
    - group: root
    - mode: 644

ssh:
  service:
    - running
    - enable: True
    - watch:
      - file: /etc/ssh/sshd_config

## Salt Minion
salt_minion:
  pkg.installed:
    - name: salt-minion
  service.running:
    - name: salt-minion
    - require:
      - pkg: salt-minion

## VIM
/etc/vim/vimrc:
  file.managed:
    - source: salt://server/vim/vimrc
    - user: root
    - group: root
    - mode: 644 

/etc/vim/colors:
  file.recurse:
    - source: salt://server/vim/colors
    - include_empty: True

/etc/vim/colors/vitamins.vim:
  file.managed:
    - source: salt://server/vim/colors/vitamins.vim
    - user: root
    - group: root
    - mode: 644 

/etc/vim/ftdetect:
    file.recurse:
      - source: salt://server/vim/ftdetect
      - user: root
      - group: root
      - file_mode: '0755'
      - makedirs: true

/etc/vim/ftplugin:
    file.recurse:
      - source: salt://server/vim/ftplugin
      - user: root
      - group: root
      - file_mode: '0755'
      - makedirs: true

/etc/vim/syntax:
    file.recurse:
      - source: salt://server/vim/syntax
      - user: root
      - group: root
      - file_mode: '0755'
      - makedirs: true

## Root Pubkey
<your-pub-key>:  
  ssh_auth.present:
    - user: root
    - enc: ssh-dss
