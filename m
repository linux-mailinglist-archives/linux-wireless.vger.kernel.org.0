Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E8878AF88
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjH1MFu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjH1MFb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED65911A
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=OvZqHvtCi0S+z98djhpbjn/jtdhstuHcyxmjuYezJmY=;
        t=1693224329; x=1694433929; b=tXHBMGbr76/eeo8Wap/9grx4WXQrcouxu/Gbazz1mQjba3e
        kCI895BW0sVIZzYP6rgktYJcKYnJ6Bwd8v1gDBusFHUor+UlfdyfS6g4jXhmM0uj92SIwbpWZ2i/t
        tGzrAqe5u++qdzfXgXyw0sKRz059Yfwh2BM/5E0p1uCDF8D1dl9Or2MhxA25/Ys9wB5z03xAoWAaf
        Gr63cMrnirGpcl5LD6Bq8DIhU2yjAZ4Kd+YENUgGq+X7HCYGX3yTAHDsIBzwVIhxxG5X6H0XizduH
        U7ZDAXALGF6NWJPXs48p13F19Mlr9bGbPzBUc/kuZAdlgCBHO9OiGuFPg7s7+7ng==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazl-00Gjgt-29;
        Mon, 28 Aug 2023 14:05:26 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 11/40] wifi: mac80211: move scan work to wiphy work
Date:   Mon, 28 Aug 2023 13:59:39 +0200
Message-ID: <20230828135927.8d34f3e4edf8.I88c97240d3f999946d39cb99e9bb6a3b58acfd9b@changeid>
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

Move the scan work to wiphy work, which also simplifies
the way we handle the work vs. the scan configuration.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  4 ++--
 net/mac80211/iface.c       |  2 +-
 net/mac80211/main.c        |  4 +---
 net/mac80211/scan.c        | 29 ++++++++++++-----------------
 net/mac80211/util.c        |  4 ++--
 5 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9be569ade9f7..72955758a846 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1496,7 +1496,7 @@ struct ieee80211_local {
 
 	unsigned long leave_oper_channel_time;
 	enum mac80211_scan_state next_scan_state;
-	struct delayed_work scan_work;
+	struct wiphy_delayed_work scan_work;
 	struct ieee80211_sub_if_data __rcu *scan_sdata;
 	/* For backward compatibility only -- do not use */
 	struct cfg80211_chan_def _oper_chandef;
@@ -1935,7 +1935,7 @@ int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata,
 			      u64 *changed);
 
 /* scan/BSS handling */
-void ieee80211_scan_work(struct work_struct *work);
+void ieee80211_scan_work(struct wiphy *wiphy, struct wiphy_work *work);
 int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 				const u8 *ssid, u8 ssid_len,
 				struct ieee80211_channel **channels,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index a8c08424c015..42e130a6aee9 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -690,7 +690,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	ieee80211_recalc_ps(local);
 
 	if (cancel_scan)
