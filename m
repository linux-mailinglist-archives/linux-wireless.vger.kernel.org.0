Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD09359979
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 11:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhDIJkw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 05:40:52 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44264 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232804AbhDIJku (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 05:40:50 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lUncx-000ELR-Do; Fri, 09 Apr 2021 12:40:37 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  9 Apr 2021 12:40:21 +0300
Message-Id: <iwlwifi.20210409123755.2e0ef3e0cf37.I78e0a780ce466a23833cc101143ad45cb1c387e5@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210409094028.356611-1-luca@coelho.fi>
References: <20210409094028.356611-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 08/15] cfg80211: allow to specifying a reason for hw_rfkill
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

rfkill now allows to report a reason for the hw_rfkill state.
Allow cfg80211 drivers to specify this reason.
Keep the current API to use the default reason
(RFKILL_HARD_BLOCK_SIGNAL).

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport-include/net/cfg80211.h | 17 +++++++++++++++++
 include/net/cfg80211.h          | 11 ++++++++++-
 net/wireless/core.c             |  7 ++++---
 3 files changed, 31 insertions(+), 4 deletions(-)
 create mode 100644 backport-include/net/cfg80211.h

diff --git a/backport-include/net/cfg80211.h b/backport-include/net/cfg80211.h
new file mode 100644
index 000000000000..9c55ba7feb4b
--- /dev/null
+++ b/backport-include/net/cfg80211.h
@@ -0,0 +1,17 @@
+#ifndef __BACKPORT_CFG80211_
+#define __BACKPORT_CFG80211_
+
+#if LINUX_VERSION_IS_LESS(5,11,0)
+/* This is really really awkward but we need to include include/linux/rkfill.h
+ * here only for backport purposes. There is content in
+ * backport-include/linux/rfkill.h that should have gone
+ * to uapi/linux/rfkill.h but we couldn't put it there because
+ * include_next gets totally confused and can't include the right
+ * file. So we had to put that content in linux/rfkill.h. In a real
+ * kernel we wouldn't need to include this from cfg80211.h.
+ */
+#include <linux/rfkill.h>
+#endif
+#include_next <net/cfg80211.h>
+
+#endif /* __BACKPORT_CFG80211 */
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 911fae42b0c0..955a4f711fdd 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10,6 +10,7 @@
  * Copyright (C) 2018-2020 Intel Corporation
  */
 
+#include <uapi/linux/rfkill.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
 #include <linux/debugfs.h>
@@ -6636,8 +6637,16 @@ void cfg80211_notify_new_peer_candidate(struct net_device *dev,
  * wiphy_rfkill_set_hw_state - notify cfg80211 about hw block state
  * @wiphy: the wiphy
  * @blocked: block status
+ * @reason: one of reasons in &enum rfkill_hard_block_reasons
  */
-void wiphy_rfkill_set_hw_state(struct wiphy *wiphy, bool blocked);
+void wiphy_rfkill_set_hw_state_reason(struct wiphy *wiphy, bool blocked,
+				      enum rfkill_hard_block_reasons reason);
+
+static inline void wiphy_rfkill_set_hw_state(struct wiphy *wiphy, bool blocked)
+{
+	wiphy_rfkill_set_hw_state_reason(wiphy, blocked,
+					 RFKILL_HARD_BLOCK_SIGNAL);
+}
 
 /**
  * wiphy_rfkill_start_polling - start polling rfkill
diff --git a/net/wireless/core.c b/net/wireless/core.c
index a2785379df6e..adfbcb33fb8f 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1092,14 +1092,15 @@ void wiphy_free(struct wiphy *wiphy)
 }
 EXPORT_SYMBOL(wiphy_free);
 
-void wiphy_rfkill_set_hw_state(struct wiphy *wiphy, bool blocked)
+void wiphy_rfkill_set_hw_state_reason(struct wiphy *wiphy, bool blocked,
+				      enum rfkill_hard_block_reasons reason)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	if (rfkill_set_hw_state(rdev->rfkill, blocked))
+	if (rfkill_set_hw_state_reason(rdev->rfkill, blocked, reason))
 		schedule_work(&rdev->rfkill_block);
 }
-EXPORT_SYMBOL(wiphy_rfkill_set_hw_state);
+EXPORT_SYMBOL(wiphy_rfkill_set_hw_state_reason);
 
 void cfg80211_cqm_config_free(struct wireless_dev *wdev)
 {
-- 
2.31.0

