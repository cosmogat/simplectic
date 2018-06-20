/* 18-06-2018 */
/* alex */
/* 14_nb46.c */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "solar.h"

int main (int num_arg, char * vec_arg[]){
  int i, j, k, it, planetes, N, pop, pit, Neval = 0;
  char noms[MAX_PLA][MAX_CAD], f_ini[20];
  real masses[MAX_PLA], q[MAX_PLA][COMP], p[MAX_PLA][COMP], v[MAX_PLA][COMP];
  real H0, H, DH, Hemax = 0.0, d2q;
  real h;
  int s = 6;
  real a[s], ah[s];
  real b[s + 1], bh[s + 1];
  double t0, t = 0.0;
  FILE * fit_pl[MAX_PLA + 1];

  carregar_configuracio(num_arg, vec_arg, &h, &N, &pop, &pit, f_ini);
  planetes = carregar_planetes(f_ini, masses, noms, q, p);
  H0 = energia(masses, q, p, planetes);
  obrir_fitxers(fit_pl, noms, f_ini, vec_arg[0], planetes);
  a[0] = a[5] = 0.2452989571842710L;
  a[1] = a[4] = 0.6048726657110800L;
  a[2] = a[3] = 0.5 - (a[0] + a[1]);
  b[0] = b[6] = 0.0829844064174052L;
  b[1] = b[5] = 0.3963098014983681L;
  b[2] = b[4] = -0.039056304922348L;
  b[3] = 1.0 - (2.0 * (b[0] + b[1] + b[2]));
  for (i = 0; i < s; i++) {
    ah[i] = a[i] * h;
    bh[i] = b[i] * h;
  }
  bh[6] = b[6] * h;
  
  for (i = 1; i < planetes; i++)
    for (j = 0; j < COMP; j++)
      v[i][j] = p[i][j] / masses[i];
    
  /* Mètode d'escissió rkn */  
  for (it = 0; it < N; it++) {
    t0 = temps();
    /* Bucle per a k */
    for (k = 0; k < s; k++) {
      for (i = 1; i < planetes; i++) {
	for (j = 0; j < COMP; j++) {
	  d2q = deriv2q(masses, q, i, j, planetes);
	  v[i][j] += bh[k] * d2q;
	}
      }
      for (i = 1; i < planetes; i++)
	for (j = 0; j < COMP; j++)
	  q[i][j] += ah[k] * v[i][j];
    }
    for (i = 1; i < planetes; i++) {
      for (j = 0; j < COMP; j++) {
	d2q = deriv2q(masses, q, i, j, planetes);
	v[i][j] += bh[6] * d2q;
	p[i][j] = v[i][j] * masses[i];
      }
    }
    Neval += ((s + 1) * (planetes - 1));
    t += temps() - t0;
    H = energia(masses, q, p, planetes);
    DH = fabs(H - H0);
    if (DH > Hemax)
      Hemax = DH;
    if ((it % pit) == 0)
      escriure_fitxers(fit_pl, pop, ((real) it) * h, q, p, H0, H, planetes);
  }
  tancar_fitxers(fit_pl, planetes);
  print_info(h, t, Neval, Hemax / H0);
  return 0;
}