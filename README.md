# bsp_iv_hi_kinetic_interp
Brownian dynamics code for simulating bead-spring-dashpot chains with fluctuating internal friction and hydrodynamic interactions.

This code builds on a Fortran90 legacy code developed in the Molecular Rheology Lab headed by Prof. Ravi Jagadeeshan at Monash University [https://www.monash.edu/engineering/ravijagadeeshan].

I have modified the code so that it can now simulate the dynamics of a single polymer chain with fluctuating internal friction and hydrodynamic interactions. A kinetic interpretation is atatched to the governing Fokker-Planck equation to obtain the corresponding stochastic differemntial equations. This avoid the calculation of the divergence tensor that would accompany the It\^{o} interpretation. The divergence terms in the stress tensor expression are evaluated using the random finite difference method.

(1) eqb_prob_dist_code.zip : simulates chains at equilibrium, so that the probability distribution of the lengths of the end to end vectors may be
                             compared against the analytical expression.
 
(2) steady_shear_code.zip  : calculates the shear viscosity of a dilute solution of bead-spring-dashpot chains.

(3) variance_reduction_code.zip: code to implement variance reduced simulations to obtain more accurate results for the viscometric functions at small                                      shear rates.

Two sample "submit scripts (.sh extension) have been provided.

The accompanying paper and the supplemental material are available at: 
R. Kailasham, Rajarshi Chakrabarti, J. Ravi Prakash, "Shear viscosity for finitely extensible chains with fluctuating internal friction and hydrodynamic interactions" (2022), J. Rheol. (in press) [Link: https://arxiv.org/abs/2204.10656] 
