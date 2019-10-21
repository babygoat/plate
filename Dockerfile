FROM node:10.15-slim

ARG app_user=keystone_user
ARG app_group=keystone_user

RUN groupadd ${app_group} && useradd --create-home --home-dir /home/${app_user} -g ${app_user} ${app_group}

ENV TZ=Asia/Taipei

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates graphicsmagick imagemagick \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/${app_user}/src
RUN chown ${app_user}:${app_group} /home/${app_user}/src

WORKDIR /home/${app_user}/src

# Copy source files
COPY . .

# Set time zone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#USER ${app_user}

EXPOSE 3000
CMD node keystone.js
