Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0AD18F882
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 16:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgCWPZu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 11:25:50 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:49308 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbgCWPZu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 11:25:50 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jGOxY-002WVN-G0; Mon, 23 Mar 2020 16:25:48 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     me@bobcopeland.com, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/7] wmediumd: support compilation with asan/ubsan
Date:   Mon, 23 Mar 2020 16:25:40 +0100
Message-Id: <20200323162245.cd34fabda35f.I5780f136bab2971b28698e2bb045387bf41add84@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323152542.68696-1-johannes@sipsolutions.net>
References: <20200323152542.68696-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Use "make SANITIZE=1" to get asan/ubsan for checking for errors.

---
 wmediumd/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/wmediumd/Makefile b/wmediumd/Makefile
index 585f488a9bd5..f75c4e8b4e3e 100644
--- a/wmediumd/Makefile
+++ b/wmediumd/Makefile
@@ -53,6 +53,12 @@ OBJECTS=wmediumd.o config.o per.o
 OBJECTS += lib/loop.o lib/sched.o lib/schedctrl.o
 OBJECTS += lib/uds.o lib/vhost.o lib/wallclock.o
 
+ifeq ($(SANITIZE),1)
+CFLAGS += -fsanitize=undefined,address
+# apparently these have to come first for some reason
+override LDFLAGS := -lasan -lubsan $(LDFLAGS)
+endif
+
 all: wmediumd 
 
 wmediumd: $(OBJECTS) 
-- 
2.25.1

