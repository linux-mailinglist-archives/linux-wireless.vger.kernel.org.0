Return-Path: <linux-wireless+bounces-4370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5897B871944
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 10:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D6D282137
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE1253365;
	Tue,  5 Mar 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCt1Zf7W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3870153371
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630015; cv=none; b=RKIMy0se+mTyJt76I9HEmxERp8/6p+xsJb1rKI7jQrfWCDXrdlpCPHFxTBl4oloTeAZwnyMrImgnGNzLooIW4WY0b9B/qK01eFTkaISpo5fl21NEfMe9QTp4Pm4vCjE4Sxpb6i52+8Kd33aaZuG4Df7p/HHjljO/uSEcWT0TPFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630015; c=relaxed/simple;
	bh=8tYBr4vyrCza+kGrJmx//V6O/Nvw711BnTzONS7/f08=;
	h=Message-ID:To:From:Date:Subject; b=VzpKtKi2ShBTiW4Pf9Krefn2tcS7RN5oi7j+HCbVILGDbZLRI+ikuDcBn3NFOYXBw4OsNl8qra39Tek0qhGlwG4Pm7lK2buRfYfT91lN1+y0FhnQMWVQGouQjwyqcIwa4t8c1M/uBQ/Hdh2VuRe+Z3SkqvW2w5T22huAFpq1toM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCt1Zf7W; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d309a23d76so41199461fa.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 Mar 2024 01:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709630007; x=1710234807; darn=vger.kernel.org;
        h=subject:date:from:to:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSwFMECUx2uIUbzh/MM197xma0a/G4siBr0K0QXUizk=;
        b=GCt1Zf7WGhY3vZmOFRZwI3hq3n8mOnkvzQPXMSAb/oLj+muYstbhfSb96VxIudlGI6
         OehKI7MZ6jHbQMkB4CaLVogWl9y00BUmhOc01kHLrwUj+eezmhOZS0XBlggAuBLC7b7Y
         r7momqJyK4PVbHJEhhsmG899mfpqi/tG1R2rgIyuyODeYAYs/YkFI3kkCQIl+zimm2TP
         pkhXZjTX3NScIxlsWEwaQXziI/zXVrt/qeYv01gYriqpaqmWDvcQ2wvIvhL5S7qYxOgS
         veaB5GdgZDpqwcwya6rr6N/EZ7Di9bUWeApcaf5VtVN5clZA/iN5hc5iGdrx7qni/z/o
         DhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709630007; x=1710234807;
        h=subject:date:from:to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSwFMECUx2uIUbzh/MM197xma0a/G4siBr0K0QXUizk=;
        b=ftshQEajji310x6ZJ60TEOnDEhyevRHv7rGRkn+O4Kt9/x1wVPth3Pj0+vUq0bxaNW
         NoT08sqWNPkYpc5n4gSCmvnJsEkJnkFw4lrNafJ4+LVZ7/fq4m5w4ZM0UXLssMFptUdK
         27Zj+4M7H/o9FiwsQ+UtrxUe2xRHItQbqL0PXvW2IIbHlrnrzxz7FLTpM/YpmY4ehGLX
         sQy1SINToVF7OuMRimN8+lE4OkWq0WOcJDFW5hLQ1rC37AIMt5238iPOGfn2hqMoAPsn
         IX9p2DmSuznL1vJSVNERpDHanBFsz0lVjYarxUSvH6souxK1M3Qs8aLaLonjUVmxfQ75
         pcwg==
X-Forwarded-Encrypted: i=1; AJvYcCUcTrWy8a6uwfQH/zfLTf/s6+5ljehAf4QE2NqnT4Vc95q/yvSa5tO0Cv0St3ViyUHaRktOvGOzufNsYSXMn/tpEmCfBwUaruXLimCQ07U=
X-Gm-Message-State: AOJu0YzzA3tiRCt+tsOVNeGXPgO4UU9u6qLDXrTXYN6VMtmONMBRqZnQ
	Ax+oK7oNy5RSsjuoAPOIHoEZMIwEFcJ6w8G5VXzqxvA+NAVYXq2JsDrOmy1YPC9Z1Q==
X-Google-Smtp-Source: AGHT+IHENC8A5fxeG+Peu7wemB3bmOVbX1yZCxgwwRizNmAeHa0lEi0YGosy5NuXQaPhFmzqiPQUcw==
X-Received: by 2002:a05:651c:c2:b0:2d3:2d30:d28 with SMTP id 2-20020a05651c00c200b002d32d300d28mr562931ljr.9.1709630006201;
        Tue, 05 Mar 2024 01:13:26 -0800 (PST)
Received: from localhost (nat-inorg.chem.msu.ru. [93.180.12.29])
        by smtp.gmail.com with ESMTPSA id b10-20020a2e894a000000b002d0d02e50fdsm2128751ljk.78.2024.03.05.01.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:13:25 -0800 (PST)
Message-ID: <d9739fa6d3dd085587c4f413087dfd6c.legale.legale@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
From: Isaev Ruslan <legale.legale@gmail.com>
Date: Mon, 4 Mar 2024 23:01:58 +0300
Subject: [PATCH v5] Add JSON output options to 'iw' for scan results
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

v5 changes:
	- add json print to print_ap_channel_report()
	- minor refactor open_json_object()

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
 Makefile           |    2 +-
 iw.c               |   27 +-
 iw.h               |    1 +
 json/json_print.c  |  206 +++++
 json/json_print.h  |   57 ++
 json/json_writer.c |  296 +++++++
 json/json_writer.h |   68 ++
 json/main.c        |   28 +
 scan.c             | 2117 ++++++++++++++++++++++++++++----------------
 util.c             |  492 +++++++---
 10 files changed, 2407 insertions(+), 887 deletions(-)
 create mode 100644 json/json_print.c
 create mode 100644 json/json_print.h
 create mode 100644 json/json_writer.c
 create mode 100644 json/json_writer.h
 create mode 100644 json/main.c

diff --git a/Makefile b/Makefile
index 2fb8db8..6cda648 100644
--- a/Makefile
+++ b/Makefile
@@ -19,7 +19,7 @@ CFLAGS += -Werror-implicit-function-declaration -Wsign-compare -Wno-unused-param
 CFLAGS += -Wdeclaration-after-statement
 CFLAGS += $(CFLAGS_EVAL)
 
-_OBJS := $(sort $(patsubst %.c,%.o,$(wildcard *.c)))
+_OBJS := $(sort $(patsubst %.c,%.o,$(wildcard *.c) json/json_writer.c json/json_print.c))
 VERSION_OBJS := $(filter-out version.o, $(_OBJS))
 OBJS := $(VERSION_OBJS) version.o
 
diff --git a/iw.c b/iw.c
index 35308ba..779a728 100644
--- a/iw.c
+++ b/iw.c
@@ -24,6 +24,8 @@
 #include "nl80211.h"
 #include "iw.h"
 
+#include "json/json_print.h"
+
 /* libnl 1.x compatibility code */
 #if !defined(CONFIG_LIBNL20) && !defined(CONFIG_LIBNL30)
 static inline struct nl_handle *nl_socket_alloc(void)
