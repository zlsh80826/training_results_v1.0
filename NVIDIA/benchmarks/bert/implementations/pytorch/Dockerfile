# Copyright (c) 2019-2021, NVIDIA CORPORATION. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ARG FROM_IMAGE_NAME=nvcr.io/nvidia/pytorch:21.05-py3
FROM ${FROM_IMAGE_NAME}

ARG uid
ARG gid
ARG username
ARG groupname

# Install dependencies
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        bzip2 \
        cabextract \
        iputils-ping \
        pbzip2 \
        pv \
        sudo \
 && rm -rf /var/lib/apt/lists/*

RUN addgroup --gid ${uid} ${username}
RUN groupmod --gid 3000 dip
RUN addgroup --gid ${gid} ${groupname}
RUN adduser --disabled-password --gecos GECOS -u ${uid} -gid ${gid} ${username}
RUN adduser ${username} sudo
RUN usermod -a -G ${groupname} ${username}
RUN usermod -a -G ${groupname} root
RUN usermod -a -G root ${username}
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# RUN mkdir /workspace
RUN chown -R ${username}:${groupname} /workspace
USER ${username}

RUN mkdir /workspace/bert
WORKDIR /workspace/bert
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade https://github.com/mlperf/logging/archive/5bc16bf.zip \
 && pip install --no-cache-dir -r requirements.txt --user

# Preprocessing
WORKDIR /workspace
RUN cd /workspace && git clone https://github.com/attardi/wikiextractor.git
RUN cd /workspace/wikiextractor && git checkout e4abb4cbd019b0257824ee47c23dd163919b731b

# Install BERT
ENV BERT_PREP_WORKING_DIR /workspace/bert/data
WORKDIR /workspace/bert
COPY --chown=${username} . .

ENV PYTHONPATH "/workspace/bert"

RUN cd /workspace/bert/mhalib && python setup.py build && cp build/lib*/mhalib* ../
WORKDIR /workspace/bert
