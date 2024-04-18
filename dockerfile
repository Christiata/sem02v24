FROM ubuntu:24.04
RUN apt-get update \
&& apt-get dist-upgrade -y \
&& apt-get autoremove -y \
&& apt-get autoclean -y \
&& apt-get install -y \
sudo \
nano \
wget \
curl \
git
RUN useradd -G sudo -m -d /home/Chris -s /bin/bash -p "$(openssl passwd -1 exit)" Chris
USER Chris
WORKDIR /home/Chris
RUN mkdir hacking \
&& cd hacking \
&& curl -SL https://raw.githubusercontent.com/uia-worker/is105misc/master/sem01v24/pawned.sh > pawned.sh \
&& chmod 764 pawned.sh \
&& cd ..
RUN git config --global user.email "Christiata@uia.no" \
&& git config --global user.name "Christiata" \
&& git config --global url."https://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:@github.com/".insteadOf "https://github.com" \
&& mkdir -p github.com/Christiata/sem02v24
USER root
RUN curl -SL https://go.dev/dl/go1.22.2.windows-amd64.msi \
| tar xvz -C /usr/local
USER Chris
SHELL ["/bin/bash", "-c"]
RUN mkdir -p $HOME/go/{src,bin}
ENV GOPATH="/home/Chris/go"
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"