FROM scratch

MAINTAINER Conor I. Anderson <conor.anderson@mail.utoronto.ca>

ADD manjarolinux.tar.xz /

VOLUME /src

WORKDIR /src

RUN mkdir -p /root/.gnupg && \
  touch /root/.gnupg/dirmngr_ldapservers.conf && \
  dirmngr < /dev/null && \
  pacman-key --populate archlinux manjaro && \
  pacman-key --refresh-keys && \
  pacman-mirrors -g && \
  pacman -Syy --noprogressbar --noconfirm && \
  pacman -S --noprogressbar --noconfirm archlinux-keyring manjaro-keyring && \
  pacman -Su --noprogressbar --noconfirm && \
  pacman -S --noprogressbar --noconfirm sudo fakeroot binutils namcap git make gcc expect && \
  rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/*

RUN useradd -ms /bin/bash maker && chown -R maker:users /src && \
  sed -e '/nice/ s/^#*/#/' -i /etc/security/limits.conf && \
  echo "maker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN pacman -Syy --noprogressbar --noconfirm && \
  git clone https://aur.archlinux.org/cower-git.git && \
  cd cower-git && chown -R maker:users . && \
  sudo -u maker makepkg -scf --noconfirm --install && \
  cd .. && rm -rf ./cower-git && \
  git clone https://aur.archlinux.org/pacaur.git && \
  cd pacaur && chown -R maker:users . && \
  sudo -u maker makepkg -scf --noconfirm --install && \
  cd .. && rm -rf ./pacaur && \
  rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/*

COPY ["pkg.sh", "/usr/local/sbin/"]

ENTRYPOINT ["/usr/local/sbin/pkg.sh"]

CMD ["bash"]
