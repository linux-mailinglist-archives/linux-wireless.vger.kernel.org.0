Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFA878AF8E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjH1MGL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjH1MFi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB4411A
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=9inldNy1ecVHZ5EYMyZ3SoZGWN7OzyTJlovrUpQ3n4M=;
        t=1693224335; x=1694433935; b=HFMhdR9Gehd2ELgGaSwuHzuZKwqmmNtTS8qKzoXk/E0XnWR
        SQjxNRZYYmUkpL194x8v43ch9/eWAUdXdxoZ8bFHcphjhp8DeKSk8DiuJn/tPCCYowQaajaDogsMH
        nA4EbcXNu9pgnrOuHym/M0so+Zq+/DK+wWSgs2iuVQyUR3gUJGJn/Ox9ptYhatXB9b/6ZoikT+/Qo
        8HrbDV3e1sFUIVZv+2FcVAW90PQpNCGeJtSyNdHacWRClGXWsFNIiJTzknYay+9wzELgEFZovyMt2
        +bTRz0aw9L8gm5jsnfdTe0BDcCbrm1kJ9q0a3+lzBm8H7b1ncKUsR1NlDkUG78oA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazs-00Gjgt-2G;
        Mon, 28 Aug 2023 14:05:33 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 17/40] wifi: mac80211: move sched-scan stop work to wiphy work
Date:   Mon, 28 Aug 2023 13:59:45 +0200
Message-ID: <20230828135927.b62e6a348fc7.Ic902f5a0fad8e16508773688d1181306c80ac228@changeid>
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

This also has the wiphy locked here then. We need to use
the _locked version of cfg80211_sched_scan_stopped() now,
which also fixes an old deadlock there.

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 5 +++--
 net/mac80211/main.c        | 6 +++---
 net/mac80211/scan.c        | 7 ++++---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 96cecc3d71f0..47040a3a103b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1489,7 +1489,7 @@ struct ieee80211_local {
 	int hw_scan_ies_bufsize;
 	struct cfg80211_scan_info scan_info;
 
-	struct work_struct sched_scan_stopped_work;
+	struct wiphy_work sched_scan_stopped_work;
 	struct ieee80211_sub_if_data __rcu *sched_scan_sdata;
 	struct cfg80211_sched_scan_request __rcu *sched_scan_req;
 	u8 scan_addr[ETH_ALEN];
@@ -1968,7 +1968,8 @@ int ieee80211_request_sched_scan_start(struct ieee80211_sub_if_data *sdata,
 				       struct cfg80211_sched_scan_request *req);
 int ieee80211_request_sched_scan_stop(struct ieee80211_local *local);
 void ieee80211_sched_scan_end(struct ieee80211_local *local);
-void ieee80211_sched_scan_stopped_work(struct work_struct *work);
+void ieee80211_sched_scan_stopped_work(struct wiphy *wiphy,
+				       struct wiphy_work *work);
 
 /* off-channel/mgmt-tx */
 void ieee80211_offchannel_stop_vifs(struct ieee80211_local *local);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 7c165e78115c..ba5382efa950 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -843,8 +843,8 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 			ieee80211_dynamic_ps_disable_work);
 	timer_setup(&local->dynamic_ps_timer, ieee80211_dynamic_ps_timer, 0);
 
-	INIT_WORK(&local->sched_scan_stopped_work,
-		  ieee80211_sched_scan_stopped_work);
+	wiphy_work_init(&local->sched_scan_stopped_work,
+			ieee80211_sched_scan_stopped_work);
 
 	spin_lock_init(&local->ack_status_lock);
 	idr_init(&local->ack_status_frames);
@@ -1502,13 +1502,13 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 
 	wiphy_lock(local->hw.wiphy);
 	wiphy_delayed_work_cancel(local->hw.wiphy, &local->roc_work);
+	wiphy_work_cancel(local->hw.wiphy, &local->sched_scan_stopped_work);
 	wiphy_work_cancel(local->hw.wiphy, &local->radar_detected_work);
 	wiphy_unlock(local->hw.wiphy);
 	rtnl_unlock();
 
 	cancel_work_sync(&local->restart_work);
 	cancel_work_sync(&local->reconfig_filter);
-	flush_work(&local->sched_scan_stopped_work);
 
 	ieee80211_clear_tx_pending(local);
 	rate_control_deinitialize(local);
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 2117cb2a916a..68ec2124c3db 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -1422,10 +1422,11 @@ void ieee80211_sched_scan_end(struct ieee80211_local *local)
 
 	mutex_unlock(&local->mtx);
 
-	cfg80211_sched_scan_stopped(local->hw.wiphy, 0);
+	cfg80211_sched_scan_stopped_locked(local->hw.wiphy, 0);
 }
 
-void ieee80211_sched_scan_stopped_work(struct work_struct *work)
+void ieee80211_sched_scan_stopped_work(struct wiphy *wiphy,
+				       struct wiphy_work *work)
 {
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local,
@@ -1448,6 +1449,6 @@ void ieee80211_sched_scan_stopped(struct ieee80211_hw *hw)
 	if (local->in_reconfig)
 		return;
 
-	schedule_work(&local->sched_scan_stopped_work);
+	wiphy_work_queue(hw->wiphy, &local->sched_scan_stopped_work);
 }
 EXPORT_SYMBOL(ieee80211_sched_scan_stopped);
-- 
2.41.0