@@ -44,6 +46,7 @@ static inline int nl_socket_set_buffer_size(struct nl_sock *sk,
 #endif /* CONFIG_LIBNL20 && CONFIG_LIBNL30 */
 
 int iw_debug = 0;
+int iw_json = 0;
 
 static int nl80211_init(struct nl80211_state *state)
 {
@@ -181,7 +184,11 @@ static void __usage_cmd(const struct cmd *cmd, char *indent, bool full)
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
@@ -592,6 +599,20 @@ int main(int argc, char **argv)
 		argv++;
 	}
 
+	if (argc > 0 && strcmp(*argv, "-j") == 0) {
+		iw_json = 1;
+		new_json_obj(1, 0); //pretty print disabled
+		argc--;
+		argv++;
+	}
+
+	if (argc > 0 && strcmp(*argv, "-jj") == 0) {
+		iw_json = 1;
+		new_json_obj(1, 1); //pretty print enabled
+		argc--;
+		argv++;
+	}
+
 	if (argc > 0 && strcmp(*argv, "--version") == 0) {
 		version();
 		return 0;
@@ -648,5 +669,9 @@ int main(int argc, char **argv)
 
 	nl80211_cleanup(&nlstate);
 
+	//close root json object and deinit jsonw
+	if(iw_json){
+		delete_json_obj();
+	}
 	return err;
 }
diff --git a/iw.h b/iw.h
index e712c59..b97eb55 100644
--- a/iw.h
+++ b/iw.h
@@ -179,6 +179,7 @@ struct vendor_event {
 extern const char iw_version[];
 
 extern int iw_debug;
+extern int iw_json;
 
 int handle_cmd(struct nl80211_state *state, enum id_input idby,
 	       int argc, char **argv);
diff --git a/json/json_print.c b/json/json_print.c
new file mode 100644
index 0000000..e2772cf
--- /dev/null
+++ b/json/json_print.c
@@ -0,0 +1,206 @@
+/*
+ * json_print.c		"print regular or json output, based on json_writer".
+ *
+ *             This program is free software; you can redistribute it and/or
+ *             modify it under the terms of the GNU General Public License
+ *             as published by the Free Software Foundation; either version
+ *             2 of the License, or (at your option) any later version.
+ *
+ * Authors:    Julien Fortin, <julien@cumulusnetworks.com>
+ */
+#include "json_print.h"
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#define SPRINT_BSIZE 64
+#define SPRINT_BUF(x) char x[SPRINT_BSIZE]
+static json_writer_t *_jw;
+#define _IS_JSON_CONTEXT(type) ((type & PRINT_JSON || type & PRINT_ANY) && _jw)
+#define _IS_FP_CONTEXT(type) (!_jw && (type & PRINT_FP || type & PRINT_ANY))
+void new_json_obj(int json, bool is_pretty) {
+	if (json) {
+		_jw = jsonw_new(stdout);
+		if (!_jw) {
+			perror("json object");
+			exit(1);
+		}
+		jsonw_pretty(_jw, is_pretty);
+		jsonw_start_object(_jw);
+	}
+}
+void delete_json_obj(void) {
+	if (_jw) {
+		jsonw_end_object(_jw);
+		jsonw_destroy(&_jw);
+	}
+}
+bool is_json_context(void) {
+	return _jw != NULL;
+}
+json_writer_t *get_json_writer(void) {
+	return _jw;
+}
+void open_json_object(const char *fmt, ...) {
+	if (_IS_JSON_CONTEXT(PRINT_JSON)) {
+		char buffer[1024];
+		va_list args;
+		va_start(args, fmt);
+		vsnprintf(buffer, sizeof(buffer), fmt, args);
+		// if not empty
+		if (*buffer) {
+			jsonw_name(_jw, buffer);
+		}
+		jsonw_start_object(_jw);
+		va_end(args);
+	}
+}
+
+void close_json_object(void) {
+	if (_IS_JSON_CONTEXT(PRINT_JSON))
+		jsonw_end_object(_jw);
+}
+/*
+ * Start json array or string array using
+ * the provided string as json key (if not null)
+ * or array delimiter in non-json context.
+ */
+void open_json_array(const char *key, const char *str) {
+	if (is_json_context()) {
+		if (key)
+			jsonw_name(_jw, key);
+		jsonw_start_array(_jw);
+	} else {
+		printf("%s", str);
+	}
+}
+/*
+ * End json array or string array
+ */
+void close_json_array(const char *delim) {
+	if (is_json_context())
+		jsonw_end_array(_jw);
+	else
+		printf("%s", delim);
+}
+/*
+ * pre-processor directive to generate similar
+ * functions handling different types
+ */
+#define _PRINT_FUNC(type_name, type)                       \
+__attribute__((format(printf, 3, 0)))                      \
+void print_##type_name(                                    \
+	enum output_type t,                                    \
+	const char *key,                                       \
+	const char *fmt,                                       \
+	type value) {                                          \
+	if (_IS_JSON_CONTEXT(t)) {                             \
+		if (!key)                                          \
+			jsonw_##type_name(_jw, value);                 \
+		else                                               \
+			jsonw_##type_name##_field(_jw, key, value);    \
+	} else if (_IS_FP_CONTEXT(t)) {                        \
+		fprintf(stdout, fmt, value);                       \
+	}                                                      \
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
+#undef _PRINT_FUNC
+void print_string(enum output_type type, const char *key, const char *fmt, ...) {
+	va_list args;
+	va_start(args, fmt);
+
+	if (_IS_JSON_CONTEXT(type)) {
+		char buffer[1024];
+		vsnprintf(buffer, sizeof(buffer), fmt, args);
+		if (key) {
+			jsonw_string_field(_jw, key, buffer);
+		} else {
+			jsonw_string(_jw, buffer);
+		}
+	} else if (_IS_FP_CONTEXT(type)) {
+		vfprintf(stdout, fmt, args);
+	}
+
+	va_end(args);
+}
+/*
+ * value's type is bool. When using this function in FP context you can't pass
+ * a value to it, you will need to use "is_json_context()" to have different
+ * branch for json and regular output. grep -r "print_bool" for example
+ */
+void print_bool(enum output_type type,
+								const char *key,
+								const char *fmt,
+								bool value) {
+	if (_IS_JSON_CONTEXT(type)) {
+		if (key)
+			jsonw_bool_field(_jw, key, value);
+		else
+			jsonw_bool(_jw, value);
+	} else if (_IS_FP_CONTEXT(type)) {
+		fprintf(stdout, fmt, value ? "true" : "false");
+	}
+}
+/*
+ * In JSON context uses hardcode %#x format: 42 -> 0x2a
+ */
+void print_0xhex(enum output_type type,
+								 const char *key,
+								 const char *fmt,
+								 unsigned long long hex) {
+	if (_IS_JSON_CONTEXT(type)) {
+		SPRINT_BUF(b1);
+		snprintf(b1, sizeof(b1), "%#llx", hex);
+		print_string(PRINT_JSON, key, NULL, b1);
+	} else if (_IS_FP_CONTEXT(type)) {
+		fprintf(stdout, fmt, hex);
+	}
+}
+void print_hex(enum output_type type,
+							 const char *key,
+							 const char *fmt,
+							 unsigned int hex) {
+	if (_IS_JSON_CONTEXT(type)) {
+		SPRINT_BUF(b1);
+		snprintf(b1, sizeof(b1), "%x", hex);
+		if (key)
+			jsonw_string_field(_jw, key, b1);
+		else
+			jsonw_string(_jw, b1);
+	} else if (_IS_FP_CONTEXT(type)) {
+		fprintf(stdout, fmt, hex);
+	}
+}
+/*
+ * In JSON context we don't use the argument "value" we simply call jsonw_null
+ * whereas FP context can use "value" to output anything
+ */
+void print_null(enum output_type type,
+								const char *key,
+								const char *fmt,
+								const char *value) {
+	if (_IS_JSON_CONTEXT(type)) {
+		if (key)
+			jsonw_null_field(_jw, key);
+		else
+			jsonw_null(_jw);
+	} else if (_IS_FP_CONTEXT(type)) {
+		fprintf(stdout, fmt, value);
+	}
+}
+/* Print line separator (if not in JSON mode) */
+void print_nl(void) {
+	if (!_jw)
+		printf("%s", "\n");
+}
diff --git a/json/json_print.h b/json/json_print.h
new file mode 100644
index 0000000..4925803
--- /dev/null
+++ b/json/json_print.h
@@ -0,0 +1,57 @@
+/*
+ * json_print.h		"print regular or json output, based on json_writer".
+ *
+ *             This program is free software; you can redistribute it and/or
+ *             modify it under the terms of the GNU General Public License
+ *             as published by the Free Software Foundation; either version
+ *             2 of the License, or (at your option) any later version.
+ *
+ * Authors:    Julien Fortin, <julien@cumulusnetworks.com>
+ */
+#ifndef _JSON_PRINT_H_
+#define _JSON_PRINT_H_
+#include "json_writer.h"
+json_writer_t *get_json_writer(void);
+/*
+ * use:
+ *      - PRINT_ANY for context based output
+ *      - PRINT_FP for non json specific output
+ *      - PRINT_JSON for json specific output
+ */
+enum output_type {
+	PRINT_FP = 1,
+	PRINT_JSON = 2,
+	PRINT_ANY = 4,
+};
+void new_json_obj(int json, bool is_pretty);
+void delete_json_obj(void);
+bool is_json_context(void);
+void fflush_fp(void);
+void open_json_object(const char *fmt, ...);
+void close_json_object(void);
+void open_json_array(const char *key, const char *str);
+void close_json_array(const char *delim);
+void print_nl(void);
+#define _PRINT_FUNC(type_name, type)         \
+	void print_##type_name(enum output_type t, \
+												 const char *key,    \
+												 const char *fmt,    \
+												 type value)
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
+_PRINT_FUNC(null, const char *);
+_PRINT_FUNC(hex, unsigned int);
+_PRINT_FUNC(0xhex, unsigned long long);
+#undef _PRINT_FUNC
+
+void print_string(enum output_type type, const char *key, const char *fmt, ...);
+#endif /* _JSON_PRINT_H_ */
diff --git a/json/json_writer.c b/json/json_writer.c
new file mode 100644
index 0000000..ae59389
--- /dev/null
+++ b/json/json_writer.c
@@ -0,0 +1,296 @@
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
+struct json_writer {
+	FILE *out;					/* output file */
+	unsigned int depth; /* nesting */
+	bool pretty;				/* optional whitepace */
+	char sep;						/* either nul or comma */
+};
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
index 0000000..a092e56
--- /dev/null
+++ b/json/json_writer.h
@@ -0,0 +1,68 @@
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
+typedef struct json_writer json_writer_t;
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
index 0000000..21d7cf4
--- /dev/null
+++ b/json/main.c
@@ -0,0 +1,28 @@
+#include <stdio.h>
+#include <stdint.h>
+
+#include "json_print.h"
+
+
+int main() {
+    // init json print without pretty print
+	new_json_obj(1, 0);
+	open_json_object("tx");
+	print_u64(PRINT_JSON, "bytes", NULL, 1);
+	print_u64(PRINT_JSON, "packets", NULL, 1);
+	print_u64(PRINT_JSON, "errors", NULL, 1);
+	print_u64(PRINT_JSON, "dropped", NULL, 1);
+    open_json_array("hobbies", NULL); // create object entry hobbies with array
+    print_string(PRINT_JSON, NULL, "%s", "Reading");
+    print_string(PRINT_JSON, NULL, "%s", "Hiking");
+    print_string(PRINT_JSON, NULL, "%s", "Coding");
+	close_json_array(NULL);
+	close_json_object();
+
+
+    // finish
+    delete_json_obj();
+
+    return 0;
+}
+
diff --git a/scan.c b/scan.c
index dfc136a..f04efb1 100644
--- a/scan.c
+++ b/scan.c
@@ -12,6 +12,8 @@
 #include "nl80211.h"
 #include "iw.h"
 
+#include "json/json_print.h"
+
 #define WLAN_CAPABILITY_ESS		(1<<0)
 #define WLAN_CAPABILITY_IBSS		(1<<1)
 #define WLAN_CAPABILITY_CF_POLLABLE	(1<<2)
@@ -546,10 +548,13 @@ static int handle_scan(struct nl80211_state *state,
 
 static void tab_on_first(bool *first)
 {
-	if (!*first)
-		printf("\t");
-	else
+	if (!*first){
+		if(!iw_json){
+			printf("\t");
+		}
+	}else{
 		*first = false;
+	}
 }
 
 struct print_ies_data {
@@ -560,9 +565,13 @@ struct print_ies_data {
 static void print_ssid(const uint8_t type, uint8_t len, const uint8_t *data,
 		       const struct print_ies_data *ie_buffer)
 {
-	printf(" ");
-	print_ssid_escaped(len, data);
-	printf("\n");
+	if(!iw_json){
+		printf(" ");
+		print_ssid_escaped(len, data);
+		printf("\n");
+	} else {
+		print_ssid_escaped(len, data);
+	}
 }
 
 #define BSS_MEMBERSHIP_SELECTOR_VHT_PHY 126
@@ -574,21 +583,35 @@ static void print_supprates(const uint8_t type, uint8_t len,
 {
 	int i;
 
-	printf(" ");
-
-	for (i = 0; i < len; i++) {
-		int r = data[i] & 0x7f;
+	if(iw_json){
+		open_json_array("array", NULL);
+		for (i = 0; i < len; i++) {
+			int r = data[i] & 0x7f;
+			if (r == BSS_MEMBERSHIP_SELECTOR_VHT_PHY && data[i] & 0x80){
+				print_string(PRINT_JSON, NULL, "VHT%s", data[i] & 0x80 ? "*" : "");
+			} else if (r == BSS_MEMBERSHIP_SELECTOR_HT_PHY && data[i] & 0x80){
+				print_string(PRINT_JSON, NULL, "HT%s", data[i] & 0x80 ? "*" : "");
+			} else {
+				print_string(PRINT_JSON, NULL, "%d.%d%s", r/2, 5*(r&1), data[i] & 0x80 ? "*" : "");
+			}
+		}
+		close_json_array(NULL);
+	}else{
+		printf(" ");
+		for (i = 0; i < len; i++) {
+			int r = data[i] & 0x7f;
 
-		if (r == BSS_MEMBERSHIP_SELECTOR_VHT_PHY && data[i] & 0x80)
-			printf("VHT");
-		else if (r == BSS_MEMBERSHIP_SELECTOR_HT_PHY && data[i] & 0x80)
-			printf("HT");
-		else
-			printf("%d.%d", r/2, 5*(r&1));
+			if (r == BSS_MEMBERSHIP_SELECTOR_VHT_PHY && data[i] & 0x80)
+				printf("VHT");
+			else if (r == BSS_MEMBERSHIP_SELECTOR_HT_PHY && data[i] & 0x80)
+				printf("HT");
+			else
+				printf("%d.%d", r/2, 5*(r&1));
 
-		printf("%s ", data[i] & 0x80 ? "*" : "");
+			printf("%s ", data[i] & 0x80 ? "*" : "");
+		}
+		printf("\n");
 	}
-	printf("\n");
 }
 
 static void print_rm_enabled_capabilities(const uint8_t type, uint8_t len,
@@ -601,16 +624,18 @@ static void print_rm_enabled_capabilities(const uint8_t type, uint8_t len,
 		     ((__u64) data[3]) << 24 |
 		     ((__u64) data[4]) << 32;
 
-	printf("\n");
-	printf("\t\tCapabilities: 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
-							     data[0], data[1],
-							     data[2], data[3],
-							     data[4]);
+	if(iw_json){
+		print_string(PRINT_JSON, "capabilities_raw", "0x%02x 0x%02x 0x%02x 0x%02x 0x%02x", data[0], data[1], data[2], data[3], data[4]);
+		open_json_array("capabilities", NULL);
+	}else{
+		printf("\n");
+		printf("\t\tCapabilities: 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",data[0], data[1], data[2], data[3], data[4]);
+	}
 
 #define PRINT_RM_CAPA(_bit, _str) \
 	do { \
 		if (capa & BIT(_bit)) \
-			printf("\t\t\t" _str "\n"); \
+			iw_json ? print_string(PRINT_JSON, NULL, _str) : printf("\t\t\t" _str "\n"); \
 	} while (0)
 
 	PRINT_RM_CAPA(0, "Link Measurement");
@@ -642,14 +667,24 @@ static void print_rm_enabled_capabilities(const uint8_t type, uint8_t len,
 	PRINT_RM_CAPA(34, "FTM Range Report");
 	PRINT_RM_CAPA(35, "Civic Location Measurement");
 
-	printf("\t\tNonoperating Channel Max Measurement Duration: %i\n", data[3] >> 5);
-	printf("\t\tMeasurement Pilot Capability: %i\n", data[4] & 7);
+	if(iw_json){
+		close_json_array(NULL);
+		print_int(PRINT_JSON, "nonoperating_channel_max_measurement_duration", "%d", data[3] >> 5);
+		print_int(PRINT_JSON, "measurement_pilot_capability", "%d", data[4] & 7);
+	}else{
+		printf("\t\tNonoperating Channel Max Measurement Duration: %i\n", data[3] >> 5);
+		printf("\t\tMeasurement Pilot Capability: %i\n", data[4] & 7);
+	}
 }
 
 static void print_ds(const uint8_t type, uint8_t len, const uint8_t *data,
 		     const struct print_ies_data *ie_buffer)
 {
-	printf(" channel %d\n", data[0]);
+	if(iw_json){
+		print_int(PRINT_JSON, "channel", "%d", data[0]);
+	}else{
+		printf(" channel %d\n", data[0]);
+	}
 }
 
 static const char *country_env_str(char environment)
@@ -669,46 +704,90 @@ static const char *country_env_str(char environment)
 static void print_country(const uint8_t type, uint8_t len, const uint8_t *data,
 			  const struct print_ies_data *ie_buffer)
 {
-	printf(" %.*s", 2, data);
+	if(iw_json){
+		print_string(PRINT_JSON, "country", "%.*s", 2, data);
+		print_string(PRINT_JSON, "environment", "%s", country_env_str(data[2]));
 
-	printf("\tEnvironment: %s\n", country_env_str(data[2]));
+		data += 3;
+		len -= 3;
 
-	data += 3;
-	len -= 3;
+		if (len < 3) {
+			print_bool(PRINT_JSON, "no_country_ie_triplets_present", "%s", true);
+			return;
+		}
 
-	if (len < 3) {
-		printf("\t\tNo country IE triplets present\n");
-		return;
-	}
+		open_json_object("channels");
+		while (len >= 3) {
+			int end_channel;
+			union ieee80211_country_ie_triplet *triplet = (void *) data;
 
-	while (len >= 3) {
-		int end_channel;
-		union ieee80211_country_ie_triplet *triplet = (void *) data;
+			if (triplet->ext.reg_extension_id >= IEEE80211_COUNTRY_EXTENSION_ID) {
+				print_int(PRINT_JSON, "extension id", "%d", triplet->ext.reg_extension_id);
+				print_int(PRINT_JSON, "regulatory class", "%d", triplet->ext.reg_class);
+				print_int(PRINT_JSON, "coverage class", "%d", triplet->ext.coverage_class);
+				print_int(PRINT_JSON, "coverage class up to", "%d", triplet->ext.coverage_class * 450);
+
+				data += 3;
+				len -= 3;
+				continue;
+			}
 
-		if (triplet->ext.reg_extension_id >= IEEE80211_COUNTRY_EXTENSION_ID) {
-			printf("\t\tExtension ID: %d Regulatory Class: %d Coverage class: %d (up to %dm)\n",
-			       triplet->ext.reg_extension_id,
-			       triplet->ext.reg_class,
-			       triplet->ext.coverage_class,
-			       triplet->ext.coverage_class * 450);
+			/* 2 GHz */
+			if (triplet->chans.first_channel <= 14)
+				end_channel = triplet->chans.first_channel + (triplet->chans.num_channels - 1);
+			else
+				end_channel =  triplet->chans.first_channel + (4 * (triplet->chans.num_channels - 1));
 
+			open_json_object("%d", triplet->chans.first_channel);
+			print_int(PRINT_JSON, "first", "%d", triplet->chans.first_channel);
+			print_int(PRINT_JSON, "end", "%d", end_channel);
+			print_int(PRINT_JSON, "max power dbm", "%d", triplet->chans.max_power);
+			close_json_object();
 			data += 3;
 			len -= 3;
-			continue;
 		}
+		close_json_object();
+	}else{
+		printf(" %.*s", 2, data);
 
-		/* 2 GHz */
-		if (triplet->chans.first_channel <= 14)
-			end_channel = triplet->chans.first_channel + (triplet->chans.num_channels - 1);
-		else
-			end_channel =  triplet->chans.first_channel + (4 * (triplet->chans.num_channels - 1));
-
-		printf("\t\tChannels [%d - %d] @ %d dBm\n", triplet->chans.first_channel, end_channel, triplet->chans.max_power);
+		printf("\tEnvironment: %s\n", country_env_str(data[2]));
 
 		data += 3;
 		len -= 3;
-	}
 
+		if (len < 3) {
+			printf("\t\tNo country IE triplets present\n");
+			return;
+		}
+
+		while (len >= 3) {
+			int end_channel;
+			union ieee80211_country_ie_triplet *triplet = (void *) data;
+
+			if (triplet->ext.reg_extension_id >= IEEE80211_COUNTRY_EXTENSION_ID) {
+				printf("\t\tExtension ID: %d Regulatory Class: %d Coverage class: %d (up to %dm)\n",
+					triplet->ext.reg_extension_id,
+					triplet->ext.reg_class,
+					triplet->ext.coverage_class,
+					triplet->ext.coverage_class * 450);
+
+				data += 3;
+				len -= 3;
+				continue;
+			}
+
+			/* 2 GHz */
+			if (triplet->chans.first_channel <= 14)
+				end_channel = triplet->chans.first_channel + (triplet->chans.num_channels - 1);
+			else
+				end_channel =  triplet->chans.first_channel + (4 * (triplet->chans.num_channels - 1));
+
+			printf("\t\tChannels [%d - %d] @ %d dBm\n", triplet->chans.first_channel, end_channel, triplet->chans.max_power);
+
+			data += 3;
+			len -= 3;
+		}
+	}
 	return;
 }
 
@@ -716,29 +795,37 @@ static void print_powerconstraint(const uint8_t type, uint8_t len,
 				  const uint8_t *data,
 				  const struct print_ies_data *ie_buffer)
 {
-	printf(" %d dB\n", data[0]);
+	if(iw_json){
+		print_int(PRINT_JSON, "db", "%d", data[0]);
+	}else{
+		printf(" %d dB\n", data[0]);
+	}
 }
 
 static void print_tpcreport(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
 			    const struct print_ies_data *ie_buffer)
 {
-	printf(" TX power: %d dBm\n", data[0]);
-	/* printf(" Link Margin (%d dB) is reserved in Beacons\n", data[1]); */
+	if(iw_json){
+		print_int(PRINT_JSON, "tx_power_dbm", "%d", data[0]);
+	}else{
+		printf(" TX power: %d dBm\n", data[0]);
+		/* printf(" Link Margin (%d dB) is reserved in Beacons\n", data[1]); */
+	}
 }
 
 static void print_erp(const uint8_t type, uint8_t len, const uint8_t *data,
 		      const struct print_ies_data *ie_buffer)
 {
 	if (data[0] == 0x00)
-		printf(" <no flags>");
+		iw_json ? print_bool(PRINT_JSON, "no_flags", "%s", true) : printf(" <no flags>");
 	if (data[0] & 0x01)
-		printf(" NonERP_Present");
+		iw_json ? print_bool(PRINT_JSON, "nonerp_present", "%s", true) : printf(" NonERP_Present");
 	if (data[0] & 0x02)
-		printf(" Use_Protection");
+		iw_json ? print_bool(PRINT_JSON, "use_protection", "%s", true) : printf(" Use_Protection");
 	if (data[0] & 0x04)
-		printf(" Barker_Preamble_Mode");
-	printf("\n");
+		iw_json ? print_bool(PRINT_JSON, "barker_preamble_mode", "%s", true) : printf(" Barker_Preamble_Mode");
+	if(!iw_json) printf("\n");
 }
 
 static void print_ap_channel_report(const uint8_t type, uint8_t len, const uint8_t *data,
@@ -747,13 +834,22 @@ static void print_ap_channel_report(const uint8_t type, uint8_t len, const uint8
 	uint8_t oper_class = data[0];
 	int i;
 
-	printf("\n");
-	printf("\t\t * operating class: %d\n", oper_class);
-	printf("\t\t * channel(s):");
-	for (i = 1; i < len; ++i) {
-		printf(" %d", data[i]);
+	if(iw_json){
+		print_int(PRINT_JSON, "operating_class", "%d", oper_class);
+		open_json_array("channels", NULL);
+		for (i = 1; i < len; ++i) {
+			print_int(PRINT_JSON, NULL, "%d", data[i]);
+		}
+		close_json_array(NULL);
+	}else{
+		printf("\n");
+		printf("\t\t * operating class: %d\n", oper_class);
+		printf("\t\t * channel(s):");
+		for (i = 1; i < len; ++i) {
+			printf(" %d", data[i]);
+		}
+		printf("\n");
 	}
-	printf("\n");
 }
 
 static void print_cipher(const uint8_t *data)
@@ -761,59 +857,56 @@ static void print_cipher(const uint8_t *data)
 	if (memcmp(data, ms_oui, 3) == 0) {
 		switch (data[3]) {
 		case 0:
-			printf("Use group cipher suite");
+			iw_json ? print_string(PRINT_JSON, NULL, "Use group cipher suite") : printf("Use group cipher suite");
 			break;
 		case 1:
-			printf("WEP-40");
+			iw_json ? print_string(PRINT_JSON, NULL, "WEP-40") : printf("WEP-40");
 			break;
 		case 2:
-			printf("TKIP");
+			iw_json ? print_string(PRINT_JSON, NULL, "TKIP") : printf("TKIP");
 			break;
 		case 4:
-			printf("CCMP");
+			iw_json ? print_string(PRINT_JSON, NULL, "CCMP") : printf("CCMP");
 			break;
 		case 5:
-			printf("WEP-104");
+			iw_json ? print_string(PRINT_JSON, NULL, "WEP-104") : printf("WEP-104");
 			break;
 		default:
-			printf("%.02x-%.02x-%.02x:%d",
-				data[0], data[1] ,data[2], data[3]);
+			iw_json ? print_string(PRINT_JSON, NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]) : printf("%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 			break;
 		}
 	} else if (memcmp(data, ieee80211_oui, 3) == 0) {
 		switch (data[3]) {
 		case 0:
-			printf("Use group cipher suite");
+			iw_json ? print_string(PRINT_JSON, NULL, "Use group cipher suite") : printf("Use group cipher suite");
 			break;
 		case 1:
-			printf("WEP-40");
+			iw_json ? print_string(PRINT_JSON, NULL, "WEP-40") : printf("WEP-40");
 			break;
 		case 2:
-			printf("TKIP");
+			iw_json ? print_string(PRINT_JSON, NULL, "TKIP") : printf("TKIP");
 			break;
 		case 4:
-			printf("CCMP");
+			iw_json ? print_string(PRINT_JSON, NULL, "CCMP") : printf("CCMP");
 			break;
 		case 5:
-			printf("WEP-104");
+			iw_json ? print_string(PRINT_JSON, NULL, "WEP-104") : printf("WEP-104");
 			break;
 		case 6:
-			printf("AES-128-CMAC");
+			iw_json ? print_string(PRINT_JSON, NULL, "AES-128-CMAC") : printf("AES-128-CMAC");
 			break;
 		case 7:
-			printf("NO-GROUP");
+			iw_json ? print_string(PRINT_JSON, NULL, "NO-GROUP") : printf("NO-GROUP");
 			break;
 		case 8:
-			printf("GCMP");
+			iw_json ? print_string(PRINT_JSON, NULL, "GCMP") : printf("GCMP");
 			break;
 		default:
-			printf("%.02x-%.02x-%.02x:%d",
-				data[0], data[1] ,data[2], data[3]);
+			iw_json ? print_string(PRINT_JSON, NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]) : printf("%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 			break;
 		}
 	} else
-		printf("%.02x-%.02x-%.02x:%d",
-			data[0], data[1] ,data[2], data[3]);
+		iw_json ? print_string(PRINT_JSON, NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]) : printf("%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 }
 
 static void print_auth(const uint8_t *data)
@@ -821,90 +914,86 @@ static void print_auth(const uint8_t *data)
 	if (memcmp(data, ms_oui, 3) == 0) {
 		switch (data[3]) {
 		case 1:
-			printf("IEEE 802.1X");
+			iw_json ? print_string(PRINT_JSON, NULL, "IEEE 802.1X") : printf("IEEE 802.1X");
 			break;
 		case 2:
-			printf("PSK");
+			iw_json ? print_string(PRINT_JSON, NULL, "PSK") : printf("PSK");
 			break;
 		default:
-			printf("%.02x-%.02x-%.02x:%d",
-				data[0], data[1] ,data[2], data[3]);
+			iw_json ? print_string(PRINT_JSON, NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]) : printf("%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 			break;
 		}
 	} else if (memcmp(data, ieee80211_oui, 3) == 0) {
 		switch (data[3]) {
 		case 1:
-			printf("IEEE 802.1X");
+			iw_json ? print_string(PRINT_JSON, NULL, "IEEE 802.1X") : printf("IEEE 802.1X");
 			break;
 		case 2:
-			printf("PSK");
+			iw_json ? print_string(PRINT_JSON, NULL, "PSK") : printf("PSK");
 			break;
 		case 3:
-			printf("FT/IEEE 802.1X");
+			iw_json ? print_string(PRINT_JSON, NULL, "FT/IEEE 802.1X") : printf("FT/IEEE 802.1X");
 			break;
 		case 4:
-			printf("FT/PSK");
+			iw_json ? print_string(PRINT_JSON, NULL, "FT/PSK") : printf("FT/PSK");
 			break;
 		case 5:
-			printf("IEEE 802.1X/SHA-256");
+			iw_json ? print_string(PRINT_JSON, NULL, "IEEE 802.1X/SHA-256") : printf("IEEE 802.1X/SHA-256");
 			break;
 		case 6:
-			printf("PSK/SHA-256");
+			iw_json ? print_string(PRINT_JSON, NULL, "PSK/SHA-256") : printf("PSK/SHA-256");
 			break;
 		case 7:
-			printf("TDLS/TPK");
+			iw_json ? print_string(PRINT_JSON, NULL, "TDLS/TPK") : printf("TDLS/TPK");
 			break;
 		case 8:
-			printf("SAE");
+			iw_json ? print_string(PRINT_JSON, NULL, "SAE") : printf("SAE");
 			break;
 		case 9:
-			printf("FT/SAE");
+			iw_json ? print_string(PRINT_JSON, NULL, "FT/SAE") : printf("FT/SAE");
 			break;
 		case 11:
-			printf("IEEE 802.1X/SUITE-B");
+			iw_json ? print_string(PRINT_JSON, NULL, "IEEE 802.1X/SUITE-B") : printf("IEEE 802.1X/SUITE-B");
 			break;
 		case 12:
-			printf("IEEE 802.1X/SUITE-B-192");
+			iw_json ? print_string(PRINT_JSON, NULL, "IEEE 802.1X/SUITE-B-192") : printf("IEEE 802.1X/SUITE-B-192");
 			break;
 		case 13:
-			printf("FT/IEEE 802.1X/SHA-384");
+			iw_json ? print_string(PRINT_JSON, NULL, "FT/IEEE 802.1X/SHA-384") : printf("FT/IEEE 802.1X/SHA-384");
 			break;
 		case 14:
-			printf("FILS/SHA-256");
+			iw_json ? print_string(PRINT_JSON, NULL, "FILS/SHA-256") : printf("FILS/SHA-256");
 			break;
 		case 15:
-			printf("FILS/SHA-384");
+			iw_json ? print_string(PRINT_JSON, NULL, "FILS/SHA-384") : printf("FILS/SHA-384");
 			break;
 		case 16:
-			printf("FT/FILS/SHA-256");
+			iw_json ? print_string(PRINT_JSON, NULL, "FT/FILS/SHA-256") : printf("FT/FILS/SHA-256");
 			break;
 		case 17:
-			printf("FT/FILS/SHA-384");
+			iw_json ? print_string(PRINT_JSON, NULL, "FT/FILS/SHA-384") : printf("FT/FILS/SHA-384");
 			break;
 		case 18:
-			printf("OWE");
+			iw_json ? print_string(PRINT_JSON, NULL, "OWE") : printf("OWE");
 			break;
 		default:
-			printf("%.02x-%.02x-%.02x:%d",
-				data[0], data[1] ,data[2], data[3]);
+			iw_json ? print_string(PRINT_JSON, NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]) : printf("%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 			break;
 		}
 	} else if (memcmp(data, wfa_oui, 3) == 0) {
 		switch (data[3]) {
 		case 1:
-			printf("OSEN");
+			iw_json ? print_string(PRINT_JSON, NULL, "OSEN") : printf("OSEN");
 			break;
 		case 2:
-			printf("DPP");
+			iw_json ? print_string(PRINT_JSON, NULL, "DPP") : printf("DPP");
 			break;
 		default:
-			printf("%.02x-%.02x-%.02x:%d",
-				data[0], data[1] ,data[2], data[3]);
+			iw_json ? print_string(PRINT_JSON, NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]) : printf("%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 			break;
 		}
 	} else
-		printf("%.02x-%.02x-%.02x:%d",
-			data[0], data[1] ,data[2], data[3]);
+		iw_json ? print_string(PRINT_JSON, NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]) : printf("%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 }
 
 static void _print_rsn_ie(const char *defcipher, const char *defauth,
@@ -913,158 +1002,305 @@ static void _print_rsn_ie(const char *defcipher, const char *defauth,
 	bool first = true;
 	__u16 count, capa;
 	int i;
+	if(iw_json){
+		if (!is_osen) {
+			__u16 version;
+			version = data[0] + (data[1] << 8);
+			print_int(PRINT_JSON, "version", "%d", version);
+			data += 2;
+			len -= 2;
+		}
+
+		if (len < 4) {
+			print_string(PRINT_JSON, "group_cipher", "%s", defcipher);
+			print_string(PRINT_JSON, "Pairwise ciphers", "%s", defcipher);
+			return;
+		}
 
-	if (!is_osen) {
-		__u16 version;
-		version = data[0] + (data[1] << 8);
 		tab_on_first(&first);
-		printf("\t * Version: %d\n", version);
+		open_json_array("group_cipher_data", NULL);
+		print_cipher(data);
+		close_json_array(NULL);
 
-		data += 2;
-		len -= 2;
-	}
+		data += 4;
+		len -= 4;
+
+		if (len < 2) {
+			print_string(PRINT_JSON, "pairwise_ciphers", "%s", defcipher);
+			return;
+		}
+
+		count = data[0] | (data[1] << 8);
+		if (2 + (count * 4) > len)
+			goto invalid;
 
-	if (len < 4) {
 		tab_on_first(&first);
-		printf("\t * Group cipher: %s\n", defcipher);
-		printf("\t * Pairwise ciphers: %s\n", defcipher);
-		return;
-	}
+		open_json_array("pairwise_ciphers_data", NULL);
+		for (i = 0; i < count; i++) {
+			print_cipher(data + 2 + (i * 4));
+		}
+		close_json_array(NULL);
 
-	tab_on_first(&first);
-	printf("\t * Group cipher: ");
-	print_cipher(data);
-	printf("\n");
+		data += 2 + (count * 4);
+		len -= 2 + (count * 4);
 
-	data += 4;
-	len -= 4;
+		if (len < 2) {
+			print_string(PRINT_JSON, "authentication_suites", "%s", defauth);
+			return;
+		}
 
-	if (len < 2) {
-		tab_on_first(&first);
-		printf("\t * Pairwise ciphers: %s\n", defcipher);
-		return;
-	}
+		count = data[0] | (data[1] << 8);
+		if (2 + (count * 4) > len)
+			goto invalid;
 
-	count = data[0] | (data[1] << 8);
-	if (2 + (count * 4) > len)
-		goto invalid;
+		open_json_array("authentication_suites_data", NULL);
+		for (i = 0; i < count; i++) {
+			print_auth(data + 2 + (i * 4));
+		}
+		close_json_array(NULL);
+
+		data += 2 + (count * 4);
+		len -= 2 + (count * 4);
+
+		if (len >= 2) {
+			capa = data[0] | (data[1] << 8);
+			print_string(PRINT_JSON, "capabilities_raw", "0x%.4x", capa);
+
+			open_json_array("capabilities", NULL);
+			if (capa & 0x0001)
+				print_string(PRINT_JSON, NULL, "PreAuth");
+			if (capa & 0x0002)
+				print_string(PRINT_JSON, NULL, "NoPairwise");
+			switch ((capa & 0x000c) >> 2) {
+			case 0:
+				print_string(PRINT_JSON, NULL, "1-PTKSA-RC");
+				break;
+			case 1:
+				print_string(PRINT_JSON, NULL, "2-PTKSA-RC");
+				break;
+			case 2:
+				print_string(PRINT_JSON, NULL, "4-PTKSA-RC");
+				break;
+			case 3:
+				print_string(PRINT_JSON, NULL, "16-PTKSA-RC");
+				break;
+			}
+			switch ((capa & 0x0030) >> 4) {
+			case 0:
+				print_string(PRINT_JSON, NULL, "1-GTKSA-RC");
+				break;
+			case 1:
+				print_string(PRINT_JSON, NULL, "2-GTKSA-RC");
+				break;
+			case 2:
+				print_string(PRINT_JSON, NULL, "4-GTKSA-RC");
+				break;
+			case 3:
+				print_string(PRINT_JSON, NULL, "16-GTKSA-RC");
+				break;
+			}
+			if (capa & 0x0040)
+				print_string(PRINT_JSON, NULL, "MFP-required");
+			if (capa & 0x0080)
+				print_string(PRINT_JSON, NULL, "MFP-capable");
+			if (capa & 0x0200)
+				print_string(PRINT_JSON, NULL, "Peerkey-enabled");
+			if (capa & 0x0400)
+				print_string(PRINT_JSON, NULL, "SPP-AMSDU-capable");
+			if (capa & 0x0800)
+				print_string(PRINT_JSON, NULL, "SPP-AMSDU-required");
+			if (capa & 0x2000)
+				print_string(PRINT_JSON, NULL, "Extended-Key-ID");
+			close_json_array(NULL);
+
+			data += 2;
+			len -= 2;
+		}
 
-	tab_on_first(&first);
-	printf("\t * Pairwise ciphers:");
-	for (i = 0; i < count; i++) {
-		printf(" ");
-		print_cipher(data + 2 + (i * 4));
-	}
-	printf("\n");
+		if (len >= 2) {
+			int pmkid_count = data[0] | (data[1] << 8);
 
-	data += 2 + (count * 4);
-	len -= 2 + (count * 4);
+			if (len >= 2 + 16 * pmkid_count) {
+				print_int(PRINT_JSON, "pmkids_count", "%d", pmkid_count);
+				/* not printing PMKID values */
+				data += 2 + 16 * pmkid_count;
+				len -= 2 + 16 * pmkid_count;
+			} else
+				goto invalid;
+		}
 
-	if (len < 2) {
-		tab_on_first(&first);
-		printf("\t * Authentication suites: %s\n", defauth);
-		return;
-	}
+		if (len >= 4) {
+			tab_on_first(&first);
+			open_json_array("group_mgmt_cipher_suite_data", NULL);
+			print_cipher(data);
+			close_json_array(NULL);
+			data += 4;
+			len -= 4;
+		}
 
-	count = data[0] | (data[1] << 8);
-	if (2 + (count * 4) > len)
-		goto invalid;
+	}else{
+		if (!is_osen) {
+			__u16 version;
+			version = data[0] + (data[1] << 8);
+			tab_on_first(&first);
+			printf("\t * Version: %d\n", version);
 
-	tab_on_first(&first);
-	printf("\t * Authentication suites:");
-	for (i = 0; i < count; i++) {
-		printf(" ");
-		print_auth(data + 2 + (i * 4));
-	}
-	printf("\n");
+			data += 2;
+			len -= 2;
+		}
 
-	data += 2 + (count * 4);
-	len -= 2 + (count * 4);
+		if (len < 4) {
+			tab_on_first(&first);
+			printf("\t * Group cipher: %s\n", defcipher);
+			printf("\t * Pairwise ciphers: %s\n", defcipher);
+			return;
+		}
 
-	if (len >= 2) {
-		capa = data[0] | (data[1] << 8);
 		tab_on_first(&first);
-		printf("\t * Capabilities:");
-		if (capa & 0x0001)
-			printf(" PreAuth");
-		if (capa & 0x0002)
-			printf(" NoPairwise");
-		switch ((capa & 0x000c) >> 2) {
-		case 0:
-			printf(" 1-PTKSA-RC");
-			break;
-		case 1:
-			printf(" 2-PTKSA-RC");
-			break;
-		case 2:
-			printf(" 4-PTKSA-RC");
-			break;
-		case 3:
-			printf(" 16-PTKSA-RC");
-			break;
+		printf("\t * Group cipher: ");
+		print_cipher(data);
+		printf("\n");
+
+		data += 4;
+		len -= 4;
+
+		if (len < 2) {
+			tab_on_first(&first);
+			printf("\t * Pairwise ciphers: %s\n", defcipher);
+			return;
 		}
-		switch ((capa & 0x0030) >> 4) {
-		case 0:
-			printf(" 1-GTKSA-RC");
-			break;
-		case 1:
-			printf(" 2-GTKSA-RC");
-			break;
-		case 2:
-			printf(" 4-GTKSA-RC");
-			break;
-		case 3:
-			printf(" 16-GTKSA-RC");
-			break;
+
+		count = data[0] | (data[1] << 8);
+		if (2 + (count * 4) > len)
+			goto invalid;
+
+		tab_on_first(&first);
+		printf("\t * Pairwise ciphers:");
+		for (i = 0; i < count; i++) {
+			printf(" ");
+			print_cipher(data + 2 + (i * 4));
 		}
-		if (capa & 0x0040)
-			printf(" MFP-required");
-		if (capa & 0x0080)
-			printf(" MFP-capable");
-		if (capa & 0x0200)
-			printf(" Peerkey-enabled");
-		if (capa & 0x0400)
-			printf(" SPP-AMSDU-capable");
-		if (capa & 0x0800)
-			printf(" SPP-AMSDU-required");
-		if (capa & 0x2000)
-			printf(" Extended-Key-ID");
-		printf(" (0x%.4x)\n", capa);
-		data += 2;
-		len -= 2;
-	}
+		printf("\n");
 
-	if (len >= 2) {
-		int pmkid_count = data[0] | (data[1] << 8);
+		data += 2 + (count * 4);
+		len -= 2 + (count * 4);
 
-		if (len >= 2 + 16 * pmkid_count) {
+		if (len < 2) {
 			tab_on_first(&first);
-			printf("\t * %d PMKIDs\n", pmkid_count);
-			/* not printing PMKID values */
-			data += 2 + 16 * pmkid_count;
-			len -= 2 + 16 * pmkid_count;
-		} else
+			printf("\t * Authentication suites: %s\n", defauth);
+			return;
+		}
+
+		count = data[0] | (data[1] << 8);
+		if (2 + (count * 4) > len)
 			goto invalid;
-	}
 
-	if (len >= 4) {
 		tab_on_first(&first);
-		printf("\t * Group mgmt cipher suite: ");
-		print_cipher(data);
+		printf("\t * Authentication suites:");
+		for (i = 0; i < count; i++) {
+			printf(" ");
+			print_auth(data + 2 + (i * 4));
+		}
 		printf("\n");
-		data += 4;
-		len -= 4;
-	}
 
+		data += 2 + (count * 4);
+		len -= 2 + (count * 4);
+
+		if (len >= 2) {
+			capa = data[0] | (data[1] << 8);
+			tab_on_first(&first);
+			printf("\t * Capabilities:");
+			if (capa & 0x0001)
+				printf(" PreAuth");
+			if (capa & 0x0002)
+				printf(" NoPairwise");
+			switch ((capa & 0x000c) >> 2) {
+			case 0:
+				printf(" 1-PTKSA-RC");
+				break;
+			case 1:
+				printf(" 2-PTKSA-RC");
+				break;
+			case 2:
+				printf(" 4-PTKSA-RC");
+				break;
+			case 3:
+				printf(" 16-PTKSA-RC");
+				break;
+			}
+			switch ((capa & 0x0030) >> 4) {
+			case 0:
+				printf(" 1-GTKSA-RC");
+				break;
+			case 1:
+				printf(" 2-GTKSA-RC");
+				break;
+			case 2:
+				printf(" 4-GTKSA-RC");
+				break;
+			case 3:
+				printf(" 16-GTKSA-RC");
+				break;
+			}
+			if (capa & 0x0040)
+				printf(" MFP-required");
+			if (capa & 0x0080)
+				printf(" MFP-capable");
+			if (capa & 0x0200)
+				printf(" Peerkey-enabled");
+			if (capa & 0x0400)
+				printf(" SPP-AMSDU-capable");
+			if (capa & 0x0800)
+				printf(" SPP-AMSDU-required");
+			if (capa & 0x2000)
+				printf(" Extended-Key-ID");
+			printf(" (0x%.4x)\n", capa);
+			data += 2;
+			len -= 2;
+		}
+
+		if (len >= 2) {
+			int pmkid_count = data[0] | (data[1] << 8);
+
+			if (len >= 2 + 16 * pmkid_count) {
+				tab_on_first(&first);
+				printf("\t * %d PMKIDs\n", pmkid_count);
+				/* not printing PMKID values */
+				data += 2 + 16 * pmkid_count;
+				len -= 2 + 16 * pmkid_count;
+			} else
+				goto invalid;
+		}
+
+		if (len >= 4) {
+			tab_on_first(&first);
+			printf("\t * Group mgmt cipher suite: ");
+			print_cipher(data);
+			printf("\n");
+			data += 4;
+			len -= 4;
+		}
+	}
  invalid:
 	if (len != 0) {
-		printf("\t\t * bogus tail data (%d):", len);
-		while (len) {
-			printf(" %.2x", *data);
-			data++;
-			len--;
+		if(iw_json){
+			print_int(PRINT_JSON,"bogus_tail_data_len", "%d", len);
+			open_json_array("bogus_tail_data", NULL);
+			while (len) {
+				print_string(PRINT_JSON, NULL, "%.2x", *data);
+				data++;
+				len--;
+			}
+			close_json_array(NULL);
+		}else{
+			printf("\t\t * bogus tail data (%d):", len);
+			while (len) {
+				printf(" %.2x", *data);
+				data++;
+				len--;
+			}
+			printf("\n");
 		}
-		printf("\n");
 	}
 }
 
@@ -1090,7 +1326,11 @@ static void print_rsn(const uint8_t type, uint8_t len, const uint8_t *data,
 static void print_ht_capa(const uint8_t type, uint8_t len, const uint8_t *data,
 			  const struct print_ies_data *ie_buffer)
 {
-	printf("\n");
+	//text output
+	if(!iw_json){
+		printf("\n");
+	}
+
 	print_ht_capability(data[0] | (data[1] << 8));
 	print_ampdu_length(data[2] & 3);
 	print_ampdu_spacing((data[2] >> 2) & 7);
@@ -1264,7 +1504,7 @@ static void print_tx_power_envelope(const uint8_t type, uint8_t len,
 		"Local Maximum Transmit Power For 160/80+80 MHz",
 	};
 
-	printf("\n");
+	if(!iw_json) printf("\n");
 
 	if (local_max_tx_power_count + 2 != len)
 		return;
@@ -1274,9 +1514,9 @@ static void print_tx_power_envelope(const uint8_t type, uint8_t len,
 		int8_t power_val = ((int8_t)data[1 + i]) >> 1;
 		int8_t point5 = data[1 + i] & 1;
 		if (point5)
-			printf("\t\t * %s: %i.5 dBm\n", power_names[i], power_val);
+			iw_json ? print_int(PRINT_JSON, power_names[i], "%i.5", power_val) : printf("\t\t * %s: %i.5 dBm\n", power_names[i], power_val);
 		else
-			printf("\t\t * %s: %i dBm\n", power_names[i], power_val);
+			iw_json ? print_int(PRINT_JSON, power_names[i], "%i", power_val) : printf("\t\t * %s: %i dBm\n", power_names[i], power_val);
 	}
 }
 
@@ -1300,22 +1540,36 @@ static void print_ht_op(const uint8_t type, uint8_t len, const uint8_t *data,
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
+	if(iw_json){
+		print_int(PRINT_JSON, "primary_channel", "%d", data[0]);
+		print_string(PRINT_JSON, "secondary_channel_offset", "%s", ht_secondary_offset[data[1] & 0x3]);
+		print_string(PRINT_JSON, "sta_channel_width", "%s", sta_chan_width[(data[1] & 0x4)>>2]);
+		print_int(PRINT_JSON, "rifs", "%d", (data[1] & 0x8)>>3);
+		print_string(PRINT_JSON, "ht_protection", "%s", protection[data[2] & 0x3]);
+		print_int(PRINT_JSON, "non-gf_present", "%d", (data[2] & 0x4) >> 2);
+		print_int(PRINT_JSON, "obss_non-gf_present", "%d", (data[2] & 0x10) >> 4);
+		print_int(PRINT_JSON, "dual_beacon", "%d", (data[4] & 0x40) >> 6);
+		print_int(PRINT_JSON, "dual_cts_protection", "%d", (data[4] & 0x80) >> 7);
+		print_int(PRINT_JSON, "stbc_beacon", "%d", data[5] & 0x1);
+		print_int(PRINT_JSON, "l-sig_txop_prot", "%d", (data[5] & 0x2) >> 1);
+		print_int(PRINT_JSON, "pco_active", "%d", (data[5] & 0x4) >> 2);
+		print_int(PRINT_JSON, "pco_phase", "%d", (data[5] & 0x8) >> 3);
+	}else{
+		printf("\n");
+		printf("\t\t * primary channel: %d\n", data[0]);
+		printf("\t\t * secondary channel offset: %s\n", ht_secondary_offset[data[1] & 0x3]);
+		printf("\t\t * STA channel width: %s\n", sta_chan_width[(data[1] & 0x4)>>2]);
+		printf("\t\t * RIFS: %d\n", (data[1] & 0x8)>>3);
+		printf("\t\t * HT protection: %s\n", protection[data[2] & 0x3]);
+		printf("\t\t * non-GF present: %d\n", (data[2] & 0x4) >> 2);
+		printf("\t\t * OBSS non-GF present: %d\n", (data[2] & 0x10) >> 4);
+		printf("\t\t * dual beacon: %d\n", (data[4] & 0x40) >> 6);
+		printf("\t\t * dual CTS protection: %d\n", (data[4] & 0x80) >> 7);
+		printf("\t\t * STBC beacon: %d\n", data[5] & 0x1);
+		printf("\t\t * L-SIG TXOP Prot: %d\n", (data[5] & 0x2) >> 1);
+		printf("\t\t * PCO active: %d\n", (data[5] & 0x4) >> 2);
+		printf("\t\t * PCO phase: %d\n", (data[5] & 0x8) >> 3);
+	}
 }
 
 static void print_capabilities(const uint8_t type, uint8_t len,
@@ -1336,6 +1590,7 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 		ie += ie[1] + 2;
 	}
 
+	if(iw_json) open_json_array("array", NULL);
 	for (i = 0; i < len; i++) {
 		base = i * 8;
 
@@ -1343,15 +1598,15 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 			if (!(data[i] & (1 << bit)))
 				continue;
 
-			printf("\n\t\t *");
+			if(!iw_json) printf("\n\t\t *");
 
-#define CAPA(bit, name)		case bit: printf(" " name); break
+#define CAPA(bit, name)		case bit: iw_json ? print_string(PRINT_JSON, NULL, name) : printf(" " name); break
 
 /* if the capability 'cap' exists add 'val' to 'sum'
  * otherwise print 'Reserved' */
 #define ADD_BIT_VAL(bit, cap, sum, val)	case (bit): do {	\
 	if (!(cap)) {						\
-		printf(" Reserved");				\
+		if(!iw_json) printf(" Reserved");				\
 		break;						\
 	}							\
 	sum += val;						\
@@ -1368,7 +1623,7 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 
 			case 6:
 				s_psmp_support = true;
-				printf(" S-PSMP Capability");
+				iw_json ? print_string(PRINT_JSON, NULL, "S-PSMP Capability") : printf(" S-PSMP Capability");
 				break;
 
 			CAPA(7, "Event");
@@ -1424,7 +1679,7 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 			CAPA(55, "QLoad Report");
 			CAPA(56, "Alternate EDCA");
 			CAPA(57, "Unprotected TXOP Negotiation");
-			CAPA(58, "Protected TXOP egotiation");
+			CAPA(58, "Protected TXOP Negotiation");
 			CAPA(59, "Reserved");
 			CAPA(60, "Protected QLoad Report");
 			CAPA(61, "TDLS Wider Bandwidth");
@@ -1444,39 +1699,53 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 			CAPA(73, "Extended Spectrum Management Capable");
 			CAPA(74, "Reserved");
 			default:
-				printf(" %d", bit);
+				iw_json ? print_int(PRINT_JSON, NULL, "%d", bit) : printf(" %d", bit);
 				break;
 			}
+
 #undef ADD_BIT_VAL
 #undef CAPA
-		}
-	}
+		} //inner for loop
+	} //outer for loop
+	if(iw_json) close_json_array(NULL);
+
 
 	if (s_psmp_support)
-		printf("\n\t\t * Service Interval Granularity is %d ms",
-		       (si_duration + 1) * 5);
+		iw_json ? print_int(PRINT_JSON, "service_interval_granularity_ms", "%d", (si_duration + 1) * 5) : printf("\n\t\t * Service Interval Granularity is %d ms", (si_duration + 1) * 5);
 
 	if (is_vht_cap) {
-		printf("\n\t\t * Max Number Of MSDUs In A-MSDU is ");
-		switch (max_amsdu) {
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
+		if(iw_json){
+			int max_amsdu_ = 0;
+			switch (max_amsdu) {
+				case 0: max_amsdu_ = -1; break;
+				case 1: max_amsdu_ = 32; break;
+				case 2: max_amsdu_ = 16; break;
+				case 3: max_amsdu_ = 8; break;
+				default: break;
+			}
+			print_int(PRINT_JSON, "max_number_of_mssdu_in_a-msdu", "%d", max_amsdu_);
+		}else{
+			printf("\n\t\t * Max Number Of MSDUs In A-MSDU is ");
+			switch (max_amsdu) {
+			case 0:
+				printf("unlimited");
+				break;
+			case 1:
+				printf("32");
+				break;
+			case 2:
+				printf("16");
+				break;
+			case 3:
+				printf("8");
+				break;
+			default:
+				break;
+			}
 		}
 	}
 
-	printf("\n");
+	if(!iw_json) printf("\n");
 }
 
 static void print_tim(const uint8_t type, uint8_t len, const uint8_t *data,
@@ -1499,7 +1768,6 @@ static void print_ibssatim(const uint8_t type, uint8_t len, const uint8_t *data,
 static void print_vht_capa(const uint8_t type, uint8_t len, const uint8_t *data,
 			   const struct print_ies_data *ie_buffer)
 {
-	printf("\n");
 	print_vht_info((__u32) data[0] | ((__u32)data[1] << 8) |
 		       ((__u32)data[2] << 16) | ((__u32)data[3] << 24),
 		       data + 4);
@@ -1515,12 +1783,20 @@ static void print_vht_oper(const uint8_t type, uint8_t len, const uint8_t *data,
 		[2] = "160 MHz",
 	};
 
-	printf("\n");
-	printf("\t\t * channel width: %d (%s)\n", data[0],
-		data[0] < ARRAY_SIZE(chandwidths) ? chandwidths[data[0]] : "unknown");
-	printf("\t\t * center freq segment 1: %d\n", data[1]);
-	printf("\t\t * center freq segment 2: %d\n", data[2]);
-	printf("\t\t * VHT basic MCS set: 0x%.2x%.2x\n", data[4], data[3]);
+	if(iw_json){
+		print_string(PRINT_JSON, "channel_width", "%d (%s)", data[0],
+			data[0] < ARRAY_SIZE(chandwidths) ? chandwidths[data[0]] : "unknown");
+		print_int(PRINT_JSON, "center freq segment 1", "%d", data[1]);
+		print_int(PRINT_JSON, "center freq segment 2", "%d", data[2]);
+		print_string(PRINT_JSON, "vht_basic_mcs_set", "0x%.2x%.2x", data[4], data[3]);
+	}else{
+		printf("\n");
+		printf("\t\t * channel width: %d (%s)\n", data[0],
+			data[0] < ARRAY_SIZE(chandwidths) ? chandwidths[data[0]] : "unknown");
+		printf("\t\t * center freq segment 1: %d\n", data[1]);
+		printf("\t\t * center freq segment 2: %d\n", data[2]);
+		printf("\t\t * VHT basic MCS set: 0x%.2x%.2x\n", data[4], data[3]);
+	}
 }
 
 static void print_supp_op_classes(const uint8_t type, uint8_t len,
@@ -1532,29 +1808,70 @@ static void print_supp_op_classes(const uint8_t type, uint8_t len,
 	int zero_delimiter = 0;
 	int one_hundred_thirty_delimiter = 0;
 
-	printf("\n");
-	printf("\t\t * current operating class: %d\n", *p);
-	while (++p < next_data) {
-		if (*p == 130) {
-			one_hundred_thirty_delimiter = 1;
-			break;
+
+
+	if(iw_json){
+		print_string(PRINT_JSON, "current_operating_class", "%d", *p);
+		open_json_array("operating_class", NULL);
+		while (++p < next_data) {
+			if (*p == 130) {
+				one_hundred_thirty_delimiter = 1;
+				break;
+			}
+			if (*p == 0) {
+				zero_delimiter = 0;
+				break;
+			}
+			print_int(PRINT_JSON, NULL, "%d", *p);
 		}
-		if (*p == 0) {
-			zero_delimiter = 0;
-			break;
+		close_json_array(NULL);
+
+		open_json_array("current operating class extension", NULL);
+		if (one_hundred_thirty_delimiter){
+			while (++p < next_data) {
+				print_int(PRINT_JSON, NULL, "%d", *p);
+			}
 		}
-		printf("\t\t * operating class: %d\n", *p);
-	}
-	if (one_hundred_thirty_delimiter)
-		while (++p < next_data) {
-			printf("\t\t * current operating class extension: %d\n", *p);
+		close_json_array(NULL);
+
+		open_json_array("operating class tuple", NULL);
+		if (zero_delimiter){
+			while (++p < next_data - 1) {
+				print_string(PRINT_JSON, NULL, "%d %d", p[0], p[1]);
+				if (*p == 0)
+					break;
+			}
 		}
-	if (zero_delimiter)
-		while (++p < next_data - 1) {
-			printf("\t\t * operating class tuple: %d %d\n", p[0], p[1]);
-			if (*p == 0)
+		close_json_array(NULL);
+	}else{
+		printf("\n");
+		printf("\t\t * current operating class: %d\n", *p);
+		while (++p < next_data) {
+			if (*p == 130) {
+				one_hundred_thirty_delimiter = 1;
+				break;
+			}
+			if (*p == 0) {
+				zero_delimiter = 0;
 				break;
+			}
+			printf("\t\t * operating class: %d\n", *p);
+		}
+
+		if (one_hundred_thirty_delimiter){
+			while (++p < next_data) {
+				printf("\t\t * current operating class extension: %d\n", *p);
+			}
+		}
+
+		if (zero_delimiter){
+			while (++p < next_data - 1) {
+				printf("\t\t * operating class tuple: %d %d\n", p[0], p[1]);
+				if (*p == 0)
+					break;
+			}
 		}
+	}
 }
 
 static void print_measurement_pilot_tx(const uint8_t type, uint8_t len,
@@ -1563,8 +1880,12 @@ static void print_measurement_pilot_tx(const uint8_t type, uint8_t len,
 {
 	uint8_t *p, len_remaining;
 
-	printf("\n");
-	printf("\t\t * interval: %d TUs\n", data[0]);
+	if(iw_json){
+		print_int(PRINT_JSON, "interval_tus", "%d", data[0]);
+	}else{
+		printf("\n");
+		printf("\t\t * interval: %d TUs\n", data[0]);
+	}
 
 	if (len <= 1)
 		return;
@@ -1584,24 +1905,32 @@ static void print_measurement_pilot_tx(const uint8_t type, uint8_t len,
 
 		/* 802.11-2016 only allows vendor specific elements */
 		if (subelement_id != 221) {
-			printf("\t\t * <Invalid subelement ID %d>\n", subelement_id);
+			iw_json ? print_int(PRINT_JSON, "invalid_subelement_id", "%d", subelement_id) : printf("\t\t * <Invalid subelement ID %d>\n", subelement_id);
 			return;
 		}
 
 		if (len < 3 || len > len_remaining) {
-			printf(" <Parse error, element too short>\n");
+			iw_json ? print_int(PRINT_JSON, "invalid_subelement_id", "%d", subelement_id) : printf(" <Parse error, element too short>\n");
 			return;
 		}
 
-		printf("\t\t * vendor specific: OUI %.2x:%.2x:%.2x, data:",
-			p[0], p[1], p[2]);
-		/* add only two here and use ++p in while loop */
-		p += 2;
-
-		while (++p < end)
-			printf(" %.2x", *p);
-		printf("\n");
+		if(iw_json){
+			open_json_array("vendor_specific_oui", NULL);
 
+			while (++p < end){
+				print_string(PRINT_JSON, NULL, "0x%.2x", *p);
+			}
+			close_json_array(NULL);
+		}else{
+			printf("\t\t * vendor specific: OUI %.2x:%.2x:%.2x, data:",
+				p[0], p[1], p[2]);
+			/* add only two here and use ++p in while loop */
+			p += 2;
+
+			while (++p < end)
+				printf(" %.2x", *p);
+			printf("\n");
+		}
 		len_remaining -= len;
 	}
 }
@@ -1610,67 +1939,123 @@ static void print_obss_scan_params(const uint8_t type, uint8_t len,
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
+	if(iw_json){
+		print_int(PRINT_JSON, "passive_dwell_tus", "%d", (data[1] << 8) | data[0]);
+		print_int(PRINT_JSON, "active_dwell_tus", "%d", (data[3] << 8) | data[2]);
+		print_int(PRINT_JSON, "channel_width_trigger_scan_interval_s", "%d", (data[5] << 8) | data[4]);
+		print_int(PRINT_JSON, "scan_passive_total_per_channel_tus", "%d", (data[7] << 8) | data[6]);
+		print_int(PRINT_JSON, "scan_active_total_per_channel_tus", "%d", (data[9] << 8) | data[8]);
+		print_int(PRINT_JSON, "bss_width_channel_transition_delay_factor", "%d", (data[11] << 8) | data[10]);
+		print_string(PRINT_JSON, "obss_scan_ctivity_threshold", "%d.%02d %%\n",
+			((data[13] << 8) | data[12]) / 100, ((data[13] << 8) | data[12]) % 100);
+	} else {
+		printf("\n");
+		printf("\t\t * passive dwell: %d TUs\n", (data[1] << 8) | data[0]);
+		printf("\t\t * active dwell: %d TUs\n", (data[3] << 8) | data[2]);
+		printf("\t\t * channel width trigger scan interval: %d s\n", (data[5] << 8) | data[4]);
+		printf("\t\t * scan passive total per channel: %d TUs\n", (data[7] << 8) | data[6]);
+		printf("\t\t * scan active total per channel: %d TUs\n", (data[9] << 8) | data[8]);
+		printf("\t\t * BSS width channel transition delay factor: %d\n", (data[11] << 8) | data[10]);
+		printf("\t\t * OBSS Scan Activity Threshold: %d.%02d %%\n",
+			((data[13] << 8) | data[12]) / 100, ((data[13] << 8) | data[12]) % 100);
+	}
 }
 
 static void print_secchan_offs(const uint8_t type, uint8_t len,
 			       const uint8_t *data,
 			       const struct print_ies_data *ie_buffer)
 {
-	if (data[0] < ARRAY_SIZE(ht_secondary_offset))
-		printf(" %s (%d)\n", ht_secondary_offset[data[0]], data[0]);
-	else
-		printf(" %d\n", data[0]);
+	if(iw_json){
+		if (data[0] < ARRAY_SIZE(ht_secondary_offset))
+			print_string(PRINT_JSON, "value", "%s (%d)", ht_secondary_offset[data[0]], data[0]);
+		else
+			print_string(PRINT_JSON, "value", "%d", data[0]);
+	}else{
+		if (data[0] < ARRAY_SIZE(ht_secondary_offset))
+			printf(" %s (%d)\n", ht_secondary_offset[data[0]], data[0]);
+		else
+			printf(" %d\n", data[0]);
+	}
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
+	if(iw_json){
+		print_int(PRINT_JSON, "station count", "%d", (data[1] << 8) | data[0]);
+		print_int(PRINT_JSON, "channel utilisation", "%d", data[2]);
+		print_int(PRINT_JSON, "available admission capacity", "%d", (data[4] << 8) | data[3]);
+	}else{
+		printf("\n");
+		printf("\t\t * station count: %d\n", (data[1] << 8) | data[0]);
+		printf("\t\t * channel utilisation: %d/255\n", data[2]);
+		printf("\t\t * available admission capacity: %d [*32us]\n", (data[4] << 8) | data[3]);
+	}
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
-	if (data[5] & 0x01)
-		printf("\t\t\t Connected to Mesh Gate\n");
-	if (data[5] & 0x80)
-		printf("\t\t\t Connected to AS\n");
-	printf("\t\t * Mesh Capability\n");
-	if (data[6] & 0x01)
-		printf("\t\t\t Accepting Additional Mesh Peerings\n");
-	if (data[6] & 0x02)
-		printf("\t\t\t MCCA Supported\n");
-	if (data[6] & 0x04)
-		printf("\t\t\t MCCA Enabled\n");
-	if (data[6] & 0x08)
-		printf("\t\t\t Forwarding\n");
-	if (data[6] & 0x10)
-		printf("\t\t\t MBCA Supported\n");
-	if (data[6] & 0x20)
-		printf("\t\t\t TBTT Adjusting\n");
-	if (data[6] & 0x40)
-		printf("\t\t\t Mesh Power Save Level\n");
+	if(iw_json){
+		print_string(PRINT_JSON, "active_path_selection_protocol_id", "%d", data[0]);
+		print_string(PRINT_JSON, "active_path_selection_metric_id", "%d", data[1]);
+		print_string(PRINT_JSON, "congestion_control_mode_id", "%d", data[2]);
+		print_string(PRINT_JSON, "synchronization_method_id", "%d", data[3]);
+		print_string(PRINT_JSON, "authentication_protocol_id", "%d", data[4]);
+		open_json_array("mesh_formation_info", NULL);
+		print_string(PRINT_JSON, "number_of_peerings", "%d", (data[5] & 0x7E) >> 1);
+		if (data[5] & 0x01)
+			print_string(PRINT_JSON, NULL, "Connected to Mesh Gate");
+		if (data[5] & 0x80)
+			print_string(PRINT_JSON, NULL, "Connected to AS");
+		close_json_array(NULL);
+		open_json_array("mesh_capability", NULL);
+		if (data[6] & 0x01)
+			print_string(PRINT_JSON, NULL, "Accepting Additional Mesh Peerings");
+		if (data[6] & 0x02)
+			print_string(PRINT_JSON, NULL, "MCCA Supported");
+		if (data[6] & 0x04)
+			print_string(PRINT_JSON, NULL, "MCCA Enabled");
+		if (data[6] & 0x08)
+			print_string(PRINT_JSON, NULL, "Forwarding");
+		if (data[6] & 0x10)
+			print_string(PRINT_JSON, NULL, "MBCA Supported");
+		if (data[6] & 0x20)
+			print_string(PRINT_JSON, NULL, "TBTT Adjusting");
+		if (data[6] & 0x40)
+			print_string(PRINT_JSON, NULL, "Mesh Power Save Level");
+		close_json_array(NULL);
+	}else{
+		printf("\n");
+		printf("\t\t * Active Path Selection Protocol ID: %d\n", data[0]);
+		printf("\t\t * Active Path Selection Metric ID: %d\n", data[1]);
+		printf("\t\t * Congestion Control Mode ID: %d\n", data[2]);
+		printf("\t\t * Synchronization Method ID: %d\n", data[3]);
+		printf("\t\t * Authentication Protocol ID: %d\n", data[4]);
+		printf("\t\t * Mesh Formation Info:\n");
+		printf("\t\t\t Number of Peerings: %d\n", (data[5] & 0x7E) >> 1);
+		if (data[5] & 0x01)
+			printf("\t\t\t Connected to Mesh Gate\n");
+		if (data[5] & 0x80)
+			printf("\t\t\t Connected to AS\n");
+		printf("\t\t * Mesh Capability\n");
+		if (data[6] & 0x01)
+			printf("\t\t\t Accepting Additional Mesh Peerings\n");
+		if (data[6] & 0x02)
+			printf("\t\t\t MCCA Supported\n");
+		if (data[6] & 0x04)
+			printf("\t\t\t MCCA Enabled\n");
+		if (data[6] & 0x08)
+			printf("\t\t\t Forwarding\n");
+		if (data[6] & 0x10)
+			printf("\t\t\t MBCA Supported\n");
+		if (data[6] & 0x20)
+			printf("\t\t\t TBTT Adjusting\n");
+		if (data[6] & 0x40)
+			printf("\t\t\t Mesh Power Save Level\n");
+	}
 }
 
 struct ie_print {
@@ -1682,31 +2067,54 @@ struct ie_print {
 };
 
 static void print_ie(const struct ie_print *p, const uint8_t type, uint8_t len,
-		     const uint8_t *data,
-		     const struct print_ies_data *ie_buffer)
+                     const uint8_t *data,
+                     const struct print_ies_data *ie_buffer)
 {
-	int i;
-
-	if (!p->print)
-		return;
-
-	printf("\t%s:", p->name);
-	if (len < p->minlen || len > p->maxlen) {
-		if (len > 1) {
-			printf(" <invalid: %d bytes:", len);
-			for (i = 0; i < len; i++)
-				printf(" %.02x", data[i]);
-			printf(">\n");
-		} else if (len)
-			printf(" <invalid: 1 byte: %.02x>\n", data[0]);
-		else
-			printf(" <invalid: no data>\n");
-		return;
-	}
-
-	p->print(type, len, data, ie_buffer);
+    int i;
+
+    if (!p->print)
+        return;
+
+    if (iw_json) {
+        open_json_object(p->name);
+        if (len < p->minlen || len > p->maxlen) {
+            print_int(PRINT_JSON, "invalid_bytes", "%d", len);
+            if (len > 1) {
+                open_json_array("data", NULL);
+                for (i = 0; i < len; i++)
+                    print_string(PRINT_JSON, NULL, "%.02x", data[i]);
+                close_json_array(NULL);
+            } else if (len) {
+                print_string(PRINT_JSON, "invalid_1_byte", "%d", data[0]);
+            } else {
+                print_bool(PRINT_JSON, "no_data", "%s", true);
+            }
+        } else {
+            // print callback
+            p->print(type, len, data, ie_buffer);
+        }
+        close_json_object();
+    } else {
+        // text output
+        printf("\t%s:", p->name);
+        if (len < p->minlen || len > p->maxlen) {
+            if (len > 1) {
+                printf(" <invalid: %d bytes:", len);
+                for (i = 0; i < len; i++)
+                    printf(" %.02x", data[i]);
+                printf(">\n");
+            } else if (len)
+                printf(" <invalid: 1 byte: %.02x>\n", data[0]);
+            else
+                printf(" <invalid: no data>\n");
+        } else {
+            // print callback
+            p->print(type, len, data, ie_buffer);
+        }
+    }
 }
 
+
 #define PRINT_IGN {		\
 	.name = "IGNORE",	\
 	.print = NULL,		\
@@ -1765,41 +2173,66 @@ static bool print_wifi_wmm_param(const uint8_t *data, uint8_t len)
 	int i;
 	static const char *aci_tbl[] = { "BE", "BK", "VI", "VO" };
 
-	if (len < 19)
-		goto invalid;
-
-	if (data[0] != 1) {
-		printf("Parameter: not version 1: ");
+	if (len < 19){
+		if(!iw_json) printf("invalid: ");
 		return false;
 	}
 
-	printf("\t * Parameter version 1");
 
-	data++;
+	if(iw_json) {
+		print_int(PRINT_JSON, "version", "%d", data[0]);
 
-	if (data[0] & 0x80)
-		printf("\n\t\t * u-APSD");
+		if (data[0] != 1) {
+			return false;
+		}
 
-	data += 2;
+		data++;
 
-	for (i = 0; i < 4; i++) {
-		printf("\n\t\t * %s:", aci_tbl[(data[0] >> 5) & 3]);
-		if (data[0] & 0x10)
-			printf(" acm");
-		printf(" CW %d-%d", (1 << (data[1] & 0xf)) - 1,
-				    (1 << (data[1] >> 4)) - 1);
-		printf(", AIFSN %d", data[0] & 0xf);
-		if (data[2] | data[3])
-			printf(", TXOP %d usec", (data[2] + (data[3] << 8)) * 32);
-		data += 4;
-	}
+		if (data[0] & 0x80){
+			print_bool(PRINT_JSON, "u-APSD", "%s", true);
+		}
+		data += 2;
 
-	printf("\n");
-	return true;
+		for (i = 0; i < 4; i++) {
+			open_json_object("%s", aci_tbl[(data[0] >> 5) & 3]);
+			if (data[0] & 0x10) print_bool(PRINT_JSON, "acm", "%s", true);
+			print_string(PRINT_JSON, "CW", "%d-%d", (1 << (data[1] & 0xf)) - 1, (1 << (data[1] >> 4)) - 1);
+			print_string(PRINT_JSON, "AIFSN", "%d", data[0] & 0xf);
 
- invalid:
- 	printf("invalid: ");
- 	return false;
+			if (data[2] | data[3]) print_int(PRINT_JSON, "TXOP_usec", "%d", (data[2] + (data[3] << 8)) * 32);
+			data += 4;
+			close_json_object();
+		}
+	}else{
+		if (data[0] != 1) {
+			printf("Parameter: not version 1: ");
+			return false;
+		}
+
+		printf("\t * Parameter version 1");
+
+		data++;
+
+		if (data[0] & 0x80)
+			printf("\n\t\t * u-APSD");
+
+		data += 2;
+
+		for (i = 0; i < 4; i++) {
+			printf("\n\t\t * %s:", aci_tbl[(data[0] >> 5) & 3]);
+			if (data[0] & 0x10)
+				printf(" acm");
+			printf(" CW %d-%d", (1 << (data[1] & 0xf)) - 1,
+						(1 << (data[1] >> 4)) - 1);
+			printf(", AIFSN %d", data[0] & 0xf);
+			if (data[2] | data[3])
+				printf(", TXOP %d usec", (data[2] + (data[3] << 8)) * 32);
+			data += 4;
+		}
+
+		printf("\n");
+	}
+	return true;
 }
 
 static void print_wifi_wmm(const uint8_t type, uint8_t len, const uint8_t *data,
@@ -1858,209 +2291,217 @@ static void print_wifi_wps(const uint8_t type, uint8_t len, const uint8_t *data,
 			break;
 
 		switch (subtype) {
-		case 0x104a:
-			tab_on_first(&first);
-			if (sublen < 1) {
-				printf("\t * Version: (invalid "
-				       "length %d)\n", sublen);
+			case 0x104a:
+				tab_on_first(&first);
+				if (sublen < 1) {
+					iw_json ? print_string(PRINT_JSON, "version", "%d", sublen) : printf("\t * Version: (invalid length %d)\n", sublen);
+					break;
+				}
+				iw_json ? print_string(PRINT_JSON, "version",  "%d.%d", data[4] >> 4, data[4] & 0xF) : printf("\t * Version: %d.%d\n", data[4] >> 4, data[4] & 0xF);
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
+				tab_on_first(&first);
+				iw_json ? print_string(PRINT_JSON, "device name", "%.*s", sublen, data + 4) : printf("\t * Device name: %.*s\n", sublen, data + 4);
+				break;
+			case 0x1012: {
+				uint16_t id;
+				tab_on_first(&first);
+				if (sublen != 2) {
+					iw_json ? print_string(PRINT_JSON, "device_password_id", "%d", sublen) : printf("\t * Device Password ID: (invalid length %d)\n", sublen);
+					break;
+				}
+				id = data[4] << 8 | data[5];
+				iw_json ? print_string(PRINT_JSON, "device_password_id",  "%u (%s)", id, wifi_wps_dev_passwd_id(id)) : printf("\t * Device Password ID: %u (%s)\n", id, wifi_wps_dev_passwd_id(id));
 				break;
 			}
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
+			case 0x1021:
+				tab_on_first(&first);
+				iw_json ? print_string(PRINT_JSON, "manufacturer", "%.*s", sublen, data + 4) : printf("\t * Manufacturer: %.*s\n", sublen, data + 4);
+				break;
+			case 0x1023:
+				tab_on_first(&first);
+				iw_json ? print_string(PRINT_JSON, "model", "%.*s", sublen, data + 4) : printf("\t * Model: %.*s\n", sublen, data + 4);
+				break;
+			case 0x1024:
+				tab_on_first(&first);
+				iw_json ? print_string(PRINT_JSON, "model_number", "%.*s\n", sublen, data + 4) : printf("\t * Model Number: %.*s\n", sublen, data + 4);
+				break;
+			case 0x103b: {
+				__u8 val;
 
-			if (sublen < 1) {
-				printf("\t * Response Type: (invalid length %d)\n",
-				       sublen);
+				if (sublen < 1) {
+					iw_json ? print_int(PRINT_JSON, "response_type_invalid_length", "%d", sublen) : printf("\t * Response Type: (invalid length %d)\n", sublen);
+					break;
+				}
+				val = data[4];
+				tab_on_first(&first);
+				iw_json ? print_string(PRINT_JSON, "response_type", "%d%s", val, val == 3 ? " (AP)" : "") : printf("\t * Response Type: %d%s\n", val, val == 3 ? " (AP)" : "");
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
+			case 0x103c: {
+				__u8 val;
 
-			if (sublen < 1) {
-				printf("\t * RF Bands: (invalid length %d)\n",
-				       sublen);
+				if (sublen < 1) {
+					iw_json ? print_int(PRINT_JSON, "rf_bands_invalid_length", "%d", sublen) : printf("\t * RF Bands: (invalid length %d)\n", sublen);
+					break;
+				}
+				val = data[4];
+				tab_on_first(&first);
+				iw_json ? print_string(PRINT_JSON, "rf_bands", "0x%x", val) : printf("\t * RF Bands: 0x%x\n", val);
 				break;
 			}
-			val = data[4];
-			tab_on_first(&first);
-			printf("\t * RF Bands: 0x%x\n", val);
-			break;
-		}
-		case 0x1041: {
-			__u8 val;
+			case 0x1041: {
+				__u8 val;
 
-			if (sublen < 1) {
-				printf("\t * Selected Registrar: (invalid length %d)\n",
-				       sublen);
+				if (sublen < 1) {
+					iw_json ? print_string(PRINT_JSON, "selected_registrar_invalid_length", "%d", sublen) : printf("\t * Selected Registrar: (invalid length %d)\n", sublen);
+					break;
+				}
+				val = data[4];
+				tab_on_first(&first);
+				iw_json ? print_string(PRINT_JSON, "selected_registrar", "0x%x", val) : printf("\t * Selected Registrar: 0x%x\n", val);
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
+			case 0x1042:
+				tab_on_first(&first);
+				iw_json ? print_string(PRINT_JSON, "serial_number", "%.*s", sublen, data + 4) : printf("\t * Serial Number: %.*s\n", sublen, data + 4);
+				break;
+			case 0x1044: {
+				__u8 val;
 
-			if (sublen < 1) {
-				printf("\t * Wi-Fi Protected Setup State: (invalid length %d)\n",
-				       sublen);
+				if (sublen < 1) {
+					iw_json ? print_string(PRINT_JSON, "wi-fi_protected_setup_state_invalid_length", "%d", sublen) : printf("\t * Wi-Fi Protected Setup State: (invalid length %d)\n", sublen);
+					break;
+				}
+				val = data[4];
+				tab_on_first(&first);
+				iw_json ? print_string(PRINT_JSON, "wi-fi_protected_setup_state", "%d%s%s", val, val == 1 ? " (Unconfigured)" : "", val == 2 ? " (Configured)" : "") : printf("\t * Wi-Fi Protected Setup State: %d%s%s\n", val, val == 1 ? " (Unconfigured)" : "", val == 2 ? " (Configured)" : "");
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
+			case 0x1047:
+				tab_on_first(&first);
+				if(!iw_json) printf("\t * UUID: ");
+				if (sublen != 16) {
+					iw_json ? print_int(PRINT_JSON, "uuid_invalid_length", "%d", sublen) : printf("(invalid, length=%d)\n", sublen);
+					break;
+				}
+				iw_json ? print_string(PRINT_JSON, "uuid", "%02x%02x-%02x%02x%02x%02x%02x%02x",
+					"%02x%02x-%02x%02x%02x%02x%02x%02x",
+					data[4], data[5], data[6], data[7],
+					data[8], data[9], data[10], data[11],
+					data[12], data[13], data[14], data[15],
+					data[16], data[17], data[18], data[19]) : printf("%02x%02x%02x%02x-%02x%02x-%02x%02x-"
+					"%02x%02x-%02x%02x%02x%02x%02x%02x\n",
+					data[4], data[5], data[6], data[7],
+					data[8], data[9], data[10], data[11],
+					data[12], data[13], data[14], data[15],
+					data[16], data[17], data[18], data[19]);
 				break;
-			}
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
+			case 0x1049:
+				tab_on_first(&first);
+				if (sublen == 6 &&
+					data[4] == 0x00 &&
+					data[5] == 0x37 &&
+					data[6] == 0x2a &&
+					data[7] == 0x00 &&
+					data[8] == 0x01) {
+					uint8_t v2 = data[9];
+					iw_json ? print_string(PRINT_JSON, "version2", "%d.%d", v2 >> 4, v2 & 0xf) : printf("\t * Version2: %d.%d\n", v2 >> 4, v2 & 0xf);
+				} else {
+					iw_json ? print_string(PRINT_JSON, "unknown_vendor_extension_length", "%u", sublen) : printf("\t * Unknown vendor extension. len=%u\n", sublen);
+				}
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
+			case 0x1054: {
+				tab_on_first(&first);
+				if (sublen != 8) {
+					iw_json ? print_string(PRINT_JSON, "primary_device_type_invalid_length", "%d", sublen) : printf("\t * Primary Device Type: (invalid length %d)\n", sublen);
+					break;
+				}
+				iw_json ? print_string(PRINT_JSON, "primary_device_type",
+					"%u-%02x%02x%02x%02x-%u",
+					data[4] << 8 | data[5],
+					data[6], data[7], data[8], data[9],
+					data[10] << 8 | data[11]) : printf("\t * Primary Device Type: "
+					"%u-%02x%02x%02x%02x-%u\n",
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
+				tab_on_first(&first);
+				if (sublen < 1) {
+					iw_json ? print_string(PRINT_JSON, "ap_setup_locked_invalid_length", "%d", sublen) : printf("\t * AP setup locked: (invalid length %d)\n", sublen);
+					break;
+				}
+				val = data[4];
+				iw_json ? print_string(PRINT_JSON, "ap_setup_locked", "0x%.2x", val) : printf("\t * AP setup locked: 0x%.2x\n", val);
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
+				bool comma;
+
+				if (sublen < 2) {
+					iw_json ? print_string(PRINT_JSON, "config_methods_invalid_length", "%d", sublen) : printf("\t * Config methods: (invalid length %d)\n", sublen);
+					break;
+				}
+				meth = (data[4] << 8) + data[5];
+				comma = false;
+				tab_on_first(&first);
+				if(iw_json){
+					print_bool(PRINT_JSON, "config_methods_selected_registrar", "%s", true);
+					open_json_array("config_methods", NULL);
+				}else{
+					printf("\t * %sConfig methods:", subtype == 0x1053 ? "Selected Registrar ": "");
+				}
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
+		if(iw_json){ \
+			print_string(PRINT_JSON, NULL, name); \
+		}else{ \
+			if (comma)		\
+				printf(",");	\
+			comma = true;		\
+			printf(" " name);	\
+		} \
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
+				iw_json ? close_json_array(NULL) : printf("\n");
+				break;
+#undef T
+			} //case 0x1053
+			default: {
+				const __u8 *subdata = data + 4;
+				__u16 tmplen = sublen;
+
+				tab_on_first(&first);
+				if(iw_json){
+					print_string(PRINT_JSON, "unknown_tlv", "%#.4x, %d bytes", subtype, tmplen);
+					open_json_array("unknown_tlv_data", NULL);
+				}else{
+					printf("\t * Unknown TLV (%#.4x, %d bytes):", subtype, tmplen);
+				}
+				while (tmplen) {
+					iw_json ? print_string(PRINT_JSON, NULL, "%.2x", *subdata) : printf(" %.2x", *subdata);
+					subdata++;
+					tmplen--;
+				}
+				iw_json ? close_json_array(NULL) : printf("\n");
+				break;
 			}
-			printf("\n");
-			break;
-		}
 		}
 
 		data += sublen + 4;
@@ -2068,13 +2509,19 @@ static void print_wifi_wps(const uint8_t type, uint8_t len, const uint8_t *data,
 	}
 
 	if (len != 0) {
-		printf("\t\t * bogus tail data (%d):", len);
+		if(iw_json){
+			print_string(PRINT_JSON, " bogus_tail_data_length", "%d", len);
+			open_json_array("bogus_tail_data", NULL);
+		} else{
+			printf("\t\t * bogus tail data (%d):", len);
+		}
+
 		while (len) {
-			printf(" %.2x", *data);
+			iw_json ? print_string(PRINT_JSON, NULL, "%.2x", *data) : printf(" %.2x", *data);
 			data++;
 			len--;
 		}
-		printf("\n");
+		iw_json ? close_json_array(NULL) : printf("\n");
 	}
 }
 
@@ -2217,31 +2664,60 @@ static void print_vendor(unsigned char len, unsigned char *data,
 			 bool unknown, enum print_ie_type ptype)
 {
 	int i;
-
 	if (len < 3) {
-		printf("\tVendor specific: <too short> data:");
-		for(i = 0; i < len; i++)
-			printf(" %.02x", data[i]);
-		printf("\n");
-		return;
+		if(iw_json){
+			open_json_array("vendor specific too short", NULL);
+			for(i = 0; i < len; i++){
+				print_int(PRINT_JSON, NULL, "%.02x", data[i]);
+			}
+			close_json_array(NULL);
+			return;
+		}else{
+			printf("\tVendor specific: <too short> data:");
+			for(i = 0; i < len; i++)
+				printf(" %.02x", data[i]);
+			printf("\n");
+			return;
+		}
 	}
+	if(iw_json){
+		if (len >= 4 && memcmp(data, ms_oui, 3) == 0) {
+			if (data[3] < ARRAY_SIZE(wifiprinters) &&
+				wifiprinters[data[3]].name &&
+				wifiprinters[data[3]].flags & BIT(ptype)) {
+				print_ie(&wifiprinters[data[3]],
+					data[3], len - 4, data + 4,
+					NULL);
+				return;
+			}
+			if (!unknown) return;
 
-	if (len >= 4 && memcmp(data, ms_oui, 3) == 0) {
-		if (data[3] < ARRAY_SIZE(wifiprinters) &&
-		    wifiprinters[data[3]].name &&
-		    wifiprinters[data[3]].flags & BIT(ptype)) {
-			print_ie(&wifiprinters[data[3]],
-				 data[3], len - 4, data + 4,
-				 NULL);
+			print_string(PRINT_JSON,"MS/WiFi", "%#.2x", data[3]);
+			open_json_array("data", NULL);
+			for(i = 0; i < len - 4; i++){
+				print_float(PRINT_JSON, NULL, "%.02x", data[i + 4]);
+			}
+			close_json_array(NULL);
 			return;
 		}
-		if (!unknown)
+	}else{
+		if (len >= 4 && memcmp(data, ms_oui, 3) == 0) {
+			if (data[3] < ARRAY_SIZE(wifiprinters) &&
+				wifiprinters[data[3]].name &&
+				wifiprinters[data[3]].flags & BIT(ptype)) {
+				print_ie(&wifiprinters[data[3]],
+					data[3], len - 4, data + 4,
+					NULL);
+				return;
+			}
+			if (!unknown)
+				return;
+			printf("\tMS/WiFi %#.2x, data:", data[3]);
+			for(i = 0; i < len - 4; i++)
+				printf(" %.02x", data[i + 4]);
+			printf("\n");
 			return;
-		printf("\tMS/WiFi %#.2x, data:", data[3]);
-		for(i = 0; i < len - 4; i++)
-			printf(" %.02x", data[i + 4]);
-		printf("\n");
-		return;
+		}
 	}
 
 	if (len >= 4 && memcmp(data, wfa_oui, 3) == 0) {
@@ -2275,7 +2751,6 @@ static void print_vendor(unsigned char len, unsigned char *data,
 static void print_he_capa(const uint8_t type, uint8_t len, const uint8_t *data,
 			  const struct print_ies_data *ie_buffer)
 {
-	printf("\n");
 	print_he_capability(data, len);
 }
 
@@ -2345,66 +2820,93 @@ void print_ies(unsigned char *ie, int ielen, bool unknown,
 
 static void print_capa_dmg(__u16 capa)
 {
-	switch (capa & WLAN_CAPABILITY_DMG_TYPE_MASK) {
-	case WLAN_CAPABILITY_DMG_TYPE_AP:
-		printf(" DMG_ESS");
-		break;
-	case WLAN_CAPABILITY_DMG_TYPE_PBSS:
-		printf(" DMG_PCP");
-		break;
-	case WLAN_CAPABILITY_DMG_TYPE_IBSS:
-		printf(" DMG_IBSS");
-		break;
-	}
+	if(iw_json){
+		switch (capa & WLAN_CAPABILITY_DMG_TYPE_MASK) {
+		case WLAN_CAPABILITY_DMG_TYPE_AP:
+			print_string(PRINT_JSON, NULL, "DMG_ESS");
+			break;
+		case WLAN_CAPABILITY_DMG_TYPE_PBSS:
+			print_string(PRINT_JSON, NULL, "DMG_PCP");
+			break;
+		case WLAN_CAPABILITY_DMG_TYPE_IBSS:
+			print_string(PRINT_JSON, NULL, "DMG_IBSS");
+			break;
+		}
+
+		if (capa & WLAN_CAPABILITY_DMG_CBAP_ONLY)
+			print_string(PRINT_JSON, NULL, "CBAP_Only");
+		if (capa & WLAN_CAPABILITY_DMG_CBAP_SOURCE)
+			print_string(PRINT_JSON, NULL, "CBAP_Src");
+		if (capa & WLAN_CAPABILITY_DMG_PRIVACY)
+			print_string(PRINT_JSON, NULL, "Privacy");
+		if (capa & WLAN_CAPABILITY_DMG_ECPAC)
+			print_string(PRINT_JSON, NULL, "ECPAC");
+		if (capa & WLAN_CAPABILITY_DMG_SPECTRUM_MGMT)
+			print_string(PRINT_JSON, NULL, "SpectrumMgmt");
+		if (capa & WLAN_CAPABILITY_DMG_RADIO_MEASURE)
+			print_string(PRINT_JSON, NULL, "RadioMeasure");
+	}else{
+		switch (capa & WLAN_CAPABILITY_DMG_TYPE_MASK) {
+		case WLAN_CAPABILITY_DMG_TYPE_AP:
+			printf(" DMG_ESS");
+			break;
+		case WLAN_CAPABILITY_DMG_TYPE_PBSS:
+			printf(" DMG_PCP");
+			break;
+		case WLAN_CAPABILITY_DMG_TYPE_IBSS:
+			printf(" DMG_IBSS");
+			break;
+		}
 
-	if (capa & WLAN_CAPABILITY_DMG_CBAP_ONLY)
-		printf(" CBAP_Only");
-	if (capa & WLAN_CAPABILITY_DMG_CBAP_SOURCE)
-		printf(" CBAP_Src");
-	if (capa & WLAN_CAPABILITY_DMG_PRIVACY)
-		printf(" Privacy");
-	if (capa & WLAN_CAPABILITY_DMG_ECPAC)
-		printf(" ECPAC");
-	if (capa & WLAN_CAPABILITY_DMG_SPECTRUM_MGMT)
-		printf(" SpectrumMgmt");
-	if (capa & WLAN_CAPABILITY_DMG_RADIO_MEASURE)
-		printf(" RadioMeasure");
+		if (capa & WLAN_CAPABILITY_DMG_CBAP_ONLY)
+			printf(" CBAP_Only");
+		if (capa & WLAN_CAPABILITY_DMG_CBAP_SOURCE)
+			printf(" CBAP_Src");
+		if (capa & WLAN_CAPABILITY_DMG_PRIVACY)
+			printf(" Privacy");
+		if (capa & WLAN_CAPABILITY_DMG_ECPAC)
+			printf(" ECPAC");
+		if (capa & WLAN_CAPABILITY_DMG_SPECTRUM_MGMT)
+			printf(" SpectrumMgmt");
+		if (capa & WLAN_CAPABILITY_DMG_RADIO_MEASURE)
+			printf(" RadioMeasure");
+	}
 }
 
 static void print_capa_non_dmg(__u16 capa)
 {
 	if (capa & WLAN_CAPABILITY_ESS)
-		printf(" ESS");
+		iw_json ? print_string(PRINT_JSON, NULL, "ESS") : printf(" ESS");
 	if (capa & WLAN_CAPABILITY_IBSS)
-		printf(" IBSS");
+		iw_json ? print_string(PRINT_JSON, NULL, "IBSS") : printf(" IBSS");
 	if (capa & WLAN_CAPABILITY_CF_POLLABLE)
-		printf(" CfPollable");
+		iw_json ? print_string(PRINT_JSON, NULL, "CfPollable") : printf(" CfPollable");
 	if (capa & WLAN_CAPABILITY_CF_POLL_REQUEST)
-		printf(" CfPollReq");
+		iw_json ? print_string(PRINT_JSON, NULL, "CfPollReq") : printf(" CfPollReq");
 	if (capa & WLAN_CAPABILITY_PRIVACY)
-		printf(" Privacy");
+		iw_json ? print_string(PRINT_JSON, NULL, "Privacy") : printf(" Privacy");
 	if (capa & WLAN_CAPABILITY_SHORT_PREAMBLE)
-		printf(" ShortPreamble");
+		iw_json ? print_string(PRINT_JSON, NULL, "ShortPreamble") : printf(" ShortPreamble");
 	if (capa & WLAN_CAPABILITY_PBCC)
-		printf(" PBCC");
+		iw_json ? print_string(PRINT_JSON, NULL, "PBCC") : printf(" PBCC");
 	if (capa & WLAN_CAPABILITY_CHANNEL_AGILITY)
-		printf(" ChannelAgility");
+		iw_json ? print_string(PRINT_JSON, NULL, "ChannelAgility") : printf(" ChannelAgility");
 	if (capa & WLAN_CAPABILITY_SPECTRUM_MGMT)
-		printf(" SpectrumMgmt");
+		iw_json ? print_string(PRINT_JSON, NULL, "SpectrumMgmt") : printf(" SpectrumMgmt");
 	if (capa & WLAN_CAPABILITY_QOS)
-		printf(" QoS");
+		iw_json ? print_string(PRINT_JSON, NULL, "QoS") : printf(" QoS");
 	if (capa & WLAN_CAPABILITY_SHORT_SLOT_TIME)
-		printf(" ShortSlotTime");
+		iw_json ? print_string(PRINT_JSON, NULL, "ShortSlotTime") : printf(" ShortSlotTime");
 	if (capa & WLAN_CAPABILITY_APSD)
-		printf(" APSD");
+		iw_json ? print_string(PRINT_JSON, NULL, "APSD") : printf(" APSD");
 	if (capa & WLAN_CAPABILITY_RADIO_MEASURE)
-		printf(" RadioMeasure");
+		iw_json ? print_string(PRINT_JSON, NULL, "RadioMeasure") : printf(" RadioMeasure");
 	if (capa & WLAN_CAPABILITY_DSSS_OFDM)
-		printf(" DSSS-OFDM");
+		iw_json ? print_string(PRINT_JSON, NULL, "DSSS-OFDM") : printf(" DSSS-OFDM");
 	if (capa & WLAN_CAPABILITY_DEL_BACK)
-		printf(" DelayedBACK");
+		iw_json ? print_string(PRINT_JSON, NULL, "DelayedBACK") : printf(" DelayedBACK");
 	if (capa & WLAN_CAPABILITY_IMM_BACK)
-		printf(" ImmediateBACK");
+		iw_json ? print_string(PRINT_JSON, NULL, "ImmediateBACK") : printf(" ImmediateBACK");
 }
 
 static int print_bss_handler(struct nl_msg *msg, void *arg)
@@ -2433,108 +2935,225 @@ static int print_bss_handler(struct nl_msg *msg, void *arg)
 	nla_parse(tb, NL80211_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
 		  genlmsg_attrlen(gnlh, 0), NULL);
 
-	if (!tb[NL80211_ATTR_BSS]) {
-		fprintf(stderr, "bss info missing!\n");
-		return NL_SKIP;
-	}
-	if (nla_parse_nested(bss, NL80211_BSS_MAX,
-			     tb[NL80211_ATTR_BSS],
-			     bss_policy)) {
-		fprintf(stderr, "failed to parse nested attributes!\n");
-		return NL_SKIP;
-	}
+	if(iw_json){
+		if (!tb[NL80211_ATTR_BSS]) {
+			fprintf(stderr, "bss info missing!\n");
+			return NL_SKIP;
+		}
+		if (nla_parse_nested(bss, NL80211_BSS_MAX,
+					tb[NL80211_ATTR_BSS],
+					bss_policy)) {
+			fprintf(stderr, "failed to parse nested attributes!\n");
+			return NL_SKIP;
+		}
 
-	if (!bss[NL80211_BSS_BSSID])
-		return NL_SKIP;
+		if (!bss[NL80211_BSS_BSSID])
+			return NL_SKIP;
 
-	mac_addr_n2a(mac_addr, nla_data(bss[NL80211_BSS_BSSID]));
-	printf("BSS %s", mac_addr);
-	if (tb[NL80211_ATTR_IFINDEX]) {
-		if_indextoname(nla_get_u32(tb[NL80211_ATTR_IFINDEX]), dev);
-		printf("(on %s)", dev);
-	}
+		mac_addr_n2a(mac_addr, nla_data(bss[NL80211_BSS_BSSID]));
+		open_json_object(mac_addr);
 
-	if (bss[NL80211_BSS_STATUS]) {
-		switch (nla_get_u32(bss[NL80211_BSS_STATUS])) {
-		case NL80211_BSS_STATUS_AUTHENTICATED:
-			printf(" -- authenticated");
-			break;
-		case NL80211_BSS_STATUS_ASSOCIATED:
-			printf(" -- associated");
-			break;
-		case NL80211_BSS_STATUS_IBSS_JOINED:
-			printf(" -- joined");
-			break;
-		default:
-			printf(" -- unknown status: %d",
-				nla_get_u32(bss[NL80211_BSS_STATUS]));
-			break;
+		if (tb[NL80211_ATTR_IFINDEX]) {
+			if_indextoname(nla_get_u32(tb[NL80211_ATTR_IFINDEX]), dev);
+			print_string(PRINT_JSON, "ifname", "%s", dev);
 		}
-	}
-	printf("\n");
 
-	if (bss[NL80211_BSS_LAST_SEEN_BOOTTIME]) {
-		unsigned long long bt;
-		bt = (unsigned long long)nla_get_u64(bss[NL80211_BSS_LAST_SEEN_BOOTTIME]);
-		printf("\tlast seen: %llu.%.3llus [boottime]\n", bt/1000000000, (bt%1000000000)/1000000);
-	}
+		char buf[32] = {0};
+		if (bss[NL80211_BSS_STATUS]) {
+			switch (nla_get_u32(bss[NL80211_BSS_STATUS])) {
+			case NL80211_BSS_STATUS_AUTHENTICATED:
+				snprintf(buf, sizeof(buf), "authenticated");
+				break;
+			case NL80211_BSS_STATUS_ASSOCIATED:
+				snprintf(buf, sizeof(buf), "associated");
+				break;
+			case NL80211_BSS_STATUS_IBSS_JOINED:
+				snprintf(buf, sizeof(buf), "joined");
+				break;
+			default:
+				snprintf(buf, sizeof(buf), "unknown status: %d", nla_get_u32(bss[NL80211_BSS_STATUS]));
+				break;
+			}
+		}
+		print_string(PRINT_JSON, "status", "%s", buf);
 
-	if (bss[NL80211_BSS_TSF]) {
-		unsigned long long tsf;
-		tsf = (unsigned long long)nla_get_u64(bss[NL80211_BSS_TSF]);
-		printf("\tTSF: %llu usec (%llud, %.2lld:%.2llu:%.2llu)\n",
-			tsf, tsf/1000/1000/60/60/24, (tsf/1000/1000/60/60) % 24,
-			(tsf/1000/1000/60) % 60, (tsf/1000/1000) % 60);
-	}
-	if (bss[NL80211_BSS_FREQUENCY]) {
-		int freq = nla_get_u32(bss[NL80211_BSS_FREQUENCY]);
-		printf("\tfreq: %d\n", freq);
-		if (freq > 45000)
-			is_dmg = true;
-	}
-	if (bss[NL80211_BSS_BEACON_INTERVAL])
-		printf("\tbeacon interval: %d TUs\n",
-			nla_get_u16(bss[NL80211_BSS_BEACON_INTERVAL]));
-	if (bss[NL80211_BSS_CAPABILITY]) {
-		__u16 capa = nla_get_u16(bss[NL80211_BSS_CAPABILITY]);
-		printf("\tcapability:");
-		if (is_dmg)
-			print_capa_dmg(capa);
-		else
-			print_capa_non_dmg(capa);
-		printf(" (0x%.4x)\n", capa);
-	}
-	if (bss[NL80211_BSS_SIGNAL_MBM]) {
-		int s = nla_get_u32(bss[NL80211_BSS_SIGNAL_MBM]);
-		printf("\tsignal: %d.%.2d dBm\n", s/100, s%100);
-	}
-	if (bss[NL80211_BSS_SIGNAL_UNSPEC]) {
-		unsigned char s = nla_get_u8(bss[NL80211_BSS_SIGNAL_UNSPEC]);
-		printf("\tsignal: %d/100\n", s);
-	}
-	if (bss[NL80211_BSS_SEEN_MS_AGO]) {
-		int age = nla_get_u32(bss[NL80211_BSS_SEEN_MS_AGO]);
-		printf("\tlast seen: %d ms ago\n", age);
-	}
+		if (bss[NL80211_BSS_LAST_SEEN_BOOTTIME]) {
+			unsigned long long bt;
+			bt = (unsigned long long)nla_get_u64(bss[NL80211_BSS_LAST_SEEN_BOOTTIME]);
+			print_string(PRINT_JSON, "last seen", "%llu.%.3llus [boottime]", bt/1000000000, (bt%1000000000)/1000000);
+		}
 
-	if (bss[NL80211_BSS_INFORMATION_ELEMENTS] && show--) {
-		struct nlattr *ies = bss[NL80211_BSS_INFORMATION_ELEMENTS];
-		struct nlattr *bcnies = bss[NL80211_BSS_BEACON_IES];
-
-		if (bss[NL80211_BSS_PRESP_DATA] ||
-		    (bcnies && (nla_len(ies) != nla_len(bcnies) ||
-				memcmp(nla_data(ies), nla_data(bcnies),
-				       nla_len(ies)))))
-			printf("\tInformation elements from Probe Response "
-			       "frame:\n");
-		print_ies(nla_data(ies), nla_len(ies),
-			  params->unknown, params->type);
-	}
-	if (bss[NL80211_BSS_BEACON_IES] && show--) {
-		printf("\tInformation elements from Beacon frame:\n");
-		print_ies(nla_data(bss[NL80211_BSS_BEACON_IES]),
-			  nla_len(bss[NL80211_BSS_BEACON_IES]),
-			  params->unknown, params->type);
+		if (bss[NL80211_BSS_TSF]) {
+			unsigned long long tsf;
+			tsf = (unsigned long long)nla_get_u64(bss[NL80211_BSS_TSF]);
+
+			open_json_object("TSF");
+			print_u64(PRINT_JSON, "usec", "%llu", tsf);
+			print_u64(PRINT_JSON, "dd", "%llu", tsf/1000/1000/60/60/24);
+			print_u64(PRINT_JSON, "hh", "%llu", (tsf/1000/1000/60/60) % 24);
+			print_u64(PRINT_JSON, "mm", "%llu", (tsf/1000/1000/60) % 60);
+			print_u64(PRINT_JSON, "ss", "%llu", (tsf/1000/1000) % 60);
+			close_json_object();
+		}
+		if (bss[NL80211_BSS_FREQUENCY]) {
+			int freq = nla_get_u32(bss[NL80211_BSS_FREQUENCY]);
+			print_int(PRINT_JSON, "freq", "%d", freq);
+			if (freq > 45000) is_dmg = true;
+		}
+		if (bss[NL80211_BSS_BEACON_INTERVAL])
+			print_int(PRINT_JSON, "beacon_interval_tus", "%d", nla_get_u16(bss[NL80211_BSS_BEACON_INTERVAL]));
+		if (bss[NL80211_BSS_CAPABILITY]) {
+			__u16 capa = nla_get_u16(bss[NL80211_BSS_CAPABILITY]);
+			open_json_array("capability", NULL);
+			if (is_dmg){
+				print_capa_dmg(capa);
+			}else{
+				print_capa_non_dmg(capa);
+			}
+			close_json_array(NULL);
+
+			print_string(PRINT_JSON, "capability_raw", "0x%.4x", capa);
+		}
+		if (bss[NL80211_BSS_SIGNAL_MBM]) {
+			int s = nla_get_u32(bss[NL80211_BSS_SIGNAL_MBM]);
+			print_string(PRINT_JSON, "signal", "%d.%.2d dBm", s/100, s%100);
+		}
+		if (bss[NL80211_BSS_SIGNAL_UNSPEC]) {
+			unsigned char s = nla_get_u8(bss[NL80211_BSS_SIGNAL_UNSPEC]);
+			print_u8(PRINT_JSON, "signal_dbm", "%d/100", s);
+		}
+		if (bss[NL80211_BSS_SEEN_MS_AGO]) {
+			int age = nla_get_u32(bss[NL80211_BSS_SEEN_MS_AGO]);
+			print_int(PRINT_JSON, "last_seen_ms_ago", "%d", age);
+		}
+
+		if (bss[NL80211_BSS_INFORMATION_ELEMENTS] && show--) {
+			struct nlattr *ies = bss[NL80211_BSS_INFORMATION_ELEMENTS];
+			struct nlattr *bcnies = bss[NL80211_BSS_BEACON_IES];
+
+			if (bss[NL80211_BSS_PRESP_DATA] ||
+				(bcnies && (nla_len(ies) != nla_len(bcnies) ||
+					memcmp(nla_data(ies), nla_data(bcnies),
+						nla_len(ies))))){
+				open_json_object("bss_probe_resp_data_frame");
+				print_ies(nla_data(ies), nla_len(ies), params->unknown, params->type);
+				close_json_object();
+			}
+		}
+		if (bss[NL80211_BSS_BEACON_IES] && show--) {
+			open_json_object("bss_beacon_frame");
+			print_ies(nla_data(bss[NL80211_BSS_BEACON_IES]),
+				nla_len(bss[NL80211_BSS_BEACON_IES]),
+				params->unknown, params->type);
+			close_json_object();
+		}
+
+		close_json_object();
+	} else { //text output
+		if (!tb[NL80211_ATTR_BSS]) {
+			fprintf(stderr, "bss info missing!\n");
+			return NL_SKIP;
+		}
+		if (nla_parse_nested(bss, NL80211_BSS_MAX,
+					tb[NL80211_ATTR_BSS],
+					bss_policy)) {
+			fprintf(stderr, "failed to parse nested attributes!\n");
+			return NL_SKIP;
+		}
+
+		if (!bss[NL80211_BSS_BSSID])
+			return NL_SKIP;
+
+		mac_addr_n2a(mac_addr, nla_data(bss[NL80211_BSS_BSSID]));
+		printf("BSS %s", mac_addr);
+
+		if (tb[NL80211_ATTR_IFINDEX]) {
+			if_indextoname(nla_get_u32(tb[NL80211_ATTR_IFINDEX]), dev);
+			printf("(on %s)", dev);
+		}
+
+		if (bss[NL80211_BSS_STATUS]) {
+			switch (nla_get_u32(bss[NL80211_BSS_STATUS])) {
+			case NL80211_BSS_STATUS_AUTHENTICATED:
+				printf(" -- authenticated");
+				break;
+			case NL80211_BSS_STATUS_ASSOCIATED:
+				printf(" -- associated");
+				break;
+			case NL80211_BSS_STATUS_IBSS_JOINED:
+				printf(" -- joined");
+				break;
+			default:
+				printf(" -- unknown status: %d",
+					nla_get_u32(bss[NL80211_BSS_STATUS]));
+				break;
+			}
+		}
+		printf("\n");
+
+		if (bss[NL80211_BSS_LAST_SEEN_BOOTTIME]) {
+			unsigned long long bt;
+			bt = (unsigned long long)nla_get_u64(bss[NL80211_BSS_LAST_SEEN_BOOTTIME]);
+			printf("\tlast seen: %llu.%.3llus [boottime]\n", bt/1000000000, (bt%1000000000)/1000000);
+		}
+
+		if (bss[NL80211_BSS_TSF]) {
+			unsigned long long tsf;
+			tsf = (unsigned long long)nla_get_u64(bss[NL80211_BSS_TSF]);
+			printf("\tTSF: %llu usec (%llud, %.2lld:%.2llu:%.2llu)\n",
+				tsf, tsf/1000/1000/60/60/24, (tsf/1000/1000/60/60) % 24,
+				(tsf/1000/1000/60) % 60, (tsf/1000/1000) % 60);
+		}
+		if (bss[NL80211_BSS_FREQUENCY]) {
+			int freq = nla_get_u32(bss[NL80211_BSS_FREQUENCY]);
+			printf("\tfreq: %d\n", freq);
+			if (freq > 45000)
+				is_dmg = true;
+		}
+		if (bss[NL80211_BSS_BEACON_INTERVAL])
+			printf("\tbeacon interval: %d TUs\n",
+				nla_get_u16(bss[NL80211_BSS_BEACON_INTERVAL]));
+		if (bss[NL80211_BSS_CAPABILITY]) {
+			__u16 capa = nla_get_u16(bss[NL80211_BSS_CAPABILITY]);
+			printf("\tcapability:");
+			if (is_dmg)
+				print_capa_dmg(capa);
+			else
+				print_capa_non_dmg(capa);
+			printf(" (0x%.4x)\n", capa);
+		}
+		if (bss[NL80211_BSS_SIGNAL_MBM]) {
+			int s = nla_get_u32(bss[NL80211_BSS_SIGNAL_MBM]);
+			printf("\tsignal: %d.%.2d dBm\n", s/100, s%100);
+		}
+		if (bss[NL80211_BSS_SIGNAL_UNSPEC]) {
+			unsigned char s = nla_get_u8(bss[NL80211_BSS_SIGNAL_UNSPEC]);
+			printf("\tsignal: %d/100\n", s);
+		}
+		if (bss[NL80211_BSS_SEEN_MS_AGO]) {
+			int age = nla_get_u32(bss[NL80211_BSS_SEEN_MS_AGO]);
+			printf("\tlast seen: %d ms ago\n", age);
+		}
+
+		if (bss[NL80211_BSS_INFORMATION_ELEMENTS] && show--) {
+			struct nlattr *ies = bss[NL80211_BSS_INFORMATION_ELEMENTS];
+			struct nlattr *bcnies = bss[NL80211_BSS_BEACON_IES];
+
+			if (bss[NL80211_BSS_PRESP_DATA] ||
+				(bcnies && (nla_len(ies) != nla_len(bcnies) ||
+					memcmp(nla_data(ies), nla_data(bcnies),
+						nla_len(ies)))))
+				printf("\tInformation elements from Probe Response "
+					"frame:\n");
+			print_ies(nla_data(ies), nla_len(ies),
+				params->unknown, params->type);
+		}
+		if (bss[NL80211_BSS_BEACON_IES] && show--) {
+			printf("\tInformation elements from Beacon frame:\n");
+			print_ies(nla_data(bss[NL80211_BSS_BEACON_IES]),
+				nla_len(bss[NL80211_BSS_BEACON_IES]),
+				params->unknown, params->type);
+		}
 	}
 
 	return NL_SKIP;
diff --git a/util.c b/util.c
index 8a2ba10..0692633 100644
--- a/util.c
+++ b/util.c
@@ -5,6 +5,8 @@
 #include "iw.h"
 #include "nl80211.h"
 
+#include "json/json_print.h"
+
 void mac_addr_n2a(char *mac_addr, const unsigned char *arg)
 {
 	int i, l;
@@ -220,19 +222,30 @@ int ieee80211_frequency_to_channel(int freq)
 		return 0;
 }
 
-void print_ssid_escaped(const uint8_t len, const uint8_t *data)
-{
-	int i;
+static char *ssid_escape(const uint8_t len, const uint8_t *data) {
+    static char ssid_escaped[512]; // static buffer
+    int pos = 0;
+
+    for (int i = 0; i < len && pos < sizeof(ssid_escaped) - 5; i++) { // leave space for "\xXX" and terminator byte
+        if (isprint(data[i]) && data[i] != ' ' && data[i] != '\\') {
+            ssid_escaped[pos++] = data[i];
+        } else if (data[i] == ' ' && (i != 0 && i != len - 1)) {
+            ssid_escaped[pos++] = ' ';
+        } else {
+            pos += snprintf(ssid_escaped + pos, sizeof(ssid_escaped) - pos, "\\x%.2x", data[i]);
+        }
+    }
+    ssid_escaped[pos] = '\0'; // set terminator byte
+    return ssid_escaped;
+}
 
-	for (i = 0; i < len; i++) {
-		if (isprint(data[i]) && data[i] != ' ' && data[i] != '\\')
-			printf("%c", data[i]);
-		else if (data[i] == ' ' &&
-			 (i != 0 && i != len -1))
-			printf(" ");
-		else
-			printf("\\x%.2x", data[i]);
-	}
+void print_ssid_escaped(const uint8_t len, const uint8_t *data) {
+	char *escaped_ssid = ssid_escape(len, data);
+    if (!iw_json) {
+        printf("%s", escaped_ssid);
+    } else {
+        print_string(PRINT_JSON, "SSID", "%s", escaped_ssid);
+    }
 }
 
 static int hex2num(char digit)
@@ -743,38 +756,103 @@ int put_chandef(struct nl_msg *msg, struct chandef *chandef)
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
+
+				//print single or range value
+				if(iw_json){
+					snprintf(p, bufleft, "%d", prev_bit);
+					print_string(PRINT_JSON, NULL, "%s", buf);
+				}else{
+					snprintf(p, bufleft, "%d, ", prev_bit);
+					printf("%s", buf);
+				}
+
+				//reset buffer
+				p = buf;
+				bufleft = sizeof(buf);
+
+			} else if (!iw_json) {
+				written = snprintf(p, bufleft, " ");
+				p += written;
+				bufleft -= written;
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
+	iw_json ? print_string(PRINT_JSON, NULL, "%s", buf) : printf("%s", buf);
+
+	//text output only
+	if(!iw_json) printf("\n");
 }
 
 /*
@@ -816,19 +894,32 @@ void print_ampdu_length(__u8 exponent)
 
 	max_ampdu_length = compute_ampdu_length(exponent);
 
-	if (max_ampdu_length) {
-		printf("\t\tMaximum RX AMPDU length %d bytes (exponent: 0x0%02x)\n",
-		       max_ampdu_length, exponent);
-	} else {
-		printf("\t\tMaximum RX AMPDU length: unrecognized bytes "
-		       "(exponent: %d)\n", exponent);
+	if(iw_json){
+		if (max_ampdu_length) {
+			print_int(PRINT_JSON, "max_ampdu_length", "%d", max_ampdu_length);
+		} else {
+			print_int(PRINT_JSON, "max_ampdu_length", "%d", -1);
+		}
+		print_string(PRINT_JSON, "max_ampdu_exponent", "0x0%02x", exponent);
+	}else{
+		if (max_ampdu_length) {
+			printf("\t\tMaximum RX AMPDU length %d bytes (exponent: 0x0%02x)\n",
+				max_ampdu_length, exponent);
+		} else {
+			printf("\t\tMaximum RX AMPDU length: unrecognized bytes "
+				"(exponent: %d)\n", exponent);
+		}
 	}
 }
 
 void print_ampdu_spacing(__u8 spacing)
 {
-	printf("\t\tMinimum RX AMPDU time spacing: %s (0x%02x)\n",
-	       print_ampdu_space(spacing), spacing);
+	if(iw_json){
+		print_string(PRINT_JSON, "min_rx_ampdu_time_spacing", "%s", print_ampdu_space(spacing));
+		print_string(PRINT_JSON, "min_rx_ampdu_time_spacing_value", "0x0%02x", spacing);
+	}else{
+		printf("\t\tMinimum RX AMPDU time spacing: %s (0x%02x)\n", print_ampdu_space(spacing), spacing);
+	}
 }
 
 void print_ht_capability(__u16 cap)
@@ -836,10 +927,19 @@ void print_ht_capability(__u16 cap)
 #define PRINT_HT_CAP(_cond, _str) \
 	do { \
 		if (_cond) \
-			printf("\t\t\t" _str "\n"); \
+			if(iw_json){ \
+				print_string(PRINT_JSON, NULL, _str); \
+			} else { \
+				printf("\t\t\t" _str "\n"); \
+			} \
 	} while (0)
 
-	printf("\t\tCapabilities: 0x%02x\n", cap);
+	if(iw_json){
+		print_string(PRINT_JSON, "capabilities_value", "0x%02x", cap);
+		open_json_array("capabilities", NULL);
+	}else{
+		printf("\t\tCapabilities: 0x%02x\n", cap);
+	}
 
 	PRINT_HT_CAP((cap & BIT(0)), "RX LDPC");
 	PRINT_HT_CAP((cap & BIT(1)), "HT20/HT40");
@@ -878,6 +978,10 @@ void print_ht_capability(__u16 cap)
 	PRINT_HT_CAP((cap & BIT(14)), "40 MHz Intolerant");
 
 	PRINT_HT_CAP((cap & BIT(15)), "L-SIG TXOP protection");
+
+	if(iw_json){
+		close_json_array(NULL);
+	}
 #undef PRINT_HT_CAP
 }
 
@@ -893,32 +997,48 @@ void print_ht_mcs(const __u8 *mcs)
 	tx_max_num_spatial_streams = ((mcs[12] >> 2) & 3) + 1;
 	tx_unequal_modulation = !!(mcs[12] & (1 << 4));
 
-	if (max_rx_supp_data_rate)
-		printf("\t\tHT Max RX data rate: %d Mbps\n", max_rx_supp_data_rate);
+	if (max_rx_supp_data_rate){
+		if(iw_json){
+			print_int(PRINT_JSON, "ht_max_rx_data_rate_mbps", "%d", max_rx_supp_data_rate);
+		}else{
+			printf("\t\tHT Max RX data rate: %d Mbps\n", max_rx_supp_data_rate);
+		}
+	}
 	/* XXX: else see 9.6.0e.5.3 how to get this I think */
 
 	if (tx_mcs_set_defined) {
 		if (tx_mcs_set_equal) {
-			printf("\t\tHT TX/RX MCS rate indexes supported:");
+			iw_json ? open_json_array("ht_tx_rx_mcs_idx_supported", NULL) : printf("\t\tHT TX/RX MCS rate indexes supported:");
 			print_mcs_index(mcs);
+			if(iw_json) close_json_array(NULL);
 		} else {
-			printf("\t\tHT RX MCS rate indexes supported:");
+			iw_json ? open_json_array("ht_rx_mcs_idx_supported", NULL) : printf("\t\tHT RX MCS rate indexes supported:");
 			print_mcs_index(mcs);
+			if(iw_json) close_json_array(NULL);
 
-			if (tx_unequal_modulation)
-				printf("\t\tTX unequal modulation supported\n");
-			else
-				printf("\t\tTX unequal modulation not supported\n");
+			if(iw_json){
+				print_bool(PRINT_JSON, "tx_unequal_modulation", "%s", tx_unequal_modulation);
+				print_int(PRINT_JSON, "ht_tx_max_spatial_streams", "%d", tx_max_num_spatial_streams);
+			}else{
 
-			printf("\t\tHT TX Max spatial streams: %d\n",
-				tx_max_num_spatial_streams);
+				if (tx_unequal_modulation)
+					printf("\t\tTX unequal modulation supported\n");
+				else
+					printf("\t\tTX unequal modulation not supported\n");
 
-			printf("\t\tHT TX MCS rate indexes supported may differ\n");
+				printf("\t\tHT TX Max spatial streams: %d\n", tx_max_num_spatial_streams);
+				printf("\t\tHT TX MCS rate indexes supported may differ\n");
+			}
 		}
 	} else {
-		printf("\t\tHT RX MCS rate indexes supported:");
+		iw_json ? open_json_array("ht_rx_mcs_idx_supported", NULL) : printf("\t\tHT RX MCS rate indexes supported:");
 		print_mcs_index(mcs);
-		printf("\t\tHT TX MCS rate indexes are undefined\n");
+		if(iw_json){
+			close_json_array(NULL);
+		}else{
+		//text output only
+			printf("\t\tHT TX MCS rate indexes are undefined\n");
+		}
 	}
 }
 
@@ -1033,13 +1153,13 @@ static const struct vht_nss_ratio nss_ratio_tbl[3][4] = {
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
@@ -1054,7 +1174,7 @@ static void print_nss_ratio_value(int ratio)
 		break;
 	}
 
-	printf("(%s NSS) ", rstr);
+	return rstr;
 }
 
 static void print_nss_ratio(const char *str, bool force_show, int ratio)
@@ -1063,53 +1183,83 @@ static void print_nss_ratio(const char *str, bool force_show, int ratio)
 		return;
 	if (ratio == 4) {
 		if (force_show)
-			printf("%s ", str);
+			iw_json ? print_string(PRINT_JSON, str, "") : printf("%s ", str);
 	} else {
-		printf("%s ", str);
-		print_nss_ratio_value(ratio);
+		if(iw_json){
+			print_string(PRINT_JSON, str, "%s NSS", nss_ratio_value(ratio));
+		}else{
+			printf("%s ", str);
+			printf("%s NSS", nss_ratio_value(ratio));
+		}
 	}
 }
 
 void print_vht_info(__u32 capa, const __u8 *mcs)
 {
+#define PRINT_VHT_CAPA(_bit, _str) \
+	do { \
+		if (capa & BIT(_bit)){ \
+			iw_json ? print_bool(PRINT_JSON, _str, "%s", true) : printf("\t\t\t" _str "\n"); \
+		} \
+	} while (0)
+
 	__u16 tmp;
 	__u32 supp_chan_width, ext_nss_bw;
 	const struct vht_nss_ratio *nss_tbl;
 	int i;
 
-	printf("\t\tVHT Capabilities (0x%.8x):\n", capa);
-
-#define PRINT_VHT_CAPA(_bit, _str) \
-	do { \
-		if (capa & BIT(_bit)) \
-			printf("\t\t\t" _str "\n"); \
-	} while (0)
-
-	printf("\t\t\tMax MPDU length: ");
-	switch (capa & 3) {
-	case 0: printf("3895\n"); break;
-	case 1: printf("7991\n"); break;
-	case 2: printf("11454\n"); break;
-	case 3: printf("(reserved)\n");
+	if(iw_json){
+		print_string(PRINT_JSON, "vht_capabilities_raw", "0x%.8x", capa);
+		switch (capa & 3) {
+			case 0: print_string(PRINT_JSON, "vht_capabilities", "3895"); break;
+			case 1: print_string(PRINT_JSON, "vht_capabilities_data", "7991"); break;
+			case 2: print_string(PRINT_JSON, "vht_capabilities_data", "11454"); break;
+			case 3: print_string(PRINT_JSON, "vht_capabilities_data", "reserved");
+		}
+	}else{
+		printf("\n");
+		printf("\t\tVHT Capabilities (0x%.8x):\n", capa);
+		printf("\t\t\tMax MPDU length: ");
+		switch (capa & 3) {
+			case 0: printf("3895\n"); break;
+			case 1: printf("7991\n"); break;
+			case 2: printf("11454\n"); break;
+			case 3: printf("(reserved)\n");
+		}
 	}
 
-	printf("\t\t\tSupported Channel Width: ");
+	iw_json ? open_json_object("supported_channel_width") : printf("\t\t\tSupported Channel Width: ");
+
 	supp_chan_width = (capa >> 2) & 3;
 	ext_nss_bw = (capa >> 30) & 3;
 	nss_tbl = &nss_ratio_tbl[supp_chan_width][ext_nss_bw];
 
 	if (!nss_tbl->valid)
-		printf("(reserved)\n");
+		iw_json ? print_bool(PRINT_JSON,"reserved", "%s", true) : printf("(reserved)\n");
 	else if (nss_tbl->bw_20 == 4 &&
 		 nss_tbl->bw_40 == 4 &&
 		 nss_tbl->bw_80 == 4 &&
 		 (!nss_tbl->bw_160 || nss_tbl->bw_160 == 4) &&
 		 (!nss_tbl->bw_80_80 || nss_tbl->bw_80_80 == 4)) {
 		/* old style print format */
-		switch (supp_chan_width) {
-		case 0: printf("neither 160 nor 80+80\n"); break;
-		case 1: printf("160 MHz\n"); break;
-		case 2: printf("160 MHz, 80+80 MHz\n"); break;
+		if(iw_json){
+			switch (supp_chan_width) {
+				case 0:
+					break;
+				case 1:
+					print_bool(PRINT_JSON, "160", "%s", true);
+					break;
+				case 2:
+					print_bool(PRINT_JSON, "160", "%s", true);
+					print_bool(PRINT_JSON, "80+80", "%s", true);
+					break;
+			}
+		}else{
+			switch (supp_chan_width) {
+				case 0: printf("neither 160 nor 80+80\n"); break;
+				case 1: printf("160 MHz\n"); break;
+				case 2: printf("160 MHz, 80+80 MHz\n"); break;
+			}
 		}
 	} else {
 		print_nss_ratio("20Mhz", false, nss_tbl->bw_20);
@@ -1119,6 +1269,9 @@ void print_vht_info(__u32 capa, const __u8 *mcs)
 		print_nss_ratio("80+80Mhz", false, nss_tbl->bw_80_80);
 		printf("\n");
 	}
+	if(iw_json){
+		close_json_object();
+	}
 
 	PRINT_VHT_CAPA(4, "RX LDPC");
 	PRINT_VHT_CAPA(5, "short GI (80 MHz)");
@@ -1138,36 +1291,39 @@ void print_vht_info(__u32 capa, const __u8 *mcs)
 	PRINT_VHT_CAPA(28, "RX antenna pattern consistency");
 	PRINT_VHT_CAPA(29, "TX antenna pattern consistency");
 
-	printf("\t\tVHT RX MCS set:\n");
-	tmp = mcs[0] | (mcs[1] << 8);
-	for (i = 1; i <= 8; i++) {
-		printf("\t\t\t%d streams: ", i);
-		switch ((tmp >> ((i-1)*2) ) & 3) {
-		case 0: printf("MCS 0-7\n"); break;
-		case 1: printf("MCS 0-8\n"); break;
-		case 2: printf("MCS 0-9\n"); break;
-		case 3: printf("not supported\n"); break;
+	if(iw_json){
+
+	}else{
+		printf("\t\tVHT RX MCS set:\n");
+		tmp = mcs[0] | (mcs[1] << 8);
+		for (i = 1; i <= 8; i++) {
+			printf("\t\t\t%d streams: ", i);
+			switch ((tmp >> ((i-1)*2) ) & 3) {
+			case 0: printf("MCS 0-7\n"); break;
+			case 1: printf("MCS 0-8\n"); break;
+			case 2: printf("MCS 0-9\n"); break;
+			case 3: printf("not supported\n"); break;
+			}
 		}
-	}
-	tmp = mcs[2] | (mcs[3] << 8);
-	printf("\t\tVHT RX highest supported: %d Mbps\n", tmp & 0x1fff);
-
-	printf("\t\tVHT TX MCS set:\n");
-	tmp = mcs[4] | (mcs[5] << 8);
-	for (i = 1; i <= 8; i++) {
-		printf("\t\t\t%d streams: ", i);
-		switch ((tmp >> ((i-1)*2) ) & 3) {
-		case 0: printf("MCS 0-7\n"); break;
-		case 1: printf("MCS 0-8\n"); break;
-		case 2: printf("MCS 0-9\n"); break;
-		case 3: printf("not supported\n"); break;
+		tmp = mcs[2] | (mcs[3] << 8);
+		printf("\t\tVHT RX highest supported: %d Mbps\n", tmp & 0x1fff);
+
+		printf("\t\tVHT TX MCS set:\n");
+		tmp = mcs[4] | (mcs[5] << 8);
+		for (i = 1; i <= 8; i++) {
+			printf("\t\t\t%d streams: ", i);
+			switch ((tmp >> ((i-1)*2) ) & 3) {
+			case 0: printf("MCS 0-7\n"); break;
+			case 1: printf("MCS 0-8\n"); break;
+			case 2: printf("MCS 0-9\n"); break;
+			case 3: printf("not supported\n"); break;
+			}
 		}
-	}
-	tmp = mcs[6] | (mcs[7] << 8);
-	printf("\t\tVHT TX highest supported: %d Mbps\n", tmp & 0x1fff);
+		tmp = mcs[6] | (mcs[7] << 8);
+		printf("\t\tVHT TX highest supported: %d Mbps\n", tmp & 0x1fff);
 
-	printf("\t\tVHT extended NSS: %ssupported\n",
-	       (tmp & (1 << 13)) ? "" : "not ");
+		printf("\t\tVHT extended NSS: %ssupported\n", (tmp & (1 << 13)) ? "" : "not ");
+	}
 }
 
 static void __print_he_capa(const __u16 *mac_cap,
@@ -1183,13 +1339,13 @@ static void __print_he_capa(const __u16 *mac_cap,
 	#define PRINT_HE_CAP(_var, _idx, _bit, _str) \
 	do { \
 		if (_var[_idx] & BIT(_bit)) \
-			printf("%s\t\t\t" _str "\n", pre); \
+			iw_json ? print_string(PRINT_JSON, NULL, _str) : printf("%s\t\t\t" _str "\n", pre); \
 	} while (0)
 
 	#define PRINT_HE_CAP_MASK(_var, _idx, _shift, _mask, _str) \
 	do { \
 		if ((_var[_idx] >> _shift) & _mask) \
-			printf("%s\t\t\t" _str ": %d\n", pre, (_var[_idx] >> _shift) & _mask); \
+			iw_json ? print_string(PRINT_JSON, NULL, "%s %d", _str, (_var[_idx] >> _shift) & _mask) : printf("%s\t\t\t" _str ": %d\n", pre, (_var[_idx] >> _shift) & _mask); \
 	} while (0)
 
 	#define PRINT_HE_MAC_CAP(...) PRINT_HE_CAP(mac_cap, __VA_ARGS__)
@@ -1198,10 +1354,16 @@ static void __print_he_capa(const __u16 *mac_cap,
 	#define PRINT_HE_PHY_CAP0(_idx, _bit, ...) PRINT_HE_CAP(phy_cap, _idx, _bit + 8, __VA_ARGS__)
 	#define PRINT_HE_PHY_CAP_MASK(...) PRINT_HE_CAP_MASK(phy_cap, __VA_ARGS__)
 
-	printf("%s\t\tHE MAC Capabilities (0x", pre);
-	for (i = 0; i < 3; i++)
-		printf("%04x", mac_cap[i]);
-	printf("):\n");
+	if(iw_json){
+		print_string(PRINT_JSON, "he_mac_capabilities_raw", "%s 0x%04x%04x%04x", pre, mac_cap[0], mac_cap[1], mac_cap[2]);
+		open_json_array("he_mac_capabilities", NULL);
+	}else{
+		printf("\n");
+		printf("%s\t\tHE MAC Capabilities (0x", pre);
+		for (i = 0; i < 3; i++)
+			printf("%04x", mac_cap[i]);
+		printf("):\n");
+	}
 
 	PRINT_HE_MAC_CAP(0, 0, "+HTC HE Supported");
 	PRINT_HE_MAC_CAP(0, 1, "TWT Requester");
@@ -1238,10 +1400,25 @@ static void __print_he_capa(const __u16 *mac_cap,
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
+		if(iw_json){
+			close_json_array(NULL);
+			print_string(PRINT_JSON, "he_phy_capabilities_raw", "%s 0x%s", pre, buf);
+			open_json_array("he_phy_capabilities", NULL);
+		}else{
+			printf("%s\t\tHE PHY Capabilities: (0x%s)", pre, buf);
+		}
+	}
 
 	PRINT_HE_PHY_CAP0(0, 1, "HE40/2.4GHz");
 	PRINT_HE_PHY_CAP0(0, 2, "HE40/HE80/5GHz");
@@ -1308,6 +1485,8 @@ static void __print_he_capa(const __u16 *mac_cap,
 	PRINT_HE_PHY_CAP(5, 4, "RX Full BW SU Using HE MU PPDU with Compression SIGB");
 	PRINT_HE_PHY_CAP(5, 5, "RX Full BW SU Using HE MU PPDU with Non-Compression SIGB");
 
+	if(iw_json) close_json_array(NULL);
+
 	mcs_used = 0;
 	for (i = 0; i < 3; i++) {
 		__u8 phy_cap_support[] = { BIT(1) | BIT(2), BIT(3), BIT(4) };
@@ -1321,20 +1500,43 @@ static void __print_he_capa(const __u16 *mac_cap,
 		if ((i * 2 + 2) * sizeof(mcs_set[0]) >= mcs_len)
 			return;
 
-		for (j = 0; j < 2; j++) {
-			int k;
-			printf("%s\t\tHE %s MCS and NSS set %s MHz\n", pre, j ? "TX" : "RX", bw[i]);
-			for (k = 0; k < 8; k++) {
-				__u16 mcs = mcs_set[(i * 2) + j];
-				mcs >>= k * 2;
-				mcs &= 0x3;
-				printf("%s\t\t\t%d streams: ", pre, k + 1);
-				if (mcs == 3)
-					printf("not supported\n");
-				else
-					printf("MCS 0-%d\n", 7 + (mcs * 2));
+		if(iw_json){
+			for (j = 0; j < 2; j++) {
+				int k;
+				char buf[512] = {0};
+				snprintf(buf, sizeof(buf), "%s_he_%s_mcs_and_nss_set", pre, j ? "tx" : "rx");
+				open_json_object(buf);
+				print_string(PRINT_JSON, "width_mhz", "%s", bw[i]);
+				open_json_object("streams");
+				for (k = 0; k < 8; k++) {
+					__u16 mcs = mcs_set[(i * 2) + j];
+					mcs >>= k * 2;
+					mcs &= 0x3;
+					char keybuf[16];
+					snprintf(keybuf, sizeof(keybuf), "%s_%d_streams", pre, k + 1);
+					if (mcs == 3)
+						print_string(PRINT_JSON, keybuf, "not supported");
+					else
+						print_string(PRINT_JSON, keybuf, "MCS 0-%d", 7 + (mcs * 2));
+				}
+				close_json_object();
+				close_json_object();
+			}
+		}else{
+			for (j = 0; j < 2; j++) {
+				int k;
+				printf("%s\t\tHE %s MCS and NSS set %s MHz\n", pre, j ? "TX" : "RX", bw[i]);
+				for (k = 0; k < 8; k++) {
+					__u16 mcs = mcs_set[(i * 2) + j];
+					mcs >>= k * 2;
+					mcs &= 0x3;
+					printf("%s\t\t\t%d streams: ", pre, k + 1);
+					if (mcs == 3)
+						printf("not supported\n");
+					else
+						printf("MCS 0-%d\n", 7 + (mcs * 2));
+				}
 			}
-
 		}
 		mcs_used += 2 * sizeof(mcs_set[0]);
 	}
@@ -1348,12 +1550,23 @@ static void __print_he_capa(const __u16 *mac_cap,
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
+			iw_json ? print_string(PRINT_JSON, "ppe_threshold", "%s", buf) : printf("%s\t\tPPE Threshold %s\n", pre, buf);
+		}
 	}
 }
 
@@ -1362,9 +1575,16 @@ void print_iftype_list(const char *name, const char *pfx, struct nlattr *attr)
 	struct nlattr *ift;
 	int rem;
 
-	printf("%s:\n", name);
-	nla_for_each_nested(ift, attr, rem)
-		printf("%s * %s\n", pfx, iftype_name(nla_type(ift)));
+	if(iw_json){
+		nla_for_each_nested(ift, attr, rem){
+			print_string(PRINT_JSON, name, "%s * %s", pfx, iftype_name(nla_type(ift)));
+		}
+	} else {
+		printf("%s:\n", name);
+		nla_for_each_nested(ift, attr, rem){
+			printf("%s * %s\n", pfx, iftype_name(nla_type(ift)));
+		}
+	}
 }
 
 void print_iftype_line(struct nlattr *attr)
@@ -1694,7 +1914,7 @@ int get_cf1(const struct chanmode *chanmode, unsigned long freq)
 				6435, 6515, 6595, 6675, 6755, 6835,
 				6195, 6995 };
 	unsigned int bw160[] = { 5180, 5500, 5955, 6115, 6275, 6435,
-				  6595, 6755, 6915 };
+				6595, 6755, 6915 };
 
 	switch (chanmode->width) {
 	case NL80211_CHAN_WIDTH_80:
-- 
2.42.0


