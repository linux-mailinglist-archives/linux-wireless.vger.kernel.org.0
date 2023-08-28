Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E661178AF5D
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjH1L7p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 07:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjH1L7X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 07:59:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6669E120
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 04:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=K3l1SoOeVInloWHUy2kLpcuc6jHWPWI+J78cuxI4C3c=;
        t=1693223960; x=1694433560; b=lbCgmddF2CYvzmBffeXR1aClChy++g+WKtAHSrXH2eK+Nm5
        Dwa8so1H4/ocoOsmFd+eZbH3rqgjLiLCtNOJJw7Hv9k41IrEzuXzB//xdqkT+tN4IiOywkSlRUb8t
        DKZxUfeLn1odKwmE26ZpD6ibEbJeY98MOtWTGBZl7nFCc39rYvtc8duVuEDZ8SOYnbHAhgbjpGeyi
        L4yPG0RVPReVVXZxldj4L8+T2joyR3K1Enh5+QX5v11Bdu/Zko8Z/h8URXl6wJlxwDLgqOHphJ/4p
        bfSB1n2rr+lJsvrbIeHn6sBcU9VCVkJLeSDP38AVohPghblAG110Vqh/q0vsPo9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaatq-00GjIn-03;
        Mon, 28 Aug 2023 13:59:18 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 2/4] wifi: mac80211: rework ack_frame_id handling a bit
Date:   Mon, 28 Aug 2023 13:59:00 +0200
Message-ID: <20230828135858.45c543acee45.If29e38f610e6c6ea667f77b6db7c4f0230d317f0@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828135858.c5182ba79e0f.I5efd1399be8e6dedc1e48982b7f20c531ff37616@changeid>
References: <20230828135858.c5182ba79e0f.I5efd1399be8e6dedc1e48982b7f20c531ff37616@changeid>
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

Take one more free bit to indicate it's IDR vs. internal
usage, to be able to carve out some bits here for other
internal usage, other than IDR handling with a full ACK
SKB, that is.

Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h     |  9 ++++++---
 net/mac80211/cfg.c         |  3 ++-
 net/mac80211/ieee80211_i.h |  5 +++++
 net/mac80211/status.c      |  4 ++--
 net/mac80211/tx.c          | 14 ++++++++++----
 5 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7c707358d15c..7f3b6f00f8a2 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1115,7 +1115,9 @@ ieee80211_rate_get_vht_nss(const struct ieee80211_tx_rate *rate)
  *	not valid if the interface is an MLD since we won't know which
  *	link the frame will be transmitted on
  * @hw_queue: HW queue to put the frame on, skb_get_queue_mapping() gives the AC
- * @ack_frame_id: internal frame ID for TX status, used internally
+ * @status_data: internal data for TX status handling, assigned privately,
+ *	see also &enum ieee80211_status_data for the internal documentation
+ * @status_data_idr: indicates status data is IDR allocated ID for ack frame
  * @tx_time_est: TX time estimate in units of 4us, used internally
  * @control: union part for control data
  * @control.rates: TX rates array to try
@@ -1155,10 +1157,11 @@ struct ieee80211_tx_info {
 	/* common information */
 	u32 flags;
 	u32 band:3,
-	    ack_frame_id:13,
+	    status_data_idr:1,
+	    status_data:13,
 	    hw_queue:4,
 	    tx_time_est:10;
-	/* 2 free bits */
+	/* 1 free bit */
 
 	union {
 		struct {
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 45e7a5d9c7d9..29a6da5ee77f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4034,7 +4034,8 @@ int ieee80211_attach_ack_skb(struct ieee80211_local *local, struct sk_buff *skb,
 		return -ENOMEM;
 	}
 
-	IEEE80211_SKB_CB(skb)->ack_frame_id = id;
+	IEEE80211_SKB_CB(skb)->status_data_idr = 1;
+	IEEE80211_SKB_CB(skb)->status_data = id;
 
 	*cookie = ieee80211_mgmt_tx_cookie(local);
 	IEEE80211_SKB_CB(ack_skb)->ack.cookie = *cookie;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 06bd406846d2..7b74cf96ee0a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -85,6 +85,11 @@ extern const u8 ieee80211_ac_to_qos_mask[IEEE80211_NUM_ACS];
 
 #define IEEE80211_MAX_NAN_INSTANCE_ID 255
 
+enum ieee80211_status_data {
+	IEEE80211_STATUS_TYPE_MASK	= 0x00f,
+	IEEE80211_STATUS_TYPE_INVALID	= 0,
+	IEEE80211_STATUS_SUBDATA_MASK	= 0xff0,
+};
 
 /*
  * Keep a station's queues on the active list for deficit accounting purposes
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 44d83da60aee..f24aceb59db0 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -633,7 +633,7 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 	unsigned long flags;
 
 	spin_lock_irqsave(&local->ack_status_lock, flags);
-	skb = idr_remove(&local->ack_status_frames, info->ack_frame_id);
+	skb = idr_remove(&local->ack_status_frames, info->status_data);
 	spin_unlock_irqrestore(&local->ack_status_lock, flags);
 
 	if (!skb)
@@ -759,7 +759,7 @@ static void ieee80211_report_used_skb(struct ieee80211_local *local,
 		}
 
 		rcu_read_unlock();
-	} else if (info->ack_frame_id) {
+	} else if (info->status_data_idr) {
 		ieee80211_report_ack_skb(local, skb, acked, dropped,
 					 ack_hwtstamp);
 	}
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 3a5b41c2ee3d..ae33f727c6a8 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2942,7 +2942,10 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 	memset(info, 0, sizeof(*info));
 
 	info->flags = info_flags;
-	info->ack_frame_id = info_id;
+	if (info_id) {
+		info->status_data = info_id;
+		info->status_data_idr = 1;
+	}
 	info->band = band;
 
 	if (likely(!cookie)) {
@@ -4639,9 +4642,12 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (unlikely(skb->sk &&
-		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS))
-		info->ack_frame_id = ieee80211_store_ack_skb(local, skb,
-							     &info->flags, NULL);
+		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
+		info->status_data = ieee80211_store_ack_skb(local, skb,
+							    &info->flags, NULL);
+		if (info->status_data)
+			info->status_data_idr = 1;
+	}
 
 	dev_sw_netstats_tx_add(dev, skbs, len);
 	sta->deflink.tx_stats.packets[queue] += skbs;
-- 
2.41.0

