Merge "cylinder.stl";            // The plane circle mesh generated in the previous step

// We first classify ("color") the surfaces by splitting the original surface
// along sharp geometrical features. This will create new discrete surfaces,
// curves and points.

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

lc = 0.1;
r = 0.5;
h = r * 5;

Mesh.MeshSizeMin = lc;
Mesh.MeshSizeMax = lc;

Curve Loop(4) = 4;                  // Annular surface outer ring
Curve Loop(5) = 5;                  // Annular surface inner ring

Plane Surface(35) = {5,4};          // Annular surface

out[] = Extrude {0,0,h} { Surface{2,3,35}; Layers{25}; };   // Extruded to generate an entire volume mesh

Physical Surface("lumen_inlet_0", 67) = {42};
Physical Surface("lumen_outlet_0", 68) = {2};
Physical Surface("lumen_wall", 69) = {41};
Physical Surface("tissue_inlet_0", 70) = {54, 66};
Physical Surface("tissue_outlet_0", 71) = {3, 35};
Physical Surface("tissue_wall", 72) = {53};
Physical Volume("fluid", 73) = {1};
Physical Volume("solid", 74) = {2, 3};

Mesh 3;