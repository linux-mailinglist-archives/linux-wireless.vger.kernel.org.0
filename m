Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA60386BF5
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 23:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbhEQVJ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 17:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbhEQVJU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 17:09:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5719EC061756
        for <linux-wireless@vger.kernel.org>; Mon, 17 May 2021 14:08:03 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1likT1-00AVFx-Hp; Mon, 17 May 2021 23:07:59 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/4] mac80211: unify queueing SKB to iface
Date:   Mon, 17 May 2021 23:07:54 +0200
Message-Id: <20210517230754.113b65febd5a.Ie0e1d58a2885e75f242cb6e06f3b9660117fef93@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We have a bunch of places that open-code the same to queue
an SKB to an interface, unify that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/rx.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 62047e93e217..06ea259bb385 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -214,6 +214,16 @@ ieee80211_rx_radiotap_hdrlen(struct ieee80211_local *local,
 	return len;
 }
 
+static void ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
+					 struct sta_info *sta,
+					 struct sk_buff *skb)
+{
+	skb_queue_tail(&sdata->skb_queue, skb);
+	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	if (sta)
+		sta->rx_stats.packets++;
+}
+
 static void ieee80211_handle_mu_mimo_mon(struct ieee80211_sub_if_data *sdata,
 					 struct sk_buff *skb,
 					 int rtap_space)
@@ -254,8 +264,7 @@ static void ieee80211_handle_mu_mimo_mon(struct ieee80211_sub_if_data *sdata,
 	if (!skb)
 		return;
 
-	skb_queue_tail(&sdata->skb_queue, skb);
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	ieee80211_queue_skb_to_iface(sdata, NULL, skb);
 }
 
 /*
@@ -1339,7 +1348,6 @@ static void ieee80211_rx_reorder_ampdu(struct ieee80211_rx_data *rx,
 				       struct sk_buff_head *frames)
 {
 	struct sk_buff *skb = rx->skb;
-	struct ieee80211_local *local = rx->local;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 	struct sta_info *sta = rx->sta;
 	struct tid_ampdu_rx *tid_agg_rx;
@@ -1391,8 +1399,7 @@ static void ieee80211_rx_reorder_ampdu(struct ieee80211_rx_data *rx,
 	/* if this mpdu is fragmented - terminate rx aggregation session */
 	sc = le16_to_cpu(hdr->seq_ctrl);
 	if (sc & IEEE80211_SCTL_FRAG) {
-		skb_queue_tail(&rx->sdata->skb_queue, skb);
-		ieee80211_queue_work(&local->hw, &rx->sdata->work);
+		ieee80211_queue_skb_to_iface(rx->sdata, NULL, skb);
 		return;
 	}
 
@@ -3412,10 +3419,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 	return RX_QUEUED;
 
  queue:
-	skb_queue_tail(&sdata->skb_queue, rx->skb);
-	ieee80211_queue_work(&local->hw, &sdata->work);
-	if (rx->sta)
-		rx->sta->rx_stats.packets++;
+	ieee80211_queue_skb_to_iface(sdata, rx->sta, rx->skb);
 	return RX_QUEUED;
 }
 
@@ -3563,10 +3567,7 @@ ieee80211_rx_h_ext(struct ieee80211_rx_data *rx)
 		return RX_DROP_MONITOR;
 
 	/* for now only beacons are ext, so queue them */
-	skb_queue_tail(&sdata->skb_queue, rx->skb);
-	ieee80211_queue_work(&rx->local->hw, &sdata->work);
-	if (rx->sta)
-		rx->sta->rx_stats.packets++;
+	ieee80211_queue_skb_to_iface(sdata, rx->sta, rx->skb);
 
 	return RX_QUEUED;
 }
@@ -3623,11 +3624,7 @@ ieee80211_rx_h_mgmt(struct ieee80211_rx_data *rx)
 		return RX_DROP_MONITOR;
 	}
 
-	/* queue up frame and kick off work to process it */
-	skb_queue_tail(&sdata->skb_queue, rx->skb);
-	ieee80211_queue_work(&rx->local->hw, &sdata->work);
-	if (rx->sta)
-		rx->sta->rx_stats.packets++;
+	ieee80211_queue_skb_to_iface(sdata, rx->sta, rx->skb);
 
 	return RX_QUEUED;
 }
-- 
2.31.1

