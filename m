Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43E11E4930
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 18:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390132AbgE0QDv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 12:03:51 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:58635 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389743AbgE0QDj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 12:03:39 -0400
Received: from legolas.fritz.box (unknown [87.147.49.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 1542F580063;
        Wed, 27 May 2020 18:03:36 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v3] nl80211: add control port tx status method
Date:   Wed, 27 May 2020 18:03:34 +0200
Message-Id: <20200527160334.19224-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds the actual code for returning the tx status of control
port frames sent over nl80211.

NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS is a new command which is used
when returning the tx status. Its availability can be queried by checking
against NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS.

The ctrl port tx status over nl80211 path re-uses some code from the path
for advertising the tx status over socket control messages, when
SKBTX_WIFI_STATUS is set.

The tx status can be used in a similar fashion as the mgmt tx status
already allows for. A cookie is included extended ack data of
NL80211_CMD_CONTROL_PORT_FRAME, which can be matched against the cookie
in NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS. The frame content is also
included, as for example hostapd currently uses it to match request and
reply.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
v3:
* set ext feature flag for mac80211

v2:
* re-use roc cookie
* better check for socket skb
* double checked WARN_ON in ieee80211_build_hdr

 net/mac80211/ieee80211_i.h |  3 +-
 net/mac80211/main.c        |  2 ++
 net/mac80211/status.c      |  9 +++++-
 net/mac80211/tdls.c        |  2 +-
 net/mac80211/tx.c          | 62 ++++++++++++++++++++++++++------------
 5 files changed, 56 insertions(+), 22 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index b87dc873825b..b7935f3d000d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1783,7 +1783,8 @@ netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 				  struct net_device *dev,
 				  u32 info_flags,
-				  u32 ctrl_flags);
+				  u32 ctrl_flags,
+				  u64 *cookie);
 void ieee80211_purge_tx_queue(struct ieee80211_hw *hw,
 			      struct sk_buff_head *skbs);
 struct sk_buff *
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 7041b9ff161c..1a8293c9cc27 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -596,6 +596,8 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 			      NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211);
 	wiphy_ext_feature_set(wiphy,
 			      NL80211_EXT_FEATURE_CONTROL_PORT_NO_PREAUTH);
+	wiphy_ext_feature_set(wiphy,
+			      NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS);
 	wiphy_ext_feature_set(wiphy,
 			      NL80211_EXT_FEATURE_SCAN_FREQ_KHZ);
 
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 22512805eafb..7b1bacac39c6 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -649,10 +649,17 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 						      info->status.ack_signal,
 						      info->status.is_valid_ack_signal,
 						      GFP_ATOMIC);
-			else
+			else if (ieee80211_is_mgmt(hdr->frame_control))
 				cfg80211_mgmt_tx_status(&sdata->wdev, cookie,
 							skb->data, skb->len,
 							acked, GFP_ATOMIC);
