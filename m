Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53EE17A84C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 15:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCEO5M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 09:57:12 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:35772 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgCEO5M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 09:57:12 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j9rvx-001JyE-TK; Thu, 05 Mar 2020 15:57:09 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Bob Copeland <me@bobcopeland.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/4] wmediumd: create dependency files
Date:   Thu,  5 Mar 2020 15:56:53 +0100
Message-Id: <20200305155407.9160bf08eb68.I572a908900222a0d2fbaf683b66acc266c5ad904@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305145655.67427-1-johannes@sipsolutions.net>
References: <20200305145655.67427-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If header files are changed, currently 'make clean' is needed.
Fix that by having the compiler write dependency files and
including them appropriately.

---
 .gitignore        | 1 +
 wmediumd/Makefile | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index 04c2b8047d3e..df3bfda9f922 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
 *.o
+*.d
 wmediumd/wmediumd
 
diff --git a/wmediumd/Makefile b/wmediumd/Makefile
index 0e5e6d2ee006..395215b74089 100644
--- a/wmediumd/Makefile
+++ b/wmediumd/Makefile
@@ -8,6 +8,7 @@ NL31FOUND := $(shell $(PKG_CONFIG) --exact-version=3.1 libnl-3.1 && echo Y)
 NL3xFOUND := $(shell $(PKG_CONFIG) --atleast-version=3.2 libnl-3.0 && echo Y)
 
 CFLAGS += -g -Wall -Wextra -Wno-unused-parameter -O2
+CFLAGS += -MMD -MP
 LDFLAGS += -levent -lm
 
 ifeq ($(NL2FOUND),Y)
@@ -53,6 +54,9 @@ all: wmediumd
 
 wmediumd: $(OBJECTS) 
 	$(CC) -o $@ $(OBJECTS) $(LDFLAGS) 
- 
+
+DEPS := $(patsubst %.o,%.d,$(OBJECTS))
 clean: 
-	rm -f $(OBJECTS) wmediumd
+	rm -f $(OBJECTS) $(DEPS) wmediumd
+
+-include *.d
-- 
2.24.1

