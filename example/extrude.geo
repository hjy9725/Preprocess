Merge "classify.msh";

SetFactory("OpenCASCADE");

lc = 0.1;
r = 0.5;
h = r * 5;

Mesh.MeshSizeMin = lc;
Mesh.MeshSizeMax = lc;

Circle(31) = {0,0,0, r*1.2};  
Circle(32) = {0,0,0, r*1.15};
Circle(33) = {0,0,0, r*1.1};
Circle(34) = {0,0,0, r*1.05};

Curve Loop(31) = 31;
Curve Loop(32) = 32;
Curve Loop(33) = 33;
Curve Loop(34) = 34;
Curve Loop(35) = 3;

Plane Surface(31) = {31,32};
Plane Surface(32) = {32,33};
Plane Surface(33) = {33,34};
Plane Surface(34) = {34,35};

// out[] = Extrude{0,0,h}{ Surface{1,2,3,4};};
// out_BL[] = Extrude{Surface{12}; Layers{ {1,1,1,1}, {-0.008, -0.022545, -0.048991,-0.09707} };Using Index[0]; Using View[0]; };

Mesh 3;

// Curve Loop(16) = {14,15};

// Point(14) = {r*-1.05, 0, 0, l}; 
// Point(15) = {r*1.05, 0, 0, l};  Circle(16) = {14,11,15};
//                                 Circle(17) = {15,11,14};
//                                 Curve Loop(18) = {16,17};
//                                 Plane Surface(19) = {18,16};

// Point(16) = {r*-1.1, 0, 0, l};
// Point(17) = {r*1.1, 0, 0, l};   Circle(18) = {16,11,17};
//                                 Circle(19) = {17,11,16};
//                                 Curve Loop(20) = {18,19};
//                                 Plane Surface(21) = {20,18};

// Point(18) = {r*-1.15, 0, 0, l};
// Point(19) = {r*1.15, 0, 0, l};  Circle(20) = {18,11,19};
//                                 Circle(21) = {19,11,18};
//                                 Curve Loop(22) = {20,21};
//                                 Plane Surface(23) = {22,20};

// Point(20) = {r*-1.2, 0, 0, l};
// Point(21) = {r*1.2, 0, 0, l};   Circle(22) = {20,11,21};
//                                 Circle(23) = {21,11,20};
//                                 Curve Loop(24) = {22,23};
//                                 Plane Surface(25) = {24,22};

// out[] = Extrude{0,0,h}{ Surface{17,19,21,23,25};};