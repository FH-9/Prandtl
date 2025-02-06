cmake_minimum_required(VERSION 3.15)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

#set(CMAKE_CXX_COMPILER ${MPICXX})
#set(MPI_CXX_INCLUDE_PATH "")
#set(MPI_CXX_LIBRARIES "")

# add_definitions(-DHYPERBOLIC)
add_definitions(-DUSE_FILTER)
add_definitions(-DPARABOLIC)

# # Add AddressSanitizer flags
# set(SANITIZER_FLAGS "-fsanitize=address -g -O1")

# # Apply sanitizer flags to compile and link phases
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${SANITIZER_FLAGS}")
# set(CMAKE_LINKER_FLAGS "${CMAKE_LINKER_FLAGS} ${SANITIZER_FLAGS}")

project(Prandtl)

find_package(MPI REQUIRED)
include_directories(${MPI_INCLUDE_PATH})
set(MPI_CXX_LIBRARIES ${MPI_CXX_LIBRARIES})

message(STATUS "MPI CXX COMPILER: ${MPI_CXX_COMPILER}")
message(STATUS "MPI INCLUDE PATH: ${MPI_INCLUDE_PATH}")
message(STATUS "MPI LIBRARIES: ${MPI_CXX_LIBRARIES}")

add_executable(${PROJECT_NAME} main.cpp)

target_sources(${PROJECT_NAME}
    PRIVATE src/Operators/DGOperator.cpp
    PRIVATE src/Operators/DGSEMOperator.cpp 
    PRIVATE src/Operators/DGFormIntegrator.cpp
    PRIVATE src/Operators/DGSEMIntegrator.cpp
    PRIVATE src/RiemannSolvers/RoeFlux.cpp
    PRIVATE src/RiemannSolvers/LaxFriedrichsFlux.cpp
    PRIVATE src/RiemannSolvers/HLLFlux.cpp
    PRIVATE src/RiemannSolvers/ChandrashekarFlux.cpp
    PRIVATE src/BasicOperations/BasicOperations.cpp
    PRIVATE src/Filters/EntropyFilter.cpp
    PRIVATE src/BoundaryConditions/BdrFaceIntegrator.cpp
    PRIVATE src/BoundaryConditions/NoSlipAdiabWallBdrFaceIntegrator.cpp
    PRIVATE src/BoundaryConditions/NoSlipIsothWallBdrFaceIntegrator.cpp
    PRIVATE src/BoundaryConditions/SpecifiedStateBdrFaceIntegrator.cpp
    PRIVATE src/BoundaryConditions/SlipWallBdrFaceIntegrator.cpp
    PRIVATE src/BoundaryConditions/RiemannInvariantBdrFaceIntegrator.cpp
    PRIVATE src/BoundaryConditions/SubsonicInflowPtTtAngBdrFaceIntegrator.cpp
    PRIVATE src/BoundaryConditions/SubsonicInflowRVBdrFaceIntegrator.cpp
    PRIVATE src/BoundaryConditions/SubsonicOutflowPBdrFaceIntegrator.cpp
    PRIVATE src/BoundaryConditions/SupersonicInflowBdrFaceIntegrator.cpp
    PRIVATE src/BoundaryConditions/SupersonicOutflowBdrFaceIntegrator.cpp
    PRIVATE src/Fluxes/NavierStokesFlux.cpp
    PRIVATE src/ModalBasis/ModalBasis.cpp
    PRIVATE src/ODESolvers/DGODESolver.cpp
    PRIVATE src/ODESolvers/RK3SSPExplicitSolver.cpp
    PRIVATE src/Limiters/MinmodLimiter.cpp
    PRIVATE src/Indicators/Indicator.cpp
    PRIVATE src/Indicators/PerssonPeraireIndicator.cpp
    PRIVATE src/Simulation/Simulation.cpp
    PRIVATE src/NonlinearForm/DGSEMNonlinearForm.cpp
    )

# add_subdirectory(${CMAKE_SOURCE_DIR}/libs/mfem-4.7)
# add_subdirectory(${CMAKE_SOURCE_DIR}/libs/hypre-2.31.0/src)
# add_subdirectory(${CMAKE_SOURCE_DIR}/libs/metis-5.1.0)



target_include_directories(${PROJECT_NAME}
    PUBLIC ${CMAKE_SOURCE_DIR}/libs/mfem
    PUBLIC ${CMAKE_SOURCE_DIR}/libs/hypre/src/hypre/include
    PUBLIC ${CMAKE_SOURCE_DIR}/libs/metis-5.1.0/include
    PUBLIC ${CMAKE_SOURCE_DIR}/src/Operators
    PUBLIC ${CMAKE_SOURCE_DIR}/src/RiemannSolvers
    PUBLIC ${CMAKE_SOURCE_DIR}/src/BasicOperations
    PUBLIC ${CMAKE_SOURCE_DIR}/src/Filters
    PUBLIC ${CMAKE_SOURCE_DIR}/src/BoundaryConditions
    PUBLIC ${CMAKE_SOURCE_DIR}/src/ModalBasis
    PUBLIC ${CMAKE_SOURCE_DIR}/src/Physics
    PUBLIC ${CMAKE_SOURCE_DIR}/src/ODESolvers
    PUBLIC ${CMAKE_SOURCE_DIR}/src/Limiters
    PUBLIC ${CMAKE_SOURCE_DIR}/src/Indicators
    PUBLIC ${CMAKE_SOURCE_DIR}/src/Simulation
    PUBLIC ${CMAKE_SOURCE_DIR}/src/Include
    PUBLIC ${CMAKE_SOURCE_DIR}/src/Fluxes
    PUBLIC ${CMAKE_SOURCE_DIR}/src/NonlinearForm
    )

target_link_directories(${PROJECT_NAME}
    PUBLIC ${CMAKE_SOURCE_DIR}/libs/mfem
    PUBLIC ${CMAKE_SOURCE_DIR}/libs/hypre/src/lib
    PUBLIC ${CMAKE_SOURCE_DIR}/libs/metis-5.1.0/lib
    )

target_link_libraries(${PROJECT_NAME} mfem HYPRE  metis MPI::MPI_CXX)


