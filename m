Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7C93AA550
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jun 2021 22:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhFPUan (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Jun 2021 16:30:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:3816 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233470AbhFPUam (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Jun 2021 16:30:42 -0400
IronPort-SDR: qS/SHAbDpf+w8HbNO4USH7nbkVncPhlDoiJU35fF9AiTMNE+3629apNH7I+Skgfkx962bOzerX
 mTYw1j94N24Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="206209971"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="206209971"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 13:28:34 -0700
IronPort-SDR: Y2/OuSN21XHf7kaS9WlFR1K4rEEhtwiBb/TPTXHrGn78PoIz5kNL1AHx8Jqp70w+TRe1whiMtk
 17Gp85G2GS0w==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="450755948"
Received: from lmakrabi-mobl.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.251.175.194])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 13:28:33 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] cfg80211: expose the rfkill device to the low level driver
Date:   Wed, 16 Jun 2021 23:28:26 +0300
Message-Id: <20210616202826.9833-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609161520.109824-1-emmanuel.grumbach@intel.com>
References: <20210609161520.109824-1-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This will allow the low level driver to query the rfkill
state.

v2: Fix the compilation issue
Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 include/net/cfg80211.h     |  9 ++++++++-
 net/wireless/core.c        | 34 +++++++++++++---------------------
 net/wireless/core.h        |  3 +--
 net/wireless/nl80211.c     |  4 ++--
 net/wireless/wext-compat.c |  6 +++---
 5 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5224f885a99a..31ad04c78fb6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -22,6 +22,7 @@
 #include <linux/if_ether.h>
 #include <linux/ieee80211.h>
 #include <linux/net.h>
+#include <linux/rfkill.h>
 #include <net/regulatory.h>
 
 /**
@@ -4945,6 +4946,7 @@ struct wiphy_iftype_akm_suites {
  *	configuration through the %NL80211_TID_CONFIG_ATTR_RETRY_SHORT and
  *	%NL80211_TID_CONFIG_ATTR_RETRY_LONG attributes
  * @sar_capa: SAR control capabilities
+ * @rfkill: a pointer to the rfkill structure
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5087,6 +5089,8 @@ struct wiphy {
 
 	const struct cfg80211_sar_capa *sar_capa;
 
+	struct rfkill *rfkill;
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
@@ -6661,7 +6665,10 @@ void wiphy_rfkill_start_polling(struct wiphy *wiphy);
  * wiphy_rfkill_stop_polling - stop polling rfkill
  * @wiphy: the wiphy
  */
