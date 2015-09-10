admins:
  manage:
    - name: unixname
      fullname: "Firstname LASTNAME" 
      uid: 1001
      gid: 1001
      shell: /bin/bash
      groups:
        - sudo
        - sshusers
      password: <usr-password>
      sshpubkeys:
        - key: <your-ssh-pubkey>
