FROM python:3.10.5-slim as base

COPY . /sqlite_rx

WORKDIR /svc

RUN pip config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple
RUN pip install --upgrade pip
RUN pip install Cython
RUN pip install wheel && pip wheel --wheel-dir=/svc/wheels /sqlite_rx[cli]
RUN rm -rf /sqlite_rx


FROM python:3.10.5-slim

COPY --from=base /svc /svc
WORKDIR /svc

RUN pip config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple
RUN pip install --upgrade pip
RUN pip install --no-index /svc/wheels/*.whl