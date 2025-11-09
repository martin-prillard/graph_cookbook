# Centrality Measures in Cybersecurity

This directory contains a comprehensive notebook on centrality measures and their applications in cybersecurity.

## Notebook: `centrality_cybersecurity.ipynb`

### Overview

This notebook demonstrates how graph theory and centrality measures can be used to analyze network topologies, identify critical infrastructure, and detect vulnerabilities in corporate networks. It provides both attacker and defender perspectives on network security analysis.

### Features

1. **Realistic Network Generation**
   - Generates a corporate network topology with:
     - Core infrastructure (routers, switches, firewalls)
     - Department networks (IT, Finance, HR, Marketing, Engineering, etc.)
     - Servers, workstations, and network devices
     - ~70+ nodes with realistic connectivity patterns

2. **Centrality Measures**
   - **Degree Centrality**: Identifies highly connected nodes
   - **Betweenness Centrality**: Finds critical bottlenecks
   - **Closeness Centrality**: Identifies centrally located nodes
   - **Eigenvector Centrality**: Finds nodes connected to important nodes
   - **PageRank**: Identifies influential nodes

3. **Single Points of Failure (SPOF) Detection**
   - **Cut-vertices (Articulation Points)**: Nodes whose removal disconnects the network
   - **Bridges (Cut-edges)**: Edges whose removal disconnects the network
   - Implementation of **Tarjan's Algorithm** for efficient SPOF detection

4. **Cybersecurity Applications**
   - **Attacker's Perspective**: Identifying high-value targets and attack paths
   - **Defender's Perspective**: Protection strategies and monitoring priorities
   - **Attack Path Analysis**: Simulating potential attack paths through the network

5. **Visualizations**
   - Interactive Plotly visualizations
   - Network topology graphs with centrality highlighting
   - SPOF visualization with cut-vertices and bridges
   - Comparative analysis dashboards
   - Attack path visualization

### Key Concepts

- **Centrality Measures**: Quantify the importance of nodes in a network
- **SPOF**: Single Points of Failure that could disrupt network operations
- **Tarjan's Algorithm**: Efficient algorithm for finding cut-vertices and bridges
- **Network Security**: Applying graph theory to cybersecurity

### Usage

1. Open the notebook in JupyterLab
2. Run all cells sequentially
3. Explore the visualizations and analysis results
4. Modify the network generation parameters to create different topologies
5. Experiment with different centrality measures and thresholds

### Requirements

All dependencies are listed in `pyproject.toml`:
- networkx
- plotly
- matplotlib
- pandas
- numpy

### Learning Objectives

After completing this notebook, you will understand:
- How to compute various centrality measures
- How to identify critical infrastructure using graph analysis
- How attackers can use centrality to identify targets
- How defenders can use centrality to protect networks
- How to visualize network vulnerabilities and critical paths
- How to implement Tarjan's algorithm for SPOF detection

### Applications

- Network security analysis
- Attack path identification
- Defense strategy planning
- Network design and redundancy planning
- Incident response prioritization
- Vulnerability assessment

