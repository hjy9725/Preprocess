SetFactory("OpenCASCADE");

lc = 0.1;
r = 0.5;
h = r * 5;

Mesh.MeshSizeMin = lc;
Mesh.MeshSizeMax = lc;

Circle(1) = {0,0,0, r*1.2};  
Circle(2) = {0,0,0, r*1.15};
Circle(3) = {0,0,0, r*1.1};
Circle(4) = {0,0,0, r*1.05};
Circle(5) = {0,0,0, r};

Curve Loop(1) = 1;
Curve Loop(2) = 2;
Curve Loop(3) = 3;
Curve Loop(4) = 4;
Curve Loop(5) = 5;

Plane Surface(1) = {1,2};
Plane Surface(2) = {2,3};
Plane Surface(3) = {3,4};
Plane Surface(4) = {4,5};

out[] = Extrude{0,0,h}{ Surface{1,2,3,4};};
// out_BL[] = Extrude{Surface{12}; Layers{ {1,1,1,1}, {-0.008, -0.022545, -0.048991,-0.09707} };Using Index[0]; Using View[0]; };

// Mesh 2;

// l = .1;
// Point(7) = {-1.4, 0.5, 0, l};
// Point(8) = {-1.4, -1.1, 0, l};
// Point(9) = {1.4, -1.1, 0, l};
// Point(10) = {1.4, 0.5, 0, l};
// Line(2) = {7, 10};
// Line(3) = {9, 10};
// Line(4) = {9, 8};
// Line(5) = {8, 7};
// Line Loop(7) = {2,-3,4,5};
// Plane Surface(8) = {7};
// Field[1] = BoundaryLayer;
// Field[1].CurvesList = {4};
// Field[1].SizeFar = 0.1;
// Field[1].Size = 0.005;
// Field[1].Thickness = 0.3;
// Field[1].Ratio = 1.4;
// Field[1].NodesList = {8, 9};

// BoundaryLayer Field = 1;

// l = .1;
// r = 0.5;
// h = r * 5;

// Point(11) = {0, 0, 0, l};
// Point(12) = {r*-1, 0, 0, l};
// Point(13) = {r, 0, 0, l};

// Circle(14) = {12,11,13};
// Circle(15) = {13,11,12};

// Curve Loop(16) = {14,15};
// Plane Surface(17) = {16};

// Field[2] = BoundaryLayer;
// Field[2].CurvesList = {14,15};
// Field[2].SizeFar = 0.1;
// Field[2].Size = 0.005;
// Field[2].Thickness = 0.08;
// Field[2].Ratio = 1.4;
// Field[2].NodesList = {12,13};

// BoundaryLayer Field = 2;

// Point(14) = {r*-1.05, 0, 0, l}; 
// Point(15) = {r*1.05, 0, 0, l}; Circle(16) = {14,11,15};
//                                 Circle(17) = {15,11,14};
//                                 Curve Loop(18) = {16,17};
//                                 // Plane Surface(19) = {18,16};

// Point(16) = {r*-1.1, 0, 0, l};
// Point(17) = {r*1.1, 0, 0, l};  Circle(18) = {16,11,17};
//                                 Circle(19) = {17,11,16};
//                                 Curve Loop(20) = {18,19};
//                                 Plane Surface(21) = {20,18};

// Point(18) = {r*-1.15, 0, 0, l};
// Point(19) = {r*1.15, 0, 0, l}; Circle(20) = {18,11,19};
//                                 Circle(21) = {19,11,18};
//                                 Curve Loop(22) = {20,21};
//                                 Plane Surface(23) = {22,20};

// Point(20) = {r*-1.2, 0, 0, l};
// Point(21) = {r*1.2, 0, 0, l};  Circle(22) = {20,11,21};
//                                 Circle(23) = {21,11,20};
//                                 Curve Loop(24) = {22,23};
//                                 Plane Surface(25) = {24,22};
//+
// Hide "*";
// //+
// Show {
//   Point{5}; Point{10}; Curve{5}; Curve{14}; Curve{15}; Surface{12}; 
// }
// //+
// Hide "*";
// //+
// Show {
//   Point{5}; Point{10}; Curve{5}; Curve{14}; Curve{15}; Surface{12}; 
// }
// //+
// Hide "*";
// //+
// Show {
//   Point{5}; Point{10}; Curve{5}; Curve{14}; Curve{15}; Surface{12}; 
// }
