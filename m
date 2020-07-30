Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2C5233372
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 15:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgG3Nwe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 09:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgG3Nwe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 09:52:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E147C061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 06:52:34 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k18z1-00DYp2-Qv; Thu, 30 Jul 2020 15:52:31 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: make check_sdata_in_driver() once for each callsite
Date:   Thu, 30 Jul 2020 15:52:13 +0200
Message-Id: <20200730155212.06fd3a95dbfb.I0b16829aabfaf5f642bce401502a29d16e2dd444@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Ben Greear has repeatedly reported in the past (for a few years
probably) that this triggers repeatedly in certain scenarios.

Make this a macro so that each callsite can trigger the warning
only once - that will still give us an idea of what's going on
and what paths can reach it, but avoids being too noisy.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/driver-ops.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index de69fc9c4f07..41d495d73d3a 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -12,12 +12,11 @@
 #include "ieee80211_i.h"
 #include "trace.h"
 
-static inline bool check_sdata_in_driver(struct ieee80211_sub_if_data *sdata)
-{
-	return !WARN(!(sdata->flags & IEEE80211_SDATA_IN_DRIVER),
-		     "%s:  Failed check-sdata-in-driver check, flags: 0x%x\n",
-		     sdata->dev ? sdata->dev->name : sdata->name, sdata->flags);
-}
+#define check_sdata_in_driver(sdata)	({					\
+	!WARN_ONCE(!(sdata->flags & IEEE80211_SDATA_IN_DRIVER),			\
+		   "%s: Failed check-sdata-in-driver check, flags: 0x%x\n",	\
+		   sdata->dev ? sdata->dev->name : sdata->name, sdata->flags);	\
+})
 
 static inline struct ieee80211_sub_if_data *
 get_bss_sdata(struct ieee80211_sub_if_data *sdata)
-- 
2.26.2

