docker run --gpus=all -it --rm --ipc=host \
    -e NVIDIA_VISIBLE_DEVICES=$NV_GPU \
    -v`pwd`/bert_data:/cks \
    ${USER}/mlperf-v1.0-nvidia:language_model
