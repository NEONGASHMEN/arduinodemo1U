#ifndef SENSOR_PARAMS_H
#define SENSOR_PARAMS_H

#if ARDUINO >= 100
#include "Arduino.h"
#else
#include "WProgram.h"
#endif

//Torquer params
double A = 0.02;
double n = 84;
double saturation_current = 0.04;

#endif
