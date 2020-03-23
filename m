Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D80A18FFAB
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 21:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgCWUno (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 16:43:44 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:55624 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgCWUno (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 16:43:44 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jGTvB-003CPS-Qi; Mon, 23 Mar 2020 21:43:41 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     me@bobcopeland.com, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wmediumd: add -lstdc++ for SANITIZE=1
Date:   Mon, 23 Mar 2020 21:43:32 +0100
Message-Id: <20200323214332.33b993c6e0a9.I3d0915b84d33b5a770cef1c1273bd33ac4e72d7b@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

It appears that in some scenarios this is necessary to get
the right version of the library, otherwise some runtime
linking can fail. Add -lstdc++ as required by -lasan.

Fixes: 7d18a8609350 ("wmediumd: support compilation with asan/ubsan")
---
Oops, sorry, should've tested this in all my environments before ...
---
 wmediumd/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wmediumd/Makefile b/wmediumd/Makefile
index f75c4e8b4e3e..fa94eb01fbc2 100644
--- a/wmediumd/Makefile
+++ b/wmediumd/Makefile
@@ -56,7 +56,7 @@ OBJECTS += lib/uds.o lib/vhost.o lib/wallclock.o
 ifeq ($(SANITIZE),1)
 CFLAGS += -fsanitize=undefined,address
 # apparently these have to come first for some reason
-override LDFLAGS := -lasan -lubsan $(LDFLAGS)
+override LDFLAGS := -lasan -lubsan -lstdc++ $(LDFLAGS)
 endif
 
 all: wmediumd 
-- 
2.25.1

