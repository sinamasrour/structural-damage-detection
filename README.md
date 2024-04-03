# Algorithms

This code is developed for structural damage detection using TLBO-based algorithms and the following articles:

-  [Teaching–learning-based optimization: A novel method for constrained mechanical design optimization problems](https://www.sciencedirect.com/science/article/abs/pii/S0010448510002484)
- [Observer-teacher-learner-based optimization: An enhanced meta-heuristic for structural sizing design](https://www.researchgate.net/publication/318261742_Observer-teacher-learner-based_optimization_An_enhanced_meta-heuristic_for_structural_sizing_design)
- [Damage detection of truss structures by hybrid immune system and teaching–learning-based optimization](https://link.springer.com/article/10.1007/s42107-018-0065-9)

- [An Efficient Hybrid Particle Swarm and Teaching-
  Learning-Based Optimization for Arch-Dam Shape
  Design](https://www.tandfonline.com/doi/abs/10.1080/10168664.2022.2129121)

# Excel files

To use structural data, you need to define it in an Excel file.

The nodal data sheet requires coordinates and node restraints to be defined. 

The second sheet is for inputting element data. You will need to define the end nodes and indicate the type of element, either beam (=1) or bar (=2). Additionally, you must provide values for the modulus of elasticity, cross-sectional area, and moment of inertia.

# How to use this code

For each element in the structure, there is a corresponding damage scenario. Therefore, you must define the damage scenario vector in "Actualinf.m".

` Alpha = [0 0 0 0 0 0 0 0.05 0 0 0 0 0 0 0.08 0 0 0 0 0 0 0 0 0.1 0 0 0 0];`



and in  "F0.m" lower and upper bound and xFlagDiscrete must define:

`PrbInfo.xLB=[0	0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0	0 0 0 0 0 0 0 0 0 0 0];`

`PrbInfo.xUB=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];`

`PrbInfo.xFlagDiscrete=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];`

` xOpt_pp = [0 0 0 0 0 0 0 0.05 0 0 0 0 0 0 0.08 0 0 0 0 0 0 0 0 0.1 0 0 0 0];`



and in "mainTLBOs.m" the script must define the damage scenario:

` xOpt_pp = [0 0 0 0 0 0 0 0.05 0 0 0 0 0 0 0.08 0 0 0 0 0 0 0 0 0.1 0 0 0 0];`



You need to specify the path of your Excel file in the Actualinf.m script on line 5 as follows:

`Name = 'Moment Frame1.xlsx';`