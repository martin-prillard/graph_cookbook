# Graph cookbook

The project contains multiple graph analytics notebooks (centrality, community detection, malware classification, etc.). The easiest way to run them consistently is via the provided Docker image:

## 1️⃣ Installation

Three different ways to use this project using:

- DevContainer
- Docker image
- Python environment

### Option A: installation using DevContainer (recommended)

**Prerequisites**: 
- Docker or Docker Desktop (https://www.docker.com/products/docker-desktop/)
- VSCode or Cursor (https://code.visualstudio.com/download)
- Dev Containers VSCode or Cursor extension (https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- Optional: WSL VSCode or Cursor extension (https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl)

**Steps**:

```bash
git clone https://github.com/martin-prillard/graph_cookbook
cd graph_cookbook
# Open in VS Code / CTRL + Shift + P → "Rebuild and Reopen in Container"
```

VSCode will build the container, installs dependencies via uv sync, mounts your code.
Code changes are automatically saved locally.


### Option B: installation using Docker only
(optional, if you have some issue with DevContainer installation or if you don't want to use a IDE)

1. **Build the image**
```bash
docker build -t graph_cookbook .
```

2. **Start JupyterLab**
```bash
docker run --rm -p 8888:8888 -v "$(pwd)":/workspace graph_cookbook
```
Note: add `--gpus all` on the docker run command if you want to use your GPU.

### Option C: installation using Python environment
(optional, if you want to run this project from scratch)

Warning: unlike installations via DevContainer and Docker, installation via UV may fail due to library dependency conflicts on your host OS/architecture. 

1. **Install uv**

https://docs.astral.sh/uv/getting-started/installation/

2. **Create your python env**
```bash
uv sync
```

3. **Run Jupyter Lab**
```bash
uv run jupyter lab
```


## 2️⃣ Run the notebooks

Use VSCode/Cursor or JupyterLab (http://localhost:8888)

Copy paste data files in the `./data` directory you need them for notebooks.
