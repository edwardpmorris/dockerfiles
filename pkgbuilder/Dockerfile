FROM base/archlinux

VOLUME /src

WORKDIR /src

RUN echo "[multilib]" >> /etc/pacman.conf && \
  echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf && \
  curl -o /etc/pacman.d/mirrorlist "https://www.archlinux.org/mirrorlist/?country=all&protocol=https&ip_version=6&use_mirror_status=on" && \
  sed -i 's/^#//' /etc/pacman.d/mirrorlist

RUN pacman-key --populate && \
  pacman-key --refresh-keys && \
  pacman -Sy --noprogressbar --noconfirm && \
  pacman -S --force openssl --noprogressbar --noconfirm && \
  pacman -S pacman --noprogressbar --noconfirm && \
  pacman-db-upgrade && \
  pacman -S --noprogressbar --noconfirm archlinux-keyring && \
  yes | pacman -S --noprogressbar gcc-libs-multilib && \
  pacman -Su --noprogressbar --noconfirm && \
  pacman -S --noprogressbar --noconfirm sudo fakeroot binutils namcap git && \
  rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/*

RUN useradd -ms /bin/bash maker && chown -R maker:users /src && \
  sed -e '/nice/ s/^#*/#/' -i /etc/security/limits.conf && \
  echo "maker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY ["pkg.sh", "/usr/local/sbin/"]

ENTRYPOINT ["/usr/local/sbin/pkg.sh"]

CMD ["--help"]
