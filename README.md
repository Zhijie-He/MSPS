# MSPS A Multi-objective Model for Multi-skill Project Scheduling Problem considering Perform Efficiency

Codebase for [MSPS: A Multi-objective Model for Multi-skill Project Scheduling Problem considering Perform Efficiency
](https://ieeexplore.ieee.org/document/8948152) 

<p align="center">
<img src="https://github.com/Zhijie-He/MSPS/blob/main/images/MSPS_generation_2d.gif"/>
</p>


## Abstract
The growing need of responsiveness for enterprises facing market volatility raises a strong demand for flexibility in their human resource management. This paper presents a multi-objective model for Multi-skill Project Scheduling Problem. We **propose a new wage distribution method** in which different perform efficiencies of human resources are taken into account. The model aims at **minimizing project duration and project costs concurrently.** An improved NSGA-II algorithm is designed to solve the model. The algorithm introduces a multi-dimensional chromosome coding scheme to identify the priorities and staff allocation of each activity. Special chromosome crossover and mutation operation are employed to address resource conflicts and constraint violations. Eventually, A case study is presented to verify the efficiency of the proposed approach.

## Getting Started
We use this repository with MATLAB2016a Windows.

Get code: `git clone https://github.com/Zhijie-He/MSPS.git`

## Running the code
Use MATLAB open project and put all files in the same workspace.
```bash
DEnsga_2(pop, gen)
```
- `--pop` specifies the size of population.
- `--gen` sepcifies the number of generations (iterations).

## Project Configure
In the Const.m file, we preset the project information, here we use one project data as simulation, 
including 
- the relationship between tasks, 
- required resources 
- the cost and time of insourcing and outsourcing.
- Human resources data

## Results
<img src="https://github.com/Zhijie-He/MSPS/blob/main/images/MSPS_generation_2d.gif"/>

### Gante Chart
<p align="center">
<img src="https://github.com/Zhijie-He/MSPS/blob/main/images/project_gante.png"/>
</p>


### Human Resource Assignment
<p align="center">
<img src="https://github.com/Zhijie-He/MSPS/blob/main/images/human_resource_assignment.png"/>
</p>