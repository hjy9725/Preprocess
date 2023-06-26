Merge "1_00.stl";
Merge "1_05.stl";
Merge "1_10.stl";
Merge "1_15.stl";
Merge "1_20.stl";

// We first classify ("color") the surfaces by splitting the original surface
// along sharp geometrical features. This will create new discrete surfaces,
// curves and points.

// Mesh.MeshSizeExtendFromBoundary = 1;
// Mesh.MeshSizeFromPoints = 1;
// Mesh.MeshSizeFromCurvature = 1;
// Mesh.Algorithm = 6;

DefineConstant[
  // Angle between two triangles above which an edge is considered as sharp
  angle = {40, Min 20, Max 120, Step 1,
    Name "Parameters/Angle for surface detection"},
  // For complex geometries, patches can be too complex, too elongated or too
  // large to be parametrized; setting the following option will force the
  // creation of patches that are amenable to reparametrization:
  forceParametrizablePatches = {0, Choices{0,1},
    Name "Parameters/Create surfaces guaranteed to be parametrizable"},
  // For open surfaces include the boundary edges in the classification process:
  includeBoundary = 1,
  // Force curves to be split on given angle:
  curveAngle = 180
];

ClassifySurfaces{angle * Pi/180, includeBoundary, forceParametrizablePatches,
                 curveAngle * Pi / 180};

Merge "distance.pos";

out1[] = Extrude{Surface{6}; Layers{ {1,1,1,1}, {0.008*0.75, 0.022545, 0.048991,0.09707} }; Using Index[0]; Using View[0]; };

Curve Loop(1) = {19};
Plane Surface(29) = {1};
Curve Loop(2) = {18};
Plane Surface(30) = {2};
Curve Loop(3) = {10};
Curve Loop(4) = {8};
Plane Surface(31) = {3, 4};
Curve Loop(5) = {12};
Plane Surface(32) = {3, 5};
Curve Loop(6) = {14};
Plane Surface(33) = {5, 6};
Curve Loop(7) = {16};
Plane Surface(34) = {6, 7};
Curve Loop(8) = {9};
Curve Loop(9) = {7};
Plane Surface(35) = {8, 9};
Curve Loop(10) = {11};
Plane Surface(36) = {8, 10};
Curve Loop(11) = {13};
Plane Surface(37) = {10, 11};
Curve Loop(12) = {15};
Plane Surface(38) = {11, 12};

// Curve Loop(1) = {7};
// Plane Surface(17) = {1};
// Curve Loop(2) = {6};
// Plane Surface(18) = {2};
// Surface Loop(200) = {16,17,18};
// Volume(200) = 200;
// Mesh 3;

// Merge "cylinder.stl";            // The plane circle mesh generated in the previous step

// // We first classify ("color") the surfaces by splitting the original surface
// // along sharp geometrical features. This will create new discrete surfaces,
// // curves and points.

// DefineConstant[
//   // Angle between two triangles above which an edge is considered as sharp
//   angle = {40, Min 20, Max 120, Step 1,
//     Name "Parameters/Angle for surface detection"},
//   // For complex geometries, patches can be too complex, too elongated or too
//   // large to be parametrized; setting the following option will force the
//   // creation of patches that are amenable to reparametrization:
//   forceParametrizablePatches = {0, Choices{0,1},
//     Name "Parameters/Create surfaces guaranteed to be parametrizable"},
//   // For open surfaces include the boundary edges in the classification process:
//   includeBoundary = 1,
//   // Force curves to be split on given angle:
//   curveAngle = 180
// ];

// ClassifySurfaces{angle * Pi/180, includeBoundary, forceParametrizablePatches,
//                  curveAngle * Pi / 180};

// lc = 0.1;
// r = 0.5;
// h = r * 5;

// Mesh.MeshSizeMin = lc;
// Mesh.MeshSizeMax = lc;

// Curve Loop(4) = 4;                  // Annular surface outer ring
// Curve Loop(5) = 5;                  // Annular surface inner ring

// Plane Surface(35) = {5,4};          // Annular surface

// out[] = Extrude {0,0,h} { Surface{2,3,35}; Layers{25}; };   // Extruded to generate an entire volume mesh

// Physical Surface("lumen_inlet_0") = {42};
// Physical Surface("lumen_outlet_0") = {2};
// Physical Surface("lumen_wall") = {41};
// Physical Surface("tissue_inlet_0") = {54, 66};
// Physical Surface("tissue_outlet_0") = {3, 35};
// Physical Surface("tissue_wall") = {53};
// Physical Volume("fluid") = {1};
// Physical Volume("solid") = {2, 3};


//+
Surface Loop(1) = {28, 29, 30};
//+
Volume(2) = {1};
//+
Surface Loop(2) = {6, 7, 35, 31};
//+
Volume(3) = {2};
//+
Surface Loop(3) = {7, 8, 36, 32};
//+
Volume(4) = {3};
//+
Surface Loop(4) = {8, 9, 33, 37};
//+
Volume(5) = {4};
//+
Surface Loop(5) = {10, 38, 34, 9};
//+
Volume(6) = {5};
//+
Physical Surface("lumen_inlet_0") = {23, 30};
//+
Physical Surface("lumen_outlet_0") = {29, 27};
//+
Physical Surface("lumen_wall") = {6};
//+
Physical Surface("tissue_inlet_0") = {38, 37, 36, 35};
//+
Physical Surface("tissue_outlet_0") = {34, 33, 32, 31};
//+
Physical Surface("tissue_wall") = {10};
//+
Physical Volume("fluid") = {2};
//+
Physical Volume("boundary_layer") = {1};
//+
Physical Volume("solid_1") = {3};
//+
Physical Volume("solid_2") = {4};
//+
Physical Volume("solid_3") = {5};
//+
Physical Volume("solid_4") = {6};
