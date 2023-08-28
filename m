Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B93A78AF7C
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjH1MFj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjH1MFg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DC0120
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1a3R36xlJ3XANjnW21yoXtLY2Lw9KZZg1OGu+wdZVDg=;
        t=1693224334; x=1694433934; b=yP/AfgTBdwAvYjNQdq5sGwIEnmqS+4ouV24xDPrpUhQgMQ/
        MIMrLqbBcEclEHqAne2uaJHAkmH1JC27bPDOzffp4yozOU0k5YulOJUY6IFT+JiScms/e7SVXe5Cs
        nOr9qHT3QpXzUxVDBTnfB7CMAM2jggCuxixdjqXS9WImHrpE4VevlqdFxJ+C9G2C/hGY4puEsEs2I
        7nSnmAifOGmRThVoSMLqycqr9QgJz2p2yFhwiLHkHIi2At86E84UDKsgVJ4P6Cp+hJ+oNRgjVO0du
        r9FY6YaAwn3DS1158axGFxL8DyyP8bboXwiA9n0cfZ6Gjd27aq9EiEpx0yAqWKFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazr-00Gjgt-1m;
        Mon, 28 Aug 2023 14:05:31 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 16/40] wifi: mac80211: move dynamic PS to wiphy work
Date:   Mon, 28 Aug 2023 13:59:44 +0200
Message-ID: <20230828135927.8cad8af687ae.I91fa4ec3674713209ae2ebd021bf735acd2d4a19@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Along with everything else, move the dynamic PS work
to be a wiphy work, to simplify locking later.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 10 ++++++----
 net/mac80211/iface.c       |  2 +-
 net/mac80211/main.c        |  8 ++++----
 net/mac80211/mlme.c        | 13 ++++++++-----
 net/mac80211/offchannel.c  |  2 +-
 net/mac80211/pm.c          |  4 ++--
 net/mac80211/tx.c          |  4 ++--
 7 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3db1accb0903..96cecc3d71f0 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1560,8 +1560,8 @@ struct ieee80211_local {
 	 * interface (and monitors) in PS, this then points there.
 	 */
 	struct ieee80211_sub_if_data *ps_sdata;
-	struct work_struct dynamic_ps_enable_work;
-	struct work_struct dynamic_ps_disable_work;
+	struct wiphy_work dynamic_ps_enable_work;
+	struct wiphy_work dynamic_ps_disable_work;
 	struct timer_list dynamic_ps_timer;
 	struct notifier_block ifa_notifier;
 	struct notifier_block ifa6_notifier;
@@ -2348,8 +2348,10 @@ static inline int ieee80211_ac_from_tid(int tid)
 	return ieee802_1d_to_ac[tid & 7];
 }
 
-void ieee80211_dynamic_ps_enable_work(struct work_struct *work);
-void ieee80211_dynamic_ps_disable_work(struct work_struct *work);
+void ieee80211_dynamic_ps_enable_work(struct wiphy *wiphy,
+				      struct wiphy_work *work);
+void ieee80211_dynamic_ps_disable_work(struct wiphy *wiphy,
+				       struct wiphy_work *work);
 void ieee80211_dynamic_ps_timer(struct timer_list *t);
 void ieee80211_send_nullfunc(struct ieee80211_local *local,
 			     struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index fa4514642d74..6dc6cdc1cd37 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -516,7 +516,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	}
 
 	del_timer_sync(&local->dynamic_ps_timer);
-	cancel_work_sync(&local->dynamic_ps_enable_work);
+	wiphy_work_cancel(local->hw.wiphy, &local->dynamic_ps_enable_work);
 
 	sdata_lock(sdata);
 	WARN(ieee80211_vif_is_mld(&sdata->vif),
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index e686b0cc2cd8..7c165e78115c 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -837,10 +837,10 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	INIT_WORK(&local->reconfig_filter, ieee80211_reconfig_filter);
 	local->smps_mode = IEEE80211_SMPS_OFF;
 
-	INIT_WORK(&local->dynamic_ps_enable_work,
-		  ieee80211_dynamic_ps_enable_work);
-	INIT_WORK(&local->dynamic_ps_disable_work,
-		  ieee80211_dynamic_ps_disable_work);
+	wiphy_work_init(&local->dynamic_ps_enable_work,
+			ieee80211_dynamic_ps_enable_work);
+	wiphy_work_init(&local->dynamic_ps_disable_work,
+			ieee80211_dynamic_ps_disable_work);
 	timer_setup(&local->dynamic_ps_timer, ieee80211_dynamic_ps_timer, 0);
 
 	INIT_WORK(&local->sched_scan_stopped_work,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ab0be5c30860..f36279e8792e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2211,7 +2211,8 @@ static void ieee80211_change_ps(struct ieee80211_local *local)
 		conf->flags &= ~IEEE80211_CONF_PS;
 		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
 		del_timer_sync(&local->dynamic_ps_timer);
-		cancel_work_sync(&local->dynamic_ps_enable_work);
+		wiphy_work_cancel(local->hw.wiphy,
+				  &local->dynamic_ps_enable_work);
 	}
 }
 
