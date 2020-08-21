Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A881524CC90
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 06:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgHUEUU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 00:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgHUEUG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 00:20:06 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139EFC061342
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 21:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8jQwOqOjROEx2njvBUDkqeNOBu4xvvtnhSBXR7qe8sg=; b=gcKMlU/XqAZG4ftHbVr3gPBtsB
        4kG86h9yLFYGiQ0F84xLEnrjGMfPOXH8LI9ELBVuxA66Fl7kxIKPx0vakto402iUkeucrcFNZ9E7O
        b0sG4JWa8r1W37dgqpgldhLuzdWTHH9FnZ6b2zgdevLyZ/V1DMBDwi+c1x1ANHevjul0=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k8yX6-0005s7-L7; Fri, 21 Aug 2020 06:20:04 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v2 05/13] mac80211: swap NEED_TXPROCESSING and HW_80211_ENCAP tx flags
Date:   Fri, 21 Aug 2020 06:19:53 +0200
Message-Id: <20200821042001.23388-6-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821042001.23388-1-nbd@nbd.name>
References: <20200821042001.23388-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to unify the tx status path, the hw 802.11 encapsulation flag
needs to survive the trip to the tx status call.
Since we don't have any free bits in info->flags, we need to move one.
IEEE80211_TX_INTFL_NEED_TXPROCESSING is only used internally in mac80211,
and only before the call into the driver.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c |  4 ++--
 drivers/net/wireless/ath/ath11k/mac.c   |  4 ++--
 include/net/mac80211.h                  | 14 +++++++-------
 net/mac80211/mesh_hwmp.c                |  4 ++--
 net/mac80211/mesh_ps.c                  |  2 +-
 net/mac80211/rx.c                       |  2 +-
 net/mac80211/status.c                   |  4 ++--
 net/mac80211/tx.c                       | 16 ++++++++--------
 8 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 1af76775b1a8..1c00bd4aea0c 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -14,7 +14,7 @@ ath11k_dp_tx_get_encap_type(struct ath11k_vif *arvif, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
 
-	if (tx_info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP)
+	if (tx_info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)
 		return HAL_TCL_ENCAP_TYPE_ETHERNET;
 
 	return HAL_TCL_ENCAP_TYPE_NATIVE_WIFI;
@@ -93,7 +93,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	if (test_bit(ATH11K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
 		return -ESHUTDOWN;
 
-	if (!(info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP) &&
+	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
 	    !ieee80211_is_data(hdr->frame_control))
 		return -ENOTSUPP;
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c100ac6298ce..4c4ab40bde8f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3898,7 +3898,7 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
 		return -ENOSPC;
 
 	info = IEEE80211_SKB_CB(skb);
-	if (!(info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP)) {
+	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)) {
 		if ((ieee80211_is_action(hdr->frame_control) ||
 		     ieee80211_is_deauth(hdr->frame_control) ||
 		     ieee80211_is_disassoc(hdr->frame_control)) &&
@@ -4025,7 +4025,7 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 	bool is_prb_rsp;
 	int ret;
 
-	if (info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP) {
+	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
 		skb_cb->flags |= ATH11K_SKB_HW_80211_ENCAP;
 	} else if (ieee80211_is_mgmt(hdr->frame_control)) {
 		is_prb_rsp = ieee80211_is_probe_resp(hdr->frame_control);
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d635f530300d..0cd8dbe4e688 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -720,9 +720,8 @@ struct ieee80211_bss_conf {
  * @IEEE80211_TX_INTFL_OFFCHAN_TX_OK: Internal to mac80211. Used to indicate
  *	that a frame can be transmitted while the queues are stopped for
  *	off-channel operation.
- * @IEEE80211_TX_INTFL_NEED_TXPROCESSING: completely internal to mac80211,
- *	used to indicate that a pending frame requires TX processing before
- *	it can be sent out.
+ * @IEEE80211_TX_CTL_HW_80211_ENCAP: This frame uses hardware encapsulation
+ *	(header conversion)
  * @IEEE80211_TX_INTFL_RETRIED: completely internal to mac80211,
  *	used to indicate that a frame was already retried due to PS
  * @IEEE80211_TX_INTFL_DONT_ENCRYPT: completely internal to mac80211,
@@ -791,7 +790,7 @@ enum mac80211_tx_info_flags {
 	IEEE80211_TX_STAT_AMPDU_NO_BACK		= BIT(11),
 	IEEE80211_TX_CTL_RATE_CTRL_PROBE	= BIT(12),
 	IEEE80211_TX_INTFL_OFFCHAN_TX_OK	= BIT(13),
-	IEEE80211_TX_INTFL_NEED_TXPROCESSING	= BIT(14),
+	IEEE80211_TX_CTL_HW_80211_ENCAP		= BIT(14),
 	IEEE80211_TX_INTFL_RETRIED		= BIT(15),
 	IEEE80211_TX_INTFL_DONT_ENCRYPT		= BIT(16),
 	IEEE80211_TX_CTL_NO_PS_BUFFER		= BIT(17),
@@ -823,8 +822,9 @@ enum mac80211_tx_info_flags {
  * @IEEE80211_TX_CTRL_AMSDU: This frame is an A-MSDU frame
  * @IEEE80211_TX_CTRL_FAST_XMIT: This frame is going through the fast_xmit path
  * @IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP: This frame skips mesh path lookup
- * @IEEE80211_TX_CTRL_HW_80211_ENCAP: This frame uses hardware encapsulation
- *	(header conversion)
+ * @IEEE80211_TX_INTCFL_NEED_TXPROCESSING: completely internal to mac80211,
+ *	used to indicate that a pending frame requires TX processing before
+ *	it can be sent out.
  * @IEEE80211_TX_CTRL_NO_SEQNO: Do not overwrite the sequence number that
  *	has already been assigned to this frame.
  *
@@ -837,7 +837,7 @@ enum mac80211_tx_control_flags {
 	IEEE80211_TX_CTRL_AMSDU			= BIT(3),
 	IEEE80211_TX_CTRL_FAST_XMIT		= BIT(4),
 	IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP	= BIT(5),
-	IEEE80211_TX_CTRL_HW_80211_ENCAP	= BIT(6),
+	IEEE80211_TX_INTCFL_NEED_TXPROCESSING	= BIT(6),
 	IEEE80211_TX_CTRL_NO_SEQNO		= BIT(7),
 };
 
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index bec23d2eee7a..313eee12410e 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -212,7 +212,7 @@ static void prepare_frame_for_deferred_tx(struct ieee80211_sub_if_data *sdata,
 	skb->priority = 7;
 
 	info->control.vif = &sdata->vif;
-	info->flags |= IEEE80211_TX_INTFL_NEED_TXPROCESSING;
+	info->control.flags |= IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
 	ieee80211_set_qos_hdr(sdata, skb);
 	ieee80211_mps_set_frame_flags(sdata, NULL, hdr);
 }
@@ -1163,7 +1163,7 @@ int mesh_nexthop_resolve(struct ieee80211_sub_if_data *sdata,
 	if (skb_queue_len(&mpath->frame_queue) >= MESH_FRAME_QUEUE_LEN)
 		skb_to_free = skb_dequeue(&mpath->frame_queue);
 
-	info->flags |= IEEE80211_TX_INTFL_NEED_TXPROCESSING;
+	info->control.flags |= IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
 	ieee80211_set_qos_hdr(sdata, skb);
 	skb_queue_tail(&mpath->frame_queue, skb);
 	if (skb_to_free)
diff --git a/net/mac80211/mesh_ps.c b/net/mac80211/mesh_ps.c
index 031e905f684a..76d19c09d26e 100644
--- a/net/mac80211/mesh_ps.c
+++ b/net/mac80211/mesh_ps.c
@@ -432,7 +432,7 @@ static void mpsp_qos_null_append(struct sta_info *sta,
 
 	info = IEEE80211_SKB_CB(new_skb);
 	info->control.vif = &sdata->vif;
-	info->flags |= IEEE80211_TX_INTFL_NEED_TXPROCESSING;
+	info->control.flags |= IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
 
 	__skb_queue_tail(frames, new_skb);
 }
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index bd8c15a65a16..b04d6e01a346 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2896,7 +2896,7 @@ ieee80211_rx_h_mesh_fwding(struct ieee80211_rx_data *rx)
 	fwd_hdr->frame_control &= ~cpu_to_le16(IEEE80211_FCTL_RETRY);
 	info = IEEE80211_SKB_CB(fwd_skb);
 	memset(info, 0, sizeof(*info));
-	info->flags |= IEEE80211_TX_INTFL_NEED_TXPROCESSING;
+	info->control.flags |= IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
 	info->control.vif = &rx->sdata->vif;
 	info->control.jiffies = jiffies;
 	if (is_multicast_ether_addr(fwd_hdr->addr1)) {
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 28ab29a5694d..c873910d95e0 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -66,8 +66,8 @@ static void ieee80211_handle_filtered_frame(struct ieee80211_local *local,
 
 	info->control.jiffies = jiffies;
 	info->control.vif = &sta->sdata->vif;
-	info->flags |= IEEE80211_TX_INTFL_NEED_TXPROCESSING |
-		       IEEE80211_TX_INTFL_RETRANSMISSION;
+	info->control.flags |= IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
+	info->flags |= IEEE80211_TX_INTFL_RETRANSMISSION;
 	info->flags &= ~IEEE80211_TX_TEMPORARY_FLAGS;
 
 	sta->status_stats.filtered++;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 607dd1e97274..518a1ed4f088 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -531,7 +531,7 @@ ieee80211_tx_h_unicast_ps_buf(struct ieee80211_tx_data *tx)
 
 		info->control.jiffies = jiffies;
 		info->control.vif = &tx->sdata->vif;
-		info->flags |= IEEE80211_TX_INTFL_NEED_TXPROCESSING;
+		info->control.flags |= IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
 		info->flags &= ~IEEE80211_TX_TEMPORARY_FLAGS;
 		skb_queue_tail(&sta->ps_tx_buf[ac], tx->skb);
 		spin_unlock(&sta->ps_lock);
@@ -1134,7 +1134,7 @@ static bool ieee80211_tx_prep_agg(struct ieee80211_tx_data *tx,
 				       tx->sta->sta.addr, tx->sta->sta.aid);
 			}
 			info->control.vif = &tx->sdata->vif;
-			info->flags |= IEEE80211_TX_INTFL_NEED_TXPROCESSING;
+			info->control.flags |= IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
 			info->flags &= ~IEEE80211_TX_TEMPORARY_FLAGS;
 			__skb_queue_tail(&tid_tx->pending, skb);
 			if (skb_queue_len(&tid_tx->pending) > STA_MAX_TX_BUFFER)
@@ -1179,7 +1179,7 @@ ieee80211_tx_prepare(struct ieee80211_sub_if_data *sdata,
 	 * we are doing the needed processing, so remove the flag
 	 * now.
 	 */
-	info->flags &= ~IEEE80211_TX_INTFL_NEED_TXPROCESSING;
+	info->control.flags &= ~IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
 
 	hdr = (struct ieee80211_hdr *) skb->data;
 
@@ -1258,7 +1258,7 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
 	    (info->control.flags & IEEE80211_TX_CTRL_PS_RESPONSE))
 		return NULL;
 
-	if (!(info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP) &&
+	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
 	    unlikely(!ieee80211_is_data_present(hdr->frame_control))) {
 		if ((!ieee80211_is_mgmt(hdr->frame_control) ||
 		     ieee80211_is_bufferable_mmpdu(hdr->frame_control) ||
@@ -3649,7 +3649,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	else
 		info->flags &= ~IEEE80211_TX_CTL_AMPDU;
 
-	if (info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP)
+	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)
 		goto encap_out;
 
 	if (info->control.flags & IEEE80211_TX_CTRL_FAST_XMIT) {
@@ -4256,7 +4256,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 		sdata = container_of(sdata->bss,
 				     struct ieee80211_sub_if_data, u.ap);
 
-	info->control.flags |= IEEE80211_TX_CTRL_HW_80211_ENCAP;
+	info->flags |= IEEE80211_TX_CTL_HW_80211_ENCAP;
 	info->control.vif = &sdata->vif;
 
 	ieee80211_tx_8023(sdata, skb, skb->len, sta, false);
@@ -4360,7 +4360,7 @@ static bool ieee80211_tx_pending_skb(struct ieee80211_local *local,
 
 	sdata = vif_to_sdata(info->control.vif);
 
-	if (info->flags & IEEE80211_TX_INTFL_NEED_TXPROCESSING) {
+	if (info->control.flags & IEEE80211_TX_INTCFL_NEED_TXPROCESSING) {
 		chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
 		if (unlikely(!chanctx_conf)) {
 			dev_kfree_skb(skb);
@@ -4368,7 +4368,7 @@ static bool ieee80211_tx_pending_skb(struct ieee80211_local *local,
 		}
 		info->band = chanctx_conf->def.chan->band;
 		result = ieee80211_tx(sdata, NULL, skb, true);
-	} else if (info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP) {
+	} else if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
 		if (ieee80211_lookup_ra_sta(sdata, skb, &sta)) {
 			dev_kfree_skb(skb);
 			return true;
-- 
2.28.0

