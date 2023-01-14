# MSPS A Multi-objective Model for Multi-skill Project Scheduling Problem considering Perform Efficiency

Codebase for [MSPS: A Multi-objective Model for Multi-skill Project Scheduling Problem considering Perform Efficiency
](https://ieeexplore.ieee.org/document/8948152) 

<p align="center">
<img src="https://github.com/Zhijie-He/MPPS/blob/main/images/MPPS_generation_3d.gif" width="80%" height="80%"/>
</p>

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