@@ -2308,7 +2309,8 @@ void ieee80211_recalc_ps_vif(struct ieee80211_sub_if_data *sdata)
 	}
 }
 
-void ieee80211_dynamic_ps_disable_work(struct work_struct *work)
+void ieee80211_dynamic_ps_disable_work(struct wiphy *wiphy,
+				       struct wiphy_work *work)
 {
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local,
@@ -2325,7 +2327,8 @@ void ieee80211_dynamic_ps_disable_work(struct work_struct *work)
 					false);
 }
 
-void ieee80211_dynamic_ps_enable_work(struct work_struct *work)
+void ieee80211_dynamic_ps_enable_work(struct wiphy *wiphy,
+				      struct wiphy_work *work)
 {
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local,
@@ -2398,7 +2401,7 @@ void ieee80211_dynamic_ps_timer(struct timer_list *t)
 {
 	struct ieee80211_local *local = from_timer(local, t, dynamic_ps_timer);
 
-	ieee80211_queue_work(&local->hw, &local->dynamic_ps_enable_work);
+	wiphy_work_queue(local->hw.wiphy, &local->dynamic_ps_enable_work);
 }
 
 void ieee80211_dfs_cac_timer_work(struct wiphy *wiphy, struct wiphy_work *work)
@@ -3002,7 +3005,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	sdata->deflink.ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
 
 	del_timer_sync(&local->dynamic_ps_timer);
-	cancel_work_sync(&local->dynamic_ps_enable_work);
+	wiphy_work_cancel(local->hw.wiphy, &local->dynamic_ps_enable_work);
 
 	/* Disable ARP filtering */
 	if (sdata->vif.cfg.arp_addr_cnt)
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 5bedd9cef414..df68d9838f87 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -34,7 +34,7 @@ static void ieee80211_offchannel_ps_enable(struct ieee80211_sub_if_data *sdata)
 	del_timer_sync(&ifmgd->bcn_mon_timer);
 	del_timer_sync(&ifmgd->conn_mon_timer);
 
-	cancel_work_sync(&local->dynamic_ps_enable_work);
+	wiphy_work_cancel(local->hw.wiphy, &local->dynamic_ps_enable_work);
 
 	if (local->hw.conf.flags & IEEE80211_CONF_PS) {
 		offchannel_ps_enabled = true;
diff --git a/net/mac80211/pm.c b/net/mac80211/pm.c
index 0ccb5701c7f3..10eb72b9b994 100644
--- a/net/mac80211/pm.c
+++ b/net/mac80211/pm.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Portions
- * Copyright (C) 2020-2021 Intel Corporation
+ * Copyright (C) 2020-2021, 2023 Intel Corporation
  */
 #include <net/mac80211.h>
 #include <net/rtnetlink.h>
@@ -76,7 +76,7 @@ int __ieee80211_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 	 * Note that this particular timer doesn't need to be
 	 * restarted at resume.
 	 */
-	cancel_work_sync(&local->dynamic_ps_enable_work);
+	wiphy_work_cancel(local->hw.wiphy, &local->dynamic_ps_enable_work);
 	del_timer_sync(&local->dynamic_ps_timer);
 
 	local->wowlan = wowlan;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index ae33f727c6a8..5cff936c6211 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -266,8 +266,8 @@ ieee80211_tx_h_dynamic_ps(struct ieee80211_tx_data *tx)
 						IEEE80211_QUEUE_STOP_REASON_PS,
 						false);
 		ifmgd->flags &= ~IEEE80211_STA_NULLFUNC_ACKED;
-		ieee80211_queue_work(&local->hw,
-				     &local->dynamic_ps_disable_work);
+		wiphy_work_queue(local->hw.wiphy,
+				 &local->dynamic_ps_disable_work);
 	}
 
 	/* Don't restart the timer if we're not disassociated */
-- 
2.41.0

