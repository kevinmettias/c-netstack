cmake_minimum_required(VERSION 3.20)

project(c_netstack C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(ENABLE_COVERAGE "Build with gcov/lcov coverage instrumentation" OFF)
option(ENABLE_ASAN "Build with AddressSanitizer instrumentation" OFF)
option(ENABLE_UBSAN "Build with UndefinedBehaviorSanitizer instrumentation" OFF)

find_package(cmocka CONFIG QUIET)
if(cmocka_FOUND)
    if(TARGET cmocka::cmocka)
        set(CMOCKA_TARGET cmocka::cmocka)
    else()
        set(CMOCKA_TARGET cmocka)
    endif()
else()
    find_library(CMOCKA_TARGET cmocka REQUIRED)
endif()

add_library(c_netstack_core
    arp/src/arp.c
    common/src/common.c
    compress/src/compress.c
    dhcp/src/dhcp.c
    dns/src/dns.c
    http/src/http.c
    rudp/src/rudp.c
    serialize/src/serialize.c
    ssh/src/ssh.c
    tcp/src/tcp.c
    tls/src/tls.c
    tools/src/tools.c
    ws/src/ws.c
)
target_include_directories(c_netstack_core PUBLIC
    arp/include
    common/include
    compress/include
    dhcp/include
    dns/include
    http/include
    rudp/include
    serialize/include
    ssh/include
    tcp/include
    tls/include
    tools/include
    ws/include
)

if(MSVC)
    target_compile_options(c_netstack_core PRIVATE /W4 /WX)
else()
    target_compile_options(c_netstack_core PRIVATE -Wall -Wextra -Wpedantic -Werror)
endif()

if(ENABLE_COVERAGE)
    if(CMAKE_C_COMPILER_ID MATCHES "GNU|Clang")
        target_compile_options(c_netstack_core PRIVATE --coverage -O0 -g)
        target_link_options(c_netstack_core PUBLIC --coverage)
    else()
        message(FATAL_ERROR "ENABLE_COVERAGE requires GCC or Clang")
    endif()
endif()

if(ENABLE_ASAN)
    if(CMAKE_C_COMPILER_ID MATCHES "GNU|Clang")
        target_compile_options(c_netstack_core PUBLIC -fsanitize=address -fno-omit-frame-pointer -O1 -g)
        target_link_options(c_netstack_core PUBLIC -fsanitize=address)
    else()
        message(FATAL_ERROR "ENABLE_ASAN requires GCC or Clang")
    endif()
endif()

if(ENABLE_UBSAN)
    if(CMAKE_C_COMPILER_ID MATCHES "GNU|Clang")
        target_compile_options(c_netstack_core PUBLIC -fsanitize=undefined -fno-omit-frame-pointer -O1 -g)
        target_link_options(c_netstack_core PUBLIC -fsanitize=undefined)
    else()
        message(FATAL_ERROR "ENABLE_UBSAN requires GCC or Clang")
    endif()
endif()

enable_testing()
add_executable(test_arp arp/tests/test_arp.c)
target_link_libraries(test_arp PRIVATE c_netstack_core ${CMOCKA_TARGET})
add_test(NAME test_arp COMMAND test_arp)
add_executable(test_common common/tests/test_common.c)
target_link_libraries(test_common PRIVATE c_netstack_core ${CMOCKA_TARGET})
add_test(NAME test_common COMMAND test_common)
add_executable(test_compress compress/tests/test_compress.c)
target_link_libraries(test_compress PRIVATE c_netstack_core ${CMOCKA_TARGET})
add_test(NAME test_compress COMMAND test_compress)
add_executable(test_dhcp dhcp/tests/test_dhcp.c)
target_link_libraries(test_dhcp PRIVATE c_netstack_core ${CMOCKA_TARGET})
add_test(NAME test_dhcp COMMAND test_dhcp)
add_executable(test_dns dns/tests/test_dns.c)
target_link_libraries(test_dns PRIVATE c_netstack_core ${CMOCKA_TARGET})
add_test(NAME test_dns COMMAND test_dns)
add_executable(test_http http/tests/test_http.c)
target_link_libraries(test_http PRIVATE c_netstack_core ${CMOCKA_TARGET})
add_test(NAME test_http COMMAND test_http)
add_executable(test_rudp rudp/tests/test_rudp.c)
target_link_libraries(test_rudp PRIVATE c_netstack_core ${CMOCKA_TARGET})
add_test(NAME test_rudp COMMAND test_rudp)
add_executable(test_serialize serialize/tests/test_serialize.c)
target_link_libraries(test_serialize PRIVATE c_netstack_core ${CMOCKA_TARGET})
add_test(NAME test_serialize COMMAND test_serialize)
add_executable(test_ssh ssh/tests/test_ssh.c)
target_link_libraries(test_ssh PRIVATE c_netstack_core ${CMOCKA_TARGET})
add_test(NAME test_ssh COMMAND test_ssh)
add_executable(test_tcp tcp/tests/test_tcp.c)
target_link_libraries(test_tcp PRIVATE c_netstack_core ${CMOCKA_TARGET})
add_test(NAME test_tcp COMMAND test_tcp)
add_executable(test_tls tls/tests/test_tls.c)
target_link_libraries(test_tls PRIVATE c_netstack_core ${CMOCKA_TARGET})
add_test(NAME test_tls COMMAND test_tls)
add_executable(test_tools tools/tests/test_tools.c)
target_link_libraries(test_tools PRIVATE c_netstack_core ${CMOCKA_TARGET})
add_test(NAME test_tools COMMAND test_tools)
add_executable(test_ws ws/tests/test_ws.c)
target_link_libraries(test_ws PRIVATE c_netstack_core ${CMOCKA_TARGET})
add_test(NAME test_ws COMMAND test_ws)