+			else
+				cfg80211_control_port_tx_status(&sdata->wdev,
+								cookie,
+								skb->data,
+								skb->len,
+								acked,
+								GFP_ATOMIC);
 		}
 		rcu_read_unlock();
 
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 8ad420db3766..4b0cff4a07bd 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1054,7 +1054,7 @@ ieee80211_tdls_prep_mgmt_packet(struct wiphy *wiphy, struct net_device *dev,
 
 	/* disable bottom halves when entering the Tx path */
 	local_bh_disable();
-	__ieee80211_subif_start_xmit(skb, dev, flags, 0);
+	__ieee80211_subif_start_xmit(skb, dev, flags, 0, NULL);
 	local_bh_enable();
 
 	return ret;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index ba34cc392ea8..00addf36c480 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2436,13 +2436,19 @@ int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
-static int ieee80211_store_ack_skb(struct ieee80211_local *local,
+static u16 ieee80211_store_ack_skb(struct ieee80211_local *local,
 				   struct sk_buff *skb,
-				   u32 *info_flags)
+				   u32 *info_flags,
+				   u64 *cookie)
 {
-	struct sk_buff *ack_skb = skb_clone_sk(skb);
+	struct sk_buff *ack_skb;
 	u16 info_id = 0;
 
+	if (skb->sk)
+		ack_skb = skb_clone_sk(skb);
+	else
+		ack_skb = skb_clone(skb, GFP_ATOMIC);
+
 	if (ack_skb) {
 		unsigned long flags;
 		int id;
@@ -2455,6 +2461,10 @@ static int ieee80211_store_ack_skb(struct ieee80211_local *local,
 		if (id >= 0) {
 			info_id = id;
 			*info_flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+			if (cookie) {
+				*cookie = ieee80211_mgmt_tx_cookie(local);
+				IEEE80211_SKB_CB(ack_skb)->ack.cookie = *cookie;
+			}
 		} else {
 			kfree_skb(ack_skb);
 		}
@@ -2484,7 +2494,8 @@ static int ieee80211_store_ack_skb(struct ieee80211_local *local,
  */
 static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 					   struct sk_buff *skb, u32 info_flags,
-					   struct sta_info *sta, u32 ctrl_flags)
+					   struct sta_info *sta, u32 ctrl_flags,
+					   u64 *cookie)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_tx_info *info;
@@ -2755,9 +2766,11 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 		goto free;
 	}
 
-	if (unlikely(!multicast && skb->sk &&
-		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS))
-		info_id = ieee80211_store_ack_skb(local, skb, &info_flags);
+	if (unlikely(!multicast && ((skb->sk &&
+		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) ||
+		     ctrl_flags & IEEE80211_TX_CTL_REQ_TX_STATUS)))
+		info_id = ieee80211_store_ack_skb(local, skb, &info_flags,
+						  cookie);
 
 	/*
 	 * If the skb is shared we need to obtain our own copy.
@@ -3913,7 +3926,8 @@ EXPORT_SYMBOL(ieee80211_txq_schedule_start);
 void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 				  struct net_device *dev,
 				  u32 info_flags,
-				  u32 ctrl_flags)
+				  u32 ctrl_flags,
+				  u64 *cookie)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
@@ -3983,7 +3997,7 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 		skb_mark_not_on_list(skb);
 
 		skb = ieee80211_build_hdr(sdata, skb, info_flags,
-					  sta, ctrl_flags);
+					  sta, ctrl_flags, cookie);
 		if (IS_ERR(skb)) {
 			kfree_skb_list(next);
 			goto out;
@@ -4125,9 +4139,9 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
 		__skb_queue_head_init(&queue);
 		ieee80211_convert_to_unicast(skb, dev, &queue);
 		while ((skb = __skb_dequeue(&queue)))
-			__ieee80211_subif_start_xmit(skb, dev, 0, 0);
+			__ieee80211_subif_start_xmit(skb, dev, 0, 0, NULL);
 	} else {
-		__ieee80211_subif_start_xmit(skb, dev, 0, 0);
+		__ieee80211_subif_start_xmit(skb, dev, 0, 0, NULL);
 	}
 
 	return NETDEV_TX_OK;
@@ -4215,7 +4229,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 
 	if (unlikely(!multicast && skb->sk &&
 		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS))
-		ieee80211_store_ack_skb(local, skb, &info->flags);
+		ieee80211_store_ack_skb(local, skb, &info->flags, NULL);
 
 	memset(info, 0, sizeof(*info));
 
@@ -4299,7 +4313,7 @@ ieee80211_build_data_template(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
-	skb = ieee80211_build_hdr(sdata, skb, info_flags, sta, 0);
+	skb = ieee80211_build_hdr(sdata, skb, info_flags, sta, 0, NULL);
 	if (IS_ERR(skb))
 		goto out;
 
@@ -5347,7 +5361,7 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	struct sk_buff *skb;
 	struct ethhdr *ehdr;
 	u32 ctrl_flags = 0;
-	u32 flags;
+	u32 flags = 0;
 
 	/* Only accept CONTROL_PORT_PROTOCOL configured in CONNECT/ASSOCIATE
 	 * or Pre-Authentication
@@ -5360,9 +5374,13 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 		ctrl_flags |= IEEE80211_TX_CTRL_PORT_CTRL_PROTO;
 
 	if (unencrypted)
-		flags = IEEE80211_TX_INTFL_DONT_ENCRYPT;
-	else
-		flags = 0;
+		flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
+
+	if (cookie)
+		ctrl_flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+
+	flags |= IEEE80211_TX_INTFL_NL80211_FRAME_TX |
+		 IEEE80211_TX_CTL_INJECTED;
 
 	skb = dev_alloc_skb(local->hw.extra_tx_headroom +
 			    sizeof(struct ethhdr) + len);
@@ -5383,10 +5401,15 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	skb_reset_network_header(skb);
 	skb_reset_mac_header(skb);
 
+	/* mutex lock is only needed for incrementing the cookie counter */
+	mutex_lock(&local->mtx);
+
 	local_bh_disable();
-	__ieee80211_subif_start_xmit(skb, skb->dev, flags, ctrl_flags);
+	__ieee80211_subif_start_xmit(skb, skb->dev, flags, ctrl_flags, cookie);
 	local_bh_enable();
 
+	mutex_unlock(&local->mtx);
+
 	return 0;
 }
 
@@ -5413,7 +5436,8 @@ int ieee80211_probe_mesh_link(struct wiphy *wiphy, struct net_device *dev,
 
 	local_bh_disable();
 	__ieee80211_subif_start_xmit(skb, skb->dev, 0,
-				     IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP);
+				     IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP,
+				     NULL);
 	local_bh_enable();
 
 	return 0;
-- 
2.26.2

