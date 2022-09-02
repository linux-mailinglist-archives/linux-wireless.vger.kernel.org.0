Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C55AB43C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbiIBOvu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236601AbiIBOvH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31461844C5
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JoRpIaSn/yg/bA5m9ebBTAxMk8IJhCEFeuk66bpZOtA=;
        t=1662127992; x=1663337592; b=StW75uXcB/Naef5kAkbSdzAtM4yCDruHbFmPVQvVYq2nMnX
        q90X0v49j9pHpfEAoOnzRzJYjHfnRTri/OG49twr8WLmFwmu+yLy9Hz965SZGXGfnTOTQk3lHzQRX
        ZpO0CvjMoZIpb2z+dzeab6hPJCun/VH0eSABF4Uoi8pOo1hBaa0fGmnLGZkaClcIMJ+RIYfG1bxva
        dWg10eBF5e6gZeQLXAzlYVUFHcgHV7ZOeiT6burW994+s0HHx51wZKcxTrfD2w2yHD9Mw/fkpJqF2
        TCNcT5mhCDzudHA99REXErjG5Kn0DbB6UQZAnORGNfsv+BApGR9rtWp38id+0Qcw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Py-006Ch3-1l;
        Fri, 02 Sep 2022 16:13:10 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 20/27] wifi: mac80211: add vif/sta link RCU dereference macros
Date:   Fri,  2 Sep 2022 16:12:52 +0200
Message-Id: <20220902161143.310be75ff36d.Iefc3fac151a2f5df338b68ed73d03559a8373b55@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add macros (and an exported function) to allow checking some
link RCU protected accesses that are happening in callbacks
from mac80211 and are thus under the correct lock.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c |  3 +--
 include/net/mac80211.h                | 31 ++++++++++++++++++++++++---
 net/mac80211/sta_info.c               | 10 +++++++++
 3 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index f464d3507fe9..f044db1621dd 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3069,8 +3069,7 @@ static int mac80211_hwsim_change_vif_links(struct ieee80211_hw *hw,
 	for_each_set_bit(i, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_bss_conf *link_conf;
 
-		/* FIXME: figure out how to get the locking here */
-		link_conf = rcu_dereference_protected(vif->link_conf[i], 1);
+		link_conf = link_conf_dereference_protected(vif, i);
 		if (WARN_ON(!link_conf))
 			continue;
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index bfa6a1625c5c..d9e7f62cc972 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -18,6 +18,7 @@
 #include <linux/if_ether.h>
 #include <linux/skbuff.h>
 #include <linux/ieee80211.h>
+#include <linux/lockdep.h>
 #include <net/cfg80211.h>
 #include <net/codel.h>
 #include <net/ieee80211_radiotap.h>
@@ -1901,6 +1902,19 @@ struct ieee80211_vif *wdev_to_ieee80211_vif(struct wireless_dev *wdev);
  */
 struct wireless_dev *ieee80211_vif_to_wdev(struct ieee80211_vif *vif);
 
+/**
+ * lockdep_vif_mutex_held - for lockdep checks on link poiners
+ * @vif: the interface to check
+ */
+static inline bool lockdep_vif_mutex_held(struct ieee80211_vif *vif)
+{
+	return lockdep_is_held(&ieee80211_vif_to_wdev(vif)->mtx);
+}
+
+#define link_conf_dereference_protected(vif, link_id)		\
+	rcu_dereference_protected((vif)->link_conf[link_id],	\
+				  lockdep_vif_mutex_held(vif))
+
 /**
  * enum ieee80211_key_flags - key flags
  *
@@ -2266,13 +2280,24 @@ struct ieee80211_sta {
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
 
-/* FIXME: check the locking correctly */
+#ifdef CONFIG_LOCKDEP
+bool lockdep_sta_mutex_held(struct ieee80211_sta *pubsta);
+#else
+static inline bool lockdep_sta_mutex_held(struct ieee80211_sta *pubsta)
+{
+	return true;
+}
+#endif
+
+#define link_sta_dereference_protected(sta, link_id)		\
+	rcu_dereference_protected((sta)->link[link_id],		\
+				  lockdep_sta_mutex_held(sta))
+
 #define for_each_sta_active_link(vif, sta, link_sta, link_id)			\
 	for (link_id = 0; link_id < ARRAY_SIZE((sta)->link); link_id++)		\
 		if ((!(vif)->active_links ||					\
 		     (vif)->active_links & BIT(link_id)) &&			\
-		    ((link_sta) = rcu_dereference_protected((sta)->link[link_id],\
-							    1)))
+		    ((link_sta) = link_sta_dereference_protected(sta, link_id)))
 
 /**
  * enum sta_notify_cmd - sta notify command
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 1749c21e735c..baa55fbab0a2 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2871,3 +2871,13 @@ void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
 	if (val)
 		sta->sta.max_amsdu_subframes = 4 << val;
 }
+
+#ifdef CONFIG_LOCKDEP
+bool lockdep_sta_mutex_held(struct ieee80211_sta *pubsta)
+{
+	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
+
+	return lockdep_is_held(&sta->local->sta_mtx);
+}
+EXPORT_SYMBOL(lockdep_sta_mutex_held);
+#endif
-- 
2.37.2

