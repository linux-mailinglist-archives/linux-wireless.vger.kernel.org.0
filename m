Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87DF31611F8
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2020 13:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgBQMZK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Feb 2020 07:25:10 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:38607 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbgBQMZK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Feb 2020 07:25:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581942308; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=PubddDTv0Oz49cIff6Vgs51YJJ7po7XMeCIDwtFVw+4=; b=bUUPn+B+YuMr7FBZt4PBjxceVjyTk+qCKiUWQSvL8G/mRhq0wM+ENZKbRf6grKmr2uji5F5N
 Q5WUnO/nTSpooRwFLsU/0BYN0fnsOyH4JAo/E/zBxyANL0sPVodHQW/BYF+ahDfqOZED4CE+
 Nhwyj1yulwzNPWyOwlXa0WRx4v8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4a8624.7fe2f54a8420-smtp-out-n01;
 Mon, 17 Feb 2020 12:25:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 48FCAC4479C; Mon, 17 Feb 2020 12:25:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mpubbise)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C226EC43383;
        Mon, 17 Feb 2020 12:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C226EC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mpubbise@codeaurora.org
From:   Manikanta Pubbisetty <mpubbise@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>
Subject: [RFC 1/2] mac80211: add receive path for ethernet frame format
Date:   Mon, 17 Feb 2020 17:54:36 +0530
Message-Id: <1581942277-585-2-git-send-email-mpubbise@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581942277-585-1-git-send-email-mpubbise@codeaurora.org>
References: <1581942277-585-1-git-send-email-mpubbise@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>

Implement rx path which does fewer processing on the received data
frame which has already gone through 802.11 header decapsulation
and other functionalities which require 802.11 header in the low
level driver or hardware. Currently this rx path is restricted
to AP and STA mode, but can be extended for Adhoc mode as well.

It is upto to the low level driver to invoke the correct API and
make sure if the frame that it passes is in ethernet format and
the sta pointer is valid.

Co-developed-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
---
 include/net/mac80211.h |  20 +++++
 net/mac80211/rx.c      | 215 +++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 230 insertions(+), 5 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ce80773..5959058 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1251,6 +1251,9 @@ ieee80211_tx_info_clear_status(struct ieee80211_tx_info *info)
  *	the "0-length PSDU" field included there.  The value for it is
  *	in &struct ieee80211_rx_status.  Note that if this value isn't
  *	known the frame shouldn't be reported.
