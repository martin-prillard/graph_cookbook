# Graph cookbook

The project contains multiple graph analytics notebooks (centrality, community detection, malware classification, etc.). The easiest way to run them consistently is via the provided Docker image:

## 1️⃣ Installation

### Installation using DevContainer (recommended)

**Prerequisites**: 
- Docker
- VSCode or Cursor
- Dev Containers extension.

**Steps**:

```bash
git clone https://github.com/martin-prillard/graph_cookbook
cd graph_cookbook
# Open in VS Code → "Reopen in Container"
```

VSCode will build the container, installs dependencies via uv sync, mounts your code.
Code changes are automatically saved locally.


### Installation using Docker only 
(optional, if you have problem with DevContainer)

1. **Build the image**
```bash
docker build -t graph_cookbook .
```

2. **Start JupyterLab**
```bash
docker run --rm -p 8888:8888 -v "$(pwd)":/workspace/cookbook graph_cookbook
```

## 2️⃣ Run the notebooks

Use VSCode/Cursor or JupyterLab (http://localhost:8888)

Copy paste data files in the `./data` directory you need them for notebooks.
