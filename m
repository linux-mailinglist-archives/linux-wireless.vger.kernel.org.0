Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0D278AF93
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjH1MGN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjH1MFn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26921125
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=FZ4tAJnD2H1Y1X4IBnhBLiLDde+FP8iyBAhW/+FX2zw=;
        t=1693224339; x=1694433939; b=ECaThkDkohrMJDrwIS0jvJIsWG7x4iPEZD4BZxpj5LSSGn3
        NNYJoASlTWl8oDgmwyjAmkR50dowIVeBKTblCTo2FTcwqXYjylXGuajAgoonC3S43SehxLK1Dz+Pa
        Q1fJ5Qfe1v6+M08ncb4PI/wFkuiBbSjnLZ/T2Jnz/koVS37ilAzuFfkGtioksLbNnP4qu+r4Z0G3H
        Wi5qTeFBxndEbIkTho/wMWf3gSEqTvtvfMWEAwWvFB00EPHBNEUTX/1geQPJxGn2GalhMct8zypGw
        /jUr0M3yWdJsxdZjB/NzP8++vUU/88owwNE8WDnBDivEyPT8PYaYb2syhPzfcoFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazx-00Gjgt-0I;
        Mon, 28 Aug 2023 14:05:37 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 21/40] wifi: mac80211: move filter reconfig to wiphy work
Date:   Mon, 28 Aug 2023 13:59:49 +0200
Message-ID: <20230828135928.6a92c30277cb.Ib01783dd15f94741b1bfa910dc5f8d7a6ac6841c@changeid>
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

This again is intended for future cleanups that are
possible when mac80211 and drivers can assume the
wiphy is locked.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 2 +-
 net/mac80211/iface.c       | 2 +-
 net/mac80211/main.c        | 7 ++++---
 net/mac80211/util.c        | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 34f528f7c13e..a5569f9bb83f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1368,7 +1368,7 @@ struct ieee80211_local {
 	spinlock_t filter_lock;
 
 	/* used for uploading changed mc list */
-	struct work_struct reconfig_filter;
+	struct wiphy_work reconfig_filter;
 
 	/* aggregated multicast list */
 	struct netdev_hw_addr_list mc_list;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index fbfb9037b523..82bb340ef4be 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -778,7 +778,7 @@ static void ieee80211_set_multicast_list(struct net_device *dev)
 	spin_lock_bh(&local->filter_lock);
 	__hw_addr_sync(&local->mc_list, &dev->mc, dev->addr_len);
 	spin_unlock_bh(&local->filter_lock);
-	ieee80211_queue_work(&local->hw, &local->reconfig_filter);
+	wiphy_work_queue(local->hw.wiphy, &local->reconfig_filter);
 }
 
 /*
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index a66cfdca42ef..37714dcf9f06 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -84,7 +84,8 @@ void ieee80211_configure_filter(struct ieee80211_local *local)
 	local->filter_flags = new_flags & ~(1<<31);
 }
 
-static void ieee80211_reconfig_filter(struct work_struct *work)
+static void ieee80211_reconfig_filter(struct wiphy *wiphy,
+				      struct wiphy_work *work)
 {
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local, reconfig_filter);
@@ -835,7 +836,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	wiphy_work_init(&local->radar_detected_work,
 			ieee80211_dfs_radar_detected_work);
 
-	INIT_WORK(&local->reconfig_filter, ieee80211_reconfig_filter);
+	wiphy_work_init(&local->reconfig_filter, ieee80211_reconfig_filter);
 	local->smps_mode = IEEE80211_SMPS_OFF;
 
 	wiphy_work_init(&local->dynamic_ps_enable_work,
@@ -1503,13 +1504,13 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 
 	wiphy_lock(local->hw.wiphy);
 	wiphy_delayed_work_cancel(local->hw.wiphy, &local->roc_work);
+	wiphy_work_cancel(local->hw.wiphy, &local->reconfig_filter);
 	wiphy_work_cancel(local->hw.wiphy, &local->sched_scan_stopped_work);
 	wiphy_work_cancel(local->hw.wiphy, &local->radar_detected_work);
 	wiphy_unlock(local->hw.wiphy);
 	rtnl_unlock();
 
 	cancel_work_sync(&local->restart_work);
-	cancel_work_sync(&local->reconfig_filter);
 
 	ieee80211_clear_tx_pending(local);
 	rate_control_deinitialize(local);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 2815f54c5aa1..bb4c7dd03758 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2316,7 +2316,7 @@ void ieee80211_stop_device(struct ieee80211_local *local)
 	ieee80211_led_radio(local, false);
 	ieee80211_mod_tpt_led_trig(local, 0, IEEE80211_TPT_LEDTRIG_FL_RADIO);
 
-	cancel_work_sync(&local->reconfig_filter);
+	wiphy_work_cancel(local->hw.wiphy, &local->reconfig_filter);
 
 	flush_workqueue(local->workqueue);
 	wiphy_work_flush(local->hw.wiphy, NULL);
-- 
2.41.0

