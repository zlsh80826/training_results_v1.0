docker build --pull -t ${USER}/mlperf-v1.0-nvidia:language_model \
    --build-arg uid=$(id -u) --build-arg username=$(id -un) \
    --build-arg gid=$(id -g) --build-arg groupname=$(id -gn) .
