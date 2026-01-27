############################
# Base image
############################
FROM python:3.11-slim

############################
# Environment
############################
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    UV_PROJECT_ENVIRONMENT=/opt/venv \
    VIRTUAL_ENV=/opt/venv \
    PATH=/opt/venv/bin:$PATH

############################
# System dependencies
############################
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    git \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
 && rm -rf /var/lib/apt/lists/*

############################
# Non-root user
############################
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid ${USER_GID} ${USERNAME} \
 && useradd  --uid ${USER_UID} --gid ${USER_GID} \
             --create-home --shell /bin/bash ${USERNAME}

############################
# uv + virtualenv
############################
RUN pip install --no-cache-dir --upgrade pip uv \
 && uv venv ${VIRTUAL_ENV} \
 && chown -R ${USERNAME}:${USERNAME} ${VIRTUAL_ENV}

############################
# Switch to non-root
############################
USER ${USERNAME}
WORKDIR /workspace

############################
# Python dependencies
############################
COPY --chown=${USERNAME}:${USERNAME} pyproject.toml uv.lock* ./

RUN uv sync --locked

# Compatibility fix: pycaret 3.3.0 ↔ node2vec 0.5.0
RUN uv pip install --no-cache-dir --force-reinstall joblib==1.3.2

############################
# Jupyter kernel
############################
RUN uv pip install --no-cache-dir ipykernel \
 && python -m ipykernel install --user \
    --name graph-cookbook \
    --display-name "Python (graph-cookbook)"

############################
# Runtime
############################
EXPOSE 8888

CMD ["jupyter", "lab", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--IdentityProvider.token=", \
     "--ServerApp.password="]
