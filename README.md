# MSPS A Multi-objective Model for Multi-skill Project Scheduling Problem considering Perform Efficiency

Codebase for [MSPS: A Multi-objective Model for Multi-skill Project Scheduling Problem considering Perform Efficiency
](https://ieeexplore.ieee.org/document/8948152) 

<p align="center">
<img src="https://github.com/Zhijie-He/MSPS/blob/main/images/MSPS_generation_2d.gif"/>
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


### Human Resource Assignment
**Task 1 (Human Resource Assignment)**

	Worker R1:1		Worker R1:2		Worker R1:3	
	Worker R2:4	

**Task 2 (Human Resource Assignment)**

	Worker R2:4		Worker R2:5		Worker R2:6		Worker R2:1	

**Task 3 (Human Resource Assignment)**

	Worker R1:1		Worker R1:2		Worker R1:3	
	Worker R3:7	
**Task 4 (Human Resource Assignment)**

	Worker R2:6		Worker R2:1	
	Worker R3:7		Worker R3:8		Worker R3:2		Worker R3:3	
**Task 5 (Human Resource Assignment)**

	Worker R2:4		Worker R2:5	
**Task 6 (Human Resource Assignment)**

	Worker R1:1		Worker R1:2		Worker R1:3		Worker R1:6	
	Worker R3:7	
**Task 7 (Human Resource Assignment)**

	Worker R1:1		Worker R1:2		Worker R1:3	
	Worker R3:7		Worker R3:8	
**Task 8 (Human Resource Assignment)**

	Worker R2:4		Worker R2:5		Worker R2:6	
	Worker R3:7		Worker R3:8		Worker R3:1	
**Task 9 (Human Resource Assignment)**

	Worker R2:4		Worker R2:5		Worker R2:6	

**Task 10 (Human Resource Assignment)**

	Worker R1:1	
	Worker R2:4		Worker R2:5		Worker R2:6	
	Worker R3:7		Worker R3:8	
**Task 11 (Human Resource Assignment)**

	Worker R2:1		Worker R2:2		Worker R2:3	
	Worker R3:7	
**Task 12 (Human Resource Assignment)**

	Worker R2:4		Worker R2:5		Worker R2:6		Worker R2:8	
**Task 13 (Human Resource Assignment)**

	Worker R1:1		Worker R1:2	
	Worker R3:7		Worker R3:8		Worker R3:5		Worker R3:6		Worker R3:3	
**Task 14 (Human Resource Assignment)**

	Worker R2:4		Worker R2:5	
	Worker R3:7		Worker R3:8		Worker R3:6	
**Task 15 (Human Resource Assignment)**

	Worker R1:1	
	Worker R2:2		Worker R2:3		Worker R2:7	

**Task 16 (Human Resource Assignment)**

	Worker R2:4		Worker R2:5		Worker R2:6	
	Worker R3:7		Worker R3:8	