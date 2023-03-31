Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1876D2357
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjCaO7k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjCaO7b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 10:59:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6BDCA38
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 07:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Qk7jwjYHM66+nt95L8c9tVyf/KkzddOGygQjTZZXIfc=;
        t=1680274762; x=1681484362; b=t94TuzClDemJAXk6jEqEQKBMboplpcDd3EKs/mD9FPT+qXr
        /p2p67EsZC6oPNRbOaNACYhNlhkgxcog6A3VqFJd2DvM1QlqIv0hG90KoBjzLHUdtwBfeUx/nT2qC
        i8KVATivUddZjJphK1S8TlzUh5CeH9mDxMTUQ2ZSFkK9kj8X5M/idVK0AKu4F63tNjAhp97IUKLGu
        kcf25sVXVuK4nnw1gRadax9zjr5PLymlDKNHPEDYJj05cub/+FaSkm7ZPgSVPsZ2eVYn3WbkYkMtY
        t1+FYMzLCEm3aC91D0FneukdZKcfwL9Y0N90e0YntdPr0n8zLwgtB+/1t/+au+uQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1piGDo-002ID5-0d;
        Fri, 31 Mar 2023 16:59:20 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: add flush_sta method
Date:   Fri, 31 Mar 2023 16:59:17 +0200
Message-Id: <20230331165915.7f6f27a79852.I4edd6fca41b04c43d5dcb7c00732525f84e48836@changeid>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331165915.2480c0c04b69.Ia95b7dbddeba0cfe619ccebfe3acafedd372c70f@changeid>
References: <20230331165915.2480c0c04b69.Ia95b7dbddeba0cfe619ccebfe3acafedd372c70f@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Some drivers like iwlwifi might have per-STA queues, so we
may want to flush/drop just those queues rather than all
when removing a station. Add a separate method for that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h    |  6 ++++++
 net/mac80211/driver-ops.h | 15 +++++++++++++++
 net/mac80211/sta_info.c   |  8 ++++++--
 net/mac80211/trace.h      |  7 +++++++
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 679421d37a42..a8dadbd83d95 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3950,6 +3950,10 @@ struct ieee80211_prep_tx_info {
  *	Note that vif can be NULL.
  *	The callback can sleep.
  *
+ * @flush_sta: Flush or drop all pending frames from the hardware queue(s) for
+ *	the given station, as it's about to be removed.
+ *	The callback can sleep.
+ *
  * @channel_switch: Drivers that need (or want) to offload the channel
  *	switch operation for CSAs received from the AP may implement this
  *	callback. They must then call ieee80211_chswitch_done() to indicate
@@ -4415,6 +4419,8 @@ struct ieee80211_ops {
 #endif
 	void (*flush)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		      u32 queues, bool drop);
+	void (*flush_sta)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta);
 	void (*channel_switch)(struct ieee80211_hw *hw,
 			       struct ieee80211_vif *vif,
 			       struct ieee80211_channel_switch *ch_switch);
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 0bf208f5bbc5..45d3e53c7383 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -649,6 +649,21 @@ static inline void drv_flush(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
+static inline void drv_flush_sta(struct ieee80211_local *local,
+				 struct ieee80211_sub_if_data *sdata,
+				 struct sta_info *sta)
+{
+	might_sleep();
+
+	if (sdata && !check_sdata_in_driver(sdata))
+		return;
+
+	trace_drv_flush_sta(local, sdata, &sta->sta);
+	if (local->ops->flush_sta)
+		local->ops->flush_sta(&local->hw, &sdata->vif, &sta->sta);
+	trace_drv_return_void(local);
+}
+
 static inline void drv_channel_switch(struct ieee80211_local *local,
 				      struct ieee80211_sub_if_data *sdata,
 				      struct ieee80211_channel_switch *ch_switch)
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index ce7c3b997269..1400512e0dde 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1299,8 +1299,12 @@ static void __sta_info_destroy_part2(struct sta_info *sta)
 	 * frames sitting on hardware queues might be sent out without
 	 * any encryption at all.
 	 */
-	if (local->ops->set_key)
-		ieee80211_flush_queues(local, sta->sdata, false);
+	if (local->ops->set_key) {
+		if (local->ops->flush_sta)
+			drv_flush_sta(local, sta->sdata, sta);
+		else
+			ieee80211_flush_queues(local, sta->sdata, false);
+	}
 
 	/* now keys can no longer be reached */
 	ieee80211_free_sta_keys(local, sta);
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index e0ccf5fe708a..de5d69f21306 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -1177,6 +1177,13 @@ TRACE_EVENT(drv_flush,
 	)
 );
 
+DEFINE_EVENT(sta_event, drv_flush_sta,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 struct ieee80211_sta *sta),
+	TP_ARGS(local, sdata, sta)
+);
+
 TRACE_EVENT(drv_channel_switch,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-- 
2.39.2

