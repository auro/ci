FROM alpine as kubectl
RUN apk add --update --no-cache curl && curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && mv kubectl /usr/bin/kubectl

FROM gcr.io/google.com/cloudsdktool/cloud-sdk:alpine
COPY --from=alpine/helm /usr/bin/helm /usr/bin/helm
COPY --from=kubectl /usr/bin/kubectl /usr/bin/kubectl
ENTRYPOINT ["kubectl"]
CMD ["--version"]
