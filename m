Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDD678AF8B
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjH1MFv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjH1MF3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F2B120
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=w+XNb81DiAN12RVdISgKpMoRkzK267oH6qwjeytfmCg=;
        t=1693224327; x=1694433927; b=qbsyISx1l+82tUDWgQiKz7lEiJR1vYBtzoaJpkTT/NkmbPy
        tESwXDFxH4l1Tfnvcok1zrmYbeRvnIj7TC6G59BNNFV7WsiIvu8iYfE32DOIkw7tF2Xnc4U2RGk1W
        GQMzWay6oaFvvwFdRYrr+FgQ8I0L5I3nz2zfLQ1gOcb22mnr6HwIAk2STjm6qrQhZE7w0tPFAapva
        uqf5TOOem1+IeLlZSwRMkVAOSI5OERp868v2qOXuXVLG+h/HTWxpKL2RbDj/0R0M+fo4ypdr4By+m
        SR4WZIEx7EEDh1EGmYM6jlF1MzQ/Il0EZ3Z1d8dt51JtHxPhHbut9f2d2iDk1+4A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazk-00Gjgt-2U;
        Mon, 28 Aug 2023 14:05:25 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 10/40] wifi: mac80211: move radar detect work to wiphy work
Date:   Mon, 28 Aug 2023 13:59:38 +0200
Message-ID: <20230828135927.53c18aed9362.Iaf5b08d047d2e291a5dd02d2408b7fcac4c64963@changeid>
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

Move the radar detect work to wiphy work in order
to lock the wiphy for it without doing it manually.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 5 +++--
 net/mac80211/main.c        | 9 +++++----
 net/mac80211/util.c        | 7 +++----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 0d9aff6a4fc8..9be569ade9f7 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1412,7 +1412,7 @@ struct ieee80211_local {
 	/* wowlan is enabled -- don't reconfig on resume */
 	bool wowlan;
 
-	struct work_struct radar_detected_work;
+	struct wiphy_work radar_detected_work;
 
 	/* number of RX chains the hardware has */
 	u8 rx_chains;
@@ -2571,7 +2571,8 @@ bool ieee80211_is_radar_required(struct ieee80211_local *local);
 
 void ieee80211_dfs_cac_timer_work(struct wiphy *wiphy, struct wiphy_work *work);
 void ieee80211_dfs_cac_cancel(struct ieee80211_local *local);
-void ieee80211_dfs_radar_detected_work(struct work_struct *work);
+void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
+				       struct wiphy_work *work);
 int ieee80211_send_action_csa(struct ieee80211_sub_if_data *sdata,
 			      struct cfg80211_csa_settings *csa_settings);
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index aeb21cfe789a..b3c3b031b5b8 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -338,7 +338,6 @@ static void ieee80211_restart_work(struct work_struct *work)
 	/* wait for scan work complete */
 	flush_workqueue(local->workqueue);
 	flush_work(&local->sched_scan_stopped_work);
-	flush_work(&local->radar_detected_work);
 
 	rtnl_lock();
 	/* we might do interface manipulations, so need both */
@@ -814,8 +813,8 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 
 	INIT_WORK(&local->restart_work, ieee80211_restart_work);
 
-	INIT_WORK(&local->radar_detected_work,
-		  ieee80211_dfs_radar_detected_work);
+	wiphy_work_init(&local->radar_detected_work,
+			ieee80211_dfs_radar_detected_work);
 
 	INIT_WORK(&local->reconfig_filter, ieee80211_reconfig_filter);
 	local->smps_mode = IEEE80211_SMPS_OFF;
@@ -1483,13 +1482,15 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 	 */
 	ieee80211_remove_interfaces(local);
 
+	wiphy_lock(local->hw.wiphy);
+	wiphy_work_cancel(local->hw.wiphy, &local->radar_detected_work);
+	wiphy_unlock(local->hw.wiphy);
 	rtnl_unlock();
 
 	cancel_delayed_work_sync(&local->roc_work);
 	cancel_work_sync(&local->restart_work);
 	cancel_work_sync(&local->reconfig_filter);
 	flush_work(&local->sched_scan_stopped_work);
-	flush_work(&local->radar_detected_work);
 
 	ieee80211_clear_tx_pending(local);
 	rate_control_deinitialize(local);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index ff99aee46656..701f5b4eadae 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4358,7 +4358,8 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 	mutex_unlock(&local->mtx);
 }
 
-void ieee80211_dfs_radar_detected_work(struct work_struct *work)
+void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
+				       struct wiphy_work *work)
 {
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local, radar_detected_work);
@@ -4376,9 +4377,7 @@ void ieee80211_dfs_radar_detected_work(struct work_struct *work)
 	}
 	mutex_unlock(&local->chanctx_mtx);
 
-	wiphy_lock(local->hw.wiphy);
 	ieee80211_dfs_cac_cancel(local);
-	wiphy_unlock(local->hw.wiphy);
 
 	if (num_chanctx > 1)
 		/* XXX: multi-channel is not supported yet */
@@ -4393,7 +4392,7 @@ void ieee80211_radar_detected(struct ieee80211_hw *hw)
 
 	trace_api_radar_detected(local);
 
-	schedule_work(&local->radar_detected_work);
+	wiphy_work_queue(hw->wiphy, &local->radar_detected_work);
 }
 EXPORT_SYMBOL(ieee80211_radar_detected);
 
-- 
2.41.0