-		flush_delayed_work(&local->scan_work);
+		wiphy_delayed_work_flush(local->hw.wiphy, &local->scan_work);
 
 	if (local->open_count == 0) {
 		ieee80211_stop_device(local);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index b3c3b031b5b8..b6c089648441 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -335,9 +335,7 @@ static void ieee80211_restart_work(struct work_struct *work)
 	struct ieee80211_sub_if_data *sdata;
 	int ret;
 
-	/* wait for scan work complete */
 	flush_workqueue(local->workqueue);
-	flush_work(&local->sched_scan_stopped_work);
 
 	rtnl_lock();
 	/* we might do interface manipulations, so need both */
@@ -809,7 +807,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	INIT_LIST_HEAD(&local->chanctx_list);
 	mutex_init(&local->chanctx_mtx);
 
-	INIT_DELAYED_WORK(&local->scan_work, ieee80211_scan_work);
+	wiphy_delayed_work_init(&local->scan_work, ieee80211_scan_work);
 
 	INIT_WORK(&local->restart_work, ieee80211_restart_work);
 
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 0805aa8603c6..2117cb2a916a 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -274,8 +274,8 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 		 * the beacon/proberesp rx gives us an opportunity to upgrade
 		 * to active scan
 		 */
-		 set_bit(SCAN_BEACON_DONE, &local->scanning);
-		 ieee80211_queue_delayed_work(&local->hw, &local->scan_work, 0);
+		set_bit(SCAN_BEACON_DONE, &local->scanning);
+		wiphy_delayed_work_queue(local->hw.wiphy, &local->scan_work, 0);
 	}
 
 	if (ieee80211_is_probe_resp(mgmt->frame_control)) {
@@ -505,7 +505,7 @@ void ieee80211_scan_completed(struct ieee80211_hw *hw,
 
 	memcpy(&local->scan_info, info, sizeof(*info));
 
-	ieee80211_queue_delayed_work(&local->hw, &local->scan_work, 0);
+	wiphy_delayed_work_queue(local->hw.wiphy, &local->scan_work, 0);
 }
 EXPORT_SYMBOL(ieee80211_scan_completed);
 
@@ -545,8 +545,7 @@ static int ieee80211_start_sw_scan(struct ieee80211_local *local,
 	/* We need to set power level at maximum rate for scanning. */
 	ieee80211_hw_config(local, 0);
 
-	ieee80211_queue_delayed_work(&local->hw,
-				     &local->scan_work, 0);
+	wiphy_delayed_work_queue(local->hw.wiphy, &local->scan_work, 0);
 
 	return 0;
 }
@@ -603,8 +602,8 @@ void ieee80211_run_deferred_scan(struct ieee80211_local *local)
 					lockdep_is_held(&local->mtx))))
 		return;
 
-	ieee80211_queue_delayed_work(&local->hw, &local->scan_work,
-				     round_jiffies_relative(0));
+	wiphy_delayed_work_queue(local->hw.wiphy, &local->scan_work,
+				 round_jiffies_relative(0));
 }
 
 static void ieee80211_send_scan_probe_req(struct ieee80211_sub_if_data *sdata,
@@ -795,8 +794,8 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 		}
 
 		/* Now, just wait a bit and we are all done! */
-		ieee80211_queue_delayed_work(&local->hw, &local->scan_work,
-					     next_delay);
+		wiphy_delayed_work_queue(local->hw.wiphy, &local->scan_work,
+					 next_delay);
 		return 0;
 	} else {
 		/* Do normal software scan */
@@ -1043,7 +1042,7 @@ static void ieee80211_scan_state_resume(struct ieee80211_local *local,
 	local->next_scan_state = SCAN_SET_CHANNEL;
 }
 
-void ieee80211_scan_work(struct work_struct *work)
+void ieee80211_scan_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local, scan_work.work);
@@ -1137,7 +1136,8 @@ void ieee80211_scan_work(struct work_struct *work)
 		}
 	} while (next_delay == 0);
 
-	ieee80211_queue_delayed_work(&local->hw, &local->scan_work, next_delay);
+	wiphy_delayed_work_queue(local->hw.wiphy, &local->scan_work,
+				 next_delay);
 	goto out;
 
 out_complete:
@@ -1280,12 +1280,7 @@ void ieee80211_scan_cancel(struct ieee80211_local *local)
 		goto out;
 	}
 
-	/*
-	 * If the work is currently running, it must be blocked on
-	 * the mutex, but we'll set scan_sdata = NULL and it'll
-	 * simply exit once it acquires the mutex.
-	 */
-	cancel_delayed_work(&local->scan_work);
+	wiphy_delayed_work_cancel(local->hw.wiphy, &local->scan_work);
 	/* and clean up */
 	memset(&local->scan_info, 0, sizeof(local->scan_info));
 	__ieee80211_scan_completed(&local->hw, true);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 701f5b4eadae..2815f54c5aa1 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2341,8 +2341,8 @@ static void ieee80211_flush_completed_scan(struct ieee80211_local *local,
 		 */
 		if (aborted)
 			set_bit(SCAN_ABORTED, &local->scanning);
-		ieee80211_queue_delayed_work(&local->hw, &local->scan_work, 0);
-		flush_delayed_work(&local->scan_work);
+		wiphy_delayed_work_queue(local->hw.wiphy, &local->scan_work, 0);
+		wiphy_delayed_work_flush(local->hw.wiphy, &local->scan_work);
 	}
 }
 
-- 
2.41.0

