Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91781CB21A
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 16:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEHOm1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 10:42:27 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:54266 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgEHOm0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 10:42:26 -0400
Received: from legolas.fritz.box (unknown [87.147.56.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id D7596580249;
        Fri,  8 May 2020 16:42:19 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/3] nl80211: add control port tx status method
Date:   Fri,  8 May 2020 16:42:01 +0200
Message-Id: <20200508144202.7678-3-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508144202.7678-1-markus.theil@tu-ilmenau.de>
References: <20200508144202.7678-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds the actual code for returning the tx status of
control port frames sent over nl80211.

NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS is a new command which is used
when returning the tx status. Its availability can be queried by checking
against NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS, which is
added in the next patch of this series.

The ctrl port tx status over nl80211 path re-uses some code from the path
for advertising the tx status over socket control messages, when
SKBTX_WIFI_STATUS is set.

The tx status can be used in a similar fashion as the mgmt tx status
already allows for. A cookie is included in a optional reply to
NL80211_CMD_CONTROL_PORT_FRAME, which can be matched against the cookie
in NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS. The frame content is also
included, as for example hostapd currently uses it to match request and
reply.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 include/net/cfg80211.h       | 17 ++++++++
 include/uapi/linux/nl80211.h |  8 ++++
 net/mac80211/ieee80211_i.h   |  5 ++-
 net/mac80211/status.c        |  9 +++-
 net/mac80211/tdls.c          |  2 +-
 net/mac80211/tx.c            | 80 +++++++++++++++++++++++++++---------
 net/wireless/nl80211.c       | 30 +++++++++++---
 net/wireless/rdev-ops.h      |  5 ++-
 net/wireless/trace.h         | 17 ++++++++
 9 files changed, 145 insertions(+), 28 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d3d18481f6da..0f8bbd6579c1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7023,6 +7023,23 @@ bool cfg80211_rx_mgmt(struct wireless_dev *wdev, int freq, int sig_dbm,
 void cfg80211_mgmt_tx_status(struct wireless_dev *wdev, u64 cookie,
 			     const u8 *buf, size_t len, bool ack, gfp_t gfp);
 
+/**
+ * cfg80211_control_port_tx_status - notification of TX status for control
+ *                                   port frames
+ * @wdev: wireless device receiving the frame
+ * @cookie: Cookie returned by cfg80211_ops::tx_control_port()
+ * @buf: Data frame (header + body)
+ * @len: length of the frame data
+ * @ack: Whether frame was acknowledged
+ * @gfp: context flags
+ *
+ * This function is called whenever a control port frame was requested to be
+ * transmitted with cfg80211_ops::tx_control_port() to report the TX status of
+ * the transmission attempt.
+ */
+void cfg80211_control_port_tx_status(struct wireless_dev *wdev, u64 cookie,
+				     const u8 *buf, size_t len, bool ack,
+				     gfp_t gfp);
 
 /**
  * cfg80211_rx_control_port - notification about a received control port frame
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9679d561f7d0..e3b7a911b35c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1160,6 +1160,12 @@
  *	dropped because it did not include a valid MME MIC while beacon
  *	protection was enabled (BIGTK configured in station mode).
  *
+ * @NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS: Report TX status of a control
+ *	port frame transmitted with %NL80211_CMD_CONTROL_PORT_FRAME.
+ *	%NL80211_ATTR_COOKIE identifies the TX command and %NL80211_ATTR_FRAME
+ *	includes the contents of the frame. %NL80211_ATTR_ACK flag is included
+ *	if the recipient acknowledged the frame.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1388,6 +1394,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_UNPROT_BEACON,
 
+	NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 4f6432c7e150..32ecb1b34371 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1407,6 +1407,8 @@ struct ieee80211_local {
 	struct idr ack_status_frames;
 	spinlock_t ack_status_lock;
 
+	u64 ctrl_port_cookie_counter;
+
 	struct ieee80211_sub_if_data __rcu *p2p_sdata;
 
 	/* virtual monitor interface */
@@ -1783,7 +1785,8 @@ netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 				  struct net_device *dev,
 				  u32 info_flags,
-				  u32 ctrl_flags);
+				  u32 ctrl_flags,
+				  u64 *cookie);
 void ieee80211_purge_tx_queue(struct ieee80211_hw *hw,
 			      struct sk_buff_head *skbs);
 struct sk_buff *
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
index ba34cc392ea8..092f282a6a5c 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2436,13 +2436,33 @@ int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
-static int ieee80211_store_ack_skb(struct ieee80211_local *local,
+static u64 ieee80211_ctrl_port_tx_cookie(struct ieee80211_local *local)
+{
+	lockdep_assert_held(&local->mtx);
+
+	local->ctrl_port_cookie_counter++;
+
+	/* wow, you wrapped 64 bits ... more likely a bug */
+	if (WARN_ON(local->ctrl_port_cookie_counter == 0))
+		local->ctrl_port_cookie_counter++;
+
+	return local->ctrl_port_cookie_counter;
+}
+
+static u16 ieee80211_store_ack_skb(struct ieee80211_local *local,
 				   struct sk_buff *skb,
-				   u32 *info_flags)
+				   u32 *info_flags,
+				   bool use_socket,
+				   u64 *cookie)
 {
-	struct sk_buff *ack_skb = skb_clone_sk(skb);
+	struct sk_buff *ack_skb;
 	u16 info_id = 0;
 
+	if (use_socket)
+		ack_skb = skb_clone_sk(skb);
+	else
+		ack_skb = skb_clone(skb, GFP_ATOMIC);
+
 	if (ack_skb) {
 		unsigned long flags;
 		int id;
@@ -2455,6 +2475,10 @@ static int ieee80211_store_ack_skb(struct ieee80211_local *local,
 		if (id >= 0) {
 			info_id = id;
 			*info_flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+			if (cookie) {
+				*cookie = ieee80211_ctrl_port_tx_cookie(local);
+				IEEE80211_SKB_CB(ack_skb)->ack.cookie = *cookie;
+			}
 		} else {
 			kfree_skb(ack_skb);
 		}
@@ -2484,7 +2508,8 @@ static int ieee80211_store_ack_skb(struct ieee80211_local *local,
  */
 static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 					   struct sk_buff *skb, u32 info_flags,
-					   struct sta_info *sta, u32 ctrl_flags)
+					   struct sta_info *sta, u32 ctrl_flags,
+					   u64 *cookie)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_tx_info *info;
@@ -2757,7 +2782,12 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 
 	if (unlikely(!multicast && skb->sk &&
 		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS))
-		info_id = ieee80211_store_ack_skb(local, skb, &info_flags);
+		info_id = ieee80211_store_ack_skb(local, skb, &info_flags,
+						  true, NULL);
+
+	if (unlikely(!multicast && ctrl_flags & IEEE80211_TX_CTL_REQ_TX_STATUS))
+		info_id = ieee80211_store_ack_skb(local, skb, &info_flags,
+						  false, cookie);
 
 	/*
 	 * If the skb is shared we need to obtain our own copy.
@@ -2765,8 +2795,9 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 	if (skb_shared(skb)) {
 		struct sk_buff *tmp_skb = skb;
 
-		/* can't happen -- skb is a clone if info_id != 0 */
-		WARN_ON(info_id);
+		if (!(ctrl_flags & IEEE80211_TX_CTL_REQ_TX_STATUS))
+			/* can't happen -- skb is a clone if info_id != 0 */
+			WARN_ON(info_id);
 
 		skb = skb_clone(skb, GFP_ATOMIC);
 		kfree_skb(tmp_skb);
@@ -3913,7 +3944,8 @@ EXPORT_SYMBOL(ieee80211_txq_schedule_start);
 void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 				  struct net_device *dev,
 				  u32 info_flags,
-				  u32 ctrl_flags)
+				  u32 ctrl_flags,
+				  u64 *cookie)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
@@ -3983,7 +4015,7 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 		skb_mark_not_on_list(skb);
 
 		skb = ieee80211_build_hdr(sdata, skb, info_flags,
-					  sta, ctrl_flags);
+					  sta, ctrl_flags, cookie);
 		if (IS_ERR(skb)) {
 			kfree_skb_list(next);
 			goto out;
@@ -4125,9 +4157,9 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
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
@@ -4215,7 +4247,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 
 	if (unlikely(!multicast && skb->sk &&
 		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS))
-		ieee80211_store_ack_skb(local, skb, &info->flags);
+		ieee80211_store_ack_skb(local, skb, &info->flags, true, NULL);
 
 	memset(info, 0, sizeof(*info));
 
@@ -4299,7 +4331,7 @@ ieee80211_build_data_template(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
-	skb = ieee80211_build_hdr(sdata, skb, info_flags, sta, 0);
+	skb = ieee80211_build_hdr(sdata, skb, info_flags, sta, 0, NULL);
 	if (IS_ERR(skb))
 		goto out;
 
@@ -5347,7 +5379,7 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	struct sk_buff *skb;
 	struct ethhdr *ehdr;
 	u32 ctrl_flags = 0;
-	u32 flags;
+	u32 flags = 0;
 
 	/* Only accept CONTROL_PORT_PROTOCOL configured in CONNECT/ASSOCIATE
 	 * or Pre-Authentication
@@ -5360,9 +5392,13 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
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
@@ -5383,10 +5419,15 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
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
 
@@ -5413,7 +5454,8 @@ int ieee80211_probe_mesh_link(struct wiphy *wiphy, struct net_device *dev,
 
 	local_bh_disable();
 	__ieee80211_subif_start_xmit(skb, skb->dev, 0,
-				     IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP);
+				     IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP,
+				     NULL);
 	local_bh_enable();
 
 	return 0;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4fe232a51078..ad5f43cad1f3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16308,8 +16308,9 @@ int nl80211_send_mgmt(struct cfg80211_registered_device *rdev,
 	return -ENOBUFS;
 }
 
-void cfg80211_mgmt_tx_status(struct wireless_dev *wdev, u64 cookie,
-			     const u8 *buf, size_t len, bool ack, gfp_t gfp)
+static void nl80211_frame_tx_status(struct wireless_dev *wdev, u64 cookie,
+				    const u8 *buf, size_t len, bool ack,
+				    gfp_t gfp, enum nl80211_commands command)
 {
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
@@ -16317,13 +16318,16 @@ void cfg80211_mgmt_tx_status(struct wireless_dev *wdev, u64 cookie,
 	struct sk_buff *msg;
 	void *hdr;
 
-	trace_cfg80211_mgmt_tx_status(wdev, cookie, ack);
+	if (command == NL80211_CMD_FRAME_TX_STATUS)
+		trace_cfg80211_mgmt_tx_status(wdev, cookie, ack);
+	else
+		trace_cfg80211_control_port_tx_status(wdev, cookie, ack);
 
 	msg = nlmsg_new(100 + len, gfp);
 	if (!msg)
 		return;
 
-	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_FRAME_TX_STATUS);
+	hdr = nl80211hdr_put(msg, 0, 0, 0, command);
 	if (!hdr) {
 		nlmsg_free(msg);
 		return;
@@ -16346,9 +16350,25 @@ void cfg80211_mgmt_tx_status(struct wireless_dev *wdev, u64 cookie,
 				NL80211_MCGRP_MLME, gfp);
 	return;
 
- nla_put_failure:
+nla_put_failure:
 	nlmsg_free(msg);
 }
+
+void cfg80211_control_port_tx_status(struct wireless_dev *wdev, u64 cookie,
+				     const u8 *buf, size_t len, bool ack,
+				     gfp_t gfp)
+{
+	nl80211_frame_tx_status(wdev, cookie, buf, len, ack, gfp,
+				NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS);
+}
+EXPORT_SYMBOL(cfg80211_control_port_tx_status);
+
+void cfg80211_mgmt_tx_status(struct wireless_dev *wdev, u64 cookie,
+			     const u8 *buf, size_t len, bool ack, gfp_t gfp)
+{
+	nl80211_frame_tx_status(wdev, cookie, buf, len, ack, gfp,
+				NL80211_CMD_FRAME_TX_STATUS);
+}
 EXPORT_SYMBOL(cfg80211_mgmt_tx_status);
 
 static int __nl80211_rx_control_port(struct net_device *dev,
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 63b5786572d0..950d57494168 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -755,7 +755,10 @@ static inline int rdev_tx_control_port(struct cfg80211_registered_device *rdev,
 				   dest, proto, noencrypt);
 	ret = rdev->ops->tx_control_port(&rdev->wiphy, dev, buf, len,
 					 dest, proto, noencrypt, cookie);
-	trace_rdev_return_int(&rdev->wiphy, ret);
+	if (cookie)
+		trace_rdev_return_int_cookie(&rdev->wiphy, ret, *cookie);
+	else
+		trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
 
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 53c887ea67c7..b9b28af1ac71 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2861,6 +2861,23 @@ TRACE_EVENT(cfg80211_mgmt_tx_status,
 		  WDEV_PR_ARG, __entry->cookie, BOOL_TO_STR(__entry->ack))
 );
 
+TRACE_EVENT(cfg80211_control_port_tx_status,
+	TP_PROTO(struct wireless_dev *wdev, u64 cookie, bool ack),
+	TP_ARGS(wdev, cookie, ack),
+	TP_STRUCT__entry(
+		WDEV_ENTRY
+		__field(u64, cookie)
+		__field(bool, ack)
+	),
+	TP_fast_assign(
+		WDEV_ASSIGN;
+		__entry->cookie = cookie;
+		__entry->ack = ack;
+	),
+	TP_printk(WDEV_PR_FMT", cookie: %llu, ack: %s",
+		  WDEV_PR_ARG, __entry->cookie, BOOL_TO_STR(__entry->ack))
+);
+
 TRACE_EVENT(cfg80211_rx_control_port,
 	TP_PROTO(struct net_device *netdev, struct sk_buff *skb,
 		 bool unencrypted),
-- 
2.26.2

