// -----------------------------------------------------------------------------
//
//  Gmsh C++ tutorial 10
//
//  Mesh size fields
//
// -----------------------------------------------------------------------------

// In addition to specifying target mesh sizes at the points of the geometry
// (see `t1.cpp') or using a background mesh (see `t7.cpp'), you can use general
// mesh size "Fields".

#include <vtkAppendPolyData.h>
#include <vtkCleanPolyData.h>
#include <vtkConeSource.h>
#include <vtkNew.h>
#include <vtkPolyData.h>
#include <vtkPolyDataMapper.h>
#include <vtkXMLPolyDataReader.h>
#include <vtkXMLPolyDataWriter.h>
#include <vtkSmoothPolyDataFilter.h>
#include <vtkDoubleArray.h>
#include <vtkPointData.h>
#include <vtkPointLocator.h>
#include <vtkMath.h>
#include <cmath>
#include <set>
#include <sstream>
#include <algorithm>
#include <gmsh.h>

int main(int argc, char **argv)
{
  gmsh::initialize(argc, argv);
  gmsh::model::add("adaptive");
  gmsh::merge("/mnt/c/Users/hjy/Desktop/remesh/needRemsh.brep");

  vtkNew<vtkPolyData> poly_main;
  vtkNew<vtkXMLPolyDataReader> main_reader;
  std::string main_vessel_vtp = "/mnt/c/Users/hjy/Desktop/remesh/centerline.vtp";

  main_reader->SetFileName(main_vessel_vtp.c_str());
  main_reader->Update();
  poly_main->DeepCopy(main_reader->GetOutput());

  double dist_factor = 0, SizeMin = 0.005, SizeMax = 0.25, DistMin = 0, DistMax = 2, pt_undefined[3], pt_main[3];

  int main_poly_num = poly_main->GetNumberOfPoints();
  printf("main_vessel_vtp_num=%d\n", main_poly_num);
  vtkDataArray *radiusArray_main = poly_main->GetPointData()->GetArray("Radius");

  // Identify the closest point on the centerline
  vtkNew<vtkPointLocator> pt_locator_main;
  pt_locator_main->Initialize();
  pt_locator_main->SetDataSet(poly_main);
  pt_locator_main->BuildLocator();

  int index_pt_main_closetest;

  gmsh::option::setNumber("Mesh.MeshSizeMin", SizeMin);
  gmsh::option::setNumber("Mesh.MeshSizeMax", SizeMax);

  gmsh::model::geo::synchronize();

  auto meshSizeCallback = [&index_pt_main_closetest, &pt_locator_main, &pt_undefined, &poly_main, &dist_factor, &pt_main, &radiusArray_main, &SizeMax, &SizeMin, &DistMax, &DistMin](int dim, int tag, double x, double y, double z, double lc)
  {
    double pt_undefined[3] = {x, y, z};
    index_pt_main_closetest = pt_locator_main->FindClosestPoint(pt_undefined);
    poly_main->GetPoint(index_pt_main_closetest, pt_main);
    // if (dist_factor > sqrt(vtkMath::Distance2BetweenPoints(pt_undefined, pt_main)) / radiusArray_main->GetComponent(index_pt_main_closetest, 0))
    // {
    dist_factor = sqrt(vtkMath::Distance2BetweenPoints(pt_undefined, pt_main)) / radiusArray_main->GetComponent(index_pt_main_closetest, 0);
    // printf("pt_undefined[3] = {%.4lf, %.4lf, %.4lf}  and pt_main[3] = {%.4lf, %.4lf, %.4lf}\n", x, y, z, pt_main[0], pt_main[1], pt_main[2]);
    //  printf("dist_factor=距离(%.4lf)÷半径(%.4lf)=%.4lfand index_pt_main_closetest = %d\n", sqrt(vtkMath::Distance2BetweenPoints(pt_undefined, pt_main)), radiusArray_main->GetComponent(index_pt_main_closetest, 0), dist_factor, index_pt_main_closetest);
    // }
    // dist_factor = sqrt(vtkMath::Distance2BetweenPoints(pt_undefined, pt_main)) / radiusArray_main->GetComponent(index_pt_main_closetest, 0);
    if (dist_factor <= 1)
      return (SizeMax - SizeMin) / (DistMax - DistMin) * radiusArray_main->GetComponent(index_pt_main_closetest, 0) + SizeMin;
    else
      return (SizeMax - SizeMin) / (DistMax - DistMin) * radiusArray_main->GetComponent(index_pt_main_closetest, 0) * (pow(dist_factor - 1, 3.5) + dist_factor) + SizeMin;
      // return (SizeMax - SizeMin) / (DistMax - DistMin) * radiusArray_main->GetComponent(index_pt_main_closetest, 0) * (exp(3.3 * (dist_factor - 1.7)) + 0.9) + SizeMin;
    //  return (SizeMax - SizeMin) / (DistMax - DistMin) * radiusArray_main->GetComponent(index_pt_main_closetest, 0) * (pow(dist_factor - 0.6, 8) + 1) + SizeMin;
    // return (SizeMax - SizeMin) / (DistMax - DistMin) * radiusArray_main->GetComponent(index_pt_main_closetest, 0) * (2 * dist_factor - 1) + SizeMin;
  };
  gmsh::model::mesh::setSizeCallback(meshSizeCallback);

  // // To determine the size of mesh elements, Gmsh locally computes the minimum
  // // of
  // //
  // // 1) the size of the model bounding box;
  // // 2) if `Mesh.MeshSizeFromPoints' is set, the mesh size specified at
  // //    geometrical points;
  // // 3) if `Mesh.MeshSizeFromCurvature' is positive, the mesh size based on
  // //    curvature (the value specifying the number of elements per 2 * pi rad);
  // // 4) the background mesh size field;
  // // 5) any per-entity mesh size constraint;
  // //
  // // The value can then be further modified by the mesh size callback, if any,
  // // before being constrained in the interval [`Mesh.MeshSizeMin',
  // // `Mesh.MeshSizeMax'] and multiplied by `Mesh.MeshSizeFactor'. In addition,
  // // boundary mesh sizes are interpolated inside surfaces and/or volumes
  // // depending on the value of `Mesh.MeshSizeExtendFromBoundary' (which is set
  // // by default).
  // //
  // // When the element size is fully specified by a mesh size field (as it is in
  // // this example), it is thus often desirable to set

  // gmsh::option::setNumber("Mesh.MeshSizeExtendFromBoundary", 1);
  // gmsh::option::setNumber("Mesh.MeshSizeFromPoints", 1);
  // gmsh::option::setNumber("Mesh.MeshSizeFromCurvature", 1);

  gmsh::option::setNumber("Mesh.MeshSizeExtendFromBoundary", 0);
  gmsh::option::setNumber("Mesh.MeshSizeFromPoints", 0);
  gmsh::option::setNumber("Mesh.MeshSizeFromCurvature", 0);

  // This will prevent over-refinement due to small mesh sizes on the boundary.

  // Finally, while the default "Frontal-Delaunay" 2D meshing algorithm
  // (Mesh.Algorithm = 6) usually leads to the highest quality meshes, the
  // "Delaunay" algorithm (Mesh.Algorithm = 5) will handle complex mesh size
  // fields better - in particular size fields with large element size
  // gradients:

  gmsh::option::setNumber("Mesh.Algorithm", 6);

  gmsh::model::mesh::generate(3);
  gmsh::write("adaptive.msh");

  // Launch the GUI to see the results:
  // std::set<std::string> args(argv, argv + argc);
  // if(!args.count("-nopopup")) gmsh::fltk::run();

  gmsh::finalize();
  return 0;
}

