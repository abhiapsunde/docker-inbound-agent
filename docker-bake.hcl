group "linux" {
  targets = [
    "alpine_jdk11",
    "alpine_jdk17",
    "alpine_jdk21",
    "debian_jdk11",
    "debian_jdk17",
    "debian_jdk21",
  ]
}

group "linux-arm64" {
  targets = [
    "debian_jdk11",
    "debian_jdk17",
    "debian_jdk21",
    "alpine_jdk21",
  ]
}

group "linux-s390x" {
  targets = []
}

group "linux-ppc64le" {
  targets = [
    "debian_jdk11",
    "debian_jdk17",
    "debian_jdk21",
  ]
}

#### This is the current (e.g. jenkins/inbound-agent) version (including build number suffix). Overridden by release builds from GIT_TAG.
variable "IMAGE_TAG" {
  default = "3071.v7e9b_0dc08466-1"
}

#### This is for the "parent" image version to use (jenkins/agent:<PARENT_IMAGE_VERSION>-<base-os>)
variable "PARENT_IMAGE_VERSION" {
  default = "3160.vd76b_9ddd10cc-2"
}

variable "REGISTRY" {
  default = "docker.io"
}

variable "JENKINS_REPO" {
  default = "jenkins/inbound-agent"
}

variable "ON_TAG" {
  default = "false"
}

target "alpine_jdk11" {
  dockerfile = "alpine/Dockerfile"
  context    = "."
  args = {
    JAVA_MAJOR_VERSION = "11"
    version            = "${PARENT_IMAGE_VERSION}"
  }
  tags = [
    equal(ON_TAG, "true") ? "${REGISTRY}/${JENKINS_REPO}:${PARENT_IMAGE_VERSION}-alpine-jdk11" : "",
    "${REGISTRY}/${JENKINS_REPO}:alpine-jdk11",
    "${REGISTRY}/${JENKINS_REPO}:latest-alpine-jdk11",
  ]
  platforms = ["linux/amd64"]
}

target "alpine_jdk17" {
  dockerfile = "alpine/Dockerfile"
  context    = "."
  args = {
    JAVA_MAJOR_VERSION = "17"
    version            = "${PARENT_IMAGE_VERSION}"
  }
  tags = [
    equal(ON_TAG, "true") ? "${REGISTRY}/${JENKINS_REPO}:${PARENT_IMAGE_VERSION}-alpine" : "",
    equal(ON_TAG, "true") ? "${REGISTRY}/${JENKINS_REPO}:${PARENT_IMAGE_VERSION}-alpine-jdk17" : "",
    "${REGISTRY}/${JENKINS_REPO}:alpine",
    "${REGISTRY}/${JENKINS_REPO}:alpine-jdk17",
    "${REGISTRY}/${JENKINS_REPO}:latest-alpine",
    "${REGISTRY}/${JENKINS_REPO}:latest-alpine-jdk17",
  ]
  platforms = ["linux/amd64"]
}

target "alpine_jdk21" {
  dockerfile = "alpine/Dockerfile-jdk21"
  context    = "."
  args = {
    JAVA_MAJOR_VERSION = "21"
    version            = "${PARENT_IMAGE_VERSION}"
  }
  tags = [
    equal(ON_TAG, "true") ? "${REGISTRY}/${JENKINS_REPO}:${PARENT_IMAGE_VERSION}-alpine-jdk21-preview" : "",
    "${REGISTRY}/${JENKINS_REPO}:alpine-jdk21-preview",
    "${REGISTRY}/${JENKINS_REPO}:latest-alpine-jdk21-preview",
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "debian_jdk11" {
  dockerfile = "debian/Dockerfile"
  context    = "."
  args = {
    JAVA_MAJOR_VERSION = "11"
    version            = "${PARENT_IMAGE_VERSION}"
  }
  tags = [
    equal(ON_TAG, "true") ? "${REGISTRY}/${JENKINS_REPO}:${PARENT_IMAGE_VERSION}-jdk11" : "",
    "${REGISTRY}/${JENKINS_REPO}:jdk11",
    "${REGISTRY}/${JENKINS_REPO}:latest-jdk11",
  ]
  platforms = ["linux/amd64", "linux/arm64", "linux/arm/v7", "linux/s390x", "linux/ppc64le"]
}

target "debian_jdk17" {
  dockerfile = "debian/Dockerfile"
  context    = "."
  args = {
    JAVA_MAJOR_VERSION = "17"
    version            = "${PARENT_IMAGE_VERSION}"
  }
  tags = [
    equal(ON_TAG, "true") ? "${REGISTRY}/${JENKINS_REPO}:${PARENT_IMAGE_VERSION}" : "",
    equal(ON_TAG, "true") ? "${REGISTRY}/${JENKINS_REPO}:${PARENT_IMAGE_VERSION}-jdk17" : "",
    "${REGISTRY}/${JENKINS_REPO}:jdk17",
    "${REGISTRY}/${JENKINS_REPO}:latest",
    "${REGISTRY}/${JENKINS_REPO}:latest-jdk17",
  ]
  platforms = ["linux/amd64", "linux/arm64", "linux/arm/v7", "linux/ppc64le"]
}

target "debian_jdk21" {
  dockerfile = "debian/Dockerfile-jdk21"
  context    = "."
  args = {
    JAVA_MAJOR_VERSION = "21"
    version            = "${PARENT_IMAGE_VERSION}"
  }
  tags = [
    equal(ON_TAG, "true") ? "${REGISTRY}/${JENKINS_REPO}:${PARENT_IMAGE_VERSION}-jdk21-preview" : "",
    "${REGISTRY}/${JENKINS_REPO}:jdk21-preview",
    "${REGISTRY}/${JENKINS_REPO}:latest-jdk21-preview",
  ]
  platforms = ["linux/amd64", "linux/arm64", "linux/ppc64le"]
}
