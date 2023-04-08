Merge "adaptive.msh"; //  stl来源于之前的wall.vtp（可以paraview将vtp-》stl）

Physical Surface("lumen_outlet_-1") = {6};
Physical Surface("lumen_outlet_0") = {60,66};
Physical Surface("lumen_outlet_1") = {59,67};
Physical Surface("lumen_outlet_2") = {62,68};
Physical Surface("lumen_outlet_3") = {61,69};
Physical Surface("lumen_outlet_4") = {57,70};
Physical Surface("lumen_outlet_5") = {58,71};
Physical Surface("lumen_wall") = {56};
Physical Surface("tissue_outlet_-1") = {74,75};
Physical Surface("tissue_outlet_0") = {76,77};
Physical Surface("tissue_outlet_1") = {78,79};
Physical Surface("tissue_outlet_2") = {80,81};
Physical Surface("tissue_outlet_3") = {82,83};
Physical Surface("tissue_outlet_4") = {84,85};
Physical Surface("tissue_outlet_5") = {86,87};
Physical Surface("tissue_wall") = {73};

Physical Volume("fluid") = {1,200};
Physical Volume("solid") = {300,400};