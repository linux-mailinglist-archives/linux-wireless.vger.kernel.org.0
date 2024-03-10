Return-Path: <linux-wireless+bounces-4523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1F28774D4
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Mar 2024 02:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823D41F21368
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Mar 2024 01:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE1023A8;
	Sun, 10 Mar 2024 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdh411CY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FEE23A7
	for <linux-wireless@vger.kernel.org>; Sun, 10 Mar 2024 01:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710034825; cv=none; b=FEyEWwAXk8tFqKW/v9GUO4BA+OAbsit4g/TxsW/OMNd9PxrpcNnQLoj61FVWIhLXilOn5mUCI7IV5sRB3ddhJxS1gRpsxZNjtfQksaBa9BQI9WqtVpAXa5WabKJ6U88bAbk/5nwG5ErCfD+JYJZbIO7AoRbJ3PRaYQAvAlPVHkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710034825; c=relaxed/simple;
	bh=JHyLcMoeg/5e+DV16zRYvCaSAuvj4NBhBxQe/rdH2jo=;
	h=Message-ID:From:Date:To:Subject; b=rwUJKQFN6x7mGwQ2m8pM27xDH3bjSc1+ApLX6ZozVb1Zak9a3DZfjIOMm1GYP9PKfmqNMvwQXGC34qY0SCEfnD9CJiVa4vfYH8ct27abpe4rhRhIanudaMpSIqKb9e7vzQbq6czkyRXAHCimUgTIVO4+XNNsDXxbFq0wsxP3Vj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qdh411CY; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d3f962a9dfso20572661fa.1
        for <linux-wireless@vger.kernel.org>; Sat, 09 Mar 2024 17:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710034818; x=1710639618; darn=vger.kernel.org;
        h=subject:to:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1pDVYrOSwr8QPN+Vg/6+9Nw3jiN4IYO/aSJtbmo0qI=;
        b=Qdh411CYIpLEXvGPe9QepKevvzXMyFI3C2NK9h31Qgtt8Dyfe6w363fcNhOegc6FcB
         8bBetJ4I42Qdld3oLL6OZBYfkzmkG/ZHUCd8uk9kkDtWLD3NoYXtr4TvAnwQAnDqgwwc
         RDOqp6cOuxeZmCFysLO374mw3WxmggVhRDGrYr3XAYyvruW4bCESokc0xq3U+P1tCiOE
         Fky1W7HXIBiUsRZDvL6/xIEzcPulPcuIE0hs+LK7Uh//FU0nJ5JVOXmxK09GgJTGyt74
         AGCJ8KMaKGMUPy6X2L7fVut9uuwQaXBwLo8lHaZEHwj/9u19h+AX3K/vXg2KKIYg8dq0
         jaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710034818; x=1710639618;
        h=subject:to:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1pDVYrOSwr8QPN+Vg/6+9Nw3jiN4IYO/aSJtbmo0qI=;
        b=Fvu87TeLYRpv8XJBsGp7nBy5GBaHrDJ5kWTNnbwd4dshlaExzdvJDXgBbXdhuXZcPD
         AiRbWDJ1YUo7FUdaTG3yAG+TbYCmvkeqj3NJ/Q2oIjZUrjELUNhN69+hlGFGgmSNyhe+
         Qiqa/6aF6ZQv77bAewBq5PdPVKjFyvbpiALnuH5D++vrNeJ1KtcZs3Yr2xk9VEoc0BVI
         6ilKL5uYPF6xgZzEoBV1RHurba74qvXgRwtnVb5KsvdkX8uP6FTS6kwcdXM9iMNGdyBp
         23GExFsoTKZT1bguU5aVAlQBFcIuw+rOI9hGn+nVenDAf5jiJLHPaCV91NWwCAw+NxxE
         pnBg==
X-Forwarded-Encrypted: i=1; AJvYcCUpKVOAa9uTfK/64Vbj+iuS6ulQgN+u9e60A7JQXEqRLux+sG0qiRoGT7Bzu3xyaA/m5ZuCtrHEENsenBPAQMyhWEtII8kKHQAo6TkctKk=
X-Gm-Message-State: AOJu0YwcrTil/mW+DmNhKDYpidt7FIRNZ/yVbaLU1p54waWUm+Q5kI3E
	WvDVag7uGWWv9AWWqpWdG0JjAOptjN0qPsRA5XSSc1ChOH/UfWpstZxh4Acs7dmSSQ==
X-Google-Smtp-Source: AGHT+IGwQ3hUwBcWV3KTcxEcnvwlyPkQOJfomC5ntvZjgaTmoCDpBPh/+3g3GJ+Szsv6rAdXI1Cwtw==
X-Received: by 2002:a2e:9dcf:0:b0:2d4:e9c:e20f with SMTP id x15-20020a2e9dcf000000b002d40e9ce20fmr1699797ljj.48.1710034816736;
        Sat, 09 Mar 2024 17:40:16 -0800 (PST)
Received: from localhost (nat-inorg.chem.msu.ru. [93.180.12.29])
        by smtp.gmail.com with ESMTPSA id s11-20020a05651c048b00b002d435b7da40sm72028ljc.38.2024.03.09.17.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 17:40:15 -0800 (PST)
Message-ID: <c215a93a66d88e9bc20c6b67c1461400.legale.legale@gmail.com>
From: Isaev Ruslan <legale.legale@gmail.com>
Date: Sun, 10 Mar 2024 04:21:20 +0300
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Subject: [PATCH v8] Add JSON output options to 'iw' for scan results
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

v8 changes:
- json_print.c rewritten.
- all printf() calls to print iw scan info replaced with new
iw_printf()

example text output:
root@ru-fap650-a3:/tmp# ./iw phy0-ap0 scan | head -n 30
00:0c:43:26:60:18:
        ifname: phy0-ap0
        status:
        TSF:
                usec: 278491388966
                dd: 3
                hh: 5
                mm: 21
                ss: 31
        freq: 5180
        beacon_interval_tus: 100
        capability:
                ESS
                Privacy
                ShortPreamble
        capability_raw: 0x0031
        signal: -78.00 dBm
        last_seen_ms_ago: 2540
        bss_probe_resp_data_frame:
                SSID:
                        SSID: tobe52
                Supported rates:
                        rates:
                                6.0*
                                9.0
                                12.0*
                                18.0
                                24.0*
                                36.0
                                48.0
root@ru-fap650-a3:/tmp#

