Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2A72C795A
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Nov 2020 14:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgK2NPi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Nov 2020 08:15:38 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33424 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727892AbgK2NPf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Nov 2020 08:15:35 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kjMXQ-0035gF-10; Sun, 29 Nov 2020 15:14:48 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Nov 2020 15:14:35 +0200
Message-Id: <iwlwifi.20201129151117.70e3f540af9a.Idb157cfb560397421c184cbf54450d90f03bf7ec@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129131442.1857561-1-luca@coelho.fi>
References: <20201129131442.1857561-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/12] cfg80211: flush scan entries upon suspend
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
 include/net/cfg80211.h | 6 ++++++
 net/wireless/sysfs.c   | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 661edfc8722e..67335a6a1816 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8026,4 +8026,10 @@ void cfg80211_update_owe_info_event(struct net_device *netdev,
  */
 void cfg80211_bss_flush(struct wiphy *wiphy);
 
+/**
+ * cfg80211_bss_flush - resets all the scan entries
+ * @wiphy: the wiphy
+ */
+void cfg80211_bss_flush(struct wiphy *wiphy);
+
 #endif /* __NET_CFG80211_H */
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
2.29.2

