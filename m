Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC5FF158DB4
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 12:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgBKLpM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 06:45:12 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:58102 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgBKLpM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 06:45:12 -0500
Received: from isengard.tu-ilmenau.de (unknown [141.24.111.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id EBC8258006E;
        Tue, 11 Feb 2020 12:45:09 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [RFC PATCH] iw: add clang-based fuzzer for scan IEs
Date:   Tue, 11 Feb 2020 12:45:02 +0100
Message-Id: <20200211114502.4250-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch is not ready for inclusion into the repo, but only useful for
testing purposes.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 Makefile    | 24 ++++++++++++++++++++----
 fuzz.sh     |  5 +++++
 fuzz_scan.c |  6 ++++++
 iw.c        |  4 ++++
 4 files changed, 35 insertions(+), 4 deletions(-)
 create mode 100755 fuzz.sh
 create mode 100644 fuzz_scan.c

diff --git a/Makefile b/Makefile
index 90f2251..4ba2daf 100644
--- a/Makefile
+++ b/Makefile
@@ -16,9 +16,9 @@ CFLAGS_EVAL := $(call cc-option,-Wstringop-overflow=4)
 CFLAGS ?= -O2 -g
 CFLAGS += -Wall -Wextra -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common \
 	  -Werror-implicit-function-declaration -Wsign-compare -Wno-unused-parameter \
-	  $(CFLAGS_EVAL)
+	  $(CFLAGS_EVAL) $(EXTRA_CFLAGS)
 
-_OBJS := $(sort $(patsubst %.c,%.o,$(wildcard *.c)))
+_OBJS := $(filter-out iw.o fuzz_scan.o, $(sort $(patsubst %.c,%.o,$(wildcard *.c))))
 VERSION_OBJS := $(filter-out version.o, $(_OBJS))
 OBJS := $(VERSION_OBJS) version.o
 
@@ -102,12 +102,28 @@ nl80211-commands.inc: nl80211.h
 	@$(NQ) ' CC  ' $@
 	$(Q)$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
 
+iw_main.o: iw.c iw.h nl80211.h nl80211-commands.inc
+	@$(NQ) ' CC  ' $@
+	$(Q)$(CC) $(CFLAGS) -DIW_MAIN=1 $(CPPFLAGS) -c -o $@ $<
+
+iw_no_main.o: iw.c iw.h nl80211.h nl80211-commands.inc
+	@$(NQ) ' CC  ' $@
+	$(Q)$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
+
 ifeq ($(IW_ANDROID_BUILD),)
-iw:	$(OBJS)
+iw:	$(OBJS) iw_main.o
 	@$(NQ) ' CC  ' iw
-	$(Q)$(CC) $(LDFLAGS) $(OBJS) $(LIBS) -o iw
+	$(Q)$(CC) $(LDFLAGS) $(OBJS) iw_main.o $(LIBS) -o iw
 endif
 
+fuzz_scan.o: fuzz_scan.c iw.h
+	@$(NQ) ' CC  ' $@
+	$(Q)$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
+
+fuzz_scan: fuzz_scan.o $(OBJS) iw_no_main.o
+	@$(NQ) ' CC  ' fuzz_scan
+	$(Q)$(CC) $(LDFLAGS) $(OBJS) iw_no_main.o fuzz_scan.o $(LIBS) -o fuzz_scan
+
 check:
 	$(Q)$(MAKE) all CC="REAL_CC=$(CC) CHECK=\"sparse -Wall\" cgcc"
 
diff --git a/fuzz.sh b/fuzz.sh
new file mode 100755
index 0000000..b98fecb
--- /dev/null
+++ b/fuzz.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+
+make V=1 CC=clang EXTRA_CFLAGS="-fsanitize=address,undefined,fuzzer" LDFLAGS="-fsanitize=fuzzer,address,undefined" fuzz_scan
+mkdir -p fuzz_corpus
+./fuzz_scan fuzz_corpus/ -max_len=512 -timeout=5 > /dev/null
diff --git a/fuzz_scan.c b/fuzz_scan.c
new file mode 100644
index 0000000..ed9da4f
--- /dev/null
+++ b/fuzz_scan.c
@@ -0,0 +1,6 @@
+#include "iw.h"
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
+	print_ies((unsigned char *)data, size, size % 2, PRINT_SCAN);
+	return 0;
+}
\ No newline at end of file
diff --git a/iw.c b/iw.c
index da71617..1563543 100644
--- a/iw.c
+++ b/iw.c
@@ -562,6 +562,8 @@ int handle_cmd(struct nl80211_state *state, enum id_input idby,
 static struct cmd sizer1 __attribute__((section("__sizer"))) = {};
 static struct cmd sizer2 __attribute__((section("__sizer"))) = {};
 
+#ifdef IW_MAIN
+
 int main(int argc, char **argv)
 {
 	struct nl80211_state nlstate;
@@ -638,3 +640,5 @@ int main(int argc, char **argv)
 
 	return err;
 }
+
+#endif
\ No newline at end of file
-- 
2.25.0

