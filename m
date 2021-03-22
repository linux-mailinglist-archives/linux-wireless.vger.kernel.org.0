Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B434345104
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Mar 2021 21:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhCVUmp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Mar 2021 16:42:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:48250 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhCVUmS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Mar 2021 16:42:18 -0400
IronPort-SDR: Jynww8iY1PgXQtYYA3fn25Am6P5AnYKwM/hRwvAFQ062Cax3IB5ADEP/izbnSYBR0YO5bLg3Ru
 yM6Rii4ezgng==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="169675994"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="169675994"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 13:42:18 -0700
IronPort-SDR: PquUHswOgf/KfYTO5UYYGWpfWGpjX+Wglwu1JEYz+pAahDy9FpTv4K9cNBjYl4oBvSuOHOS2B8
 ZkuNRnM6iKPA==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="407978357"
Received: from isutskov-mobl.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.251.189.99])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 13:42:16 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     kvalo@codeaurora.org
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        luca@coelho.fi, Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 3/5] cfg80211: allow to specifying a reason for hw_rfkill
Date:   Mon, 22 Mar 2021 22:41:53 +0200
Message-Id: <20210322204157.102078-4-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322204157.102078-1-emmanuel.grumbach@intel.com>
References: <20210322204157.102078-1-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

rfkill now allows to report a reason for the hw_rfkill state.
Allow cfg80211 drivers to specify this reason.
Keep the current API to use the default reason
(RFKILL_HARD_BLOCK_SIGNAL).

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 include/net/cfg80211.h | 11 ++++++++++-
 net/wireless/core.c    |  7 ++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 911fae42b0c0..3b296f2b7a2c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -11,6 +11,7 @@
  */
 
 #include <linux/ethtool.h>
+#include <uapi/linux/rfkill.h>
 #include <linux/netdevice.h>
 #include <linux/debugfs.h>
 #include <linux/list.h>
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
2.25.1

