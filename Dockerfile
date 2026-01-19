# Base Python
FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Dépendances système
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    ca-certificates \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Installer pip et uv
RUN pip install --upgrade pip uv

# Copier fichiers de dépendances
COPY pyproject.toml uv.lock* ./

# Installer les dépendances
RUN if [ -f uv.lock ]; then \
      uv sync --python /usr/local/bin/python --locked; \
    else \
      uv sync --python /usr/local/bin/python; \
    fi

# PyTorch CPU + PyTorch Geometric
RUN uv pip install --index-url https://download.pytorch.org/whl/cpu torch \
 && uv pip install torch-geometric

# Configurer le virtualenv par défaut
ENV VIRTUAL_ENV="/workspace/.venv" \
    PATH="/workspace/.venv/bin:$PATH"

# Ne pas copier le code source ici
# → le code sera monté via volume Docker ou DevContainer
