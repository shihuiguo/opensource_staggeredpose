clear;

[s, m, f] = bvhReadFile('examples/07_02.bvh');

probCOM = comMeasure(s, m);
[probLocal, weightsLocal] = localMeasure(s, m);
probGlobal = globalMeasure(s, m);

weightsCOM = 1;
weightsGlobal = 1;

probRoughSum = [probCOM probLocal probGlobal] * [weightsCOM weightsLocal' weightsGlobal]';