cmake_minimum_required(VERSION 3.24)

project(CppTemplTests)

enable_testing()

find_package(GTest REQUIRED)
find_package(Threads REQUIRED)
find_package(spdlog REQUIRED)

add_executable(${PROJECT_NAME}
    CppTemplTests.cpp
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
    Threads::Threads
    spdlog::spdlog
    CppTempl::CppTempl
    GTest::gtest_main
)

target_include_directories(
    ${PROJECT_NAME}
    PRIVATE
)

include(GoogleTest)
gtest_discover_tests(${PROJECT_NAME})