+ * @RX_FLAG_80211_MCAST: If the receiver address (addr1) in the frame is
+ *	multicast. This is used with the data frames by the drivers
+ *	supporting 802.11 hdr decap offload.
  */
 enum mac80211_rx_flags {
 	RX_FLAG_MMIC_ERROR		= BIT(0),
@@ -1283,6 +1286,7 @@ enum mac80211_rx_flags {
 	RX_FLAG_RADIOTAP_HE_MU		= BIT(27),
 	RX_FLAG_RADIOTAP_LSIG		= BIT(28),
 	RX_FLAG_NO_PSDU			= BIT(29),
+	RX_FLAG_80211_MCAST		= BIT(30),
 };
 
 /**
@@ -4402,6 +4406,22 @@ static inline void ieee80211_rx_ni(struct ieee80211_hw *hw,
 }
 
 /**
+ * ieee80211_rx_decap_offl - Receive frames in 802.11 decapsulated format
+ *
+ * Low level driver capable of 802.11 header decap uses this function. The frame
+ * will be in ethernet format.
+ * This function may not be called in IRQ context. Calls to this function
+ * for a single hardware must be synchronized against each other.
+ *
+ * @hw: the hardware this frame came in on
+ * @sta : the station the frame was received from, must not be %NULL
+ * @skb: the buffer to receive, owned by mac80211 after this call
+ * @napi: the NAPI context
+ */
+void ieee80211_rx_decap_offl(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
+			     struct sk_buff *skb, struct napi_struct *napi);
+
+/**
  * ieee80211_sta_ps_transition - PS transition for connected sta
  *
  * When operating in AP mode with the %IEEE80211_HW_AP_LINK_PS
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index ec3a04a..78f2f71 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2410,13 +2410,14 @@ __ieee80211_data_to_8023(struct ieee80211_rx_data *rx, bool *port_control)
 	return 0;
 }
 
+static const u8 pae_group_addr[ETH_ALEN] __aligned(2) = {0x01, 0x80, 0xC2, 0x00,
+							 0x00, 0x03};
+
 /*
  * requires that rx->skb is a frame with ethernet header
  */
 static bool ieee80211_frame_allowed(struct ieee80211_rx_data *rx, __le16 fc)
 {
-	static const u8 pae_group_addr[ETH_ALEN] __aligned(2)
-		= { 0x01, 0x80, 0xC2, 0x00, 0x00, 0x03 };
 	struct ethhdr *ehdr = (struct ethhdr *) rx->skb->data;
 
 	/*
@@ -2471,6 +2472,7 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
 	struct sk_buff *skb, *xmit_skb;
 	struct ethhdr *ehdr = (struct ethhdr *) rx->skb->data;
 	struct sta_info *dsta;
+	struct ieee80211_sta_rx_stats *rx_stats;
 
 	skb = rx->skb;
 	xmit_skb = NULL;
@@ -2483,9 +2485,12 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
 		 * for non-QoS-data frames. Here we know it's a data
 		 * frame, so count MSDUs.
 		 */
-		u64_stats_update_begin(&rx->sta->rx_stats.syncp);
-		rx->sta->rx_stats.msdu[rx->seqno_idx]++;
-		u64_stats_update_end(&rx->sta->rx_stats.syncp);
+		rx_stats = &rx->sta->rx_stats;
+		if (ieee80211_hw_check(&rx->local->hw, USES_RSS))
+			rx_stats = this_cpu_ptr(rx->sta->pcpu_rx_stats);
+		u64_stats_update_begin(&rx_stats->syncp);
+		rx_stats->msdu[rx->seqno_idx]++;
+		u64_stats_update_end(&rx_stats->syncp);
 	}
 
 	if ((sdata->vif.type == NL80211_IFTYPE_AP ||
@@ -4658,3 +4663,203 @@ void ieee80211_rx_irqsafe(struct ieee80211_hw *hw, struct sk_buff *skb)
 	tasklet_schedule(&local->tasklet);
 }
 EXPORT_SYMBOL(ieee80211_rx_irqsafe);
+
+/* Receive path for decap offloaded data frames */
+
+static void
+ieee80211_rx_handle_decap_offl(struct ieee80211_sub_if_data *sdata,
+			       struct sta_info *sta, struct sk_buff *skb,
+			       struct napi_struct *napi)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_vif *vif = &sdata->vif;
+	struct net_device *dev = sdata->dev;
+	struct ieee80211_rx_status *status;
+	struct ieee80211_key *key = NULL;
+	struct ieee80211_rx_data rx;
+	int i;
+	struct ethhdr *ehdr;
+	struct ieee80211_sta_rx_stats *stats = &sta->rx_stats;
+
+	ehdr = (struct ethhdr *)skb->data;
+	status = IEEE80211_SKB_RXCB(skb);
+
+	if (ieee80211_hw_check(&local->hw, USES_RSS))
+		stats = this_cpu_ptr(sta->pcpu_rx_stats);
+
+	/* TODO: Extend ieee80211_rx_decap_offl() with bssid so that Ethernet
+	 * encap/decap can be supported in Adhoc interface type as well.
+	 * Adhoc interface depends on bssid to update last_rx.
+	 */
+	if (vif->type != NL80211_IFTYPE_STATION &&
+	    vif->type != NL80211_IFTYPE_AP_VLAN &&
+	    vif->type != NL80211_IFTYPE_AP)
+		goto drop;
+
+	if (unlikely(!test_sta_flag(sta, WLAN_STA_AUTHORIZED))) {
+		if (ehdr->h_proto != sdata->control_port_protocol)
+			goto drop;
+		else if (!ether_addr_equal(ehdr->h_dest, vif->addr) &&
+			 !ether_addr_equal(ehdr->h_dest, pae_group_addr))
+			goto drop;
+	}
+
+	if (status->flag & RX_FLAG_80211_MCAST) {
+		for (i = 0; i < NUM_DEFAULT_KEYS; i++) {
+			key = rcu_dereference(sta->gtk[i]);
+			if (key)
+				break;
+		}
+	} else {
+		key = rcu_dereference(sta->ptk[sta->ptk_idx]);
+	}
+
+	if (key && unlikely(key->flags & KEY_FLAG_TAINTED))
+		goto drop;
+
+	if (status->flag & RX_FLAG_MMIC_ERROR) {
+		if (key)
+			key->u.tkip.mic_failures++;
+		goto mic_fail;
+	}
+
+#define ETH_RX_CRYPT_FLAGS	(RX_FLAG_PN_VALIDATED | RX_FLAG_DECRYPTED)
+
+	if (key && (status->flag & ETH_RX_CRYPT_FLAGS) != ETH_RX_CRYPT_FLAGS)
+		goto drop;
+
+	if (!(status->flag & RX_FLAG_DUP_VALIDATED))
+		goto drop;
+
+	I802_DEBUG_INC(local->dot11ReceivedFragmentCount);
+
+	if (!(status->flag & RX_FLAG_80211_MCAST)) {
+		stats->last_rx = jiffies;
+		stats->last_rate = sta_stats_encode_rate(status);
+	}
+
+	if (sdata->vif.type == NL80211_IFTYPE_STATION &&
+	    !(status->flag & RX_FLAG_80211_MCAST))
+		ieee80211_sta_reset_conn_monitor(sdata);
+
+	u64_stats_update_begin(&stats->syncp);
+	stats->fragments++;
+	stats->packets++;
+	stats->bytes += skb->len;
+	u64_stats_update_end(&stats->syncp);
+
+	if (!(status->flag & RX_FLAG_NO_SIGNAL_VAL)) {
+		stats->last_signal = status->signal;
+		if (!ieee80211_hw_check(&local->hw, USES_RSS))
+			ewma_signal_add(&sta->rx_stats_avg.signal,
+					-status->signal);
+	}
+
+	if (status->chains) {
+		stats->chains = status->chains;
+		for (i = 0; i < ARRAY_SIZE(status->chain_signal); i++) {
+			int signal = status->chain_signal[i];
+
+			if (!(status->chains & BIT(i)))
+				continue;
+
+			stats->chain_signal_last[i] = signal;
+			if (!ieee80211_hw_check(&local->hw, USES_RSS))
+				ewma_signal_add(&sta->rx_stats_avg.chain_signal[i],
+						-signal);
+		}
+	}
+
+	if (unlikely(ehdr->h_proto == cpu_to_be16(ETH_P_TDLS))) {
+		struct ieee80211_tdls_data *tf = (void *)skb->data;
+
+		if (pskb_may_pull(skb,
+				  offsetof(struct ieee80211_tdls_data, u)) &&
+		    tf->payload_type == WLAN_TDLS_SNAP_RFTYPE &&
+		    tf->category == WLAN_CATEGORY_TDLS &&
+		    (tf->action_code == WLAN_TDLS_CHANNEL_SWITCH_REQUEST ||
+		     tf->action_code == WLAN_TDLS_CHANNEL_SWITCH_RESPONSE)) {
+			skb_queue_tail(&local->skb_queue_tdls_chsw, skb);
+			schedule_work(&local->tdls_chsw_work);
+			return;
+		}
+	}
+
+	memset(&rx, 0, sizeof(rx));
+	rx.skb = skb;
+	rx.sdata = sdata;
+	rx.local = local;
+	rx.sta = sta;
+	rx.napi = napi;
+
+	if (vif->type == NL80211_IFTYPE_AP_VLAN && sdata->bss &&
+	    unlikely(ehdr->h_proto == sdata->control_port_protocol)) {
+		sdata = container_of(sdata->bss, struct ieee80211_sub_if_data,
+				     u.ap);
+		dev = sdata->dev;
+		rx.sdata = sdata;
+	}
+
+	rx.skb->dev = dev;
+
+	/* FIXME: Since rx.seqno_idx is not available for decap offloaded frames
+	 * rx msdu stats update at the seqno_idx in ieee80211_deliver_skb()
+	 * will always be updated at index 0 and will not be very useful.
+	 * Should we disable these statistics in the case of decap offload?
+	 */
+	ieee80211_deliver_skb(&rx);
+
+	return;
+
+mic_fail:
+
+	cfg80211_michael_mic_failure(sdata->dev, sta->addr,
+				     is_multicast_ether_addr(ehdr->h_dest) ?
+				     NL80211_KEYTYPE_GROUP :
+				     NL80211_KEYTYPE_PAIRWISE,
+				     key ? key->conf.keyidx : -1,
+				     NULL, GFP_ATOMIC);
+
+drop:
+	stats->dropped++;
+	dev_kfree_skb(skb);
+}
+
+/* Receive path handler that a low level driver supporting 802.11 hdr decap
+ * offload can call. The frame is in ethernet format and the assumption is
+ * all necessary operations like decryption, defrag, deaggregation, etc.
+ * requiring 802.11 headers are already performed in the low level driver
+ * or hardware.
+ */
+void ieee80211_rx_decap_offl(struct ieee80211_hw *hw,
+			     struct ieee80211_sta *pubsta, struct sk_buff *skb,
+			     struct napi_struct *napi)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct sta_info *sta;
+
+	if (unlikely(local->quiescing || local->suspended))
+		goto drop;
+
+	if (unlikely(local->in_reconfig))
+		goto drop;
+
+	if (WARN_ON(!local->started))
+		goto drop;
+
+	if (!pubsta)
+		goto drop;
+
+	sta  = container_of(pubsta, struct sta_info, sta);
+
+	/* TODO: Toggle Rx throughput LED */
+
+	rcu_read_lock();
+	ieee80211_rx_handle_decap_offl(sta->sdata, sta, skb, napi);
+	rcu_read_unlock();
+
+	return;
+drop:
+	kfree_skb(skb);
+}
+EXPORT_SYMBOL(ieee80211_rx_decap_offl);
-- 
2.7.4
