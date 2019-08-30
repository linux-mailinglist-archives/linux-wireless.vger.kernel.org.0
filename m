Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D051DA359C
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 13:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfH3LZA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 07:25:00 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39420 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727386AbfH3LY7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 07:24:59 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i3f1V-0001lc-3F; Fri, 30 Aug 2019 14:24:57 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 30 Aug 2019 14:24:44 +0300
Message-Id: <20190830112451.21655-2-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190830112451.21655-1-luca@coelho.fi>
References: <20190830112451.21655-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 1/8] cfg80211: always shut down on HW rfkill
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When the RFKILL subsystem isn't available, then rfkill_blocked()
always returns false. In the case of hardware rfkill this will
be wrong though, as if the hardware reported being killed then
it cannot operate any longer.

Since we only ever call the rfkill_sync work in this case, just
rename it to rfkill_block and always pass "true" for the blocked
parameter, rather than passing rfkill_blocked().

We rely on the underlying driver to still reject any new attempt
to bring up the device by itself.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/core.c        | 13 +++++++------
 net/wireless/core.h        |  2 +-
 net/wireless/wext-compat.c |  5 +++--
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index a599469b8157..350513744575 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010		Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018-2019 Intel Corporation
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -300,12 +300,13 @@ static int cfg80211_rfkill_set_block(void *data, bool blocked)
 	return 0;
 }
 
-static void cfg80211_rfkill_sync_work(struct work_struct *work)
+static void cfg80211_rfkill_block_work(struct work_struct *work)
 {
 	struct cfg80211_registered_device *rdev;
 
-	rdev = container_of(work, struct cfg80211_registered_device, rfkill_sync);
-	cfg80211_rfkill_set_block(rdev, rfkill_blocked(rdev->rfkill));
+	rdev = container_of(work, struct cfg80211_registered_device,
+			    rfkill_block);
+	cfg80211_rfkill_set_block(rdev, true);
 }
 
 static void cfg80211_event_work(struct work_struct *work)
@@ -516,7 +517,7 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 		return NULL;
 	}
 
-	INIT_WORK(&rdev->rfkill_sync, cfg80211_rfkill_sync_work);
+	INIT_WORK(&rdev->rfkill_block, cfg80211_rfkill_block_work);
 	INIT_WORK(&rdev->conn_work, cfg80211_conn_work);
 	INIT_WORK(&rdev->event_work, cfg80211_event_work);
 
@@ -1061,7 +1062,7 @@ void wiphy_rfkill_set_hw_state(struct wiphy *wiphy, bool blocked)
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
 	if (rfkill_set_hw_state(rdev->rfkill, blocked))
-		schedule_work(&rdev->rfkill_sync);
+		schedule_work(&rdev->rfkill_block);
 }
 EXPORT_SYMBOL(wiphy_rfkill_set_hw_state);
 
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 77556c58d9ac..ed487e324571 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -28,7 +28,7 @@ struct cfg80211_registered_device {
 	/* rfkill support */
 	struct rfkill_ops rfkill_ops;
 	struct rfkill *rfkill;
-	struct work_struct rfkill_sync;
+	struct work_struct rfkill_block;
 
 	/* ISO / IEC 3166 alpha2 for which this device is receiving
 	 * country IEs on, this can help disregard country IEs from APs
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 46e4d69db845..7b6529d81c61 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -7,6 +7,7 @@
  * we directly assign the wireless handlers of wireless interfaces.
  *
  * Copyright 2008-2009	Johannes Berg <johannes@sipsolutions.net>
+ * Copyright (C) 2019 Intel Corporation
  */
 
 #include <linux/export.h>
@@ -864,8 +865,8 @@ static int cfg80211_wext_siwtxpower(struct net_device *dev,
 			}
 		}
 	} else {
-		rfkill_set_sw_state(rdev->rfkill, true);
-		schedule_work(&rdev->rfkill_sync);
+		if (rfkill_set_sw_state(rdev->rfkill, true))
+			schedule_work(&rdev->rfkill_block);
 		return 0;
 	}
 
-- 
2.23.0.rc1

