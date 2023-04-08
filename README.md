# Preprocess
Finite element mesh pre-processing, including generation of adaptively sized meshes based on radius, and layered solid vascular wall meshes that also include local coordinate systems.

Environment configuration : gmsh and VTK(>=9.2.0)

\\10.16.2.199\M3C-Lab\LiuJ\osmsc_repository\adams_modified_models\0149_1001

brep ——> 3D slicer ——> centerline.vtp

brep + centerline    ___gmsh___    adaptive.cpp ——> adaptive.msh(3D or 2D(2D edges need to be classified))

defined the input and output surfaces and fluid domain(which should be done manually)
