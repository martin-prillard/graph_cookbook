# syntax=docker/dockerfile:1
FROM python:3.11-slim

# --------------- ENV ---------------
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    VIRTUAL_ENV=/workspace/.venv \
    PATH=/workspace/.venv/bin:$PATH

WORKDIR /workspace

# --------------- SYSTEM DEPENDENCIES ---------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential git curl ca-certificates \
    libgdal-dev libgeos-dev libproj-dev \
    && rm -rf /var/lib/apt/lists/*

# --------------- CREATE NON-ROOT USER ---------------
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

# --------------- PYTHON DEPENDENCIES ---------------
RUN pip install --upgrade pip uv

# Copier uniquement pyproject.toml et uv.lock
COPY pyproject.toml uv.lock* ./

# Installer deps via uv
RUN uv sync --python /usr/local/bin/python --locked

# Installer PyTorch CPU et PyG
RUN uv pip install --index-url https://download.pytorch.org/whl/cpu torch \
 && uv pip install torch-geometric

# --------------- USER SETUP ---------------
USER $USERNAME

# --------------- PORT & CMD ---------------
EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--ServerApp.token=", "--ServerApp.password="]