// dist_factor=距离(1.1734)÷半径(0.6534)=1.7959and index_pt_main_closetest = 8806
// dist_factor=距离(2.5168)÷半径(1.6406)=1.5340and index_pt_main_closetest = 92
// dist_factor=距离(1.5460)÷半径(1.4868)=1.0398and index_pt_main_closetest = 43
// dist_factor=距离(1.5009)÷半径(1.4575)=1.0298and index_pt_main_closetest = 30
// dist_factor=距离(1.4984)÷半径(1.4575)=1.0280and index_pt_main_closetest = 30
// dist_factor=距离(1.4972)÷半径(1.4575)=1.0272and index_pt_main_closetest = 30
// dist_factor=距离(1.4966)÷半径(1.4575)=1.0268and index_pt_main_closetest = 30
// dist_factor=距离(1.4965)÷半径(1.4575)=1.0268and index_pt_main_closetest = 30
// dist_factor=距离(1.4965)÷半径(1.4575)=1.0268and index_pt_main_closetest = 30
// dist_factor=距离(1.4965)÷半径(1.4575)=1.0268and index_pt_main_closetest = 30
// dist_factor=距离(1.4965)÷半径(1.4575)=1.0268and index_pt_main_closetest = 30
// dist_factor=距离(1.4965)÷半径(1.4575)=1.0268and index_pt_main_closetest = 30
// dist_factor=距离(1.4965)÷半径(1.4575)=1.0268and index_pt_main_closetest = 30
// dist_factor=距离(1.4965)÷半径(1.4575)=1.0268and index_pt_main_closetest = 30
// dist_factor=距离(1.4965)÷半径(1.4575)=1.0268and index_pt_main_closetest = 30
// dist_factor=距离(1.6803)÷半径(1.6391)=1.0252and index_pt_main_closetest = 84
// dist_factor=距离(1.6270)÷半径(1.6010)=1.0162and index_pt_main_closetest = 68
// dist_factor=距离(1.6268)÷半径(1.6010)=1.0161and index_pt_main_closetest = 68
// dist_factor=距离(1.6267)÷半径(1.6010)=1.0161and index_pt_main_closetest = 68
// dist_factor=距离(1.6267)÷半径(1.6010)=1.0161and index_pt_main_closetest = 68
// dist_factor=距离(1.6267)÷半径(1.6010)=1.0161and index_pt_main_closetest = 68
// dist_factor=距离(1.6267)÷半径(1.6010)=1.0161and index_pt_main_closetest = 68
// dist_factor=距离(1.6267)÷半径(1.6010)=1.0161and index_pt_main_closetest = 68
// dist_factor=距离(1.6267)÷半径(1.6010)=1.0161and index_pt_main_closetest = 68
// dist_factor=距离(1.6473)÷半径(1.6215)=1.0159and index_pt_main_closetest = 75
// dist_factor=距离(1.6294)÷半径(1.6074)=1.0137and index_pt_main_closetest = 70
// dist_factor=距离(1.6293)÷半径(1.6074)=1.0136and index_pt_main_closetest = 70
// dist_factor=距离(1.6293)÷半径(1.6074)=1.0136and index_pt_main_closetest = 70
// dist_factor=距离(1.6293)÷半径(1.6074)=1.0136and index_pt_main_closetest = 70
// dist_factor=距离(1.6293)÷半径(1.6074)=1.0136and index_pt_main_closetest = 70
// dist_factor=距离(1.6394)÷半径(1.6190)=1.0126and index_pt_main_closetest = 74
// dist_factor=距离(1.6380)÷半径(1.6190)=1.0118and index_pt_main_closetest = 74
// dist_factor=距离(1.6380)÷半径(1.6190)=1.0118and index_pt_main_closetest = 74
// dist_factor=距离(1.6380)÷半径(1.6190)=1.0118and index_pt_main_closetest = 74
// dist_factor=距离(1.6380)÷半径(1.6190)=1.0118and index_pt_main_closetest = 74
// dist_factor=距离(1.6380)÷半径(1.6190)=1.0118and index_pt_main_closetest = 74
// dist_factor=距离(1.6380)÷半径(1.6190)=1.0118and index_pt_main_closetest = 74
// dist_factor=距离(1.6380)÷半径(1.6190)=1.0118and index_pt_main_closetest = 74
// dist_factor=距离(1.6380)÷半径(1.6190)=1.0118and index_pt_main_closetest = 74
// dist_factor=距离(1.6380)÷半径(1.6190)=1.0118and index_pt_main_closetest = 74
// Info    : [ 10%] Meshing curve 2 (BSpline)
// Info    : [ 10%] Meshing curve 3 (BSpline)
// Info    : [ 10%] Meshing curve 4 (BSpline)
// dist_factor=距离(0.1649)÷半径(0.1700)=0.9701and index_pt_main_closetest = 8772
// dist_factor=距离(0.1522)÷半径(0.1680)=0.9059and index_pt_main_closetest = 8771
// dist_factor=距离(0.1522)÷半径(0.1680)=0.9059and index_pt_main_closetest = 8771
// dist_factor=距离(0.1522)÷半径(0.1680)=0.9059and index_pt_main_closetest = 8771
// dist_factor=距离(0.1522)÷半径(0.1680)=0.9059and index_pt_main_closetest = 8771
// dist_factor=距离(0.1522)÷半径(0.1680)=0.9059and index_pt_main_closetest = 8771
// Info    : [ 10%] Meshing curve 5 (BSpline)
// dist_factor=距离(0.1603)÷半径(0.2050)=0.7823and index_pt_main_closetest = 544
// dist_factor=距离(0.1601)÷半径(0.2050)=0.7811and index_pt_main_closetest = 544
// dist_factor=距离(0.1600)÷半径(0.2050)=0.7804and index_pt_main_closetest = 544
// dist_factor=距离(0.1599)÷半径(0.2050)=0.7804and index_pt_main_closetest = 544