-void wiphy_rfkill_stop_polling(struct wiphy *wiphy);
+static inline void wiphy_rfkill_stop_polling(struct wiphy *wiphy)
+{
+	rfkill_pause_polling(wiphy->rfkill);
+}
 
 /**
  * DOC: Vendor commands
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 6fbf7537faf5..bd1edec19cfa 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -532,11 +532,11 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 	wiphy_net_set(&rdev->wiphy, &init_net);
 
 	rdev->rfkill_ops.set_block = cfg80211_rfkill_set_block;
-	rdev->rfkill = rfkill_alloc(dev_name(&rdev->wiphy.dev),
-				   &rdev->wiphy.dev, RFKILL_TYPE_WLAN,
-				   &rdev->rfkill_ops, rdev);
+	rdev->wiphy.rfkill = rfkill_alloc(dev_name(&rdev->wiphy.dev),
+					  &rdev->wiphy.dev, RFKILL_TYPE_WLAN,
+					  &rdev->rfkill_ops, rdev);
 
-	if (!rdev->rfkill) {
+	if (!rdev->wiphy.rfkill) {
 		wiphy_free(&rdev->wiphy);
 		return NULL;
 	}
@@ -993,10 +993,10 @@ int wiphy_register(struct wiphy *wiphy)
 	rdev->wiphy.registered = true;
 	rtnl_unlock();
 
-	res = rfkill_register(rdev->rfkill);
+	res = rfkill_register(rdev->wiphy.rfkill);
 	if (res) {
-		rfkill_destroy(rdev->rfkill);
-		rdev->rfkill = NULL;
+		rfkill_destroy(rdev->wiphy.rfkill);
+		rdev->wiphy.rfkill = NULL;
 		wiphy_unregister(&rdev->wiphy);
 		return res;
 	}
@@ -1012,18 +1012,10 @@ void wiphy_rfkill_start_polling(struct wiphy *wiphy)
 	if (!rdev->ops->rfkill_poll)
 		return;
 	rdev->rfkill_ops.poll = cfg80211_rfkill_poll;
-	rfkill_resume_polling(rdev->rfkill);
+	rfkill_resume_polling(wiphy->rfkill);
 }
 EXPORT_SYMBOL(wiphy_rfkill_start_polling);
 
-void wiphy_rfkill_stop_polling(struct wiphy *wiphy)
-{
-	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
-
-	rfkill_pause_polling(rdev->rfkill);
-}
-EXPORT_SYMBOL(wiphy_rfkill_stop_polling);
-
 void wiphy_unregister(struct wiphy *wiphy)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
@@ -1035,8 +1027,8 @@ void wiphy_unregister(struct wiphy *wiphy)
 		wiphy_unlock(&rdev->wiphy);
 		__count == 0; }));
 
-	if (rdev->rfkill)
-		rfkill_unregister(rdev->rfkill);
+	if (rdev->wiphy.rfkill)
+		rfkill_unregister(rdev->wiphy.rfkill);
 
 	rtnl_lock();
 	wiphy_lock(&rdev->wiphy);
@@ -1088,7 +1080,7 @@ void cfg80211_dev_free(struct cfg80211_registered_device *rdev)
 {
 	struct cfg80211_internal_bss *scan, *tmp;
 	struct cfg80211_beacon_registration *reg, *treg;
-	rfkill_destroy(rdev->rfkill);
+	rfkill_destroy(rdev->wiphy.rfkill);
 	list_for_each_entry_safe(reg, treg, &rdev->beacon_registrations, list) {
 		list_del(&reg->list);
 		kfree(reg);
@@ -1110,7 +1102,7 @@ void wiphy_rfkill_set_hw_state_reason(struct wiphy *wiphy, bool blocked,
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	if (rfkill_set_hw_state_reason(rdev->rfkill, blocked, reason))
+	if (rfkill_set_hw_state_reason(wiphy->rfkill, blocked, reason))
 		schedule_work(&rdev->rfkill_block);
 }
 EXPORT_SYMBOL(wiphy_rfkill_set_hw_state_reason);
@@ -1506,7 +1498,7 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 					     wdev->use_4addr, 0))
 			return notifier_from_errno(-EOPNOTSUPP);
 
-		if (rfkill_blocked(rdev->rfkill))
+		if (rfkill_blocked(rdev->wiphy.rfkill))
 			return notifier_from_errno(-ERFKILL);
 		break;
 	default:
diff --git a/net/wireless/core.h b/net/wireless/core.h
index a7d19b4b40ac..b35d0db12f1d 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -3,7 +3,7 @@
  * Wireless configuration interface internals.
  *
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 #ifndef __NET_WIRELESS_CORE_H
 #define __NET_WIRELESS_CORE_H
@@ -27,7 +27,6 @@ struct cfg80211_registered_device {
 
 	/* rfkill support */
 	struct rfkill_ops rfkill_ops;
-	struct rfkill *rfkill;
 	struct work_struct rfkill_block;
 
 	/* ISO / IEC 3166 alpha2 for which this device is receiving
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fc9286afe3c9..e006d26d5c2a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13042,7 +13042,7 @@ static int nl80211_start_p2p_device(struct sk_buff *skb, struct genl_info *info)
 	if (wdev_running(wdev))
 		return 0;
 
-	if (rfkill_blocked(rdev->rfkill))
+	if (rfkill_blocked(rdev->wiphy.rfkill))
 		return -ERFKILL;
 
 	err = rdev_start_p2p_device(rdev, wdev);
@@ -13084,7 +13084,7 @@ static int nl80211_start_nan(struct sk_buff *skb, struct genl_info *info)
 	if (wdev_running(wdev))
 		return -EEXIST;
 
-	if (rfkill_blocked(rdev->rfkill))
+	if (rfkill_blocked(rdev->wiphy.rfkill))
 		return -ERFKILL;
 
 	if (!info->attrs[NL80211_ATTR_NAN_MASTER_PREF])
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index a8320dc59af7..35c6c705a073 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -902,7 +902,7 @@ static int cfg80211_wext_siwtxpower(struct net_device *dev,
 
 	/* only change when not disabling */
 	if (!data->txpower.disabled) {
-		rfkill_set_sw_state(rdev->rfkill, false);
+		rfkill_set_sw_state(rdev->wiphy.rfkill, false);
 
 		if (data->txpower.fixed) {
 			/*
@@ -927,7 +927,7 @@ static int cfg80211_wext_siwtxpower(struct net_device *dev,
 			}
 		}
 	} else {
-		if (rfkill_set_sw_state(rdev->rfkill, true))
+		if (rfkill_set_sw_state(rdev->wiphy.rfkill, true))
 			schedule_work(&rdev->rfkill_block);
 		return 0;
 	}
@@ -963,7 +963,7 @@ static int cfg80211_wext_giwtxpower(struct net_device *dev,
 
 	/* well... oh well */
 	data->txpower.fixed = 1;
-	data->txpower.disabled = rfkill_blocked(rdev->rfkill);
+	data->txpower.disabled = rfkill_blocked(rdev->wiphy.rfkill);
 	data->txpower.value = val;
 	data->txpower.flags = IW_TXPOW_DBM;
 

base-commit: 77091933e453a258bbe9ff2aeb1c8d6fc1db7ef9
-- 
2.25.1

