# Graph cookbook

The project contains multiple graph analytics notebooks (centrality, community detection, malware classification, etc.). The easiest way to run them consistently is via the provided Docker image:

1. **Build the image**
   ```bash
   docker build -t graph_cookbook .
   ```
2. **Start JupyterLab**
   ```bash
   docker run --rm -p 8888:8888 -v "$(pwd)":/app graph_cookbook
   ```

Then open `http://localhost:8888` in your browser (token disabled) and launch any notebook inside the workspace.

