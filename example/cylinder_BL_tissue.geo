/*********************************************/
/*
This code is designed to create a circle x^2 + y^2 = r^2
with a boundary layer inside and 
four layers of solid tissue outside
*/
/*********************************************/


l = 0.1;                       // Mesh size and mesh precision
r = 0.5;                       // The radius of the cylinder
h = r * 5;                     // The height of the cylinder

Point(11) = {0, 0, 0, l};      // The center of a circle
Point(12) = {r*-1, 0, 0, l};   // The start point of the arc
Point(13) = {r, 0, 0, l};      // The end point of the arc

Circle(14) = {12,11,13};       // The top half of the circle
Circle(15) = {13,11,12};       // The bottom half of the circle

Curve Loop(16) = {14,15};      // Join two arcs together to form a whole circle
Plane Surface(17) = {16};      // Define a circle plane in terms of this whole circle

Field[2] = BoundaryLayer;      // Define a distance field that generates a boundary layer
Field[2].CurvesList = {14,15}; // The boundary of the distance field is the previous whole circle
Field[2].SizeFar = 0.1;        // Mesh size far from the curvesMesh size far from the curves
Field[2].Size = 0.005;         // Mesh size normal to the curve
Field[2].Thickness = 0.08;     // Maximal thickness of the boundary layer
Field[2].Ratio = 1.4;          // Size ratio between two successive layers

BoundaryLayer Field = 2;       // Set the label of boundary layer distance field

Point(14) = {r*-1.05, 0, 0, l}; 
Point(15) = {r*1.05, 0, 0, l};  Circle(16) = {14,11,15};
                                Circle(17) = {15,11,14};
                                Curve Loop(18) = {16,17};
                                // Plane Surface(19) = {18,16};

Point(16) = {r*-1.1, 0, 0, l};
Point(17) = {r*1.1, 0, 0, l};   Circle(18) = {16,11,17};
                                Circle(19) = {17,11,16};
                                Curve Loop(20) = {18,19};
                                Plane Surface(21) = {20,18};

Point(18) = {r*-1.15, 0, 0, l};
Point(19) = {r*1.15, 0, 0, l};  Circle(20) = {18,11,19};
                                Circle(21) = {19,11,18};
                                Curve Loop(22) = {20,21};
                                Plane Surface(23) = {22,20};

Point(20) = {r*-1.2, 0, 0, l};
Point(21) = {r*1.2, 0, 0, l};   Circle(22) = {20,11,21};
                                Circle(23) = {21,11,20};
                                Curve Loop(24) = {22,23};
                                Plane Surface(25) = {24,22};

Mesh 2;