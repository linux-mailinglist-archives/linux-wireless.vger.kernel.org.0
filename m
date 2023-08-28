Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4257178AF7D
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjH1MFk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjH1MFe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925C3120
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=SLwxIY+yAQOrnVAyriHxBVJifE3hC8IIGqHUVSpf0TI=;
        t=1693224331; x=1694433931; b=dDfGYwj+BRF2605z1jI49hzOIC7zg6ZkN5iONp4bMF/yxPp
        Wa/BsqhnC8W+vTbJqaCfAqjdrg3BB1hINEMWb7mW0JMBUEHyISfc9VvAwTKZ/5yKjsvGMGS+pVwio
        DT7f7V2uGIRSYOKKjvuJPYWE9UQN1tF0b29zwa+1MhfaDbEKc6o0gEjAZm4eBykQMm7yRUJSKVKCa
        fly5jXmjhKyhVrJnfGaIp3bjwry6FBM/x4h8WUH3JS6s7XxaL2cy5AZiWtdCHxgs86kJiL6ktmeca
        0zA+nQznSn4rAuX8/AkuBAdXrpB/s91Mg+1/FG3qJSPfDYNV3UZ1dgzDdv8LGy/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazp-00Gjgt-0s;
        Mon, 28 Aug 2023 14:05:29 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/40] wifi: mac80211: move offchannel works to wiphy work
Date:   Mon, 28 Aug 2023 13:59:42 +0200
Message-ID: <20230828135927.14c989da9ed2.I2c1a380b5d47b5b4122ff3f0ceb9d5c82d37f587@changeid>
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

Make the offchannel works wiphy works to have the
wiphy locked for executing them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  4 ++--
 net/mac80211/main.c        |  6 +++---
 net/mac80211/offchannel.c  | 36 ++++++++++++++++++------------------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 1cb29a67a2c7..6d789087b453 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1589,9 +1589,9 @@ struct ieee80211_local {
 	/*
 	 * Remain-on-channel support
 	 */
-	struct delayed_work roc_work;
+	struct wiphy_delayed_work roc_work;
 	struct list_head roc_list;
-	struct work_struct hw_roc_start, hw_roc_done;
+	struct wiphy_work hw_roc_start, hw_roc_done;
 	unsigned long hw_roc_start_time;
 	u64 roc_cookie_counter;
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index f6860889fbdd..e686b0cc2cd8 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -377,8 +377,8 @@ static void ieee80211_restart_work(struct work_struct *work)
 	ieee80211_scan_cancel(local);
 
 	/* make sure any new ROC will consider local->in_reconfig */
-	flush_delayed_work(&local->roc_work);
-	flush_work(&local->hw_roc_done);
+	wiphy_delayed_work_flush(local->hw.wiphy, &local->roc_work);
+	wiphy_work_flush(local->hw.wiphy, &local->hw_roc_done);
 
 	/* wait for all packet processing to be done */
 	synchronize_net();
@@ -1501,11 +1501,11 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 	ieee80211_remove_interfaces(local);
 
 	wiphy_lock(local->hw.wiphy);
+	wiphy_delayed_work_cancel(local->hw.wiphy, &local->roc_work);
 	wiphy_work_cancel(local->hw.wiphy, &local->radar_detected_work);
 	wiphy_unlock(local->hw.wiphy);
 	rtnl_unlock();
 
-	cancel_delayed_work_sync(&local->roc_work);
 	cancel_work_sync(&local->restart_work);
 	cancel_work_sync(&local->reconfig_filter);
 	flush_work(&local->sched_scan_stopped_work);
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index cdf991e74ab9..5bedd9cef414 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -230,7 +230,7 @@ static bool ieee80211_recalc_sw_work(struct ieee80211_local *local,
 	if (dur == LONG_MAX)
 		return false;
 
-	mod_delayed_work(local->workqueue, &local->roc_work, dur);
+	wiphy_delayed_work_queue(local->hw.wiphy, &local->roc_work, dur);
 	return true;
 }
 
@@ -258,7 +258,7 @@ static void ieee80211_handle_roc_started(struct ieee80211_roc_work *roc,
 	roc->notified = true;
 }
 
-static void ieee80211_hw_roc_start(struct work_struct *work)
+static void ieee80211_hw_roc_start(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local, hw_roc_start);
@@ -285,7 +285,7 @@ void ieee80211_ready_on_channel(struct ieee80211_hw *hw)
 
 	trace_api_ready_on_channel(local);
 
-	ieee80211_queue_work(hw, &local->hw_roc_start);
+	wiphy_work_queue(hw->wiphy, &local->hw_roc_start);
 }
 EXPORT_SYMBOL_GPL(ieee80211_ready_on_channel);
 
