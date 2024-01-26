#!/bin/bash

trap killgroup SIGINT

function killgroup() {
  echo killing...
  kill 0
}

function generated_warning() {
	cat <<-EOH
		#
		# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
		#
		# PLEASE DO NOT EDIT IT DIRECTLY.
		#

	EOH
}

function docker_tag_exists() {
  docker manifest inspect $1:$2 &> /dev/null && docker manifest inspect ghcr.io/$1:$2 &> /dev/null
}

# opencv versions
for version in \
  4.9.0 \
; do
  
  # edition small (opencv only) or full (with opencv_contrib)
  for edition in \
    base \
    text \
  ; do

    # Supported base images
    for image in \
      alpine:3.19.0 \
      node:20.11.0-alpine3.19 \
    ; do
      # Parse image string
      base="${image%%:*}"
      baseVersion="${image##*:}"
      baseVersionClean="${baseVersion%%-*}"

      # Check for base OS type (currently only alpine)
      case "$image" in
        alpine*)
          os="alpine"
          template="Dockerfile-alpine-$edition.template"
          replaceRules="
            s/%%IMAGE%%/$image/g;
            s/%%OPENCVVERSION%%/$version/g;
            /%%END%%/d;
          "
        ;;
        *alpine*)
          os="alpine"
          template="Dockerfile-alpine-$edition.template"
          replaceRules="
            s/%%IMAGE%%/$image/g;
            s/%%OPENCVVERSION%%/$version/g;
            s/%%END%%/ENV OPENCV4NODEJS_DISABLE_AUTOBUILD=1/g;
          "
        ;;
        *)
          echo "WARNING: OS Type not supported"
          exit
        ;;
      esac

      # Prepare imageName and tag
      if [ "$os" == "$base" ]; then
        imageName="$base-opencv"
      else
        imageName="$os-$base-opencv"
      fi
      tag="$baseVersionClean-$version-$edition"
      dir="archive/$imageName"
      file="Dockerfile_$tag"

      # Build container if needed
      if ! docker_tag_exists "surnet/$imageName" "$tag"; then
        # Prepare Dockerfile
        mkdir -p "$dir"
        { generated_warning; cat "$template"; } > "$dir/$file"
        sed -i.bak -e "$replaceRules" "$dir/$file"

        # Build container
        echo "Starting build for surnet/$imageName:$tag"
        docker buildx build . -f "$dir/$file" -t "surnet/$imageName:$tag" --platform linux/amd64,linux/arm64 --push \
        && docker buildx build . -f "$dir/$file" -t "ghcr.io/surnet/$imageName:$tag" --platform linux/amd64,linux/arm64 --push \
        && echo "Successfully built and pushed surnet/$imageName:$tag" || echo "Building or pushing failed for surnet/$imageName:$tag"
      fi
      
    done

  done

done

wait
echo "###########################################################
  The script completed creating and pushing docker images
###########################################################"
