# syntax=docker/dockerfile:1
FROM python:3.11-slim

# ---------------- ENV ----------------
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    UV_PROJECT_ENVIRONMENT=/opt/venv \
    PATH=/opt/venv/bin:/usr/local/bin:$PATH

# ---------------- SYSTEM DEPENDENCIES ----------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    ca-certificates \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    && rm -rf /var/lib/apt/lists/*

# ---------------- USER ----------------
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME}

# ---------------- UV + VENV ----------------
RUN pip install --upgrade pip uv \
    && uv venv /opt/venv --python python \
    && chown -R ${USERNAME}:${USERNAME} /opt/venv

# ---------------- SWITCH USER ----------------
USER ${USERNAME}

# ---------------- WORKDIR ----------------
WORKDIR /workspace

# ---------------- PYTHON DEPS ----------------
COPY pyproject.toml uv.lock* ./
RUN uv sync --locked

# hard fix: compatibility issue between pycaret 3.3.0 and node2vec 0.5.0
RUN uv pip install --force-reinstall joblib==1.3.2

# ---------------- JUPYTER KERNEL ----------------
RUN uv pip install ipykernel \
    && python -m ipykernel install --user \
       --name graph-cookbook \
       --display-name "Python (graph-cookbook)"

# ---------------- PORT & CMD ----------------
EXPOSE 8888

CMD ["jupyter", "lab", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--IdentityProvider.token=", \
     "--ServerApp.password="]