example pretty json output:
root@ru-fap650-a3:/tmp# ./iw -jj phy0-ap0 scan | head -n 30
{
    "00:0c:43:26:60:18": {
        "ifname": "phy0-ap0",
        "status": "",
        "TSF": {
            "usec": 278643858296,
            "dd": 3,
            "hh": 5,
            "mm": 24,
            "ss": 3
        },
        "freq": 5180,
        "beacon_interval_tus": 100,
        "capability": [ "ESS","Privacy","ShortPreamble" ],
        "capability_raw": "0x0031",
        "signal": "-77.00 dBm",
        "last_seen_ms_ago": 2740,
        "bss_probe_resp_data_frame": {
            "SSID": {
                "SSID": "tobe52"
            },
            "Supported rates": {
                "rates": [ "6.0*","9.0","12.0*","18.0","24.0*","36.0","48.0","54.0" ]
            },

v7 changes:
- binaries json/a json/a.out removed

v6 changes:
- add iw_printf(const char *key, const char *fmt, ...)
- rewrite print_ssid_escaped() as a demo with new concept

void print_ssid_escaped(const uint8_t len, const uint8_t *data) {
	char *escaped_ssid = ssid_escape(len, data);
	iw_printf("SSID", "%s", escaped_ssid);
}

How it works:
	text output:
Tabs for text output is based on json depth. For example: ssid is depth 3
or something so 3 tabs will be printed before "SSID: %s"

	json output:
iw_printf will print number (without "") or text based on passed format.

For all number formats. Formats:  %d %i %p %hu etc will print without quotes
If else format is passed iw_print will print it with quotes. To make it work
some new functions added.

branch: v5.19

This commit introduces the ability to output scan results from 'iw' in
JSON format, similar to the 'ip' utility from the iproute2 package.
The addition aims to enhance the tool's usability and scriptability
by providing a structured data format option.

Two new command-line options are added:
- '-j': Outputs scan results in compact JSON format.
- '-jj': Outputs scan results in pretty-printed JSON format.

The implementation focuses on modifying the printing functions to format
the output as JSON without altering the existing netlink
response parsing logic. This patch demonstrates the concept with scan
results, showcasing the potential for expanding JSON support
to other 'iw' functionalities.

If these changes prove valuable, I am prepared to continue working on
extending JSON output support throughout the tool.
Feedback is welcome and appreciated.

Thank you.

Signed-off-by: Isaev Ruslan <legale.legale@gmail.com>
---
 Makefile             |    2 +-
 iw.c                 |   27 +-
 json/Makefile        |   19 +
 json/iw_json_print.c |  221 ++++++++
 json/iw_json_print.h |   35 ++
 json/iw_json_printer |  Bin 0 -> 28112 bytes
 json/json_writer.c   |  298 +++++++++++
 json/json_writer.h   |   76 +++
 json/main.c          |   49 ++
 scan.c               | 1187 ++++++++++++++++++++----------------------
 util.c               |  333 +++++++-----
 11 files changed, 1508 insertions(+), 739 deletions(-)
 create mode 100644 json/Makefile
 create mode 100644 json/iw_json_print.c
 create mode 100644 json/iw_json_print.h
 create mode 100755 json/iw_json_printer
 create mode 100644 json/json_writer.c
 create mode 100644 json/json_writer.h
 create mode 100644 json/main.c

diff --git a/Makefile b/Makefile
index 2fb8db8..9b73f4b 100644
--- a/Makefile
+++ b/Makefile
@@ -19,7 +19,7 @@ CFLAGS += -Werror-implicit-function-declaration -Wsign-compare -Wno-unused-param
 CFLAGS += -Wdeclaration-after-statement
 CFLAGS += $(CFLAGS_EVAL)
 
-_OBJS := $(sort $(patsubst %.c,%.o,$(wildcard *.c)))
+_OBJS := $(sort $(patsubst %.c,%.o,$(wildcard *.c) json/json_writer.c json/iw_json_print.c))
 VERSION_OBJS := $(filter-out version.o, $(_OBJS))
 OBJS := $(VERSION_OBJS) version.o
 
diff --git a/iw.c b/iw.c
index 35308ba..98541fd 100644
--- a/iw.c
+++ b/iw.c
@@ -24,6 +24,8 @@
 #include "nl80211.h"
 #include "iw.h"
 
+#include "json/iw_json_print.h"
+
 /* libnl 1.x compatibility code */
 #if !defined(CONFIG_LIBNL20) && !defined(CONFIG_LIBNL30)
 static inline struct nl_handle *nl_socket_alloc(void)
@@ -181,7 +183,11 @@ static void __usage_cmd(const struct cmd *cmd, char *indent, bool full)
 static void usage_options(void)
 {
 	printf("Options:\n");
-	printf("\t--debug\t\tenable netlink debugging\n");
+	printf(""
+	"\t--debug\t\tenable netlink debugging\n"
+	"\t-j     \t\tjson output\n"
+	"\t-jj    \t\tjson pretty output\n"
+	"");
 }
 
 static const char *argv0;
@@ -592,6 +598,21 @@ int main(int argc, char **argv)
 		argv++;
 	}
 
+	if (argc > 0 && strcmp(*argv, "-j") == 0) {
+		json_obj_new(1, 0); //pretty print disabled
+		argc--;
+		argv++;
+	}
+
+	if (argc > 0 && strcmp(*argv, "-jj") == 0) {
+		json_obj_new(1, 1); //pretty print enabled
+		argc--;
+		argv++;
+	}
+
+	//call json_obj_new() anyway to track depth
+	if (!iw_json) json_obj_new(0, 0);
+
 	if (argc > 0 && strcmp(*argv, "--version") == 0) {
 		version();
 		return 0;
@@ -648,5 +669,9 @@ int main(int argc, char **argv)
 
 	nl80211_cleanup(&nlstate);
 
+	//close root json object and deinit jsonw
+	if(iw_json){
+		json_obj_del();
+	}
 	return err;
 }
diff --git a/json/Makefile b/json/Makefile
new file mode 100644
index 0000000..d7b0858
--- /dev/null
+++ b/json/Makefile
@@ -0,0 +1,19 @@
+CC = gcc
+CFLAGS = -Wall -Wextra -Iinclude
+
+SRC_DIR = .
+OBJ_DIR = .
+
+SRC_FILES = $(wildcard $(SRC_DIR)/*.c)
+OBJ_FILES = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC_FILES))
+
+all: iw_json_printer
+
+$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
+	$(CC) $(CFLAGS) -c $< -o $@
+
+iw_json_printer: $(OBJ_FILES)
+	$(CC) $(CFLAGS) $^ -o $@
+
+clean:
+	rm -f $(OBJ_DIR)/*.o iw_json_printer
diff --git a/json/iw_json_print.c b/json/iw_json_print.c
new file mode 100644
index 0000000..998a8eb
--- /dev/null
+++ b/json/iw_json_print.c
@@ -0,0 +1,221 @@
+/*
+* iw_json_print.c 
+* print text or json output, based on json_writer and json_print
+* License: BSD-2-CLAUSE
+*/
+#include "iw_json_print.h"
+#include <assert.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+
+int iw_json = 0;
+
+static json_writer_t *_jw;
+void json_obj_new(int json, bool is_pretty) {
+	iw_json = json;
+	_jw = jsonw_new(stdout);
+	if (!_jw) {
+		perror("json object");
+		exit(1);
+	}
+	jsonw_pretty(_jw, is_pretty);
+	if(iw_json) jsonw_start_object(_jw);
+}
+void json_obj_del(void) {
+	if (_jw) {
+		if(iw_json) jsonw_end_object(_jw);
+		jsonw_destroy(&_jw);
+	}
+}
+
+json_writer_t *get_json_writer(void) {
+	return _jw;
+}
+void json_obj_open(const char *fmt, ...) {
+	char buf[1024];
+	va_list args;
+	va_start(args, fmt);
+	vsnprintf(buf, sizeof(buf), fmt, args);
+	if(!iw_json){
+		//tab intend based on json depth
+		for (unsigned i = 0; i < _jw->depth; i++) {
+			printf("\t");
+		}
+		printf("%s:\n", (*buf != '\0') ? buf : "object");
+		++_jw->depth;
+	} else {
+		if(*buf != '\0') jsonw_name(_jw, buf);
+		jsonw_start_object(_jw);
+	}
+
+	va_end(args);
+}
+
+void json_obj_close(void) {
+	if(iw_json){
+		jsonw_end_object(_jw);
+	}else{
+		assert(_jw->depth > 0);
+		--_jw->depth;
+	}
+}
+
+void json_arr_open(const char *fmt, ...) {
+	char buf[1024];
+	va_list args;
+	va_start(args, fmt);
+	vsnprintf(buf, sizeof(buf), fmt, args);
+	// if not empty
+	assert(buf);
+	if(!iw_json){
+		//tab intend based on json depth
+		for (unsigned i = 0; i < _jw->depth; i++) {
+			printf("\t");
+		}
+		printf("%s:\n", (*buf != '\0') ? buf : "array");
+		++_jw->depth;
+	} else {
+		if(*buf != '\0') jsonw_name(_jw, buf);
+		jsonw_start_array(_jw);
+	}
+
+	va_end(args);
+}
+
+void json_arr_close() {
+	if(iw_json){
+		jsonw_end_array(_jw);
+	}else{
+		assert(_jw->depth > 0);
+		--_jw->depth;
+	}
+}
+
+#define _PRINT_FUNC(type_name, type)                       \
+void json_print_##type_name(const char *key, type value) {      \
+		if (!key)                                          \
+			jsonw_##type_name(_jw, value);                 \
+		else                                               \
+			jsonw_##type_name##_field(_jw, key, value);    \
+}
+
+_PRINT_FUNC(u8, uint8_t);
+_PRINT_FUNC(u16, uint16_t);
+_PRINT_FUNC(u32, uint32_t);
+_PRINT_FUNC(u64, uint64_t);
+_PRINT_FUNC(s8, int8_t);
+_PRINT_FUNC(s16, int16_t);
+_PRINT_FUNC(s32, int32_t);
+_PRINT_FUNC(s64, int64_t);
+_PRINT_FUNC(int, int);
+_PRINT_FUNC(uint, unsigned int);
+_PRINT_FUNC(float, double);
+_PRINT_FUNC(bool, bool);
+#undef _PRINT_FUNC
+
+void json_print_string(const char *key, const char *fmt, ...) {
+	va_list args;
+	va_start(args, fmt);
+
+	char buf[1024];
+	vsnprintf(buf, sizeof(buf), fmt, args);
+	if (key) {
+		jsonw_string_field(_jw, key, buf);
+	} else {
+		jsonw_string(_jw, buf);
+	}
+
+	va_end(args);
+}
+
+void json_print_num(const char *key, const char *fmt, ...) {
+	va_list args;
+	va_start(args, fmt);
+
+	char buffer[1024];
+	vsnprintf(buffer, sizeof(buffer), fmt, args);
+	if (key) {
+		jsonw_num_field(_jw, key, buffer);
+	} else {
+		jsonw_num(_jw, buffer);
+	}
+
+	va_end(args);
+}
+
+enum format_type {
+	FORMAT_STRING,
+	FORMAT_NUMBER
+};
+
+// all number formats
+const char* num_formats[] = {
+  "%d",         // 4 bytes - int
+  "%i",         // 4 bytes - int
+  "%u",         // 4 bytes - unsigned int
+  "%f",         // 4 bytes - float
+  "%lf",        // 8 bytes - double
+  "%e",         // 4 bytes - float
+  "%E",         // 4 bytes - float
+  "%g",         // 4 bytes - float
+  "%G",         // 4 bytes - float
+  "%ld",        // 4 bytes - long int
+  "%li",        // 4 bytes - long int
+  "%lu",        // 4 bytes - unsigned long int
+  "%lld",       // 8 bytes - long long int
+  "%lli",       // 8 bytes - long long int
+  "%llu",       // 8 bytes - unsigned long long int
+  "%hhd",       // 1 byte - signed char
+  "%hhi",       // 1 byte - signed char
+  "%hhu",       // 1 byte - unsigned char
+  "%hd",        // 2 bytes - short int
+  "%hi",        // 2 bytes - short int
+  "%hu",        // 2 bytes - unsigned short int
+  "%Lf",        // 16 bytes - long double
+  "%zd",        // varies by system - size_t
+  "%zi",        // varies by system - ssize_t
+  "%zu",        // varies by system - size_t
+  "%p"          // varies by system - pointer
+};
+
+#define MAX_FORMAT_TYPE sizeof(num_formats) / sizeof(num_formats[0])
+static enum format_type get_format_type(const char* fmt) {
+	for (unsigned i = 0; i < MAX_FORMAT_TYPE; i++) {
+		if (strcmp(fmt, num_formats[i]) == 0) {
+			return FORMAT_NUMBER;
+		}
+	}
+	return FORMAT_STRING;
+}
+
+void iw_printf(const char *key, const char *fmt, ...) {
+	va_list args;
+	static char buf[1024];
+	va_start(args, fmt);
+	vsnprintf(buf, sizeof(buf), fmt, args);
+	va_end(args);
+
+
+	enum format_type type = get_format_type(fmt);
+
+	if (iw_json) {
+		switch (type) {
+			case FORMAT_NUMBER:
+				json_print_num(key, "%s", buf);
+				break;
+			case FORMAT_STRING:
+			default:
+				json_print_string(key, "%s", buf);
+				break;
+		}
+	} else {
+		//tab intend based on json depth
+		for (unsigned i = 0; i < _jw->depth; i++) {
+			printf("\t");
+		}
+		key ? printf("%s: %s\n", key, buf) : printf("%s\n", buf);
+	}
+}
\ No newline at end of file
diff --git a/json/iw_json_print.h b/json/iw_json_print.h
new file mode 100644
index 0000000..7542624
--- /dev/null
+++ b/json/iw_json_print.h
@@ -0,0 +1,35 @@
+#ifndef _JSON_PRINT_H_
+#define _JSON_PRINT_H_
+#include "json_writer.h"
+
+extern int iw_json;
+
+json_writer_t *get_json_writer(void);
+
+void json_obj_new(int json, bool is_pretty);
+void json_obj_del(void);
+void json_obj_open(const char *fmt, ...);
+void json_obj_close(void);
+void json_arr_open(const char *fmt, ...);
+void json_arr_close(void);
+
+#define _PRINT_FUNC(type_name, type)         \
+	void json_print_##type_name(const char *key, type value)
+_PRINT_FUNC(u8, uint8_t);
+_PRINT_FUNC(u16, uint16_t);
+_PRINT_FUNC(u32, uint32_t);
+_PRINT_FUNC(u64, uint64_t);
+_PRINT_FUNC(s8, int8_t);
+_PRINT_FUNC(s16, int16_t);
+_PRINT_FUNC(s32, int32_t);
+_PRINT_FUNC(s64, int64_t);
+_PRINT_FUNC(int, int);
+_PRINT_FUNC(float, double);
+_PRINT_FUNC(bool, bool);
+#undef _PRINT_FUNC
+
+void json_print_string(const char *key, const char *fmt, ...);
+void json_print_num(const char *key, const char *fmt, ...);
+void iw_printf(const char *key, const char *fmt, ...);
+
+#endif /* _JSON_PRINT_H_ */
diff --git a/json/iw_json_printer b/json/iw_json_printer
new file mode 100755
index 0000000000000000000000000000000000000000..9511de64fe0289ce88af5fd74f307d131d04d424
GIT binary patch
literal 28112
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
Kw<*|)#(x2X{U8ni

literal 0
HcmV?d00001

diff --git a/json/json_writer.c b/json/json_writer.c
new file mode 100644
index 0000000..79e49b9
--- /dev/null
+++ b/json/json_writer.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) //
+/*
+ * Simple streaming JSON writer
+ *
+ * This takes care of the annoying bits of JSON syntax like the commas
+ * after elements
+ *
+ * Authors:	Stephen Hemminger <stephen@networkplumber.org>
+ */
+#include "json_writer.h"
+#include <assert.h>
+#include <inttypes.h>
+#include <malloc.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+
+/* indentation for pretty print */
+static void jsonw_indent(json_writer_t *self) {
+	unsigned int i;
+	for (i = 0; i < self->depth; ++i)
+		fputs("    ", self->out);
+}
+/* end current line and indent if pretty printing */
+static void jsonw_eol(json_writer_t *self) {
+	if (!self->pretty)
+		return;
+	putc('\n', self->out);
+	jsonw_indent(self);
+}
+/* If current object is not empty print a comma */
+static void jsonw_eor(json_writer_t *self) {
+	if (self->sep != '\0')
+		putc(self->sep, self->out);
+	self->sep = ',';
+}
+/* Output JSON encoded string */
+/* Handles C escapes, does not do Unicode */
+static void jsonw_puts(json_writer_t *self, const char *str) {
+	putc('"', self->out);
+	for (; *str; ++str)
+		switch (*str) {
+		case '\t':
+			fputs("\\t", self->out);
+			break;
+		case '\n':
+			fputs("\\n", self->out);
+			break;
+		case '\r':
+			fputs("\\r", self->out);
+			break;
+		case '\f':
+			fputs("\\f", self->out);
+			break;
+		case '\b':
+			fputs("\\b", self->out);
+			break;
+		case '\\':
+			fputs("\\\\", self->out);
+			break;
+		case '"':
+			fputs("\\\"", self->out);
+			break;
+		case '\'':
+			fputs("\\\'", self->out);
+			break;
+		default:
+			putc(*str, self->out);
+		}
+	putc('"', self->out);
+}
+/* Create a new JSON stream */
+json_writer_t *jsonw_new(FILE *f) {
+	json_writer_t *self = malloc(sizeof(*self));
+	if (self) {
+		self->out = f;
+		self->depth = 0;
+		self->pretty = false;
+		self->sep = '\0';
+	}
+	return self;
+}
+/* End output to JSON stream */
+void jsonw_destroy(json_writer_t **self_p) {
+	json_writer_t *self = *self_p;
+	assert(self->depth == 0);
+	fputs("\n", self->out);
+	fflush(self->out);
+	free(self);
+	*self_p = NULL;
+}
+void jsonw_pretty(json_writer_t *self, bool on) {
+	self->pretty = on;
+}
+/* Basic blocks */
+static void jsonw_begin(json_writer_t *self, int c) {
+	jsonw_eor(self);
+	putc(c, self->out);
+	++self->depth;
+	self->sep = '\0';
+}
+static void jsonw_end(json_writer_t *self, int c) {
+	assert(self->depth > 0);
+	--self->depth;
+	if (self->sep != '\0')
+		jsonw_eol(self);
+	putc(c, self->out);
+	self->sep = ',';
+}
+/* Add a JSON property name */
+void jsonw_name(json_writer_t *self, const char *name) {
+	jsonw_eor(self);
+	jsonw_eol(self);
+	self->sep = '\0';
+	jsonw_puts(self, name);
+	putc(':', self->out);
+	if (self->pretty)
+		putc(' ', self->out);
+}
+__attribute__((format(printf, 2, 3))) void jsonw_printf(json_writer_t *self, const char *fmt, ...) {
+	va_list ap;
+	va_start(ap, fmt);
+	jsonw_eor(self);
+	vfprintf(self->out, fmt, ap);
+	va_end(ap);
+}
+/* Collections */
+void jsonw_start_object(json_writer_t *self) {
+	jsonw_begin(self, '{');
+}
+void jsonw_end_object(json_writer_t *self) {
+	jsonw_end(self, '}');
+}
+void jsonw_start_array(json_writer_t *self) {
+	jsonw_begin(self, '[');
+	if (self->pretty)
+		putc(' ', self->out);
+}
+void jsonw_end_array(json_writer_t *self) {
+	if (self->pretty && self->sep)
+		putc(' ', self->out);
+	self->sep = '\0';
+	jsonw_end(self, ']');
+}
+/* JSON value types */
+void jsonw_string(json_writer_t *self, const char *value) {
+	jsonw_eor(self);
+	jsonw_puts(self, value);
+}
+void jsonw_num(json_writer_t *self, const char *value) {
+	jsonw_printf(self, "%s", value);
+}
+void jsonw_bool(json_writer_t *self, bool val) {
+	jsonw_printf(self, "%s", val ? "true" : "false");
+}
+void jsonw_null(json_writer_t *self) {
+	jsonw_printf(self, "null");
+}
+void jsonw_float(json_writer_t *self, double num) {
+	jsonw_printf(self, "%g", num);
+}
+void jsonw_int(json_writer_t *self, int num) {
+	jsonw_printf(self, "%d", num);
+}
+void jsonw_uint(json_writer_t *self, unsigned int num) {
+	jsonw_printf(self, "%u", num);
+}
+void jsonw_xint(json_writer_t *self, uint64_t num) {
+	jsonw_printf(self, "%" PRIx64, num);
+}
+void jsonw_u8(json_writer_t *self, uint8_t num) {
+	jsonw_printf(self, "%hhu", num);
+}
+void jsonw_u16(json_writer_t *self, uint16_t num) {
+	jsonw_printf(self, "%hu", num);
+}
+void jsonw_u32(json_writer_t *self, uint32_t num) {
+	jsonw_printf(self, "%u", num);
+}
+void jsonw_u64(json_writer_t *self, uint64_t num) {
+	jsonw_printf(self, "%" PRIu64, num);
+}
+void jsonw_s8(json_writer_t *self, int8_t num) {
+	jsonw_printf(self, "%hhu", num);
+}
+void jsonw_s16(json_writer_t *self, int16_t num) {
+	jsonw_printf(self, "%hu", num);
+}
+void jsonw_s32(json_writer_t *self, int32_t num) {
+	jsonw_printf(self, "%u", num);
+}
+void jsonw_s64(json_writer_t *self, int64_t num) {
+	jsonw_printf(self, "%" PRId64, num);
+}
+/* Basic name/value objects */
+void jsonw_string_field(json_writer_t *self, const char *prop, const char *val) {
+	jsonw_name(self, prop);
+	jsonw_string(self, val);
+}
+void jsonw_num_field(json_writer_t *self, const char *prop, const char *val) {
+	jsonw_name(self, prop);
+	jsonw_num(self, val);
+}
+void jsonw_bool_field(json_writer_t *self, const char *prop, bool val) {
+	jsonw_name(self, prop);
+	jsonw_bool(self, val);
+}
+void jsonw_null_field(json_writer_t *self, const char *prop) {
+	jsonw_name(self, prop);
+	jsonw_null(self);
+}
+void jsonw_float_field(json_writer_t *self, const char *prop, double val) {
+	jsonw_name(self, prop);
+	jsonw_float(self, val);
+}
+void jsonw_int_field(json_writer_t *self, const char *prop, int num) {
+	jsonw_name(self, prop);
+	jsonw_int(self, num);
+}
+void jsonw_uint_field(json_writer_t *self, const char *prop, unsigned int num) {
+	jsonw_name(self, prop);
+	jsonw_uint(self, num);
+}
+void jsonw_xint_field(json_writer_t *self, const char *prop, uint64_t num) {
+	jsonw_name(self, prop);
+	jsonw_xint(self, num);
+}
+void jsonw_u8_field(json_writer_t *self, const char *prop, uint8_t num) {
+	jsonw_name(self, prop);
+	jsonw_u8(self, num);
+}
+void jsonw_u16_field(json_writer_t *self, const char *prop, uint16_t num) {
+	jsonw_name(self, prop);
+	jsonw_u16(self, num);
+}
+void jsonw_u32_field(json_writer_t *self, const char *prop, uint32_t num) {
+	jsonw_name(self, prop);
+	jsonw_u32(self, num);
+}
+void jsonw_u64_field(json_writer_t *self, const char *prop, uint64_t num) {
+	jsonw_name(self, prop);
+	jsonw_u64(self, num);
+}
+void jsonw_s8_field(json_writer_t *self, const char *prop, int8_t num) {
+	jsonw_name(self, prop);
+	jsonw_s8(self, num);
+}
+void jsonw_s16_field(json_writer_t *self, const char *prop, int16_t num) {
+	jsonw_name(self, prop);
+	jsonw_s16(self, num);
+}
+void jsonw_s32_field(json_writer_t *self, const char *prop, int32_t num) {
+	jsonw_name(self, prop);
+	jsonw_s32(self, num);
+}
+void jsonw_s64_field(json_writer_t *self, const char *prop, int64_t num) {
+	jsonw_name(self, prop);
+	jsonw_s64(self, num);
+}
+#ifdef TEST
+int main(int argc, char **argv) {
+	json_writer_t *wr = jsonw_new(stdout);
+	jsonw_start_object(wr);
+	jsonw_pretty(wr, true);
+	jsonw_name(wr, "Vyatta");
+	jsonw_start_object(wr);
+	jsonw_string_field(wr, "url", "http://vyatta.com");
+	jsonw_uint_field(wr, "downloads", 2000000ul);
+	jsonw_float_field(wr, "stock", 8.16);
+	jsonw_name(wr, "ARGV");
+	jsonw_start_array(wr);
+	while (--argc)
+		jsonw_string(wr, *++argv);
+	jsonw_end_array(wr);
+	jsonw_name(wr, "empty");
+	jsonw_start_array(wr);
+	jsonw_end_array(wr);
+	jsonw_name(wr, "NIL");
+	jsonw_start_object(wr);
+	jsonw_end_object(wr);
+	jsonw_null_field(wr, "my_null");
+	jsonw_name(wr, "special chars");
+	jsonw_start_array(wr);
+	jsonw_string_field(wr, "slash", "/");
+	jsonw_string_field(wr, "newline", "\n");
+	jsonw_string_field(wr, "tab", "\t");
+	jsonw_string_field(wr, "ff", "\f");
+	jsonw_string_field(wr, "quote", "\"");
+	jsonw_string_field(wr, "tick", "\'");
+	jsonw_string_field(wr, "backslash", "\\");
+	jsonw_end_array(wr);
+	jsonw_end_object(wr);
+	jsonw_end_object(wr);
+	jsonw_destroy(&wr);
+	return 0;
+}
+#endif
diff --git a/json/json_writer.h b/json/json_writer.h
new file mode 100644
index 0000000..b19ab91
--- /dev/null
+++ b/json/json_writer.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
+/*
+ * Simple streaming JSON writer
+ *
+ * This takes care of the annoying bits of JSON syntax like the commas
+ * after elements
+ *
+ * Authors:	Stephen Hemminger <stephen@networkplumber.org>
+ */
+#ifndef _JSON_WRITER_H_
+#define _JSON_WRITER_H_
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+/* Opaque class structure */
+typedef struct json_writer {
+	FILE *out;					/* output file */
+	unsigned int depth; 		/* nesting */
+	bool pretty;				/* optional whitepace */
+	char sep;					/* either nul or comma */
+} json_writer_t;
+
+/* Create a new JSON stream */
+json_writer_t *jsonw_new(FILE *f);
+/* End output to JSON stream */
+void jsonw_destroy(json_writer_t **self_p);
+/* Cause output to have pretty whitespace */
+void jsonw_pretty(json_writer_t *self, bool on);
+/* Add property name */
+void jsonw_name(json_writer_t *self, const char *name);
+/* Add value  */
+__attribute__((format(printf, 2, 3))) void jsonw_printf(json_writer_t *self, const char *fmt, ...);
+void jsonw_float_fmt(json_writer_t *self, const char *fmt, double num);
+
+void jsonw_string(json_writer_t *self, const char *value);
+void jsonw_num(json_writer_t *self, const char *value);
+void jsonw_bool(json_writer_t *self, bool val);
+void jsonw_null(json_writer_t *self);
+void jsonw_float(json_writer_t *self, double num);
+void jsonw_int(json_writer_t *self, int num);
+void jsonw_uint(json_writer_t *self, unsigned int);
+void jsonw_xint(json_writer_t *self, uint64_t num);
+void jsonw_u8(json_writer_t *self, uint8_t num);
+void jsonw_u16(json_writer_t *self, uint16_t num);
+void jsonw_u32(json_writer_t *self, uint32_t num);
+void jsonw_u64(json_writer_t *self, uint64_t num);
+void jsonw_s8(json_writer_t *self, int8_t num);
+void jsonw_s16(json_writer_t *self, int16_t num);
+void jsonw_s32(json_writer_t *self, int32_t num);
+void jsonw_s64(json_writer_t *self, int64_t num);
+
+/* Useful Combinations of name and value */
+void jsonw_string_field(json_writer_t *self, const char *prop, const char *val);
+void jsonw_num_field(json_writer_t *self, const char *prop, const char *val);
+void jsonw_bool_field(json_writer_t *self, const char *prop, bool value);
+void jsonw_null_field(json_writer_t *self, const char *prop);
+void jsonw_float_field(json_writer_t *self, const char *prop, double num);
+void jsonw_int_field(json_writer_t *self, const char *prop, int num);
+void jsonw_uint_field(json_writer_t *self, const char *prop, unsigned int num);
+void jsonw_xint_field(json_writer_t *self, const char *prop, uint64_t num);
+void jsonw_u8_field(json_writer_t *self, const char *prop, unsigned char num);
+void jsonw_u16_field(json_writer_t *self, const char *prop, uint16_t num);
+void jsonw_u32_field(json_writer_t *self, const char *prop, uint32_t num);
+void jsonw_u64_field(json_writer_t *self, const char *prop, uint64_t num);
+void jsonw_s8_field(json_writer_t *self, const char *prop, int8_t num);
+void jsonw_s16_field(json_writer_t *self, const char *prop, int16_t num);
+void jsonw_s32_field(json_writer_t *self, const char *prop, int32_t num);
+void jsonw_s64_field(json_writer_t *self, const char *prop, int64_t num);
+/* Collections */
+void jsonw_start_object(json_writer_t *self);
+void jsonw_end_object(json_writer_t *self);
+void jsonw_start_array(json_writer_t *self);
+void jsonw_end_array(json_writer_t *self);
+/* Override default exception handling */
+typedef void(jsonw_err_handler_fn)(const char *);
+#endif /* _JSON_WRITER_H_ */
diff --git a/json/main.c b/json/main.c
new file mode 100644
index 0000000..c6683a9
--- /dev/null
+++ b/json/main.c
@@ -0,0 +1,49 @@
+#include <stdio.h>
+#include <stdint.h>
+
+#include "iw_json_print.h"
+
+
+int main() {
+    // init json print without pretty print
+	printf("compact json\n");
+	json_obj_new(1, 0);
+	json_obj_open("tx");
+	json_print_u8("bytes", 255);
+	json_print_u32("packets", 65536);
+	json_print_s32("errors", 65536);
+	json_print_u64("dropped", 1);
+    json_arr_open("hobbies"); // create object entry hobbies with array
+    json_print_string(NULL, "%s", "Reading");
+    json_print_string(NULL, "%s", "Hiking");
+    json_print_string(NULL, "%s", "Coding");
+	json_arr_close();
+	json_obj_close();
+
+    json_obj_del();
+
+	printf("text output\n");
+	json_obj_new(0, 0);
+	iw_printf("k1", "%s", "Sleeping");
+    iw_printf("k2", "%u", 1241);
+	json_arr_open("my_array");
+	iw_printf(NULL, "%s", "Sleeping");
+    iw_printf(NULL, "%u", 1241);
+	json_arr_close();
+    json_obj_del();
+
+	printf("json pretty print\n");
+	json_obj_new(1, 1);
+	iw_printf("k1", "%s", "Sleeping");
+    iw_printf("k2", "%llu", 432425435435345435);
+	json_arr_open("my_array");
+	iw_printf(NULL, "%s", "Walking");
+    iw_printf(NULL, "%u", 1241);
+	json_arr_close();
+    json_obj_del();
+
+
+
+    return 0;
+}
+
diff --git a/scan.c b/scan.c
index dfc136a..470e79b 100644
--- a/scan.c
+++ b/scan.c
@@ -12,6 +12,8 @@
 #include "nl80211.h"
 #include "iw.h"
 
