FROM obedmr/devbox
MAINTAINER obed.n.munoz@gmail.com

# Dependencies
RUN pacman -Syu --noconfirm python

# Google Cloud SDK
ENV GOOGLE_CLOUD_SDK_VERSION 319.0.0
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-$GOOGLE_CLOUD_SDK_VERSION-linux-x86_64.tar.gz; \
    tar -xzvf google-cloud-sdk-$GOOGLE_CLOUD_SDK_VERSION-linux-x86_64.tar.gz ; \
    ./google-cloud-sdk/install.sh ; \
    rm *.tar.gz
RUN echo "source /google-cloud-sdk/path.zsh.inc" >> $HOME/.extras ; \
    echo "export PATH=/google-cloud-sdk/bin:/root/go/bin/:/root/dev/go/bin:\$PATH" >> $HOME/.extras \
    echo "source <(kubectl completion zsh)" >> $HOME/.extras
RUN /google-cloud-sdk/bin/gcloud components install app-engine-java kubectl beta

# Tools
RUN pacman -Sy --noconfirm bazel go kubectx openssh docker
RUN sudo -u yaourt yaourt -Sy --noconfirm k9s kafkacat
RUN go get github.com/bazelbuild/bazelisk

# Final settings
WORKDIR /root
