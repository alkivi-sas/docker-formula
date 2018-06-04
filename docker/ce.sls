docker-requirements:
  pkg.installed:
    - pkgs: 
      - apt-transport-https
      - ca-certificates
      - curl
      - gnupg2
      - software-properties-common

docker-ce-repo:
  pkgrepo.managed:
    - humanname: Docker CE
    - name: deb [arch={{ salt['grains.get']('osarch')}}] https://download.docker.com/linux/debian {{ salt['grains.get']('oscodename') }} stable
    - file: /etc/apt/sources.list.d/docker.list
    - gpgcheck: 1
    - key_url: https://download.docker.com/linux/debian/gpg
    - require:
      - pkg: docker-requirements

docker-ce:
  pkg.installed

docker-service:
  service.running:
    - name: docker
    - enable: True
    - watch:
      - pkg: docker-ce
