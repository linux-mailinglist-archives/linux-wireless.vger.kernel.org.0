Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81823205A4F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 20:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733059AbgFWSKe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 14:10:34 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:38060 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728916AbgFWSKe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 14:10:34 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jnnNP-001DUk-8a; Tue, 23 Jun 2020 21:10:31 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 23 Jun 2020 21:10:29 +0300
Message-Id: <iwlwifi.20200623211013.df306f28bb0f.Ib56a98fa55090cc2d9952463f2c292a0a101f3cb@changeid>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH] cfg80211: flush scan entries upon suspend
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When we suspend, we can't really remember our BSS table.
Purge all the data.
Export this function to allow driver to purge the BSS table
in case they feel the need to.
iwlwifi will need to do that.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/cfg80211.h |  6 ++++++
 net/wireless/scan.c    | 10 ++++++++++
 net/wireless/sysfs.c   |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fc7e8807838d..03a72b5b1986 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7882,4 +7882,10 @@ void cfg80211_update_owe_info_event(struct net_device *netdev,
 				    struct cfg80211_update_owe_info *owe_info,
 				    gfp_t gfp);
 
+/**
+ * cfg80211_bss_flush - resets all the scan entries
+ * @wiphy: the wiphy
+ */
+void cfg80211_bss_flush(struct wiphy *wiphy);
+
 #endif /* __NET_CFG80211_H */
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 74ea4cfb39fb..e67a74488bbe 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -712,6 +712,16 @@ void cfg80211_bss_expire(struct cfg80211_registered_device *rdev)
 	__cfg80211_bss_expire(rdev, jiffies - IEEE80211_SCAN_RESULT_EXPIRE);
 }
 
+void cfg80211_bss_flush(struct wiphy *wiphy)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+
+	spin_lock_bh(&rdev->bss_lock);
+	__cfg80211_bss_expire(rdev, jiffies);
+	spin_unlock_bh(&rdev->bss_lock);
+}
+EXPORT_SYMBOL(cfg80211_bss_flush);
+
 const struct element *
 cfg80211_find_elem_match(u8 eid, const u8 *ies, unsigned int len,
 			 const u8 *match, unsigned int match_len,
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 3ac1f48195d2..b670f0d78621 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -5,6 +5,7 @@
  *
  * Copyright 2005-2006	Jiri Benc <jbenc@suse.cz>
  * Copyright 2006	Johannes Berg <johannes@sipsolutions.net>
+ * Copyright (C) 2020 Intel Corporation
  */
 
 #include <linux/device.h>
@@ -107,6 +108,7 @@ static int wiphy_suspend(struct device *dev)
 	if (rdev->wiphy.registered) {
 		if (!rdev->wiphy.wowlan_config) {
 			cfg80211_leave_all(rdev);
+			cfg80211_bss_flush(&rdev->wiphy);
 			cfg80211_process_rdev_events(rdev);
 		}
 		if (rdev->ops->suspend)
-- 
2.27.0