+#include "json/iw_json_print.h"
+
 #define WLAN_CAPABILITY_ESS		(1<<0)
 #define WLAN_CAPABILITY_IBSS		(1<<1)
 #define WLAN_CAPABILITY_CF_POLLABLE	(1<<2)
@@ -544,14 +546,6 @@ static int handle_scan(struct nl80211_state *state,
 	return err;
 }
 
-static void tab_on_first(bool *first)
-{
-	if (!*first)
-		printf("\t");
-	else
-		*first = false;
-}
-
 struct print_ies_data {
 	unsigned char *ie;
 	int ielen;
@@ -560,9 +554,7 @@ struct print_ies_data {
 static void print_ssid(const uint8_t type, uint8_t len, const uint8_t *data,
 		       const struct print_ies_data *ie_buffer)
 {
-	printf(" ");
-	print_ssid_escaped(len, data);
-	printf("\n");
+		print_ssid_escaped(len, data);
 }
 
 #define BSS_MEMBERSHIP_SELECTOR_VHT_PHY 126
@@ -574,21 +566,18 @@ static void print_supprates(const uint8_t type, uint8_t len,
 {
 	int i;
 
-	printf(" ");
-
+	json_arr_open("rates");
 	for (i = 0; i < len; i++) {
 		int r = data[i] & 0x7f;
-
-		if (r == BSS_MEMBERSHIP_SELECTOR_VHT_PHY && data[i] & 0x80)
-			printf("VHT");
-		else if (r == BSS_MEMBERSHIP_SELECTOR_HT_PHY && data[i] & 0x80)
-			printf("HT");
-		else
-			printf("%d.%d", r/2, 5*(r&1));
-
-		printf("%s ", data[i] & 0x80 ? "*" : "");
+		if (r == BSS_MEMBERSHIP_SELECTOR_VHT_PHY && data[i] & 0x80){
+			iw_printf(NULL, "VHT%s", data[i] & 0x80 ? "*" : "");
+		} else if (r == BSS_MEMBERSHIP_SELECTOR_HT_PHY && data[i] & 0x80){
+			iw_printf(NULL, "HT%s", data[i] & 0x80 ? "*" : "");
+		} else {
+			iw_printf(NULL, "%d.%d%s", r/2, 5*(r&1), data[i] & 0x80 ? "*" : "");
+		}
 	}
-	printf("\n");
+	json_arr_close();
 }
 
 static void print_rm_enabled_capabilities(const uint8_t type, uint8_t len,
@@ -601,16 +590,14 @@ static void print_rm_enabled_capabilities(const uint8_t type, uint8_t len,
 		     ((__u64) data[3]) << 24 |
 		     ((__u64) data[4]) << 32;
 
-	printf("\n");
-	printf("\t\tCapabilities: 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
-							     data[0], data[1],
-							     data[2], data[3],
-							     data[4]);
+	iw_printf("capabilities_raw", "0x%02x 0x%02x 0x%02x 0x%02x 0x%02x", data[0], data[1], data[2], data[3], data[4]);
+	json_arr_open("capabilities");
+
 
 #define PRINT_RM_CAPA(_bit, _str) \
 	do { \
 		if (capa & BIT(_bit)) \
-			printf("\t\t\t" _str "\n"); \
+			iw_printf(NULL, _str); \
 	} while (0)
 
 	PRINT_RM_CAPA(0, "Link Measurement");
@@ -642,14 +629,16 @@ static void print_rm_enabled_capabilities(const uint8_t type, uint8_t len,
 	PRINT_RM_CAPA(34, "FTM Range Report");
 	PRINT_RM_CAPA(35, "Civic Location Measurement");
 
-	printf("\t\tNonoperating Channel Max Measurement Duration: %i\n", data[3] >> 5);
-	printf("\t\tMeasurement Pilot Capability: %i\n", data[4] & 7);
+	json_arr_close();
+	iw_printf("nonoperating_channel_max_measurement_duration", "%d", data[3] >> 5);
+	iw_printf("measurement_pilot_capability", "%d", data[4] & 7);
+
 }
 
 static void print_ds(const uint8_t type, uint8_t len, const uint8_t *data,
 		     const struct print_ies_data *ie_buffer)
 {
-	printf(" channel %d\n", data[0]);
+	iw_printf("channel", "%d", data[0]);
 }
 
 static const char *country_env_str(char environment)
@@ -669,28 +658,27 @@ static const char *country_env_str(char environment)
 static void print_country(const uint8_t type, uint8_t len, const uint8_t *data,
 			  const struct print_ies_data *ie_buffer)
 {
-	printf(" %.*s", 2, data);
-
-	printf("\tEnvironment: %s\n", country_env_str(data[2]));
+	iw_printf("country", "%.*s", 2, data);
+	iw_printf("environment", "%s", country_env_str(data[2]));
 
 	data += 3;
 	len -= 3;
 
 	if (len < 3) {
-		printf("\t\tNo country IE triplets present\n");
+		iw_printf("no_country_ie_triplets_present", "%s", "true");
 		return;
 	}
 
+	json_obj_open("channels");
 	while (len >= 3) {
 		int end_channel;
 		union ieee80211_country_ie_triplet *triplet = (void *) data;
 
 		if (triplet->ext.reg_extension_id >= IEEE80211_COUNTRY_EXTENSION_ID) {
-			printf("\t\tExtension ID: %d Regulatory Class: %d Coverage class: %d (up to %dm)\n",
-			       triplet->ext.reg_extension_id,
-			       triplet->ext.reg_class,
-			       triplet->ext.coverage_class,
-			       triplet->ext.coverage_class * 450);
+			iw_printf("extension id", "%d", triplet->ext.reg_extension_id);
+			iw_printf("regulatory class", "%d", triplet->ext.reg_class);
+			iw_printf("coverage class", "%d", triplet->ext.coverage_class);
+			iw_printf("coverage class up to", "%d", triplet->ext.coverage_class * 450);
 
 			data += 3;
 			len -= 3;
@@ -703,11 +691,15 @@ static void print_country(const uint8_t type, uint8_t len, const uint8_t *data,
 		else
 			end_channel =  triplet->chans.first_channel + (4 * (triplet->chans.num_channels - 1));
 
-		printf("\t\tChannels [%d - %d] @ %d dBm\n", triplet->chans.first_channel, end_channel, triplet->chans.max_power);
-
+		json_obj_open("%d", triplet->chans.first_channel);
+		iw_printf("first", "%d", triplet->chans.first_channel);
+		iw_printf("end", "%d", end_channel);
+		iw_printf("max power dbm", "%d", triplet->chans.max_power);
+		json_obj_close();
 		data += 3;
 		len -= 3;
 	}
+	json_obj_close();
 
 	return;
 }
@@ -716,29 +708,27 @@ static void print_powerconstraint(const uint8_t type, uint8_t len,
 				  const uint8_t *data,
 				  const struct print_ies_data *ie_buffer)
 {
-	printf(" %d dB\n", data[0]);
+	iw_printf("db", "%d", data[0]);
 }
 
 static void print_tpcreport(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
 			    const struct print_ies_data *ie_buffer)
 {
-	printf(" TX power: %d dBm\n", data[0]);
-	/* printf(" Link Margin (%d dB) is reserved in Beacons\n", data[1]); */
+	iw_printf("tx_power_dbm", "%d", data[0]);
 }
 
 static void print_erp(const uint8_t type, uint8_t len, const uint8_t *data,
 		      const struct print_ies_data *ie_buffer)
 {
 	if (data[0] == 0x00)
-		printf(" <no flags>");
+		iw_printf("no_flags", "%s", "true");
 	if (data[0] & 0x01)
-		printf(" NonERP_Present");
+		iw_printf("nonerp_present", "%s", "true");
 	if (data[0] & 0x02)
-		printf(" Use_Protection");
+		iw_printf("use_protection", "%s", "true");
 	if (data[0] & 0x04)
-		printf(" Barker_Preamble_Mode");
-	printf("\n");
+		iw_printf("barker_preamble_mode", "%s", "true");
 }
 
 static void print_ap_channel_report(const uint8_t type, uint8_t len, const uint8_t *data,
@@ -747,13 +737,13 @@ static void print_ap_channel_report(const uint8_t type, uint8_t len, const uint8
 	uint8_t oper_class = data[0];
 	int i;
 
-	printf("\n");
-	printf("\t\t * operating class: %d\n", oper_class);
-	printf("\t\t * channel(s):");
+	iw_printf("operating_class", "%d", oper_class);
+	json_arr_open("channels");
 	for (i = 1; i < len; ++i) {
-		printf(" %d", data[i]);
+		iw_printf(NULL, "%d", data[i]);
 	}
-	printf("\n");
+	json_arr_close();
+
 }
 
 static void print_cipher(const uint8_t *data)
@@ -761,59 +751,56 @@ static void print_cipher(const uint8_t *data)
 	if (memcmp(data, ms_oui, 3) == 0) {
 		switch (data[3]) {
 		case 0:
-			printf("Use group cipher suite");
+			iw_printf(NULL, "Use group cipher suite");
 			break;
 		case 1:
-			printf("WEP-40");
+			iw_printf(NULL, "WEP-40");
 			break;
 		case 2:
-			printf("TKIP");
+			iw_printf(NULL, "TKIP");
 			break;
 		case 4:
-			printf("CCMP");
+			iw_printf(NULL, "CCMP");
 			break;
 		case 5:
-			printf("WEP-104");
+			iw_printf(NULL, "WEP-104");
 			break;
 		default:
-			printf("%.02x-%.02x-%.02x:%d",
-				data[0], data[1] ,data[2], data[3]);
+			iw_printf(NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 			break;
 		}
 	} else if (memcmp(data, ieee80211_oui, 3) == 0) {
 		switch (data[3]) {
 		case 0:
-			printf("Use group cipher suite");
+			iw_printf(NULL, "Use group cipher suite");
 			break;
 		case 1:
-			printf("WEP-40");
+			iw_printf(NULL, "WEP-40");
 			break;
 		case 2:
-			printf("TKIP");
+			iw_printf(NULL, "TKIP");
 			break;
 		case 4:
-			printf("CCMP");
+			iw_printf(NULL, "CCMP");
 			break;
 		case 5:
-			printf("WEP-104");
+			iw_printf(NULL, "WEP-104");
 			break;
 		case 6:
-			printf("AES-128-CMAC");
+			iw_printf(NULL, "AES-128-CMAC");
 			break;
 		case 7:
-			printf("NO-GROUP");
+			iw_printf(NULL, "NO-GROUP");
 			break;
 		case 8:
-			printf("GCMP");
+			iw_printf(NULL, "GCMP");
 			break;
 		default:
-			printf("%.02x-%.02x-%.02x:%d",
-				data[0], data[1] ,data[2], data[3]);
+			iw_printf(NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 			break;
 		}
 	} else
-		printf("%.02x-%.02x-%.02x:%d",
-			data[0], data[1] ,data[2], data[3]);
+		iw_printf(NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 }
 
 static void print_auth(const uint8_t *data)
@@ -821,127 +808,117 @@ static void print_auth(const uint8_t *data)
 	if (memcmp(data, ms_oui, 3) == 0) {
 		switch (data[3]) {
 		case 1:
-			printf("IEEE 802.1X");
+			iw_printf(NULL, "IEEE 802.1X");
 			break;
 		case 2:
-			printf("PSK");
+			iw_printf(NULL, "PSK");
 			break;
 		default:
-			printf("%.02x-%.02x-%.02x:%d",
-				data[0], data[1] ,data[2], data[3]);
+			iw_printf(NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 			break;
 		}
 	} else if (memcmp(data, ieee80211_oui, 3) == 0) {
 		switch (data[3]) {
 		case 1:
-			printf("IEEE 802.1X");
+			iw_printf(NULL, "IEEE 802.1X");
 			break;
 		case 2:
-			printf("PSK");
+			iw_printf(NULL, "PSK");
 			break;
 		case 3:
-			printf("FT/IEEE 802.1X");
+			iw_printf(NULL, "FT/IEEE 802.1X");
 			break;
 		case 4:
-			printf("FT/PSK");
+			iw_printf(NULL, "FT/PSK");
 			break;
 		case 5:
-			printf("IEEE 802.1X/SHA-256");
+			iw_printf(NULL, "IEEE 802.1X/SHA-256");
 			break;
 		case 6:
-			printf("PSK/SHA-256");
+			iw_printf(NULL, "PSK/SHA-256");
 			break;
 		case 7:
-			printf("TDLS/TPK");
+			iw_printf(NULL, "TDLS/TPK");
 			break;
 		case 8:
-			printf("SAE");
+			iw_printf(NULL, "SAE");
 			break;
 		case 9:
-			printf("FT/SAE");
+			iw_printf(NULL, "FT/SAE");
 			break;
 		case 11:
-			printf("IEEE 802.1X/SUITE-B");
+			iw_printf(NULL, "IEEE 802.1X/SUITE-B");
 			break;
 		case 12:
-			printf("IEEE 802.1X/SUITE-B-192");
+			iw_printf(NULL, "IEEE 802.1X/SUITE-B-192");
 			break;
 		case 13:
-			printf("FT/IEEE 802.1X/SHA-384");
+			iw_printf(NULL, "FT/IEEE 802.1X/SHA-384");
 			break;
 		case 14:
-			printf("FILS/SHA-256");
+			iw_printf(NULL, "FILS/SHA-256");
 			break;
 		case 15:
-			printf("FILS/SHA-384");
+			iw_printf(NULL, "FILS/SHA-384");
 			break;
 		case 16:
-			printf("FT/FILS/SHA-256");
+			iw_printf(NULL, "FT/FILS/SHA-256");
 			break;
 		case 17:
-			printf("FT/FILS/SHA-384");
+			iw_printf(NULL, "FT/FILS/SHA-384");
 			break;
 		case 18:
-			printf("OWE");
+			iw_printf(NULL, "OWE");
 			break;
 		default:
-			printf("%.02x-%.02x-%.02x:%d",
-				data[0], data[1] ,data[2], data[3]);
+			iw_printf(NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 			break;
 		}
 	} else if (memcmp(data, wfa_oui, 3) == 0) {
 		switch (data[3]) {
 		case 1:
-			printf("OSEN");
+			iw_printf(NULL, "OSEN");
 			break;
 		case 2:
-			printf("DPP");
+			iw_printf(NULL, "DPP");
 			break;
 		default:
-			printf("%.02x-%.02x-%.02x:%d",
-				data[0], data[1] ,data[2], data[3]);
+			iw_printf(NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 			break;
 		}
 	} else
-		printf("%.02x-%.02x-%.02x:%d",
-			data[0], data[1] ,data[2], data[3]);
+		iw_printf(NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 }
 
 static void _print_rsn_ie(const char *defcipher, const char *defauth,
 			  uint8_t len, const uint8_t *data, int is_osen)
 {
-	bool first = true;
 	__u16 count, capa;
 	int i;
 
 	if (!is_osen) {
 		__u16 version;
 		version = data[0] + (data[1] << 8);
-		tab_on_first(&first);
-		printf("\t * Version: %d\n", version);
-
+		iw_printf("version", "%d", version);
 		data += 2;
 		len -= 2;
 	}
 
 	if (len < 4) {
-		tab_on_first(&first);
-		printf("\t * Group cipher: %s\n", defcipher);
-		printf("\t * Pairwise ciphers: %s\n", defcipher);
+		iw_printf("group_cipher", "%s", defcipher);
+		iw_printf("Pairwise ciphers", "%s", defcipher);
 		return;
 	}
 
-	tab_on_first(&first);
-	printf("\t * Group cipher: ");
+	json_arr_open("group_cipher_data");
 	print_cipher(data);
-	printf("\n");
+	json_arr_close();
 
 	data += 4;
 	len -= 4;
 
 	if (len < 2) {
-		tab_on_first(&first);
-		printf("\t * Pairwise ciphers: %s\n", defcipher);
+		iw_printf("pairwise_ciphers", "%s", defcipher);
 		return;
 	}
 
@@ -949,20 +926,17 @@ static void _print_rsn_ie(const char *defcipher, const char *defauth,
 	if (2 + (count * 4) > len)
 		goto invalid;
 
-	tab_on_first(&first);
-	printf("\t * Pairwise ciphers:");
+	json_arr_open("pairwise_ciphers_data");
 	for (i = 0; i < count; i++) {
-		printf(" ");
 		print_cipher(data + 2 + (i * 4));
 	}
-	printf("\n");
+	json_arr_close();
 
 	data += 2 + (count * 4);
 	len -= 2 + (count * 4);
 
 	if (len < 2) {
-		tab_on_first(&first);
-		printf("\t * Authentication suites: %s\n", defauth);
+		iw_printf("authentication_suites", "%s", defauth);
 		return;
 	}
 
@@ -970,66 +944,66 @@ static void _print_rsn_ie(const char *defcipher, const char *defauth,
 	if (2 + (count * 4) > len)
 		goto invalid;
 
-	tab_on_first(&first);
-	printf("\t * Authentication suites:");
+	json_arr_open("authentication_suites_data");
 	for (i = 0; i < count; i++) {
-		printf(" ");
 		print_auth(data + 2 + (i * 4));
 	}
-	printf("\n");
+	json_arr_close();
 
 	data += 2 + (count * 4);
 	len -= 2 + (count * 4);
 
 	if (len >= 2) {
 		capa = data[0] | (data[1] << 8);
-		tab_on_first(&first);
-		printf("\t * Capabilities:");
+		iw_printf("capabilities_raw", "0x%.4x", capa);
+
+		json_arr_open("capabilities");
 		if (capa & 0x0001)
-			printf(" PreAuth");
+			iw_printf(NULL, "PreAuth");
 		if (capa & 0x0002)
-			printf(" NoPairwise");
+			iw_printf(NULL, "NoPairwise");
 		switch ((capa & 0x000c) >> 2) {
 		case 0:
-			printf(" 1-PTKSA-RC");
+			iw_printf(NULL, "1-PTKSA-RC");
 			break;
 		case 1:
-			printf(" 2-PTKSA-RC");
+			iw_printf(NULL, "2-PTKSA-RC");
 			break;
 		case 2:
-			printf(" 4-PTKSA-RC");
+			iw_printf(NULL, "4-PTKSA-RC");
 			break;
 		case 3:
-			printf(" 16-PTKSA-RC");
+			iw_printf(NULL, "16-PTKSA-RC");
 			break;
 		}
 		switch ((capa & 0x0030) >> 4) {
 		case 0:
-			printf(" 1-GTKSA-RC");
+			iw_printf(NULL, "1-GTKSA-RC");
 			break;
 		case 1:
-			printf(" 2-GTKSA-RC");
+			iw_printf(NULL, "2-GTKSA-RC");
 			break;
 		case 2:
-			printf(" 4-GTKSA-RC");
+			iw_printf(NULL, "4-GTKSA-RC");
 			break;
 		case 3:
-			printf(" 16-GTKSA-RC");
+			iw_printf(NULL, "16-GTKSA-RC");
 			break;
 		}
 		if (capa & 0x0040)
-			printf(" MFP-required");
+			iw_printf(NULL, "MFP-required");
 		if (capa & 0x0080)
-			printf(" MFP-capable");
+			iw_printf(NULL, "MFP-capable");
 		if (capa & 0x0200)
-			printf(" Peerkey-enabled");
+			iw_printf(NULL, "Peerkey-enabled");
 		if (capa & 0x0400)
-			printf(" SPP-AMSDU-capable");
+			iw_printf(NULL, "SPP-AMSDU-capable");
 		if (capa & 0x0800)
-			printf(" SPP-AMSDU-required");
+			iw_printf(NULL, "SPP-AMSDU-required");
 		if (capa & 0x2000)
-			printf(" Extended-Key-ID");
-		printf(" (0x%.4x)\n", capa);
+			iw_printf(NULL, "Extended-Key-ID");
+		json_arr_close();
+
 		data += 2;
 		len -= 2;
 	}
@@ -1038,8 +1012,7 @@ static void _print_rsn_ie(const char *defcipher, const char *defauth,
 		int pmkid_count = data[0] | (data[1] << 8);
 
 		if (len >= 2 + 16 * pmkid_count) {
-			tab_on_first(&first);
-			printf("\t * %d PMKIDs\n", pmkid_count);
+			iw_printf("pmkids_count", "%d", pmkid_count);
 			/* not printing PMKID values */
 			data += 2 + 16 * pmkid_count;
 			len -= 2 + 16 * pmkid_count;
@@ -1048,23 +1021,23 @@ static void _print_rsn_ie(const char *defcipher, const char *defauth,
 	}
 
 	if (len >= 4) {
-		tab_on_first(&first);
-		printf("\t * Group mgmt cipher suite: ");
+		json_arr_open("group_mgmt_cipher_suite_data");
 		print_cipher(data);
-		printf("\n");
+		json_arr_close();
 		data += 4;
 		len -= 4;
 	}
 
  invalid:
 	if (len != 0) {
-		printf("\t\t * bogus tail data (%d):", len);
+		iw_printf("bogus_tail_data_len", "%d", len);
+		json_arr_open("bogus_tail_data");
 		while (len) {
-			printf(" %.2x", *data);
+			iw_printf(NULL, "%.2x", *data);
 			data++;
 			len--;
 		}
-		printf("\n");
+		json_arr_close();
 	}
 }
 
@@ -1090,7 +1063,6 @@ static void print_rsn(const uint8_t type, uint8_t len, const uint8_t *data,
 static void print_ht_capa(const uint8_t type, uint8_t len, const uint8_t *data,
 			  const struct print_ies_data *ie_buffer)
 {
-	printf("\n");
 	print_ht_capability(data[0] | (data[1] << 8));
 	print_ampdu_length(data[2] & 3);
 	print_ampdu_spacing((data[2] >> 2) & 7);
@@ -1206,47 +1178,46 @@ static void print_11u_rcon(const uint8_t type, uint8_t len, const uint8_t *data,
 	int ln0 = data[1] & 0xf;
 	int ln1 = ((data[1] & 0xf0) >> 4);
 	int ln2 = 0;
-	printf("\n");
 
 	if (ln1)
 		ln2 = len - 2 - ln0 - ln1;
 
-	printf("\t\tANQP OIs: %i\n", data[0]);
+	iw_printf("ANQP OIs", "%i", data[0]);
 
 	if (ln0 > 0) {
-		printf("\t\tOI 1: ");
+		json_arr_open("OI 1");
 		if (2 + ln0 > len) {
-			printf("Invalid IE length.\n");
+			iw_printf(NULL, "Invalid IE length", "len: %d 2+ln0: %d", len, 2 + ln0);
 		} else {
 			for (idx = 0; idx < ln0; idx++) {
-				printf("%02hhx", data[2 + idx]);
+				iw_printf(NULL, "%02hhx", data[2 + idx]);
 			}
-			printf("\n");
 		}
+		json_arr_close();
 	}
 
 	if (ln1 > 0) {
-		printf("\t\tOI 2: ");
+		json_arr_open("tOI 2");
 		if (2 + ln0 + ln1 > len) {
-			printf("Invalid IE length.\n");
+			iw_printf(NULL, "Invalid IE length len: %d 2 + ln0 + ln1: %d", len, 2 + ln0 + ln1);
 		} else {
 			for (idx = 0; idx < ln1; idx++) {
-				printf("%02hhx", data[2 + ln0 + idx]);
+				iw_printf(NULL, "%02hhx", data[2 + ln0 + idx]);
 			}
-			printf("\n");
 		}
+		json_arr_close();
 	}
 
 	if (ln2 > 0) {
-		printf("\t\tOI 3: ");
+		json_arr_open("OI 3");
 		if (2 + ln0 + ln1 + ln2 > len) {
-			printf("Invalid IE length.\n");
+			iw_printf(NULL, "Invalid IE length len: %d 2+ln0+ln1+ln2: %d", len, 2 + ln0 + ln1 + ln2);
 		} else {
 			for (idx = 0; idx < ln2; idx++) {
-				printf("%02hhx", data[2 + ln0 + ln1 + idx]);
+				iw_printf(NULL, "%02hhx", data[2 + ln0 + ln1 + idx]);
 			}
-			printf("\n");
 		}
+		json_arr_close();
 	}
 }
 
@@ -1264,8 +1235,6 @@ static void print_tx_power_envelope(const uint8_t type, uint8_t len,
 		"Local Maximum Transmit Power For 160/80+80 MHz",
 	};
 
-	printf("\n");
-
 	if (local_max_tx_power_count + 2 != len)
 		return;
 	if (local_max_tx_power_unit_interp != 0)
@@ -1274,9 +1243,9 @@ static void print_tx_power_envelope(const uint8_t type, uint8_t len,
 		int8_t power_val = ((int8_t)data[1 + i]) >> 1;
 		int8_t point5 = data[1 + i] & 1;
 		if (point5)
-			printf("\t\t * %s: %i.5 dBm\n", power_names[i], power_val);
+			iw_printf(power_names[i], "%s: %i.5 dBm\n", power_names[i], power_val);
 		else
-			printf("\t\t * %s: %i dBm\n", power_names[i], power_val);
+			iw_printf(power_names[i], "%s: %i dBm", power_names[i], power_val);
 	}
 }
 
@@ -1300,22 +1269,19 @@ static void print_ht_op(const uint8_t type, uint8_t len, const uint8_t *data,
 		"20 MHz",
 		"any",
 	};
-
-	printf("\n");
-	printf("\t\t * primary channel: %d\n", data[0]);
-	printf("\t\t * secondary channel offset: %s\n",
-		ht_secondary_offset[data[1] & 0x3]);
-	printf("\t\t * STA channel width: %s\n", sta_chan_width[(data[1] & 0x4)>>2]);
-	printf("\t\t * RIFS: %d\n", (data[1] & 0x8)>>3);
-	printf("\t\t * HT protection: %s\n", protection[data[2] & 0x3]);
-	printf("\t\t * non-GF present: %d\n", (data[2] & 0x4) >> 2);
-	printf("\t\t * OBSS non-GF present: %d\n", (data[2] & 0x10) >> 4);
-	printf("\t\t * dual beacon: %d\n", (data[4] & 0x40) >> 6);
-	printf("\t\t * dual CTS protection: %d\n", (data[4] & 0x80) >> 7);
-	printf("\t\t * STBC beacon: %d\n", data[5] & 0x1);
-	printf("\t\t * L-SIG TXOP Prot: %d\n", (data[5] & 0x2) >> 1);
-	printf("\t\t * PCO active: %d\n", (data[5] & 0x4) >> 2);
-	printf("\t\t * PCO phase: %d\n", (data[5] & 0x8) >> 3);
+	iw_printf("primary_channel", "%d", data[0]);
+	iw_printf("secondary_channel_offset", "%s", ht_secondary_offset[data[1] & 0x3]);
+	iw_printf("sta_channel_width", "%s", sta_chan_width[(data[1] & 0x4)>>2]);
+	iw_printf("rifs", "%d", (data[1] & 0x8)>>3);
+	iw_printf("ht_protection", "%s", protection[data[2] & 0x3]);
+	iw_printf("non-gf_present", "%d", (data[2] & 0x4) >> 2);
+	iw_printf("obss_non-gf_present", "%d", (data[2] & 0x10) >> 4);
+	iw_printf("dual_beacon", "%d", (data[4] & 0x40) >> 6);
+	iw_printf("dual_cts_protection", "%d", (data[4] & 0x80) >> 7);
+	iw_printf("stbc_beacon", "%d", data[5] & 0x1);
+	iw_printf("l-sig_txop_prot", "%d", (data[5] & 0x2) >> 1);
+	iw_printf("pco_active", "%d", (data[5] & 0x4) >> 2);
+	iw_printf("pco_phase", "%d", (data[5] & 0x8) >> 3);
 }
 
 static void print_capabilities(const uint8_t type, uint8_t len,
@@ -1336,6 +1302,7 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 		ie += ie[1] + 2;
 	}
 
+	json_arr_open("capabilities");
 	for (i = 0; i < len; i++) {
 		base = i * 8;
 
@@ -1343,15 +1310,13 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 			if (!(data[i] & (1 << bit)))
 				continue;
 
-			printf("\n\t\t *");
-
-#define CAPA(bit, name)		case bit: printf(" " name); break
+#define CAPA(bit, name)		case bit: iw_printf(NULL, name); break
 
 /* if the capability 'cap' exists add 'val' to 'sum'
  * otherwise print 'Reserved' */
 #define ADD_BIT_VAL(bit, cap, sum, val)	case (bit): do {	\
 	if (!(cap)) {						\
-		printf(" Reserved");				\
+		iw_printf(NULL, "Reserved");				\
 		break;						\
 	}							\
 	sum += val;						\
@@ -1368,7 +1333,7 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 
 			case 6:
 				s_psmp_support = true;
-				printf(" S-PSMP Capability");
+				iw_printf(NULL, "S-PSMP Capability");
 				break;
 
 			CAPA(7, "Event");
@@ -1424,7 +1389,7 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 			CAPA(55, "QLoad Report");
 			CAPA(56, "Alternate EDCA");
 			CAPA(57, "Unprotected TXOP Negotiation");
-			CAPA(58, "Protected TXOP egotiation");
+			CAPA(58, "Protected TXOP Negotiation");
 			CAPA(59, "Reserved");
 			CAPA(60, "Protected QLoad Report");
 			CAPA(61, "TDLS Wider Bandwidth");
@@ -1444,62 +1409,50 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 			CAPA(73, "Extended Spectrum Management Capable");
 			CAPA(74, "Reserved");
 			default:
-				printf(" %d", bit);
+				iw_printf(NULL, "bit: %d", bit);
 				break;
 			}
+
 #undef ADD_BIT_VAL
 #undef CAPA
-		}
-	}
+		} //inner for loop
+	} //outer for loop
+	json_arr_close();
+
 
 	if (s_psmp_support)
-		printf("\n\t\t * Service Interval Granularity is %d ms",
-		       (si_duration + 1) * 5);
+		iw_printf("service_interval_granularity_ms", "%d", (si_duration + 1) * 5);
 
 	if (is_vht_cap) {
-		printf("\n\t\t * Max Number Of MSDUs In A-MSDU is ");
+		int max_amsdu_ = 0;
 		switch (max_amsdu) {
-		case 0:
-			printf("unlimited");
-			break;
-		case 1:
-			printf("32");
-			break;
-		case 2:
-			printf("16");
-			break;
-		case 3:
-			printf("8");
-			break;
-		default:
-			break;
+			case 0: max_amsdu_ = -1; break;
+			case 1: max_amsdu_ = 32; break;
+			case 2: max_amsdu_ = 16; break;
+			case 3: max_amsdu_ = 8; break;
+			default: break;
 		}
+		iw_printf("max_number_of_mssdu_in_a-msdu", "%d", max_amsdu_);
 	}
-
-	printf("\n");
 }
 
 static void print_tim(const uint8_t type, uint8_t len, const uint8_t *data,
 		      const struct print_ies_data *ie_buffer)
 {
-	printf(" DTIM Count %u DTIM Period %u Bitmap Control 0x%x "
-	       "Bitmap[0] 0x%x",
-	       data[0], data[1], data[2], data[3]);
+	iw_printf("value", "DTIM Count %u DTIM Period %u Bitmap Control 0x%x Bitmap[0] 0x%x", data[0], data[1], data[2], data[3]);
 	if (len - 4)
-		printf(" (+ %u octet%s)", len - 4, len - 4 == 1 ? "" : "s");
-	printf("\n");
+		iw_printf("octets", "%u", len - 4);
 }
 
 static void print_ibssatim(const uint8_t type, uint8_t len, const uint8_t *data,
 			   const struct print_ies_data *ie_buffer)
 {
-	printf(" %d TUs\n", (data[1] << 8) + data[0]);
+	iw_printf("TUs", "%d", (data[1] << 8) + data[0]);
 }
 
 static void print_vht_capa(const uint8_t type, uint8_t len, const uint8_t *data,
 			   const struct print_ies_data *ie_buffer)
 {
-	printf("\n");
 	print_vht_info((__u32) data[0] | ((__u32)data[1] << 8) |
 		       ((__u32)data[2] << 16) | ((__u32)data[3] << 24),
 		       data + 4);
@@ -1515,12 +1468,12 @@ static void print_vht_oper(const uint8_t type, uint8_t len, const uint8_t *data,
 		[2] = "160 MHz",
 	};
 
-	printf("\n");
-	printf("\t\t * channel width: %d (%s)\n", data[0],
+	iw_printf("channel_width", "%d (%s)", data[0],
 		data[0] < ARRAY_SIZE(chandwidths) ? chandwidths[data[0]] : "unknown");
-	printf("\t\t * center freq segment 1: %d\n", data[1]);
-	printf("\t\t * center freq segment 2: %d\n", data[2]);
-	printf("\t\t * VHT basic MCS set: 0x%.2x%.2x\n", data[4], data[3]);
+	iw_printf("center freq segment 1", "%d", data[1]);
+	iw_printf("center freq segment 2", "%d", data[2]);
+	iw_printf("vht_basic_mcs_set", "0x%.2x%.2x", data[4], data[3]);
+
 }
 
 static void print_supp_op_classes(const uint8_t type, uint8_t len,
@@ -1532,8 +1485,8 @@ static void print_supp_op_classes(const uint8_t type, uint8_t len,
 	int zero_delimiter = 0;
 	int one_hundred_thirty_delimiter = 0;
 
-	printf("\n");
-	printf("\t\t * current operating class: %d\n", *p);
+	iw_printf("current_operating_class", "%d", *p);
+	json_arr_open("operating_class");
 	while (++p < next_data) {
 		if (*p == 130) {
 			one_hundred_thirty_delimiter = 1;
@@ -1543,18 +1496,28 @@ static void print_supp_op_classes(const uint8_t type, uint8_t len,
 			zero_delimiter = 0;
 			break;
 		}
-		printf("\t\t * operating class: %d\n", *p);
+		iw_printf(NULL, "%d", *p);
 	}
-	if (one_hundred_thirty_delimiter)
+	json_arr_close();
+
+	json_arr_open("current operating class extension");
+	if (one_hundred_thirty_delimiter){
 		while (++p < next_data) {
-			printf("\t\t * current operating class extension: %d\n", *p);
+			iw_printf(NULL, "%d", *p);
 		}
-	if (zero_delimiter)
+	}
+	json_arr_close();
+
+	json_arr_open("operating class tuple");
+	if (zero_delimiter){
 		while (++p < next_data - 1) {
-			printf("\t\t * operating class tuple: %d %d\n", p[0], p[1]);
+			iw_printf(NULL, "%d %d", p[0], p[1]);
 			if (*p == 0)
 				break;
 		}
+	}
+	json_arr_close();
+
 }
 
 static void print_measurement_pilot_tx(const uint8_t type, uint8_t len,
@@ -1563,8 +1526,7 @@ static void print_measurement_pilot_tx(const uint8_t type, uint8_t len,
 {
 	uint8_t *p, len_remaining;
 
-	printf("\n");
-	printf("\t\t * interval: %d TUs\n", data[0]);
+	iw_printf("interval_tus", "%d", data[0]);
 
 	if (len <= 1)
 		return;
@@ -1584,23 +1546,21 @@ static void print_measurement_pilot_tx(const uint8_t type, uint8_t len,
 
 		/* 802.11-2016 only allows vendor specific elements */
 		if (subelement_id != 221) {
-			printf("\t\t * <Invalid subelement ID %d>\n", subelement_id);
+			iw_printf("invalid_subelement_id", "%d", subelement_id);
 			return;
 		}
 
 		if (len < 3 || len > len_remaining) {
-			printf(" <Parse error, element too short>\n");
+			iw_printf("invalid_subelement_id", "%d", subelement_id);
 			return;
 		}
 
-		printf("\t\t * vendor specific: OUI %.2x:%.2x:%.2x, data:",
-			p[0], p[1], p[2]);
-		/* add only two here and use ++p in while loop */
-		p += 2;
+		json_arr_open("vendor_specific_oui");
 
-		while (++p < end)
-			printf(" %.2x", *p);
-		printf("\n");
+		while (++p < end){
+			iw_printf(NULL, "0x%.2x", *p);
+		}
+		json_arr_close();
 
 		len_remaining -= len;
 	}
@@ -1610,15 +1570,13 @@ static void print_obss_scan_params(const uint8_t type, uint8_t len,
 				   const uint8_t *data,
 				   const struct print_ies_data *ie_buffer)
 {
-	printf("\n");
-	printf("\t\t * passive dwell: %d TUs\n", (data[1] << 8) | data[0]);
-	printf("\t\t * active dwell: %d TUs\n", (data[3] << 8) | data[2]);
-	printf("\t\t * channel width trigger scan interval: %d s\n", (data[5] << 8) | data[4]);
-	printf("\t\t * scan passive total per channel: %d TUs\n", (data[7] << 8) | data[6]);
-	printf("\t\t * scan active total per channel: %d TUs\n", (data[9] << 8) | data[8]);
-	printf("\t\t * BSS width channel transition delay factor: %d\n", (data[11] << 8) | data[10]);
-	printf("\t\t * OBSS Scan Activity Threshold: %d.%02d %%\n",
-		((data[13] << 8) | data[12]) / 100, ((data[13] << 8) | data[12]) % 100);
+	iw_printf("passive_dwell_tus", "%d", (data[1] << 8) | data[0]);
+	iw_printf("active_dwell_tus", "%d", (data[3] << 8) | data[2]);
+	iw_printf("channel_width_trigger_scan_interval_s", "%d", (data[5] << 8) | data[4]);
+	iw_printf("scan_passive_total_per_channel_tus", "%d", (data[7] << 8) | data[6]);
+	iw_printf("scan_active_total_per_channel_tus", "%d", (data[9] << 8) | data[8]);
+	iw_printf("bss_width_channel_transition_delay_factor", "%d", (data[11] << 8) | data[10]);
+	iw_printf("obss_scan_ctivity_threshold", "%d.%02d %%\n", ((data[13] << 8) | data[12]) / 100, ((data[13] << 8) | data[12]) % 100);
 }
 
 static void print_secchan_offs(const uint8_t type, uint8_t len,
@@ -1626,51 +1584,52 @@ static void print_secchan_offs(const uint8_t type, uint8_t len,
 			       const struct print_ies_data *ie_buffer)
 {
 	if (data[0] < ARRAY_SIZE(ht_secondary_offset))
-		printf(" %s (%d)\n", ht_secondary_offset[data[0]], data[0]);
+		iw_printf("value", "%s (%d)", ht_secondary_offset[data[0]], data[0]);
 	else
-		printf(" %d\n", data[0]);
+		iw_printf("value", "%d", data[0]);
 }
 
-static void print_bss_load(const uint8_t type, uint8_t len, const uint8_t *data,
+static void print_bss_load(const uint8_t type, uint8_t len, const uint8_t *_data,
 			   const struct print_ies_data *ie_buffer)
 {
-	printf("\n");
-	printf("\t\t * station count: %d\n", (data[1] << 8) | data[0]);
-	printf("\t\t * channel utilisation: %d/255\n", data[2]);
-	printf("\t\t * available admission capacity: %d [*32us]\n", (data[4] << 8) | data[3]);
+	const int8_t *data = (int8_t *)_data;
+	iw_printf("station count", "%d", (data[1] << 8) | data[0]);
+	iw_printf("channel utilisation", "%d", data[2]);
+	iw_printf("available admission capacity", "%d", (data[4] << 8) | data[3]);
 }
 
 static void print_mesh_conf(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
 			    const struct print_ies_data *ie_buffer)
 {
-	printf("\n");
-	printf("\t\t * Active Path Selection Protocol ID: %d\n", data[0]);
-	printf("\t\t * Active Path Selection Metric ID: %d\n", data[1]);
-	printf("\t\t * Congestion Control Mode ID: %d\n", data[2]);
-	printf("\t\t * Synchronization Method ID: %d\n", data[3]);
-	printf("\t\t * Authentication Protocol ID: %d\n", data[4]);
-	printf("\t\t * Mesh Formation Info:\n");
-	printf("\t\t\t Number of Peerings: %d\n", (data[5] & 0x7E) >> 1);
+	iw_printf("active_path_selection_protocol_id", "%d", data[0]);
+	iw_printf("active_path_selection_metric_id", "%d", data[1]);
+	iw_printf("congestion_control_mode_id", "%d", data[2]);
+	iw_printf("synchronization_method_id", "%d", data[3]);
+	iw_printf("authentication_protocol_id", "%d", data[4]);
+	json_arr_open("mesh_formation_info");
+	iw_printf("number_of_peerings", "%d", (data[5] & 0x7E) >> 1);
 	if (data[5] & 0x01)
-		printf("\t\t\t Connected to Mesh Gate\n");
+		iw_printf(NULL, "Connected to Mesh Gate");
 	if (data[5] & 0x80)
-		printf("\t\t\t Connected to AS\n");
-	printf("\t\t * Mesh Capability\n");
+		iw_printf(NULL, "Connected to AS");
+	json_arr_close();
+	json_arr_open("mesh_capability");
 	if (data[6] & 0x01)
-		printf("\t\t\t Accepting Additional Mesh Peerings\n");
+		iw_printf(NULL, "Accepting Additional Mesh Peerings");
 	if (data[6] & 0x02)
-		printf("\t\t\t MCCA Supported\n");
+		iw_printf(NULL, "MCCA Supported");
 	if (data[6] & 0x04)
-		printf("\t\t\t MCCA Enabled\n");
+		iw_printf(NULL, "MCCA Enabled");
 	if (data[6] & 0x08)
-		printf("\t\t\t Forwarding\n");
+		iw_printf(NULL, "Forwarding");
 	if (data[6] & 0x10)
-		printf("\t\t\t MBCA Supported\n");
+		iw_printf(NULL, "MBCA Supported");
 	if (data[6] & 0x20)
-		printf("\t\t\t TBTT Adjusting\n");
+		iw_printf(NULL, "TBTT Adjusting");
 	if (data[6] & 0x40)
-		printf("\t\t\t Mesh Power Save Level\n");
+		iw_printf(NULL, "Mesh Power Save Level");
+	json_arr_close();
 }
 
 struct ie_print {
@@ -1682,31 +1641,34 @@ struct ie_print {
 };
 
 static void print_ie(const struct ie_print *p, const uint8_t type, uint8_t len,
-		     const uint8_t *data,
-		     const struct print_ies_data *ie_buffer)
+                     const uint8_t *data,
+                     const struct print_ies_data *ie_buffer)
 {
-	int i;
+    int i;
 
-	if (!p->print)
-		return;
+    if (!p->print) return;
 
-	printf("\t%s:", p->name);
+	json_obj_open(p->name);
 	if (len < p->minlen || len > p->maxlen) {
+		iw_printf("invalid_bytes", "%d", len);
 		if (len > 1) {
-			printf(" <invalid: %d bytes:", len);
+			json_arr_open("data");
 			for (i = 0; i < len; i++)
-				printf(" %.02x", data[i]);
-			printf(">\n");
-		} else if (len)
-			printf(" <invalid: 1 byte: %.02x>\n", data[0]);
-		else
-			printf(" <invalid: no data>\n");
-		return;
+				iw_printf(NULL, "%.02x", data[i]);
+			json_arr_close();
+		} else if (len) {
+			iw_printf("invalid_1_byte", "%d", data[0]);
+		} else {
+			iw_printf("no_data", "%s", "true");
+		}
+	} else {
+		// print callback
+		p->print(type, len, data, ie_buffer);
 	}
-
-	p->print(type, len, data, ie_buffer);
+	json_obj_close();
 }
 
+
 #define PRINT_IGN {		\
 	.name = "IGNORE",	\
 	.print = NULL,		\
@@ -1765,41 +1727,36 @@ static bool print_wifi_wmm_param(const uint8_t *data, uint8_t len)
 	int i;
 	static const char *aci_tbl[] = { "BE", "BK", "VI", "VO" };
 
-	if (len < 19)
-		goto invalid;
+	if (len < 19){
+		iw_printf("invalid length", "len < 19, len: %d", len);
+		return false;
+	}
+
+
+	iw_printf("version", "%d", data[0]);
 
 	if (data[0] != 1) {
-		printf("Parameter: not version 1: ");
 		return false;
 	}
 
-	printf("\t * Parameter version 1");
-
 	data++;
 
-	if (data[0] & 0x80)
-		printf("\n\t\t * u-APSD");
-
+	if (data[0] & 0x80){
+		iw_printf("u-APSD", "%s", "true");
+	}
 	data += 2;
 
 	for (i = 0; i < 4; i++) {
-		printf("\n\t\t * %s:", aci_tbl[(data[0] >> 5) & 3]);
-		if (data[0] & 0x10)
-			printf(" acm");
-		printf(" CW %d-%d", (1 << (data[1] & 0xf)) - 1,
-				    (1 << (data[1] >> 4)) - 1);
-		printf(", AIFSN %d", data[0] & 0xf);
-		if (data[2] | data[3])
-			printf(", TXOP %d usec", (data[2] + (data[3] << 8)) * 32);
+		json_obj_open("%s", aci_tbl[(data[0] >> 5) & 3]);
+		if (data[0] & 0x10) iw_printf("acm", "%s", "true");
+		iw_printf("CW", "%d-%d", (1 << (data[1] & 0xf)) - 1, (1 << (data[1] >> 4)) - 1);
+		iw_printf("AIFSN", "%d", data[0] & 0xf);
+
+		if (data[2] | data[3]) iw_printf("TXOP_usec", "%d", (data[2] + (data[3] << 8)) * 32);
 		data += 4;
+		json_obj_close();
 	}
-
-	printf("\n");
 	return true;
-
- invalid:
- 	printf("invalid: ");
- 	return false;
 }
 
 static void print_wifi_wmm(const uint8_t type, uint8_t len, const uint8_t *data,
@@ -1809,20 +1766,22 @@ static void print_wifi_wmm(const uint8_t type, uint8_t len, const uint8_t *data,
 
 	switch (data[0]) {
 	case 0x00:
-		printf(" information:");
+		json_arr_open("information");
 		break;
 	case 0x01:
 		if (print_wifi_wmm_param(data + 1, len - 1))
 			return;
 		break;
 	default:
-		printf(" type %d:", data[0]);
+		char buf[32];
+		snprintf(buf, sizeof(buf), "type %d", data[0]);
+		json_arr_open(buf, NULL);
 		break;
 	}
 
 	for(i = 1; i < len; i++)
-		printf(" %.02x", data[i]);
-	printf("\n");
+		iw_printf(NULL, "%.02x", data[i]);
+	json_arr_close();
 }
 
 static const char * wifi_wps_dev_passwd_id(uint16_t id)
@@ -1848,7 +1807,6 @@ static const char * wifi_wps_dev_passwd_id(uint16_t id)
 static void print_wifi_wps(const uint8_t type, uint8_t len, const uint8_t *data,
 			   const struct print_ies_data *ie_buffer)
 {
-	bool first = true;
 	__u16 subtype, sublen;
 
 	while (len >= 4) {
@@ -1858,209 +1816,175 @@ static void print_wifi_wps(const uint8_t type, uint8_t len, const uint8_t *data,
 			break;
 
 		switch (subtype) {
-		case 0x104a:
-			tab_on_first(&first);
-			if (sublen < 1) {
-				printf("\t * Version: (invalid "
-				       "length %d)\n", sublen);
+			case 0x104a:
+				if (sublen < 1) {
+					iw_printf("version_invalid_length", "%d", sublen);
+					break;
+				}
+				iw_printf("version",  "%d.%d", data[4] >> 4, data[4] & 0xF);
 				break;
-			}
-			printf("\t * Version: %d.%d\n", data[4] >> 4, data[4] & 0xF);
-			break;
-		case 0x1011:
-			tab_on_first(&first);
-			printf("\t * Device name: %.*s\n", sublen, data + 4);
-			break;
-		case 0x1012: {
-			uint16_t id;
-			tab_on_first(&first);
-			if (sublen != 2) {
-				printf("\t * Device Password ID: (invalid length %d)\n",
-				       sublen);
+			case 0x1011:
+				iw_printf("device name", "%.*s", sublen, data + 4);
 				break;
-			}
-			id = data[4] << 8 | data[5];
-			printf("\t * Device Password ID: %u (%s)\n",
-			       id, wifi_wps_dev_passwd_id(id));
-			break;
-		}
-		case 0x1021:
-			tab_on_first(&first);
-			printf("\t * Manufacturer: %.*s\n", sublen, data + 4);
-			break;
-		case 0x1023:
-			tab_on_first(&first);
-			printf("\t * Model: %.*s\n", sublen, data + 4);
-			break;
-		case 0x1024:
-			tab_on_first(&first);
-			printf("\t * Model Number: %.*s\n", sublen, data + 4);
-			break;
-		case 0x103b: {
-			__u8 val;
-
-			if (sublen < 1) {
-				printf("\t * Response Type: (invalid length %d)\n",
-				       sublen);
+			case 0x1012: {
+				uint16_t id;
+				if (sublen != 2) {
+					iw_printf("device_password_id", "%d", sublen);
+					break;
+				}
+				id = data[4] << 8 | data[5];
+				iw_printf("device_password_id",  "%u (%s)", id, wifi_wps_dev_passwd_id(id));
 				break;
 			}
-			val = data[4];
-			tab_on_first(&first);
-			printf("\t * Response Type: %d%s\n",
-			       val, val == 3 ? " (AP)" : "");
-			break;
-		}
-		case 0x103c: {
-			__u8 val;
+			case 0x1021:
+				iw_printf("manufacturer", "%.*s", sublen, data + 4);
+				break;
+			case 0x1023:
+				iw_printf("model", "%.*s", sublen, data + 4);
+				break;
+			case 0x1024:
+				iw_printf("model_number", "%.*s", sublen, data + 4);
+				break;
+			case 0x103b: {
+				__u8 val;
 
-			if (sublen < 1) {
-				printf("\t * RF Bands: (invalid length %d)\n",
-				       sublen);
+				if (sublen < 1) {
+					iw_printf("response_type_invalid_length", "%d", sublen);
+					break;
+				}
+				val = data[4];
+				iw_printf("response_type", "%d%s", val, val == 3 ? " (AP)" : "");
 				break;
 			}
-			val = data[4];
-			tab_on_first(&first);
-			printf("\t * RF Bands: 0x%x\n", val);
-			break;
-		}
-		case 0x1041: {
-			__u8 val;
+			case 0x103c: {
+				__u8 val;
 
-			if (sublen < 1) {
-				printf("\t * Selected Registrar: (invalid length %d)\n",
-				       sublen);
+				if (sublen < 1) {
+					iw_printf("rf_bands_invalid_length", "%d", sublen);
+					break;
+				}
+				val = data[4];
+				iw_printf("rf_bands", "0x%x", val);
 				break;
 			}
-			val = data[4];
-			tab_on_first(&first);
-			printf("\t * Selected Registrar: 0x%x\n", val);
-			break;
-		}
-		case 0x1042:
-			tab_on_first(&first);
-			printf("\t * Serial Number: %.*s\n", sublen, data + 4);
-			break;
-		case 0x1044: {
-			__u8 val;
+			case 0x1041: {
+				__u8 val;
 
-			if (sublen < 1) {
-				printf("\t * Wi-Fi Protected Setup State: (invalid length %d)\n",
-				       sublen);
+				if (sublen < 1) {
+					iw_printf("selected_registrar_invalid_length", "%d", sublen);
+					break;
+				}
+				val = data[4];
+				iw_printf("selected_registrar", "0x%x", val);
 				break;
 			}
-			val = data[4];
-			tab_on_first(&first);
-			printf("\t * Wi-Fi Protected Setup State: %d%s%s\n",
-			       val,
-			       val == 1 ? " (Unconfigured)" : "",
-			       val == 2 ? " (Configured)" : "");
-			break;
-		}
-		case 0x1047:
-			tab_on_first(&first);
-			printf("\t * UUID: ");
-			if (sublen != 16) {
-				printf("(invalid, length=%d)\n", sublen);
+			case 0x1042:
+				iw_printf("serial_number", "%.*s", sublen, data + 4);
 				break;
+			case 0x1044: {
+				__u8 val;
+
+				if (sublen < 1) {
+					iw_printf("wi-fi_protected_setup_state_invalid_length", "%d", sublen);
+					break;
+				}
+				val = data[4];
+				iw_printf("wi-fi_protected_setup_state", "%d%s%s", val, val == 1 ? " (Unconfigured)" : "", val == 2 ? " (Configured)" : "");
+					break;
 			}
-			printf("%02x%02x%02x%02x-%02x%02x-%02x%02x-"
-				"%02x%02x-%02x%02x%02x%02x%02x%02x\n",
-				data[4], data[5], data[6], data[7],
-				data[8], data[9], data[10], data[11],
-				data[12], data[13], data[14], data[15],
-				data[16], data[17], data[18], data[19]);
-			break;
-		case 0x1049:
-			tab_on_first(&first);
-			if (sublen == 6 &&
-			    data[4] == 0x00 &&
-			    data[5] == 0x37 &&
-			    data[6] == 0x2a &&
-			    data[7] == 0x00 &&
-			    data[8] == 0x01) {
-				uint8_t v2 = data[9];
-				printf("\t * Version2: %d.%d\n", v2 >> 4, v2 & 0xf);
-			} else {
-				printf("\t * Unknown vendor extension. len=%u\n",
-				       sublen);
-			}
-			break;
-		case 0x1054: {
-			tab_on_first(&first);
-			if (sublen != 8) {
-				printf("\t * Primary Device Type: (invalid length %d)\n",
-				       sublen);
+			case 0x1047:
+				if (sublen != 16) {
+					iw_printf("uuid_invalid_length", "%d", sublen);
+					break;
+				}
+				iw_printf("uuid", "%02x%02x-%02x%02x%02x%02x%02x%02x",
+					"%02x%02x-%02x%02x%02x%02x%02x%02x",
+					data[4], data[5], data[6], data[7],
+					data[8], data[9], data[10], data[11],
+					data[12], data[13], data[14], data[15],
+					data[16], data[17], data[18], data[19]);
 				break;
-			}
-			printf("\t * Primary Device Type: "
-			       "%u-%02x%02x%02x%02x-%u\n",
-			       data[4] << 8 | data[5],
-			       data[6], data[7], data[8], data[9],
-			       data[10] << 8 | data[11]);
-			break;
-		}
-		case 0x1057: {
-			__u8 val;
-			tab_on_first(&first);
-			if (sublen < 1) {
-				printf("\t * AP setup locked: (invalid length %d)\n",
-				       sublen);
+			case 0x1049:
+				if (sublen == 6 &&
+					data[4] == 0x00 &&
+					data[5] == 0x37 &&
+					data[6] == 0x2a &&
+					data[7] == 0x00 &&
+					data[8] == 0x01) {
+					uint8_t v2 = data[9];
+					iw_printf("version2", "%d.%d", v2 >> 4, v2 & 0xf);
+				} else {
+					iw_printf("unknown_vendor_extension_length", "%u", sublen);
+				}
+				break;
+			case 0x1054: {
+				if (sublen != 8) {
+					iw_printf("primary_device_type_invalid_length", "%d", sublen);
+					break;
+				}
+				iw_printf("primary_device_type",
+					"%u-%02x%02x%02x%02x-%u",
+					data[4] << 8 | data[5],
+					data[6], data[7], data[8], data[9],
+					data[10] << 8 | data[11]);
 				break;
 			}
-			val = data[4];
-			printf("\t * AP setup locked: 0x%.2x\n", val);
-			break;
-		}
-		case 0x1008:
-		case 0x1053: {
-			__u16 meth;
-			bool comma;
-
-			if (sublen < 2) {
-				printf("\t * Config methods: (invalid length %d)\n",
-				       sublen);
+			case 0x1057: {
+				__u8 val;
+				if (sublen < 1) {
+					iw_printf("ap_setup_locked_invalid_length", "%d", sublen);
+					break;
+				}
+				val = data[4];
+				iw_printf("ap_setup_locked", "0x%.2x", val);
 				break;
 			}
-			meth = (data[4] << 8) + data[5];
-			comma = false;
-			tab_on_first(&first);
-			printf("\t * %sConfig methods:",
-			       subtype == 0x1053 ? "Selected Registrar ": "");
+			case 0x1008:
+			case 0x1053: {
+				__u16 meth;
+
+				if (sublen < 2) {
+					iw_printf("config_methods_invalid_length", "%d", sublen);
+					break;
+				}
+				meth = (data[4] << 8) + data[5];
+				iw_printf("config_methods_selected_registrar", "%s", "true");
+				json_arr_open("config_methods");
+
 #define T(bit, name) do {		\
 	if (meth & (1<<bit)) {		\
-		if (comma)		\
-			printf(",");	\
-		comma = true;		\
-		printf(" " name);	\
-	} } while (0)
-			T(0, "USB");
-			T(1, "Ethernet");
-			T(2, "Label");
-			T(3, "Display");
-			T(4, "Ext. NFC");
-			T(5, "Int. NFC");
-			T(6, "NFC Intf.");
-			T(7, "PBC");
-			T(8, "Keypad");
-			printf("\n");
-			break;
-#undef T
-		}
-		default: {
-			const __u8 *subdata = data + 4;
-			__u16 tmplen = sublen;
+		iw_printf(NULL, name); \
+	} \
+} while (0)
 
-			tab_on_first(&first);
-			printf("\t * Unknown TLV (%#.4x, %d bytes):",
-			       subtype, tmplen);
-			while (tmplen) {
-				printf(" %.2x", *subdata);
-				subdata++;
-				tmplen--;
+				T(0, "USB");
+				T(1, "Ethernet");
+				T(2, "Label");
+				T(3, "Display");
+				T(4, "Ext. NFC");
+				T(5, "Int. NFC");
+				T(6, "NFC Intf.");
+				T(7, "PBC");
+				T(8, "Keypad");
+				json_arr_close();
+				break;
+#undef T
+			} //case 0x1053
+			default: {
+				const __u8 *subdata = data + 4;
+				__u16 tmplen = sublen;
+
+				iw_printf("unknown_tlv", "%#.4x, %d bytes", subtype, tmplen);
+				json_arr_open("unknown_tlv_data");
+
+				while (tmplen) {
+					iw_printf(NULL, "%.2x", *subdata);
+					subdata++;
+					tmplen--;
+				}
+				json_arr_close();
+				break;
 			}
-			printf("\n");
-			break;
-		}
 		}
 
 		data += sublen + 4;
@@ -2068,13 +1992,15 @@ static void print_wifi_wps(const uint8_t type, uint8_t len, const uint8_t *data,
 	}
 
 	if (len != 0) {
-		printf("\t\t * bogus tail data (%d):", len);
+		iw_printf(" bogus_tail_data_length", "%d", len);
+		json_arr_open("bogus_tail_data");
+
 		while (len) {
-			printf(" %.2x", *data);
+			iw_printf(NULL, "%.2x", *data);
 			data++;
 			len--;
 		}
-		printf("\n");
+		json_arr_close();
 	}
 }
 
@@ -2088,7 +2014,6 @@ static inline void print_p2p(const uint8_t type, uint8_t len,
 			     const uint8_t *data,
 			     const struct print_ies_data *ie_buffer)
 {
-	bool first = true;
 	__u8 subtype;
 	__u16 sublen;
 
@@ -2101,17 +2026,16 @@ static inline void print_p2p(const uint8_t type, uint8_t len,
 
 		switch (subtype) {
 		case 0x02: /* capability */
-			tab_on_first(&first);
 			if (sublen < 2) {
-				printf("\t * malformed capability\n");
+				iw_printf("malformed capability", "true");
 				break;
 			}
-			printf("\t * Group capa: 0x%.2x, Device capa: 0x%.2x\n",
-				data[3], data[4]);
+			iw_printf("Group capa", "0x%.2x", data[3]);
+			iw_printf("Device capa", "0x%.2x", data[4]);
 			break;
 		case 0x0d: /* device info */
 			if (sublen < 6 + 2 + 8 + 1) {
-				printf("\t * malformed device info\n");
+				iw_printf("malformed device info", "true");
 				break;
 			}
 			/* fall through */
@@ -2137,15 +2061,17 @@ static inline void print_p2p(const uint8_t type, uint8_t len,
 			const __u8 *subdata = data + 3;
 			__u16 tmplen = sublen;
 
-			tab_on_first(&first);
-			printf("\t * Unknown TLV (%#.2x, %d bytes):",
-			       subtype, tmplen);
+			json_obj_open("Unknown TLV");
+			iw_printf("type", "%#.2x", subtype);
+			iw_printf("length", "%d", tmplen);
+			json_arr_open("data");
 			while (tmplen) {
-				printf(" %.2x", *subdata);
+				iw_printf(NULL, "%.2x", *subdata);
 				subdata++;
 				tmplen--;
 			}
-			printf("\n");
+			json_arr_close();
+			json_obj_close();
 			break;
 		}
 		}
@@ -2155,14 +2081,16 @@ static inline void print_p2p(const uint8_t type, uint8_t len,
 	}
 
 	if (len != 0) {
-		tab_on_first(&first);
-		printf("\t * bogus tail data (%d):", len);
+		json_obj_open("bogus tail data");
+		iw_printf("length", "%d", len);
+		json_arr_open("data");
 		while (len) {
-			printf(" %.2x", *data);
+			iw_printf(NULL, "%.2x", *data);
 			data++;
 			len--;
 		}
-		printf("\n");
+		json_arr_close();
+		json_obj_close();
 	}
 }
 
@@ -2171,11 +2099,10 @@ static inline void print_hs20_ind(const uint8_t type, uint8_t len,
 				  const struct print_ies_data *ie_buffer)
 {
 	/* I can't find the spec for this...just going off what wireshark uses. */
-	printf("\n");
 	if (len > 0)
-		printf("\t\tDGAF: %i\n", (int)(data[0] & 0x1));
+		iw_printf("DGAF", "%i", (int)(data[0] & 0x1));
 	else
-		printf("\t\tUnexpected length: %i\n", len);
+		iw_printf("Unexpected length", "%i", len);
 }
 
 static void print_wifi_owe_tarns(const uint8_t type, uint8_t len,
@@ -2185,24 +2112,21 @@ static void print_wifi_owe_tarns(const uint8_t type, uint8_t len,
 	char mac_addr[20];
 	int ssid_len;
 
-	printf("\n");
 	if (len < 7)
 		return;
 
 	mac_addr_n2a(mac_addr, data);
-	printf("\t\tBSSID: %s\n", mac_addr);
+	iw_printf("BSSID", "%s", mac_addr);
 
 	ssid_len = data[6];
 	if (ssid_len > len - 7)
 		return;
-	printf("\t\tSSID: ");
 	print_ssid_escaped(ssid_len, data + 7);
-	printf("\n");
 
 	/* optional elements */
 	if (len >= ssid_len + 9) {
-		printf("\t\tBand Info: %u\n", data[ssid_len + 7]);
-		printf("\t\tChannel Info: %u\n", data[ssid_len + 8]);
+		iw_printf("Band Info", "%u", data[ssid_len + 7]);
+		iw_printf("Channel Info", "%u", data[ssid_len + 8]);
 	}
 }
 
@@ -2217,30 +2141,32 @@ static void print_vendor(unsigned char len, unsigned char *data,
 			 bool unknown, enum print_ie_type ptype)
 {
 	int i;
-
 	if (len < 3) {
-		printf("\tVendor specific: <too short> data:");
-		for(i = 0; i < len; i++)
-			printf(" %.02x", data[i]);
-		printf("\n");
+		json_arr_open("vendor specific too short");
+		for(i = 0; i < len; i++){
+			iw_printf(NULL, "%.02x", data[i]);
+		}
+		json_arr_close();
 		return;
 	}
 
 	if (len >= 4 && memcmp(data, ms_oui, 3) == 0) {
 		if (data[3] < ARRAY_SIZE(wifiprinters) &&
-		    wifiprinters[data[3]].name &&
-		    wifiprinters[data[3]].flags & BIT(ptype)) {
+			wifiprinters[data[3]].name &&
+			wifiprinters[data[3]].flags & BIT(ptype)) {
 			print_ie(&wifiprinters[data[3]],
-				 data[3], len - 4, data + 4,
-				 NULL);
+				data[3], len - 4, data + 4,
+				NULL);
 			return;
 		}
-		if (!unknown)
-			return;
-		printf("\tMS/WiFi %#.2x, data:", data[3]);
-		for(i = 0; i < len - 4; i++)
-			printf(" %.02x", data[i + 4]);
-		printf("\n");
+		if (!unknown) return;
+
+		iw_printf("MS/WiFi", "%#.2x", data[3]);
+		json_arr_open("data");
+		for(i = 0; i < len - 4; i++){
+			iw_printf(NULL, "%.02x", data[i + 4]);
+		}
+		json_arr_close();
 		return;
 	}
 
@@ -2255,27 +2181,31 @@ static void print_vendor(unsigned char len, unsigned char *data,
 		}
 		if (!unknown)
 			return;
-		printf("\tWFA %#.2x, data:", data[3]);
+		char buf[32];
+		snprintf(buf, sizeof(buf), "WFA %#.2x, data", data[3]);
+		json_arr_open(buf, NULL);
 		for(i = 0; i < len - 4; i++)
-			printf(" %.02x", data[i + 4]);
-		printf("\n");
+			iw_printf(NULL, "%.02x", data[i + 4]);
+		json_arr_close();
 		return;
 	}
 
 	if (!unknown)
 		return;
 
-	printf("\tVendor specific: OUI %.2x:%.2x:%.2x, data:",
-		data[0], data[1], data[2]);
+	json_obj_open("Vendor specific");
+	iw_printf("OUI", "%.2x:%.2x:%.2x", data[0], data[1], data[2]);
+
+	json_arr_open("data");
 	for (i = 3; i < len; i++)
-		printf(" %.2x", data[i]);
-	printf("\n");
+		iw_printf(NULL, "%.2x", data[i]);
+	json_arr_close();
+	json_obj_close();
 }
 
 static void print_he_capa(const uint8_t type, uint8_t len, const uint8_t *data,
 			  const struct print_ies_data *ie_buffer)
 {
-	printf("\n");
 	print_he_capability(data, len);
 }
 
@@ -2289,7 +2219,7 @@ static void print_extension(unsigned char len, unsigned char *ie,
 	unsigned char tag;
 
 	if (len < 1) {
-		printf("\tExtension IE: <empty>\n");
+		iw_printf("Extension IE empty", "true");
 		return;
 	}
 
@@ -2303,10 +2233,13 @@ static void print_extension(unsigned char len, unsigned char *ie,
 	if (unknown) {
 		int i;
 
-		printf("\tUnknown Extension ID (%d):", ie[0]);
+		json_obj_open("Unknown Extension ID");
+		iw_printf("id", "%d", ie[0]);
+		json_arr_open("data");
 		for (i = 1; i < len; i++)
-			printf(" %.2x", ie[i]);
-		printf("\n");
+			iw_printf(NULL, "%.2x", ie[i]);
+		json_arr_close();
+		json_obj_close();
 	}
 }
 
@@ -2333,10 +2266,13 @@ void print_ies(unsigned char *ie, int ielen, bool unknown,
 		} else if (unknown) {
 			int i;
 
-			printf("\tUnknown IE (%d):", ie[0]);
+			json_obj_open("Unknown IE");
+			iw_printf("ie", "%d", ie[0]);
+			json_arr_open("data");
 			for (i=0; i<ie[1]; i++)
-				printf(" %.2x", ie[2+i]);
-			printf("\n");
+				iw_printf(NULL, "%.2x", ie[2+i]);
+			json_arr_close();
+			json_obj_close();
 		}
 		ielen -= ie[1] + 2;
 		ie += ie[1] + 2;
@@ -2347,64 +2283,64 @@ static void print_capa_dmg(__u16 capa)
 {
 	switch (capa & WLAN_CAPABILITY_DMG_TYPE_MASK) {
 	case WLAN_CAPABILITY_DMG_TYPE_AP:
-		printf(" DMG_ESS");
+		iw_printf(NULL, "DMG_ESS");
 		break;
 	case WLAN_CAPABILITY_DMG_TYPE_PBSS:
-		printf(" DMG_PCP");
+		iw_printf(NULL, "DMG_PCP");
 		break;
 	case WLAN_CAPABILITY_DMG_TYPE_IBSS:
-		printf(" DMG_IBSS");
+		iw_printf(NULL, "DMG_IBSS");
 		break;
 	}
 
 	if (capa & WLAN_CAPABILITY_DMG_CBAP_ONLY)
-		printf(" CBAP_Only");
+		iw_printf(NULL, "CBAP_Only");
 	if (capa & WLAN_CAPABILITY_DMG_CBAP_SOURCE)
-		printf(" CBAP_Src");
+		iw_printf(NULL, "CBAP_Src");
 	if (capa & WLAN_CAPABILITY_DMG_PRIVACY)
-		printf(" Privacy");
+		iw_printf(NULL, "Privacy");
 	if (capa & WLAN_CAPABILITY_DMG_ECPAC)
-		printf(" ECPAC");
+		iw_printf(NULL, "ECPAC");
 	if (capa & WLAN_CAPABILITY_DMG_SPECTRUM_MGMT)
-		printf(" SpectrumMgmt");
+		iw_printf(NULL, "SpectrumMgmt");
 	if (capa & WLAN_CAPABILITY_DMG_RADIO_MEASURE)
-		printf(" RadioMeasure");
+		iw_printf(NULL, "RadioMeasure");
 }
 
 static void print_capa_non_dmg(__u16 capa)
 {
 	if (capa & WLAN_CAPABILITY_ESS)
-		printf(" ESS");
+		iw_printf(NULL, "ESS");
 	if (capa & WLAN_CAPABILITY_IBSS)
-		printf(" IBSS");
+		iw_printf(NULL, "IBSS");
 	if (capa & WLAN_CAPABILITY_CF_POLLABLE)
-		printf(" CfPollable");
+		iw_printf(NULL, "CfPollable");
 	if (capa & WLAN_CAPABILITY_CF_POLL_REQUEST)
-		printf(" CfPollReq");
+		iw_printf(NULL, "CfPollReq");
 	if (capa & WLAN_CAPABILITY_PRIVACY)
-		printf(" Privacy");
+		iw_printf(NULL, "Privacy");
 	if (capa & WLAN_CAPABILITY_SHORT_PREAMBLE)
-		printf(" ShortPreamble");
+		iw_printf(NULL, "ShortPreamble");
 	if (capa & WLAN_CAPABILITY_PBCC)
-		printf(" PBCC");
+		iw_printf(NULL, "PBCC");
 	if (capa & WLAN_CAPABILITY_CHANNEL_AGILITY)
-		printf(" ChannelAgility");
+		iw_printf(NULL, "ChannelAgility");
 	if (capa & WLAN_CAPABILITY_SPECTRUM_MGMT)
-		printf(" SpectrumMgmt");
+		iw_printf(NULL, "SpectrumMgmt");
 	if (capa & WLAN_CAPABILITY_QOS)
-		printf(" QoS");
+		iw_printf(NULL, "QoS");
 	if (capa & WLAN_CAPABILITY_SHORT_SLOT_TIME)
-		printf(" ShortSlotTime");
+		iw_printf(NULL, "ShortSlotTime");
 	if (capa & WLAN_CAPABILITY_APSD)
-		printf(" APSD");
+		iw_printf(NULL, "APSD");
 	if (capa & WLAN_CAPABILITY_RADIO_MEASURE)
-		printf(" RadioMeasure");
+		iw_printf(NULL, "RadioMeasure");
 	if (capa & WLAN_CAPABILITY_DSSS_OFDM)
-		printf(" DSSS-OFDM");
+		iw_printf(NULL, "DSSS-OFDM");
 	if (capa & WLAN_CAPABILITY_DEL_BACK)
-		printf(" DelayedBACK");
+		iw_printf(NULL, "DelayedBACK");
 	if (capa & WLAN_CAPABILITY_IMM_BACK)
-		printf(" ImmediateBACK");
+		iw_printf(NULL, "ImmediateBACK");
 }
 
 static int print_bss_handler(struct nl_msg *msg, void *arg)
@@ -2430,16 +2366,15 @@ static int print_bss_handler(struct nl_msg *msg, void *arg)
 	int show = params->show_both_ie_sets ? 2 : 1;
 	bool is_dmg = false;
 
-	nla_parse(tb, NL80211_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
-		  genlmsg_attrlen(gnlh, 0), NULL);
+	nla_parse(tb, NL80211_ATTR_MAX, genlmsg_attrdata(gnlh, 0), genlmsg_attrlen(gnlh, 0), NULL);
 
 	if (!tb[NL80211_ATTR_BSS]) {
 		fprintf(stderr, "bss info missing!\n");
 		return NL_SKIP;
 	}
 	if (nla_parse_nested(bss, NL80211_BSS_MAX,
-			     tb[NL80211_ATTR_BSS],
-			     bss_policy)) {
+				tb[NL80211_ATTR_BSS],
+				bss_policy)) {
 		fprintf(stderr, "failed to parse nested attributes!\n");
 		return NL_SKIP;
 	}
@@ -2448,73 +2383,80 @@ static int print_bss_handler(struct nl_msg *msg, void *arg)
 		return NL_SKIP;
 
 	mac_addr_n2a(mac_addr, nla_data(bss[NL80211_BSS_BSSID]));
-	printf("BSS %s", mac_addr);
+	json_obj_open(mac_addr);
+
 	if (tb[NL80211_ATTR_IFINDEX]) {
 		if_indextoname(nla_get_u32(tb[NL80211_ATTR_IFINDEX]), dev);
-		printf("(on %s)", dev);
+		iw_printf("ifname", "%s", dev);
 	}
 
+	char buf[32] = {0};
 	if (bss[NL80211_BSS_STATUS]) {
 		switch (nla_get_u32(bss[NL80211_BSS_STATUS])) {
 		case NL80211_BSS_STATUS_AUTHENTICATED:
-			printf(" -- authenticated");
+			snprintf(buf, sizeof(buf), "authenticated");
 			break;
 		case NL80211_BSS_STATUS_ASSOCIATED:
-			printf(" -- associated");
+			snprintf(buf, sizeof(buf), "associated");
 			break;
 		case NL80211_BSS_STATUS_IBSS_JOINED:
-			printf(" -- joined");
+			snprintf(buf, sizeof(buf), "joined");
 			break;
 		default:
-			printf(" -- unknown status: %d",
-				nla_get_u32(bss[NL80211_BSS_STATUS]));
+			snprintf(buf, sizeof(buf), "unknown status: %d", nla_get_u32(bss[NL80211_BSS_STATUS]));
 			break;
 		}
 	}
-	printf("\n");
+	iw_printf("status", "%s", buf);
 
 	if (bss[NL80211_BSS_LAST_SEEN_BOOTTIME]) {
 		unsigned long long bt;
 		bt = (unsigned long long)nla_get_u64(bss[NL80211_BSS_LAST_SEEN_BOOTTIME]);
-		printf("\tlast seen: %llu.%.3llus [boottime]\n", bt/1000000000, (bt%1000000000)/1000000);
+		iw_printf("last seen", "%llu.%.3llus [boottime]", bt/1000000000, (bt%1000000000)/1000000);
 	}
 
 	if (bss[NL80211_BSS_TSF]) {
 		unsigned long long tsf;
 		tsf = (unsigned long long)nla_get_u64(bss[NL80211_BSS_TSF]);
-		printf("\tTSF: %llu usec (%llud, %.2lld:%.2llu:%.2llu)\n",
-			tsf, tsf/1000/1000/60/60/24, (tsf/1000/1000/60/60) % 24,
-			(tsf/1000/1000/60) % 60, (tsf/1000/1000) % 60);
+
+		json_obj_open("TSF");
+		iw_printf("usec", "%llu", tsf);
+		iw_printf("dd", "%llu", tsf/1000/1000/60/60/24);
+		iw_printf("hh", "%llu", (tsf/1000/1000/60/60) % 24);
+		iw_printf("mm", "%llu", (tsf/1000/1000/60) % 60);
+		iw_printf("ss", "%llu", (tsf/1000/1000) % 60);
+		json_obj_close();
 	}
 	if (bss[NL80211_BSS_FREQUENCY]) {
 		int freq = nla_get_u32(bss[NL80211_BSS_FREQUENCY]);
-		printf("\tfreq: %d\n", freq);
-		if (freq > 45000)
-			is_dmg = true;
+		iw_printf("freq", "%d", freq);
+		if (freq > 45000) is_dmg = true;
 	}
 	if (bss[NL80211_BSS_BEACON_INTERVAL])
-		printf("\tbeacon interval: %d TUs\n",
-			nla_get_u16(bss[NL80211_BSS_BEACON_INTERVAL]));
+		iw_printf("beacon_interval_tus", "%d", nla_get_u16(bss[NL80211_BSS_BEACON_INTERVAL]));
 	if (bss[NL80211_BSS_CAPABILITY]) {
 		__u16 capa = nla_get_u16(bss[NL80211_BSS_CAPABILITY]);
-		printf("\tcapability:");
-		if (is_dmg)
+		json_arr_open("capability");
+		if (is_dmg){
 			print_capa_dmg(capa);
-		else
+		}else{
 			print_capa_non_dmg(capa);
-		printf(" (0x%.4x)\n", capa);
+		}
+		json_arr_close();
+
+		iw_printf("capability_raw", "0x%.4x", capa);
 	}
 	if (bss[NL80211_BSS_SIGNAL_MBM]) {
 		int s = nla_get_u32(bss[NL80211_BSS_SIGNAL_MBM]);
-		printf("\tsignal: %d.%.2d dBm\n", s/100, s%100);
+		iw_printf("signal", "%d.%.2d dBm", s/100, s%100);
 	}
 	if (bss[NL80211_BSS_SIGNAL_UNSPEC]) {
 		unsigned char s = nla_get_u8(bss[NL80211_BSS_SIGNAL_UNSPEC]);
-		printf("\tsignal: %d/100\n", s);
+		iw_printf("signal_dbm", "%d/100", s);
 	}
 	if (bss[NL80211_BSS_SEEN_MS_AGO]) {
 		int age = nla_get_u32(bss[NL80211_BSS_SEEN_MS_AGO]);
-		printf("\tlast seen: %d ms ago\n", age);
+		iw_printf("last_seen_ms_ago", "%d", age);
 	}
 
 	if (bss[NL80211_BSS_INFORMATION_ELEMENTS] && show--) {
@@ -2522,21 +2464,24 @@ static int print_bss_handler(struct nl_msg *msg, void *arg)
 		struct nlattr *bcnies = bss[NL80211_BSS_BEACON_IES];
 
 		if (bss[NL80211_BSS_PRESP_DATA] ||
-		    (bcnies && (nla_len(ies) != nla_len(bcnies) ||
+			(bcnies && (nla_len(ies) != nla_len(bcnies) ||
 				memcmp(nla_data(ies), nla_data(bcnies),
-				       nla_len(ies)))))
-			printf("\tInformation elements from Probe Response "
-			       "frame:\n");
-		print_ies(nla_data(ies), nla_len(ies),
-			  params->unknown, params->type);
+					nla_len(ies))))){
+			json_obj_open("bss_probe_resp_data_frame");
+			print_ies(nla_data(ies), nla_len(ies), params->unknown, params->type);
+			json_obj_close();
+		}
 	}
 	if (bss[NL80211_BSS_BEACON_IES] && show--) {
-		printf("\tInformation elements from Beacon frame:\n");
+		json_obj_open("bss_beacon_frame");
 		print_ies(nla_data(bss[NL80211_BSS_BEACON_IES]),
-			  nla_len(bss[NL80211_BSS_BEACON_IES]),
-			  params->unknown, params->type);
+			nla_len(bss[NL80211_BSS_BEACON_IES]),
+			params->unknown, params->type);
+		json_obj_close();
 	}
 
+	json_obj_close();
+
 	return NL_SKIP;
 }
 
diff --git a/util.c b/util.c
index 8a2ba10..ea0982c 100644
--- a/util.c
+++ b/util.c
@@ -5,6 +5,8 @@
 #include "iw.h"
 #include "nl80211.h"
 
+#include "json/iw_json_print.h"
+
 void mac_addr_n2a(char *mac_addr, const unsigned char *arg)
 {
 	int i, l;
@@ -220,19 +222,26 @@ int ieee80211_frequency_to_channel(int freq)
 		return 0;
 }
 
-void print_ssid_escaped(const uint8_t len, const uint8_t *data)
-{
-	int i;
+static char *ssid_escape(const uint8_t len, const uint8_t *data) {
+    static char buf[512]; // static buffer
+	int pos = 0;
 
-	for (i = 0; i < len; i++) {
-		if (isprint(data[i]) && data[i] != ' ' && data[i] != '\\')
-			printf("%c", data[i]);
-		else if (data[i] == ' ' &&
-			 (i != 0 && i != len -1))
-			printf(" ");
-		else
-			printf("\\x%.2x", data[i]);
-	}
+    for (int i = 0; i < len && pos < sizeof(buf) - 5; i++) { // leave space for "\xXX" and terminator byte
+        if (isprint(data[i]) && data[i] != ' ' && data[i] != '\\') {
+            buf[pos++] = data[i];
+        } else if (data[i] == ' ' && (i != 0 && i != len - 1)) {
+            buf[pos++] = ' ';
+        } else {
+            pos += snprintf(buf + pos, sizeof(buf) - pos, "\\x%.2x", data[i]);
+        }
+    }
+    buf[pos] = '\0'; // set terminator byte
+    return buf;
+}
+
+void print_ssid_escaped(const uint8_t len, const uint8_t *data) {
+	char *escaped_ssid = ssid_escape(len, data);
+	iw_printf("SSID", "%s", escaped_ssid);
 }
 
 static int hex2num(char digit)
@@ -743,38 +752,90 @@ int put_chandef(struct nl_msg *msg, struct chandef *chandef)
 	return -ENOBUFS;
 }
 
+static void print_mcs_index3(const __u8 *mcs)
+{
+    int mcs_bit, prev_bit = -2, prev_cont = 0;
+
+    for (mcs_bit = 0; mcs_bit <= 76; mcs_bit++) {
+        unsigned int mcs_octet = mcs_bit/8;
+        unsigned int MCS_RATE_BIT = 1 << mcs_bit % 8;
+        bool mcs_rate_idx_set;
+
+        mcs_rate_idx_set = !!(mcs[mcs_octet] & MCS_RATE_BIT);
+
+        if (!mcs_rate_idx_set)
+            continue;
+
+        if (prev_bit != mcs_bit - 1) {
+            if (prev_bit != -2)
+                printf("%d, ", prev_bit);
+            else
+                printf(" ");
+            printf("%d", mcs_bit);
+            prev_cont = 0;
+        } else if (!prev_cont) {
+            printf("-");
+            prev_cont = 1;
+        }
+
+        prev_bit = mcs_bit;
+    }
+
+    if (prev_cont)
+        printf("%d", prev_bit);
+    printf("\n");
+}
+
 static void print_mcs_index(const __u8 *mcs)
 {
 	int mcs_bit, prev_bit = -2, prev_cont = 0;
 
+	char buf[8];
+	char *p = (char *)buf;
+	int bufleft = (int)sizeof(buf);
+	int written = 0;
+
 	for (mcs_bit = 0; mcs_bit <= 76; mcs_bit++) {
-		unsigned int mcs_octet = mcs_bit/8;
-		unsigned int MCS_RATE_BIT = 1 << mcs_bit % 8;
-		bool mcs_rate_idx_set;
+		unsigned int mcs_octet = mcs_bit / 8;
+		unsigned int MCS_RATE_BIT = 1 << (mcs_bit % 8);
+		bool mcs_rate_idx_set = (mcs[mcs_octet] & MCS_RATE_BIT) != 0;
 
-		mcs_rate_idx_set = !!(mcs[mcs_octet] & MCS_RATE_BIT);
+		if (!mcs_rate_idx_set) continue;
 
-		if (!mcs_rate_idx_set)
-			continue;
 
 		if (prev_bit != mcs_bit - 1) {
-			if (prev_bit != -2)
-				printf("%d, ", prev_bit);
-			else
-				printf(" ");
-			printf("%d", mcs_bit);
+			if (prev_bit != -2) {
+				//print single or range value
+				snprintf(p, bufleft, "%d", prev_bit);
+				iw_printf(NULL, "%s", buf);
+
+				//reset buffer
+				p = buf;
+				bufleft = sizeof(buf);
+
+			}
+
+			written = snprintf(p, bufleft, "%d", mcs_bit);
+			p += written;
+			bufleft -= written;
 			prev_cont = 0;
 		} else if (!prev_cont) {
-			printf("-");
+			written = snprintf(p, bufleft, "-");
+			p += written;
+			bufleft -= written;
 			prev_cont = 1;
 		}
 
 		prev_bit = mcs_bit;
 	}
 
-	if (prev_cont)
-		printf("%d", prev_bit);
-	printf("\n");
+	//if is range write last chunk
+	if (prev_cont) {
+		snprintf(p, bufleft, "%d", prev_bit);
+	}
+
+	//print last value
+	iw_printf(NULL, "%s", buf);
 }
 
 /*
@@ -817,18 +878,18 @@ void print_ampdu_length(__u8 exponent)
 	max_ampdu_length = compute_ampdu_length(exponent);
 
 	if (max_ampdu_length) {
-		printf("\t\tMaximum RX AMPDU length %d bytes (exponent: 0x0%02x)\n",
-		       max_ampdu_length, exponent);
+		iw_printf("max_ampdu_length", "%d", max_ampdu_length);
 	} else {
-		printf("\t\tMaximum RX AMPDU length: unrecognized bytes "
-		       "(exponent: %d)\n", exponent);
+		iw_printf("max_ampdu_length", "%d", -1);
 	}
+	iw_printf("max_ampdu_exponent", "0x0%02x", exponent);
+
 }
 
 void print_ampdu_spacing(__u8 spacing)
 {
-	printf("\t\tMinimum RX AMPDU time spacing: %s (0x%02x)\n",
-	       print_ampdu_space(spacing), spacing);
+	iw_printf("min_rx_ampdu_time_spacing", "%s", print_ampdu_space(spacing));
+	iw_printf("min_rx_ampdu_time_spacing_value", "0x0%02x", spacing);
 }
 
 void print_ht_capability(__u16 cap)
@@ -836,10 +897,11 @@ void print_ht_capability(__u16 cap)
 #define PRINT_HT_CAP(_cond, _str) \
 	do { \
 		if (_cond) \
-			printf("\t\t\t" _str "\n"); \
+			iw_printf(NULL, _str); \
 	} while (0)
 
-	printf("\t\tCapabilities: 0x%02x\n", cap);
+	iw_printf("capabilities_value", "0x%02x", cap);
+	json_arr_open("capabilities");
 
 	PRINT_HT_CAP((cap & BIT(0)), "RX LDPC");
 	PRINT_HT_CAP((cap & BIT(1)), "HT20/HT40");
@@ -878,6 +940,8 @@ void print_ht_capability(__u16 cap)
 	PRINT_HT_CAP((cap & BIT(14)), "40 MHz Intolerant");
 
 	PRINT_HT_CAP((cap & BIT(15)), "L-SIG TXOP protection");
+
+	json_arr_close();
 #undef PRINT_HT_CAP
 }
 
@@ -893,32 +957,28 @@ void print_ht_mcs(const __u8 *mcs)
 	tx_max_num_spatial_streams = ((mcs[12] >> 2) & 3) + 1;
 	tx_unequal_modulation = !!(mcs[12] & (1 << 4));
 
-	if (max_rx_supp_data_rate)
-		printf("\t\tHT Max RX data rate: %d Mbps\n", max_rx_supp_data_rate);
+	if (max_rx_supp_data_rate){
+		iw_printf("ht_max_rx_data_rate_mbps", "%d", max_rx_supp_data_rate);
+	}
 	/* XXX: else see 9.6.0e.5.3 how to get this I think */
 
 	if (tx_mcs_set_defined) {
 		if (tx_mcs_set_equal) {
-			printf("\t\tHT TX/RX MCS rate indexes supported:");
+			json_arr_open("ht_tx_rx_mcs_idx_supported");
 			print_mcs_index(mcs);
+			json_arr_close();
 		} else {
-			printf("\t\tHT RX MCS rate indexes supported:");
+			json_arr_open("ht_rx_mcs_idx_supported");
 			print_mcs_index(mcs);
+			json_arr_close();
 
-			if (tx_unequal_modulation)
-				printf("\t\tTX unequal modulation supported\n");
-			else
-				printf("\t\tTX unequal modulation not supported\n");
-
-			printf("\t\tHT TX Max spatial streams: %d\n",
-				tx_max_num_spatial_streams);
-
-			printf("\t\tHT TX MCS rate indexes supported may differ\n");
+			iw_printf("tx_unequal_modulation", "%s", tx_unequal_modulation);
+			iw_printf("ht_tx_max_spatial_streams", "%d", tx_max_num_spatial_streams);
 		}
 	} else {
-		printf("\t\tHT RX MCS rate indexes supported:");
+		json_arr_open("ht_rx_mcs_idx_supported");
 		print_mcs_index(mcs);
-		printf("\t\tHT TX MCS rate indexes are undefined\n");
+		json_arr_close();
 	}
 }
 
@@ -1033,13 +1093,13 @@ static const struct vht_nss_ratio nss_ratio_tbl[3][4] = {
 	},
 };
 
-static void print_nss_ratio_value(int ratio)
+static const char *nss_ratio_value(int ratio)
 {
 	const char *rstr;
 
 	switch (ratio) {
 	case 4:
-		return;
+		return NULL;
 	case 3:
 		rstr = "3/4";
 		break;
@@ -1054,52 +1114,51 @@ static void print_nss_ratio_value(int ratio)
 		break;
 	}
 
-	printf("(%s NSS) ", rstr);
+	return rstr;
 }
 
 static void print_nss_ratio(const char *str, bool force_show, int ratio)
-{
+{ 	
 	if (!ratio)
 		return;
 	if (ratio == 4) {
 		if (force_show)
-			printf("%s ", str);
+			iw_printf("value", "%s", str);
 	} else {
-		printf("%s ", str);
-		print_nss_ratio_value(ratio);
+		iw_printf("value", "%s NSS", nss_ratio_value(ratio));
 	}
 }
 
 void print_vht_info(__u32 capa, const __u8 *mcs)
 {
+#define PRINT_VHT_CAPA(_bit, _str) \
+	do { \
+		if (capa & BIT(_bit)){ \
+			iw_printf(_str, "%s", "true"); \
+		} \
+	} while (0)
+
 	__u16 tmp;
 	__u32 supp_chan_width, ext_nss_bw;
 	const struct vht_nss_ratio *nss_tbl;
 	int i;
 
-	printf("\t\tVHT Capabilities (0x%.8x):\n", capa);
 
-#define PRINT_VHT_CAPA(_bit, _str) \
-	do { \
-		if (capa & BIT(_bit)) \
-			printf("\t\t\t" _str "\n"); \
-	} while (0)
-
-	printf("\t\t\tMax MPDU length: ");
+	iw_printf("vht_capabilities_raw", "0x%.8x", capa);
 	switch (capa & 3) {
-	case 0: printf("3895\n"); break;
-	case 1: printf("7991\n"); break;
-	case 2: printf("11454\n"); break;
-	case 3: printf("(reserved)\n");
+		case 0: iw_printf("vht_capabilities", "3895"); break;
+		case 1: iw_printf("vht_capabilities_data", "7991"); break;
+		case 2: iw_printf("vht_capabilities_data", "11454"); break;
+		case 3: iw_printf("vht_capabilities_data", "reserved");
 	}
+	json_obj_open("supported_channel_width");
 
-	printf("\t\t\tSupported Channel Width: ");
 	supp_chan_width = (capa >> 2) & 3;
 	ext_nss_bw = (capa >> 30) & 3;
 	nss_tbl = &nss_ratio_tbl[supp_chan_width][ext_nss_bw];
 
 	if (!nss_tbl->valid)
-		printf("(reserved)\n");
+		iw_printf("reserved", "%s", "true");
 	else if (nss_tbl->bw_20 == 4 &&
 		 nss_tbl->bw_40 == 4 &&
 		 nss_tbl->bw_80 == 4 &&
@@ -1107,9 +1166,15 @@ void print_vht_info(__u32 capa, const __u8 *mcs)
 		 (!nss_tbl->bw_80_80 || nss_tbl->bw_80_80 == 4)) {
 		/* old style print format */
 		switch (supp_chan_width) {
-		case 0: printf("neither 160 nor 80+80\n"); break;
-		case 1: printf("160 MHz\n"); break;
-		case 2: printf("160 MHz, 80+80 MHz\n"); break;
+			case 0:
+				break;
+			case 1:
+				iw_printf("160", "%s", "true");
+				break;
+			case 2:
+				iw_printf("160", "%s", "true");
+				iw_printf("80+80", "%s", "true");
+				break;
 		}
 	} else {
 		print_nss_ratio("20Mhz", false, nss_tbl->bw_20);
@@ -1117,8 +1182,8 @@ void print_vht_info(__u32 capa, const __u8 *mcs)
 		print_nss_ratio("80Mhz", false, nss_tbl->bw_80);
 		print_nss_ratio("160Mhz", false, nss_tbl->bw_160);
 		print_nss_ratio("80+80Mhz", false, nss_tbl->bw_80_80);
-		printf("\n");
 	}
+	json_obj_close();
 
 	PRINT_VHT_CAPA(4, "RX LDPC");
 	PRINT_VHT_CAPA(5, "short GI (80 MHz)");
@@ -1138,36 +1203,42 @@ void print_vht_info(__u32 capa, const __u8 *mcs)
 	PRINT_VHT_CAPA(28, "RX antenna pattern consistency");
 	PRINT_VHT_CAPA(29, "TX antenna pattern consistency");
 
-	printf("\t\tVHT RX MCS set:\n");
+
+	json_obj_open("VHT RX MCS set");
 	tmp = mcs[0] | (mcs[1] << 8);
 	for (i = 1; i <= 8; i++) {
-		printf("\t\t\t%d streams: ", i);
+		char buf[16];
+		snprintf(buf, sizeof(buf), "%d streams", i);
 		switch ((tmp >> ((i-1)*2) ) & 3) {
-		case 0: printf("MCS 0-7\n"); break;
-		case 1: printf("MCS 0-8\n"); break;
-		case 2: printf("MCS 0-9\n"); break;
-		case 3: printf("not supported\n"); break;
+			case 0: iw_printf(buf, "MCS 0-7"); break;
+			case 1: iw_printf(buf, "MCS 0-8"); break;
+			case 2: iw_printf(buf, "MCS 0-9"); break;
+			case 3: iw_printf(buf, "not supported"); break;
 		}
 	}
+	json_obj_close();
 	tmp = mcs[2] | (mcs[3] << 8);
-	printf("\t\tVHT RX highest supported: %d Mbps\n", tmp & 0x1fff);
+	
+	iw_printf("VHT RX highest supported Mbps", "%d", tmp & 0x1fff);
 
-	printf("\t\tVHT TX MCS set:\n");
+	json_obj_open("VHT TX MCS set");
 	tmp = mcs[4] | (mcs[5] << 8);
 	for (i = 1; i <= 8; i++) {
-		printf("\t\t\t%d streams: ", i);
+		char buf[16];
+		snprintf(buf, sizeof(buf), "%d streams", i);
 		switch ((tmp >> ((i-1)*2) ) & 3) {
-		case 0: printf("MCS 0-7\n"); break;
-		case 1: printf("MCS 0-8\n"); break;
-		case 2: printf("MCS 0-9\n"); break;
-		case 3: printf("not supported\n"); break;
+			case 0: iw_printf(buf, "MCS 0-7"); break;
+			case 1: iw_printf(buf, "MCS 0-8"); break;
+			case 2: iw_printf(buf, "MCS 0-9"); break;
+			case 3: iw_printf(buf, "not supported"); break;
 		}
 	}
+	json_obj_close();
+
 	tmp = mcs[6] | (mcs[7] << 8);
-	printf("\t\tVHT TX highest supported: %d Mbps\n", tmp & 0x1fff);
+	iw_printf("VHT TX highest supported Mbps", "%d", tmp & 0x1fff);
 
-	printf("\t\tVHT extended NSS: %ssupported\n",
-	       (tmp & (1 << 13)) ? "" : "not ");
+	iw_printf("VHT extended NSS: supported", "%s", (tmp & (1 << 13)) ? true : false);
 }
 
 static void __print_he_capa(const __u16 *mac_cap,
@@ -1183,13 +1254,13 @@ static void __print_he_capa(const __u16 *mac_cap,
 	#define PRINT_HE_CAP(_var, _idx, _bit, _str) \
 	do { \
 		if (_var[_idx] & BIT(_bit)) \
-			printf("%s\t\t\t" _str "\n", pre); \
+			iw_printf(NULL, _str); \
 	} while (0)
 
 	#define PRINT_HE_CAP_MASK(_var, _idx, _shift, _mask, _str) \
 	do { \
 		if ((_var[_idx] >> _shift) & _mask) \
-			printf("%s\t\t\t" _str ": %d\n", pre, (_var[_idx] >> _shift) & _mask); \
+			iw_printf(NULL, "%s %d", _str, (_var[_idx] >> _shift) & _mask); \
 	} while (0)
 
 	#define PRINT_HE_MAC_CAP(...) PRINT_HE_CAP(mac_cap, __VA_ARGS__)
@@ -1198,10 +1269,9 @@ static void __print_he_capa(const __u16 *mac_cap,
 	#define PRINT_HE_PHY_CAP0(_idx, _bit, ...) PRINT_HE_CAP(phy_cap, _idx, _bit + 8, __VA_ARGS__)
 	#define PRINT_HE_PHY_CAP_MASK(...) PRINT_HE_CAP_MASK(phy_cap, __VA_ARGS__)
 
-	printf("%s\t\tHE MAC Capabilities (0x", pre);
-	for (i = 0; i < 3; i++)
-		printf("%04x", mac_cap[i]);
-	printf("):\n");
+	iw_printf("he_mac_capabilities_raw", "%s 0x%04x%04x%04x", pre, mac_cap[0], mac_cap[1], mac_cap[2]);
+
+	json_arr_open("he_mac_capabilities");
 
 	PRINT_HE_MAC_CAP(0, 0, "+HTC HE Supported");
 	PRINT_HE_MAC_CAP(0, 1, "TWT Requester");
@@ -1238,10 +1308,21 @@ static void __print_he_capa(const __u16 *mac_cap,
 	PRINT_HE_MAC_CAP(2, 11, "UL 2x996-Tone RU");
 	PRINT_HE_MAC_CAP(2, 12, "OM Control UL MU Data Disable RX");
 
-	printf("%s\t\tHE PHY Capabilities: (0x", pre);
-	for (i = 0; i < 11; i++)
-		printf("%02x", ((__u8 *)phy_cap)[i + 1]);
-	printf("):\n");
+	{
+		char buf[64] = {0};
+		int bufleft = (int)sizeof(buf);
+		char *p = buf;
+		int written = 0;
+		for (i = 0; i < 11; i++){
+			written = snprintf(p, bufleft, "%02x", ((__u8 *)phy_cap)[i + 1]);
+			bufleft -= written;
+			p += written;
+		}
+
+		json_arr_close();
+		iw_printf("he_phy_capabilities_raw", "%s 0x%s", pre, buf);
+		json_arr_open("he_phy_capabilities");
+	}
 
 	PRINT_HE_PHY_CAP0(0, 1, "HE40/2.4GHz");
 	PRINT_HE_PHY_CAP0(0, 2, "HE40/HE80/5GHz");
@@ -1308,6 +1389,8 @@ static void __print_he_capa(const __u16 *mac_cap,
 	PRINT_HE_PHY_CAP(5, 4, "RX Full BW SU Using HE MU PPDU with Compression SIGB");
 	PRINT_HE_PHY_CAP(5, 5, "RX Full BW SU Using HE MU PPDU with Non-Compression SIGB");
 
+	json_arr_close();
+
 	mcs_used = 0;
 	for (i = 0; i < 3; i++) {
 		__u8 phy_cap_support[] = { BIT(1) | BIT(2), BIT(3), BIT(4) };
@@ -1323,19 +1406,26 @@ static void __print_he_capa(const __u16 *mac_cap,
 
 		for (j = 0; j < 2; j++) {
 			int k;
-			printf("%s\t\tHE %s MCS and NSS set %s MHz\n", pre, j ? "TX" : "RX", bw[i]);
+			char buf[128] = {0};
+			snprintf(buf, sizeof(buf), "%s_he_%s_mcs_and_nss_set", pre, j ? "tx" : "rx");
+			json_obj_open(buf);
+			iw_printf("width_mhz", "%s", bw[i]);
+			json_obj_open("streams");
 			for (k = 0; k < 8; k++) {
 				__u16 mcs = mcs_set[(i * 2) + j];
 				mcs >>= k * 2;
 				mcs &= 0x3;
-				printf("%s\t\t\t%d streams: ", pre, k + 1);
+				char keybuf[16];
+				snprintf(keybuf, sizeof(keybuf), "%s_%d_streams", pre, k + 1);
 				if (mcs == 3)
-					printf("not supported\n");
+					iw_printf(keybuf, "not supported");
 				else
-					printf("MCS 0-%d\n", 7 + (mcs * 2));
+					iw_printf(keybuf, "MCS 0-%d", 7 + (mcs * 2));
 			}
-
+			json_obj_close();
+			json_obj_close();
 		}
+
 		mcs_used += 2 * sizeof(mcs_set[0]);
 	}
 
@@ -1348,12 +1438,23 @@ static void __print_he_capa(const __u16 *mac_cap,
 			ppet_len = 0;
 	}
 
-	if (ppet_len && (phy_cap[3] & BIT(15))) {
-		printf("%s\t\tPPE Threshold ", pre);
-		for (i = 0; i < ppet_len; i++)
-			if (ppet[i])
-				printf("0x%02x ", ppet[i]);
-		printf("\n");
+	{
+		char buf[64];
+		char *p = buf;
+		int bufleft = (int)sizeof(buf);
+		int written = 0;
+
+		for (i = 0; i < ppet_len; i++){
+			if (ppet[i]){
+				written = snprintf(p, bufleft, "0x%02x ", ppet[i]);
+				bufleft -= written;
+				p += written;
+			}
+		}
+
+		if (ppet_len && (phy_cap[3] & BIT(15))) {
+			iw_printf("ppe_threshold", "%s", buf);
+		}
 	}
 }
 
@@ -1362,9 +1463,9 @@ void print_iftype_list(const char *name, const char *pfx, struct nlattr *attr)
 	struct nlattr *ift;
 	int rem;
 
-	printf("%s:\n", name);
-	nla_for_each_nested(ift, attr, rem)
-		printf("%s * %s\n", pfx, iftype_name(nla_type(ift)));
+	nla_for_each_nested(ift, attr, rem){
+		iw_printf(name, "%s * %s", pfx, iftype_name(nla_type(ift)));
+	}
 }
 
 void print_iftype_line(struct nlattr *attr)
@@ -1694,7 +1795,7 @@ int get_cf1(const struct chanmode *chanmode, unsigned long freq)
 				6435, 6515, 6595, 6675, 6755, 6835,
 				6195, 6995 };
 	unsigned int bw160[] = { 5180, 5500, 5955, 6115, 6275, 6435,
-				  6595, 6755, 6915 };
+				6595, 6755, 6915 };
 
 	switch (chanmode->width) {
 	case NL80211_CHAN_WIDTH_80:
-- 
2.42.0