@@ -338,7 +338,7 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 				tmp->started = true;
 				tmp->abort = true;
 			}
-			ieee80211_queue_work(&local->hw, &local->hw_roc_done);
+			wiphy_work_queue(local->hw.wiphy, &local->hw_roc_done);
 			return;
 		}
 
@@ -368,8 +368,8 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 			ieee80211_hw_config(local, 0);
 		}
 
-		ieee80211_queue_delayed_work(&local->hw, &local->roc_work,
-					     msecs_to_jiffies(min_dur));
+		wiphy_delayed_work_queue(local->hw.wiphy, &local->roc_work,
+					 msecs_to_jiffies(min_dur));
 
 		/* tell userspace or send frame(s) */
 		list_for_each_entry(tmp, &local->roc_list, list) {
@@ -407,8 +407,8 @@ void ieee80211_start_next_roc(struct ieee80211_local *local)
 		_ieee80211_start_next_roc(local);
 	} else {
 		/* delay it a bit */
-		ieee80211_queue_delayed_work(&local->hw, &local->roc_work,
-					     round_jiffies_relative(HZ/2));
+		wiphy_delayed_work_queue(local->hw.wiphy, &local->roc_work,
+					 round_jiffies_relative(HZ / 2));
 	}
 }
 
@@ -451,7 +451,7 @@ static void __ieee80211_roc_work(struct ieee80211_local *local)
 	}
 }
 
-static void ieee80211_roc_work(struct work_struct *work)
+static void ieee80211_roc_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local, roc_work.work);
@@ -461,7 +461,7 @@ static void ieee80211_roc_work(struct work_struct *work)
 	mutex_unlock(&local->mtx);
 }
 
-static void ieee80211_hw_roc_done(struct work_struct *work)
+static void ieee80211_hw_roc_done(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local, hw_roc_done);
@@ -482,7 +482,7 @@ void ieee80211_remain_on_channel_expired(struct ieee80211_hw *hw)
 
 	trace_api_remain_on_channel_expired(local);
 
-	ieee80211_queue_work(hw, &local->hw_roc_done);
+	wiphy_work_queue(hw->wiphy, &local->hw_roc_done);
 }
 EXPORT_SYMBOL_GPL(ieee80211_remain_on_channel_expired);
 
@@ -586,8 +586,8 @@ static int ieee80211_start_roc_work(struct ieee80211_local *local,
 		/* if not HW assist, just queue & schedule work */
 		if (!local->ops->remain_on_channel) {
 			list_add_tail(&roc->list, &local->roc_list);
-			ieee80211_queue_delayed_work(&local->hw,
-						     &local->roc_work, 0);
+			wiphy_delayed_work_queue(local->hw.wiphy,
+						 &local->roc_work, 0);
 		} else {
 			/* otherwise actually kick it off here
 			 * (for error handling)
@@ -695,7 +695,7 @@ static int ieee80211_cancel_roc(struct ieee80211_local *local,
 	if (!cookie)
 		return -ENOENT;
 
-	flush_work(&local->hw_roc_start);
+	wiphy_work_flush(local->hw.wiphy, &local->hw_roc_start);
 
 	mutex_lock(&local->mtx);
 	list_for_each_entry_safe(roc, tmp, &local->roc_list, list) {
@@ -745,7 +745,7 @@ static int ieee80211_cancel_roc(struct ieee80211_local *local,
 	} else {
 		/* go through work struct to return to the operating channel */
 		found->abort = true;
-		mod_delayed_work(local->workqueue, &local->roc_work, 0);
+		wiphy_delayed_work_queue(local->hw.wiphy, &local->roc_work, 0);
 	}
 
  out_unlock:
@@ -994,9 +994,9 @@ int ieee80211_mgmt_tx_cancel_wait(struct wiphy *wiphy,
 
 void ieee80211_roc_setup(struct ieee80211_local *local)
 {
-	INIT_WORK(&local->hw_roc_start, ieee80211_hw_roc_start);
-	INIT_WORK(&local->hw_roc_done, ieee80211_hw_roc_done);
-	INIT_DELAYED_WORK(&local->roc_work, ieee80211_roc_work);
+	wiphy_work_init(&local->hw_roc_start, ieee80211_hw_roc_start);
+	wiphy_work_init(&local->hw_roc_done, ieee80211_hw_roc_done);
+	wiphy_delayed_work_init(&local->roc_work, ieee80211_roc_work);
 	INIT_LIST_HEAD(&local->roc_list);
 }
 
-- 
2.41.0

