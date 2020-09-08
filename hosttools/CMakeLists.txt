project(HostBuild)

include(FetchContent)
set(protobuf_BUILD_TESTS OFF)
set(protobuf_BUILD_CONFORMANCE OFF)
set(protobuf_BUILD_EXPORT OFF)
set(protobuf_BUILD_EXAMPLES OFF)
set(protobuf_MSVC_STATIC_RUNTIME OFF)
FetchContent_Declare(
    host_protobuf
    GIT_REPOSITORY "https://github.com/protocolbuffers/protobuf.git"
    GIT_TAG "v3.12.2"
    SOURCE_SUBDIR cmake)
FetchContent_MakeAvailable(host_protobuf)

export(TARGETS protoc NAMESPACE hostprotoc:: FILE hostprotoc.cmake)
