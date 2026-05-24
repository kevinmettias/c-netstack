CC := cc
CMAKE := cmake
CFLAGS := -std=c11 -Wall -Wextra -Wpedantic -Werror -Iarp/include -Icommon/include -Icompress/include -Idhcp/include -Idns/include -Ihttp/include -Irudp/include -Iserialize/include -Issh/include -Itcp/include -Itls/include -Itools/include -Iws/include
LDFLAGS :=
LDLIBS := -lcmocka

BUILD_DIR := build
CORE_SRC := arp/src/arp.c common/src/common.c compress/src/compress.c dhcp/src/dhcp.c dns/src/dns.c http/src/http.c rudp/src/rudp.c serialize/src/serialize.c ssh/src/ssh.c tcp/src/tcp.c tls/src/tls.c tools/src/tools.c ws/src/ws.c
TESTS := $(BUILD_DIR)/test_arp $(BUILD_DIR)/test_common $(BUILD_DIR)/test_compress $(BUILD_DIR)/test_dhcp $(BUILD_DIR)/test_dns $(BUILD_DIR)/test_http $(BUILD_DIR)/test_rudp $(BUILD_DIR)/test_serialize $(BUILD_DIR)/test_ssh $(BUILD_DIR)/test_tcp $(BUILD_DIR)/test_tls $(BUILD_DIR)/test_tools $(BUILD_DIR)/test_ws

.PHONY: all test clean dirs

all: dirs $(TESTS)

dirs:
	$(CMAKE) -E make_directory $(BUILD_DIR)
$(BUILD_DIR)/test_arp: $(CORE_SRC) arp/tests/test_arp.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) arp/tests/test_arp.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_common: $(CORE_SRC) common/tests/test_common.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) common/tests/test_common.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_compress: $(CORE_SRC) compress/tests/test_compress.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) compress/tests/test_compress.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_dhcp: $(CORE_SRC) dhcp/tests/test_dhcp.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) dhcp/tests/test_dhcp.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_dns: $(CORE_SRC) dns/tests/test_dns.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) dns/tests/test_dns.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_http: $(CORE_SRC) http/tests/test_http.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) http/tests/test_http.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_rudp: $(CORE_SRC) rudp/tests/test_rudp.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) rudp/tests/test_rudp.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_serialize: $(CORE_SRC) serialize/tests/test_serialize.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) serialize/tests/test_serialize.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_ssh: $(CORE_SRC) ssh/tests/test_ssh.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) ssh/tests/test_ssh.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_tcp: $(CORE_SRC) tcp/tests/test_tcp.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) tcp/tests/test_tcp.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_tls: $(CORE_SRC) tls/tests/test_tls.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) tls/tests/test_tls.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_tools: $(CORE_SRC) tools/tests/test_tools.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) tools/tests/test_tools.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_ws: $(CORE_SRC) ws/tests/test_ws.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) ws/tests/test_ws.c -o $@ $(LDFLAGS) $(LDLIBS)
test: $(TESTS)
	$(BUILD_DIR)/test_arp
	$(BUILD_DIR)/test_common
	$(BUILD_DIR)/test_compress
	$(BUILD_DIR)/test_dhcp
	$(BUILD_DIR)/test_dns
	$(BUILD_DIR)/test_http
	$(BUILD_DIR)/test_rudp
	$(BUILD_DIR)/test_serialize
	$(BUILD_DIR)/test_ssh
	$(BUILD_DIR)/test_tcp
	$(BUILD_DIR)/test_tls
	$(BUILD_DIR)/test_tools
	$(BUILD_DIR)/test_ws

clean:
	rm -rf $(BUILD_DIR)
