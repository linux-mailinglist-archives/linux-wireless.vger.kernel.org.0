Return-Path: <linux-wireless+bounces-34361-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLLcC7D20WkkRwcAu9opvQ
	(envelope-from <linux-wireless+bounces-34361-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Apr 2026 07:44:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE17039D6E2
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Apr 2026 07:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0553F3006D61
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Apr 2026 05:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398FF35CB66;
	Sun,  5 Apr 2026 05:44:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A01635AC16;
	Sun,  5 Apr 2026 05:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775367846; cv=none; b=LPj56YKiih4Ypn3pZLrktTk9svxKajpbjjNdCnMnf6FjSX2vbVwxL9ceyFhxiCxU769w4sjIky7P/W5CmorSyk+7J+VTquZuepwGQWxLNiSr0knk0EQ2x74gPaE1HUUxvC9WRKOhBaJkaLDvd3aFHnDCwKqKT4xEisj/AinfO6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775367846; c=relaxed/simple;
	bh=KWZZq6YzQDNrIkX3MrL7rTNUp4+g1nGWmsqhUlV9XKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSLEr/x5cdI7MEsMlr+PMpy8nWo2L6GAlr4gg+hqiUHgpxIJ2QyG36TE7/Ptnhzv/Z0llBoG2+OB3uTyUGV7aNkPAaDx1vaeYwjFrwgJ32Jmmsost0qbELbWKH6fSSj/6x4oAPtJp79GJwo/Z3CfoUOc01H36zJVNNICpNZ0YR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
From: Cole Leavitt <cole@unwrap.rs>
To: linux-wireless@vger.kernel.org
Cc: greearb@candelatech.com,
	miriam.rachel.korenblit@intel.com,
	johannes@sipsolutions.net,
	cole@unwrap.rs,
	stable@vger.kernel.org
Subject: [PATCH 1/3] wifi: iwlwifi: prevent NAPI processing after firmware error
Date: Sat,  4 Apr 2026 22:41:43 -0700
Message-ID: <20260405054145.1064152-2-cole@unwrap.rs>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260405054145.1064152-1-cole@unwrap.rs>
References: <20260405054145.1064152-1-cole@unwrap.rs>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[unwrap.rs : SPF not aligned (strict), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cole@unwrap.rs,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[unwrap.rs:email,unwrap.rs:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,candelatech.com:email];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	TAGGED_FROM(0.00)[bounces-34361-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: CE17039D6E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After a firmware error is detected and STATUS_FW_ERROR is set, NAPI can
still be actively polling or get scheduled from a prior interrupt. The
NAPI poll functions (both legacy and MSIX variants) have no check for
STATUS_FW_ERROR and will continue processing stale RX ring entries from
dying firmware. This can dispatch TX completion notifications containing
corrupt SSN values to iwl_mld_handle_tx_resp_notif(), which passes them
to iwl_trans_reclaim(). If the corrupt SSN causes reclaim to walk TX
queue entries that were already freed by a prior correct reclaim, the
result is an skb use-after-free or double-free.

The race window opens when the MSIX IRQ handler schedules NAPI (lines
2319-2321 in rx.c) before processing the error bit (lines 2382-2396),
or when NAPI is already running on another CPU from a previous interrupt
when STATUS_FW_ERROR gets set on the current CPU.

Add STATUS_FW_ERROR checks to both NAPI poll functions to prevent
processing stale RX data after firmware error, and add early-return
guards in the TX response and compressed BA notification handlers as
defense-in-depth. Each check uses WARN_ONCE to log if the race is
actually hit, which aids diagnosis of the hard-to-reproduce skb
use-after-free reported on Intel BE200.

Note that _iwl_trans_pcie_gen2_stop_device() already calls
iwl_pcie_rx_napi_sync() to quiesce NAPI during device teardown, but that
runs much later in the restart sequence. These checks close the window
between error detection and device stop.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Cc: stable@vger.kernel.org
Tested-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Cole Leavitt <cole@unwrap.rs>
---
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   | 202 +++++------
 .../wireless/intel/iwlwifi/pcie/gen1_2/rx.c   | 337 +++++++++---------
 2 files changed, 273 insertions(+), 266 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 546d09a38dab..e341d12e5233 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -44,8 +44,8 @@ void iwl_mld_toggle_tx_ant(struct iwl_mld *mld, u8 *ant)
 	*ant = iwl_mld_next_ant(iwl_mld_get_valid_tx_ant(mld), *ant);
 }
 
-static int
-iwl_mld_get_queue_size(struct iwl_mld *mld, struct ieee80211_txq *txq)
+static int iwl_mld_get_queue_size(struct iwl_mld *mld,
+				  struct ieee80211_txq *txq)
 {
 	struct ieee80211_sta *sta = txq->sta;
 	struct ieee80211_link_sta *link_sta;
@@ -74,9 +74,10 @@ static int iwl_mld_allocate_txq(struct iwl_mld *mld, struct ieee80211_txq *txq)
 	/* We can't know when the station is asleep or awake, so we
 	 * must disable the queue hang detection.
 	 */
-	unsigned int watchdog_timeout = txq->vif->type == NL80211_IFTYPE_AP ?
-				IWL_WATCHDOG_DISABLED :
-				mld->trans->mac_cfg->base->wd_timeout;
+	unsigned int watchdog_timeout =
+		txq->vif->type == NL80211_IFTYPE_AP ?
+			IWL_WATCHDOG_DISABLED :
+			mld->trans->mac_cfg->base->wd_timeout;
 	int queue, size;
 
 	lockdep_assert_wiphy(mld->wiphy);
@@ -91,9 +92,9 @@ static int iwl_mld_allocate_txq(struct iwl_mld *mld, struct ieee80211_txq *txq)
 				    watchdog_timeout);
 
 	if (queue >= 0)
-		IWL_DEBUG_TX_QUEUES(mld,
-				    "Enabling TXQ #%d for sta mask 0x%x tid %d\n",
-				    queue, fw_sta_mask, tid);
+		IWL_DEBUG_TX_QUEUES(
+			mld, "Enabling TXQ #%d for sta mask 0x%x tid %d\n",
+			queue, fw_sta_mask, tid);
 	return queue;
 }
 
@@ -123,9 +124,8 @@ void iwl_mld_add_txq_list(struct iwl_mld *mld)
 
 	while (!list_empty(&mld->txqs_to_add)) {
 		struct ieee80211_txq *txq;
-		struct iwl_mld_txq *mld_txq =
-			list_first_entry(&mld->txqs_to_add, struct iwl_mld_txq,
-					 list);
+		struct iwl_mld_txq *mld_txq = list_first_entry(
+			&mld->txqs_to_add, struct iwl_mld_txq, list);
 		int failed;
 
 		txq = container_of((void *)mld_txq, struct ieee80211_txq,
@@ -149,8 +149,7 @@ void iwl_mld_add_txq_list(struct iwl_mld *mld)
 
 void iwl_mld_add_txqs_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 {
-	struct iwl_mld *mld = container_of(wk, struct iwl_mld,
-					   add_txqs_wk);
+	struct iwl_mld *mld = container_of(wk, struct iwl_mld, add_txqs_wk);
 
 	/* will reschedule to run after restart */
 	if (mld->fw_status.in_hw_restart)
@@ -159,8 +158,8 @@ void iwl_mld_add_txqs_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 	iwl_mld_add_txq_list(mld);
 }
 
-void
-iwl_mld_free_txq(struct iwl_mld *mld, u32 fw_sta_mask, u32 tid, u32 queue_id)
+void iwl_mld_free_txq(struct iwl_mld *mld, u32 fw_sta_mask, u32 tid,
+		      u32 queue_id)
 {
 	struct iwl_scd_queue_cfg_cmd remove_cmd = {
 		.operation = cpu_to_le32(IWL_SCD_QUEUE_REMOVE),
@@ -193,8 +192,7 @@ void iwl_mld_remove_txq(struct iwl_mld *mld, struct ieee80211_txq *txq)
 
 	sta_msk = iwl_mld_fw_sta_id_mask(mld, txq->sta);
 
-	tid = txq->tid == IEEE80211_NUM_TIDS ? IWL_MGMT_TID :
-					       txq->tid;
+	tid = txq->tid == IEEE80211_NUM_TIDS ? IWL_MGMT_TID : txq->tid;
 
 	iwl_mld_free_txq(mld, sta_msk, tid, mld_txq->fw_id);
 
@@ -202,11 +200,9 @@ void iwl_mld_remove_txq(struct iwl_mld *mld, struct ieee80211_txq *txq)
 	mld_txq->status.allocated = false;
 }
 
-#define OPT_HDR(type, skb, off) \
-	(type *)(skb_network_header(skb) + (off))
+#define OPT_HDR(type, skb, off) (type *)(skb_network_header(skb) + (off))
 
-static __le32
-iwl_mld_get_offload_assist(struct sk_buff *skb, bool amsdu)
+static __le32 iwl_mld_get_offload_assist(struct sk_buff *skb, bool amsdu)
 {
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	u16 mh_len = ieee80211_hdrlen(hdr->frame_control);
@@ -225,7 +221,7 @@ iwl_mld_get_offload_assist(struct sk_buff *skb, bool amsdu)
 	 * the devices we support has this flags?
 	 */
 	if (WARN_ONCE(skb->protocol != htons(ETH_P_IP) &&
-		      skb->protocol != htons(ETH_P_IPV6),
+			      skb->protocol != htons(ETH_P_IPV6),
 		      "No support for requested checksum\n")) {
 		skb_checksum_help(skb);
 		goto out;
@@ -306,8 +302,8 @@ static void iwl_mld_get_basic_rates_and_band(struct iwl_mld *mld,
 					     unsigned long *basic_rates,
 					     u8 *band)
 {
-	u32 link_id = u32_get_bits(info->control.flags,
-				   IEEE80211_TX_CTRL_MLO_LINK);
+	u32 link_id =
+		u32_get_bits(info->control.flags, IEEE80211_TX_CTRL_MLO_LINK);
 
 	*basic_rates = vif->bss_conf.basic_rates;
 	*band = info->band;
@@ -333,8 +329,7 @@ static void iwl_mld_get_basic_rates_and_band(struct iwl_mld *mld,
 	}
 }
 
-u8 iwl_mld_get_lowest_rate(struct iwl_mld *mld,
-			   struct ieee80211_tx_info *info,
+u8 iwl_mld_get_lowest_rate(struct iwl_mld *mld, struct ieee80211_tx_info *info,
 			   struct ieee80211_vif *vif)
 {
 	struct ieee80211_supported_band *sband;
@@ -389,8 +384,8 @@ static u32 iwl_mld_mac80211_rate_idx_to_fw(struct iwl_mld *mld,
 
 	/* if the rate isn't a well known legacy rate, take the lowest one */
 	if (rate_idx < 0 || rate_idx >= IWL_RATE_COUNT_LEGACY)
-		rate_idx = iwl_mld_get_lowest_rate(mld, info,
-						   info->control.vif);
+		rate_idx =
+			iwl_mld_get_lowest_rate(mld, info, info->control.vif);
 
 	WARN_ON_ONCE(rate_idx < 0);
 
@@ -404,7 +399,8 @@ static u32 iwl_mld_mac80211_rate_idx_to_fw(struct iwl_mld *mld,
 	 * 0 - 3 for CCK and 0 - 7 for OFDM
 	 */
 	rate_plcp = (rate_idx >= IWL_FIRST_OFDM_RATE ?
-		     rate_idx - IWL_FIRST_OFDM_RATE : rate_idx);
+			     rate_idx - IWL_FIRST_OFDM_RATE :
+			     rate_idx);
 
 	return (u32)rate_plcp | rate_flags;
 }
@@ -424,8 +420,7 @@ static u32 iwl_mld_get_tx_ant(struct iwl_mld *mld,
 
 static u32 iwl_mld_get_inject_tx_rate(struct iwl_mld *mld,
 				      struct ieee80211_tx_info *info,
-				      struct ieee80211_sta *sta,
-				      __le16 fc)
+				      struct ieee80211_sta *sta, __le16 fc)
 {
 	struct ieee80211_tx_rate *rate = &info->control.rates[0];
 	u32 result;
@@ -492,9 +487,8 @@ static __le32 iwl_mld_get_tx_rate_n_flags(struct iwl_mld *mld,
 	return iwl_v3_rate_to_v2_v3(rate, mld->fw_rates_ver_3);
 }
 
-static void
-iwl_mld_fill_tx_cmd_hdr(struct iwl_tx_cmd *tx_cmd,
-			struct sk_buff *skb, bool amsdu)
+static void iwl_mld_fill_tx_cmd_hdr(struct iwl_tx_cmd *tx_cmd,
+				    struct sk_buff *skb, bool amsdu)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (void *)skb->data;
@@ -530,10 +524,9 @@ iwl_mld_fill_tx_cmd_hdr(struct iwl_tx_cmd *tx_cmd,
 	}
 }
 
-static void
-iwl_mld_fill_tx_cmd(struct iwl_mld *mld, struct sk_buff *skb,
-		    struct iwl_device_tx_cmd *dev_tx_cmd,
-		    struct ieee80211_sta *sta)
+static void iwl_mld_fill_tx_cmd(struct iwl_mld *mld, struct sk_buff *skb,
+				struct iwl_device_tx_cmd *dev_tx_cmd,
+				struct ieee80211_sta *sta)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (void *)skb->data;
@@ -561,8 +554,7 @@ iwl_mld_fill_tx_cmd(struct iwl_mld *mld, struct sk_buff *skb,
 		rate_n_flags = iwl_mld_get_tx_rate_n_flags(mld, info, sta,
 							   hdr->frame_control);
 	} else if (!ieee80211_is_data(hdr->frame_control) ||
-		   (mld_sta &&
-		    mld_sta->sta_state < IEEE80211_STA_AUTHORIZED)) {
+		   (mld_sta && mld_sta->sta_state < IEEE80211_STA_AUTHORIZED)) {
 		/* These are important frames */
 		flags |= IWL_TX_FLAGS_HIGH_PRI;
 	}
@@ -587,8 +579,8 @@ iwl_mld_get_link_from_tx_info(struct ieee80211_tx_info *info)
 {
 	struct iwl_mld_vif *mld_vif =
 		iwl_mld_vif_from_mac80211(info->control.vif);
-	u32 link_id = u32_get_bits(info->control.flags,
-				   IEEE80211_TX_CTRL_MLO_LINK);
+	u32 link_id =
+		u32_get_bits(info->control.flags, IEEE80211_TX_CTRL_MLO_LINK);
 
 	if (link_id == IEEE80211_LINK_UNSPECIFIED) {
 		if (info->control.vif->active_links)
@@ -600,9 +592,9 @@ iwl_mld_get_link_from_tx_info(struct ieee80211_tx_info *info)
 	return rcu_dereference(mld_vif->link[link_id]);
 }
 
-static int
-iwl_mld_get_tx_queue_id(struct iwl_mld *mld, struct ieee80211_txq *txq,
-			struct sk_buff *skb)
+static int iwl_mld_get_tx_queue_id(struct iwl_mld *mld,
+				   struct ieee80211_txq *txq,
+				   struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (void *)skb->data;
@@ -686,8 +678,7 @@ iwl_mld_get_tx_queue_id(struct iwl_mld *mld, struct ieee80211_txq *txq,
 	return IWL_MLD_INVALID_QUEUE;
 }
 
-static void iwl_mld_probe_resp_set_noa(struct iwl_mld *mld,
-				       struct sk_buff *skb)
+static void iwl_mld_probe_resp_set_noa(struct iwl_mld *mld, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct iwl_mld_link *mld_link =
@@ -709,8 +700,7 @@ static void iwl_mld_probe_resp_set_noa(struct iwl_mld *mld,
 
 	if (skb_tailroom(skb) < resp_data->noa_len) {
 		if (pskb_expand_head(skb, 0, resp_data->noa_len, GFP_ATOMIC)) {
-			IWL_ERR(mld,
-				"Failed to reallocate probe resp\n");
+			IWL_ERR(mld, "Failed to reallocate probe resp\n");
 			goto out;
 		}
 	}
@@ -770,8 +760,7 @@ static int iwl_mld_tx_mpdu(struct iwl_mld *mld, struct sk_buff *skb,
 			tid = IWL_TID_NON_QOS;
 	}
 
-	IWL_DEBUG_TX(mld, "TX TID:%d from Q:%d len %d\n",
-		     tid, queue, skb->len);
+	IWL_DEBUG_TX(mld, "TX TID:%d from Q:%d len %d\n", tid, queue, skb->len);
 
 	/* From now on, we cannot access info->control */
 	memset(&info->status, 0, sizeof(info->status));
@@ -824,7 +813,7 @@ static int iwl_mld_tx_tso_segment(struct iwl_mld *mld, struct sk_buff *skb,
 	 */
 	if (skb->protocol == htons(ETH_P_IPV6) &&
 	    ((struct ipv6hdr *)skb_network_header(skb))->nexthdr !=
-	    IPPROTO_TCP) {
+		    IPPROTO_TCP) {
 		netdev_flags &= ~NETIF_F_CSUM_MASK;
 		return iwl_tx_tso_segment(skb, 1, netdev_flags, mpdus_skbs);
 	}
@@ -851,7 +840,7 @@ static int iwl_mld_tx_tso_segment(struct iwl_mld *mld, struct sk_buff *skb,
 		num_subframes = sta->max_amsdu_subframes;
 
 	tcp_payload_len = skb_tail_pointer(skb) - skb_transport_header(skb) -
-		tcp_hdrlen(skb) + skb->data_len;
+			  tcp_hdrlen(skb) + skb->data_len;
 
 	/* Make sure we have enough TBs for the A-MSDU:
 	 *	2 for each subframe
@@ -893,7 +882,7 @@ static int iwl_mld_tx_tso(struct iwl_mld *mld, struct sk_buff *skb,
 		return -1;
 
 	payload_len = skb_tail_pointer(skb) - skb_transport_header(skb) -
-		tcp_hdrlen(skb) + skb->data_len;
+		      tcp_hdrlen(skb) + skb->data_len;
 
 	if (payload_len <= skb_shinfo(skb)->gso_size)
 		return iwl_mld_tx_mpdu(mld, skb, txq);
@@ -1011,8 +1000,8 @@ static void iwl_mld_hwrate_to_tx_rate(struct iwl_mld *mld,
 {
 	enum nl80211_band band = info->band;
 	struct ieee80211_tx_rate *tx_rate = &info->status.rates[0];
-	u32 rate_n_flags = iwl_v3_rate_from_v2_v3(rate_n_flags_fw,
-						  mld->fw_rates_ver_3);
+	u32 rate_n_flags =
+		iwl_v3_rate_from_v2_v3(rate_n_flags_fw, mld->fw_rates_ver_3);
 	u32 sgi = rate_n_flags & RATE_MCS_SGI_MSK;
 	u32 chan_width = rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK;
 	u32 format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
@@ -1042,10 +1031,9 @@ static void iwl_mld_hwrate_to_tx_rate(struct iwl_mld *mld,
 		tx_rate->idx = RATE_HT_MCS_INDEX(rate_n_flags);
 		break;
 	case RATE_MCS_MOD_TYPE_VHT:
-		ieee80211_rate_set_vht(tx_rate,
-				       rate_n_flags & RATE_MCS_CODE_MSK,
-				       u32_get_bits(rate_n_flags,
-						    RATE_MCS_NSS_MSK) + 1);
+		ieee80211_rate_set_vht(
+			tx_rate, rate_n_flags & RATE_MCS_CODE_MSK,
+			u32_get_bits(rate_n_flags, RATE_MCS_NSS_MSK) + 1);
 		tx_rate->flags |= IEEE80211_TX_RC_VHT_MCS;
 		break;
 	case RATE_MCS_MOD_TYPE_HE:
@@ -1056,9 +1044,8 @@ static void iwl_mld_hwrate_to_tx_rate(struct iwl_mld *mld,
 		tx_rate->idx = 0;
 		break;
 	default:
-		tx_rate->idx =
-			iwl_mld_legacy_hw_idx_to_mac80211_idx(rate_n_flags,
-							      band);
+		tx_rate->idx = iwl_mld_legacy_hw_idx_to_mac80211_idx(
+			rate_n_flags, band);
 		break;
 	}
 }
@@ -1082,6 +1069,19 @@ void iwl_mld_handle_tx_resp_notif(struct iwl_mld *mld,
 	bool mgmt = false;
 	bool tx_failure = (status & TX_STATUS_MSK) != TX_STATUS_SUCCESS;
 
+	/* Firmware is dead — the TX response may contain corrupt SSN values
+	 * from a dying firmware DMA. Processing it could cause
+	 * iwl_trans_reclaim() to free the wrong TX queue entries, leading to
+	 * skb use-after-free or double-free.
+	 */
+	if (unlikely(test_bit(STATUS_FW_ERROR, &mld->trans->status))) {
+		WARN_ONCE(
+			1,
+			"iwlwifi: TX resp notif (sta=%d txq=%d) after FW error\n",
+			sta_id, txq_id);
+		return;
+	}
+
 	if (IWL_FW_CHECK(mld, tx_resp->frame_count != 1,
 			 "Invalid tx_resp notif frame_count (%d)\n",
 			 tx_resp->frame_count))
@@ -1093,8 +1093,8 @@ void iwl_mld_handle_tx_resp_notif(struct iwl_mld *mld,
 			 notif_size, pkt_len))
 		return;
 
-	ssn = le32_to_cpup((__le32 *)agg_status +
-			   tx_resp->frame_count) & 0xFFFF;
+	ssn = le32_to_cpup((__le32 *)agg_status + tx_resp->frame_count) &
+	      0xFFFF;
 
 	__skb_queue_head_init(&skbs);
 
@@ -1112,7 +1112,8 @@ void iwl_mld_handle_tx_resp_notif(struct iwl_mld *mld,
 
 		memset(&info->status, 0, sizeof(info->status));
 
-		info->flags &= ~(IEEE80211_TX_STAT_ACK | IEEE80211_TX_STAT_TX_FILTERED);
+		info->flags &= ~(IEEE80211_TX_STAT_ACK |
+				 IEEE80211_TX_STAT_TX_FILTERED);
 
 		/* inform mac80211 about what happened with the frame */
 		switch (status & TX_STATUS_MSK) {
@@ -1149,10 +1150,11 @@ void iwl_mld_handle_tx_resp_notif(struct iwl_mld *mld,
 			ieee80211_tx_status_skb(mld->hw, skb);
 	}
 
-	IWL_DEBUG_TX_REPLY(mld,
-			   "TXQ %d status 0x%08x ssn=%d initial_rate 0x%x retries %d\n",
-			   txq_id, status, ssn, le32_to_cpu(tx_resp->initial_rate),
-			   tx_resp->failure_frame);
+	IWL_DEBUG_TX_REPLY(
+		mld,
+		"TXQ %d status 0x%08x ssn=%d initial_rate 0x%x retries %d\n",
+		txq_id, status, ssn, le32_to_cpu(tx_resp->initial_rate),
+		tx_resp->failure_frame);
 
 	if (tx_failure && mgmt)
 		iwl_mld_toggle_tx_ant(mld, &mld->mgmt_tx_ant);
@@ -1168,9 +1170,8 @@ void iwl_mld_handle_tx_resp_notif(struct iwl_mld *mld,
 		/* This can happen if the TX cmd was sent before pre_rcu_remove
 		 * but the TX response was received after
 		 */
-		IWL_DEBUG_TX_REPLY(mld,
-				   "Got valid sta_id (%d) but sta is NULL\n",
-				   sta_id);
+		IWL_DEBUG_TX_REPLY(
+			mld, "Got valid sta_id (%d) but sta is NULL\n", sta_id);
 		goto out;
 	}
 
@@ -1246,8 +1247,7 @@ int iwl_mld_flush_link_sta_txqs(struct iwl_mld *mld, u32 fw_sta_id)
 
 	resp_len = iwl_rx_packet_payload_len(cmd.resp_pkt);
 	if (IWL_FW_CHECK(mld, resp_len != sizeof(*rsp),
-			 "Invalid TXPATH_FLUSH response len: %d\n",
-			 resp_len)) {
+			 "Invalid TXPATH_FLUSH response len: %d\n", resp_len)) {
 		ret = -EIO;
 		goto free_rsp;
 	}
@@ -1273,16 +1273,14 @@ int iwl_mld_flush_link_sta_txqs(struct iwl_mld *mld, u32 fw_sta_id)
 		int read_after = le16_to_cpu(queue_info->read_after_flush);
 		int txq_id = le16_to_cpu(queue_info->queue_num);
 
-		if (IWL_FW_CHECK(mld,
-				 txq_id >= ARRAY_SIZE(mld->fw_id_to_txq),
+		if (IWL_FW_CHECK(mld, txq_id >= ARRAY_SIZE(mld->fw_id_to_txq),
 				 "Invalid txq id %d\n", txq_id))
 			continue;
 
-		IWL_DEBUG_TX_QUEUES(mld,
-				    "tid %d txq_id %d read-before %d read-after %d\n",
-				    le16_to_cpu(queue_info->tid), txq_id,
-				    le16_to_cpu(queue_info->read_before_flush),
-				    read_after);
+		IWL_DEBUG_TX_QUEUES(
+			mld, "tid %d txq_id %d read-before %d read-after %d\n",
+			le16_to_cpu(queue_info->tid), txq_id,
+			le16_to_cpu(queue_info->read_before_flush), read_after);
 
 		iwl_mld_tx_reclaim_txq(mld, txq_id, read_after, true);
 	}
@@ -1312,8 +1310,7 @@ int iwl_mld_ensure_queue(struct iwl_mld *mld, struct ieee80211_txq *txq)
 	return ret;
 }
 
-int iwl_mld_update_sta_txqs(struct iwl_mld *mld,
-			    struct ieee80211_sta *sta,
+int iwl_mld_update_sta_txqs(struct iwl_mld *mld, struct ieee80211_sta *sta,
 			    u32 old_sta_mask, u32 new_sta_mask)
 {
 	struct iwl_scd_queue_cfg_cmd cmd = {
@@ -1326,10 +1323,9 @@ int iwl_mld_update_sta_txqs(struct iwl_mld *mld,
 
 	for (int tid = 0; tid <= IWL_MAX_TID_COUNT; tid++) {
 		struct ieee80211_txq *txq =
-			sta->txq[tid != IWL_MAX_TID_COUNT ?
-					tid : IEEE80211_NUM_TIDS];
-		struct iwl_mld_txq *mld_txq =
-			iwl_mld_txq_from_mac80211(txq);
+			sta->txq[tid != IWL_MAX_TID_COUNT ? tid :
+							    IEEE80211_NUM_TIDS];
+		struct iwl_mld_txq *mld_txq = iwl_mld_txq_from_mac80211(txq);
 		int ret;
 
 		if (!mld_txq->status.allocated)
@@ -1340,10 +1336,9 @@ int iwl_mld_update_sta_txqs(struct iwl_mld *mld,
 		else
 			cmd.u.modify.tid = cpu_to_le32(tid);
 
-		ret = iwl_mld_send_cmd_pdu(mld,
-					   WIDE_ID(DATA_PATH_GROUP,
-						   SCD_QUEUE_CONFIG_CMD),
-					   &cmd);
+		ret = iwl_mld_send_cmd_pdu(
+			mld, WIDE_ID(DATA_PATH_GROUP, SCD_QUEUE_CONFIG_CMD),
+			&cmd);
 		if (ret)
 			return ret;
 	}
@@ -1360,27 +1355,32 @@ void iwl_mld_handle_compressed_ba_notif(struct iwl_mld *mld,
 	u8 sta_id = ba_res->sta_id;
 	struct ieee80211_link_sta *link_sta;
 
+	if (unlikely(test_bit(STATUS_FW_ERROR, &mld->trans->status))) {
+		WARN_ONCE(1, "iwlwifi: BA notif (sta=%d) after FW error\n",
+			  sta_id);
+		return;
+	}
+
 	if (!tfd_cnt)
 		return;
 
 	if (IWL_FW_CHECK(mld, struct_size(ba_res, tfd, tfd_cnt) > pkt_len,
-			 "Short BA notif (tfd_cnt=%d, size:0x%x)\n",
-			 tfd_cnt, pkt_len))
+			 "Short BA notif (tfd_cnt=%d, size:0x%x)\n", tfd_cnt,
+			 pkt_len))
 		return;
 
-	IWL_DEBUG_TX_REPLY(mld,
-			   "BA notif received from sta_id=%d, flags=0x%x, sent:%d, acked:%d\n",
-			   sta_id, le32_to_cpu(ba_res->flags),
-			   le16_to_cpu(ba_res->txed),
-			   le16_to_cpu(ba_res->done));
+	IWL_DEBUG_TX_REPLY(
+		mld,
+		"BA notif received from sta_id=%d, flags=0x%x, sent:%d, acked:%d\n",
+		sta_id, le32_to_cpu(ba_res->flags), le16_to_cpu(ba_res->txed),
+		le16_to_cpu(ba_res->done));
 
 	for (int i = 0; i < tfd_cnt; i++) {
 		struct iwl_compressed_ba_tfd *ba_tfd = &ba_res->tfd[i];
 		int txq_id = le16_to_cpu(ba_tfd->q_num);
 		int index = le16_to_cpu(ba_tfd->tfd_index);
 
-		if (IWL_FW_CHECK(mld,
-				 txq_id >= ARRAY_SIZE(mld->fw_id_to_txq),
+		if (IWL_FW_CHECK(mld, txq_id >= ARRAY_SIZE(mld->fw_id_to_txq),
 				 "Invalid txq id %d\n", txq_id))
 			continue;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
index fe263cdc2e4f..554c22777ec1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
@@ -151,8 +151,8 @@ int iwl_pcie_rx_stop(struct iwl_trans *trans)
 					      RXF_DMA_IDLE, RXF_DMA_IDLE, 1000);
 	} else if (trans->mac_cfg->mq_rx_supported) {
 		iwl_write_prph(trans, RFH_RXF_DMA_CFG, 0);
-		return iwl_poll_prph_bit(trans, RFH_GEN_STATUS,
-					   RXF_DMA_IDLE, RXF_DMA_IDLE, 1000);
+		return iwl_poll_prph_bit(trans, RFH_GEN_STATUS, RXF_DMA_IDLE,
+					 RXF_DMA_IDLE, 1000);
 	} else {
 		iwl_write_direct32(trans, FH_MEM_RCSR_CHNL0_CONFIG_REG, 0);
 		return iwl_poll_direct_bit(trans, FH_MEM_RSSR_RX_STATUS_REG,
@@ -181,8 +181,10 @@ static void iwl_pcie_rxq_inc_wr_ptr(struct iwl_trans *trans,
 		reg = iwl_read32(trans, CSR_UCODE_DRV_GP1);
 
 		if (reg & CSR_UCODE_DRV_GP1_BIT_MAC_SLEEP) {
-			IWL_DEBUG_INFO(trans, "Rx queue requesting wakeup, GP1 = 0x%x\n",
-				       reg);
+			IWL_DEBUG_INFO(
+				trans,
+				"Rx queue requesting wakeup, GP1 = 0x%x\n",
+				reg);
 			iwl_set_bit(trans, CSR_GP_CNTRL,
 				    CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 			rxq->need_update = true;
@@ -194,8 +196,8 @@ static void iwl_pcie_rxq_inc_wr_ptr(struct iwl_trans *trans,
 	if (!trans->mac_cfg->mq_rx_supported)
 		iwl_write32(trans, FH_RSCSR_CHNL0_WPTR, rxq->write_actual);
 	else if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
-		iwl_write32(trans, HBUS_TARG_WRPTR, rxq->write_actual |
-			    HBUS_TARG_WRPTR_RX_Q(rxq->id));
+		iwl_write32(trans, HBUS_TARG_WRPTR,
+			    rxq->write_actual | HBUS_TARG_WRPTR_RX_Q(rxq->id));
 	else
 		iwl_write32(trans, RFH_Q_FRBDCB_WIDX_TRG(rxq->id),
 			    rxq->write_actual);
@@ -218,8 +220,7 @@ static void iwl_pcie_rxq_check_wrptr(struct iwl_trans *trans)
 	}
 }
 
-static void iwl_pcie_restock_bd(struct iwl_trans *trans,
-				struct iwl_rxq *rxq,
+static void iwl_pcie_restock_bd(struct iwl_trans *trans, struct iwl_rxq *rxq,
 				struct iwl_rx_mem_buffer *rxb)
 {
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
@@ -242,8 +243,7 @@ static void iwl_pcie_restock_bd(struct iwl_trans *trans,
 /*
  * iwl_pcie_rxmq_restock - restock implementation for multi-queue rx
  */
-static void iwl_pcie_rxmq_restock(struct iwl_trans *trans,
-				  struct iwl_rxq *rxq)
+static void iwl_pcie_rxmq_restock(struct iwl_trans *trans, struct iwl_rxq *rxq)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_rx_mem_buffer *rxb;
@@ -289,8 +289,7 @@ static void iwl_pcie_rxmq_restock(struct iwl_trans *trans,
 /*
  * iwl_pcie_rxsq_restock - restock implementation for single queue rx
  */
-static void iwl_pcie_rxsq_restock(struct iwl_trans *trans,
-				  struct iwl_rxq *rxq)
+static void iwl_pcie_rxsq_restock(struct iwl_trans *trans, struct iwl_rxq *rxq)
 {
 	struct iwl_rx_mem_buffer *rxb;
 
@@ -346,8 +345,7 @@ static void iwl_pcie_rxsq_restock(struct iwl_trans *trans,
  * also updates the memory address in the firmware to reference the new
  * target buffer.
  */
-static
-void iwl_pcie_rxq_restock(struct iwl_trans *trans, struct iwl_rxq *rxq)
+static void iwl_pcie_rxq_restock(struct iwl_trans *trans, struct iwl_rxq *rxq)
 {
 	if (trans->mac_cfg->mq_rx_supported)
 		iwl_pcie_rxmq_restock(trans, rxq);
@@ -359,8 +357,8 @@ void iwl_pcie_rxq_restock(struct iwl_trans *trans, struct iwl_rxq *rxq)
  * iwl_pcie_rx_alloc_page - allocates and returns a page.
  *
  */
-static struct page *iwl_pcie_rx_alloc_page(struct iwl_trans *trans,
-					   u32 *offset, gfp_t priority)
+static struct page *iwl_pcie_rx_alloc_page(struct iwl_trans *trans, u32 *offset,
+					   gfp_t priority)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	unsigned int allocsize = PAGE_SIZE << trans_pcie->rx_page_order;
@@ -399,8 +397,7 @@ static struct page *iwl_pcie_rx_alloc_page(struct iwl_trans *trans,
 		  * buffers.
 		 */
 		if (!(gfp_mask & __GFP_NOWARN) && net_ratelimit())
-			IWL_CRIT(trans,
-				 "Failed to alloc_pages\n");
+			IWL_CRIT(trans, "Failed to alloc_pages\n");
 		return NULL;
 	}
 
@@ -464,10 +461,9 @@ void iwl_pcie_rxq_alloc_rbs(struct iwl_trans *trans, gfp_t priority,
 		rxb->page = page;
 		rxb->offset = offset;
 		/* Get physical address of the RB */
-		rxb->page_dma =
-			dma_map_page(trans->dev, page, rxb->offset,
-				     trans_pcie->rx_buf_bytes,
-				     DMA_FROM_DEVICE);
+		rxb->page_dma = dma_map_page(trans->dev, page, rxb->offset,
+					     trans_pcie->rx_buf_bytes,
+					     DMA_FROM_DEVICE);
 		if (dma_mapping_error(trans->dev, rxb->page_dma)) {
 			rxb->page = NULL;
 			spin_lock_bh(&rxq->lock);
@@ -579,9 +575,10 @@ static void iwl_pcie_rx_allocator(struct iwl_trans *trans)
 		if (!pending) {
 			pending = atomic_read(&rba->req_pending);
 			if (pending)
-				IWL_DEBUG_TPT(trans,
-					      "Got more pending allocation requests = %d\n",
-					      pending);
+				IWL_DEBUG_TPT(
+					trans,
+					"Got more pending allocation requests = %d\n",
+					pending);
 		}
 
 		spin_lock_bh(&rba->lock);
@@ -592,7 +589,6 @@ static void iwl_pcie_rx_allocator(struct iwl_trans *trans)
 		spin_unlock_bh(&rba->lock);
 
 		atomic_inc(&rba->req_ready);
-
 	}
 
 	spin_lock_bh(&rba->lock);
@@ -634,9 +630,8 @@ static void iwl_pcie_rx_allocator_get(struct iwl_trans *trans,
 	spin_lock(&rba->lock);
 	for (i = 0; i < RX_CLAIM_REQ_ALLOC; i++) {
 		/* Get next free Rx buffer, remove it from free list */
-		struct iwl_rx_mem_buffer *rxb =
-			list_first_entry(&rba->rbd_allocated,
-					 struct iwl_rx_mem_buffer, list);
+		struct iwl_rx_mem_buffer *rxb = list_first_entry(
+			&rba->rbd_allocated, struct iwl_rx_mem_buffer, list);
 
 		list_move(&rxb->list, &rxq->rx_free);
 	}
@@ -661,8 +656,8 @@ static int iwl_pcie_free_bd_size(struct iwl_trans *trans)
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		return sizeof(struct iwl_rx_transfer_desc);
 
-	return trans->mac_cfg->mq_rx_supported ?
-			sizeof(__le64) : sizeof(__le32);
+	return trans->mac_cfg->mq_rx_supported ? sizeof(__le64) :
+						 sizeof(__le32);
 }
 
 static int iwl_pcie_used_bd_size(struct iwl_trans *trans)
@@ -676,14 +671,12 @@ static int iwl_pcie_used_bd_size(struct iwl_trans *trans)
 	return sizeof(__le32);
 }
 
-static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
-				  struct iwl_rxq *rxq)
+static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans, struct iwl_rxq *rxq)
 {
 	int free_size = iwl_pcie_free_bd_size(trans);
 
 	if (rxq->bd)
-		dma_free_coherent(trans->dev,
-				  free_size * rxq->queue_size,
+		dma_free_coherent(trans->dev, free_size * rxq->queue_size,
 				  rxq->bd, rxq->bd_dma);
 	rxq->bd_dma = 0;
 	rxq->bd = NULL;
@@ -694,7 +687,7 @@ static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
 	if (rxq->used_bd)
 		dma_free_coherent(trans->dev,
 				  iwl_pcie_used_bd_size(trans) *
-					rxq->queue_size,
+					  rxq->queue_size,
 				  rxq->used_bd, rxq->used_bd_dma);
 	rxq->used_bd_dma = 0;
 	rxq->used_bd = NULL;
@@ -702,8 +695,8 @@ static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
 
 static size_t iwl_pcie_rb_stts_size(struct iwl_trans *trans)
 {
-	bool use_rx_td = (trans->mac_cfg->device_family >=
-			  IWL_DEVICE_FAMILY_AX210);
+	bool use_rx_td =
+		(trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210);
 
 	if (use_rx_td)
 		return sizeof(__le16);
@@ -711,8 +704,7 @@ static size_t iwl_pcie_rb_stts_size(struct iwl_trans *trans)
 	return sizeof(struct iwl_rb_status);
 }
 
-static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
-				  struct iwl_rxq *rxq)
+static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans, struct iwl_rxq *rxq)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	size_t rb_stts_size = iwl_pcie_rb_stts_size(trans);
@@ -738,11 +730,9 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 		goto err;
 
 	if (trans->mac_cfg->mq_rx_supported) {
-		rxq->used_bd = dma_alloc_coherent(dev,
-						  iwl_pcie_used_bd_size(trans) *
-							rxq->queue_size,
-						  &rxq->used_bd_dma,
-						  GFP_KERNEL);
+		rxq->used_bd = dma_alloc_coherent(
+			dev, iwl_pcie_used_bd_size(trans) * rxq->queue_size,
+			&rxq->used_bd_dma, GFP_KERNEL);
 		if (!rxq->used_bd)
 			goto err;
 	}
@@ -774,8 +764,8 @@ static int iwl_pcie_rx_alloc(struct iwl_trans *trans)
 		return -EINVAL;
 
 	trans_pcie->rxq = kzalloc_objs(struct iwl_rxq, trans->info.num_rxqs);
-	trans_pcie->rx_pool = kzalloc_objs(trans_pcie->rx_pool[0],
-					   RX_POOL_SIZE(trans_pcie->num_rx_bufs));
+	trans_pcie->rx_pool = kzalloc_objs(
+		trans_pcie->rx_pool[0], RX_POOL_SIZE(trans_pcie->num_rx_bufs));
 	trans_pcie->global_table =
 		kzalloc_objs(trans_pcie->global_table[0],
 			     RX_POOL_SIZE(trans_pcie->num_rx_bufs));
@@ -791,11 +781,9 @@ static int iwl_pcie_rx_alloc(struct iwl_trans *trans)
 	 * Allocate the driver's pointer to receive buffer status.
 	 * Allocate for all queues continuously (HW requirement).
 	 */
-	trans_pcie->base_rb_stts =
-			dma_alloc_coherent(trans->dev,
-					   rb_stts_size * trans->info.num_rxqs,
-					   &trans_pcie->base_rb_stts_dma,
-					   GFP_KERNEL);
+	trans_pcie->base_rb_stts = dma_alloc_coherent(
+		trans->dev, rb_stts_size * trans->info.num_rxqs,
+		&trans_pcie->base_rb_stts_dma, GFP_KERNEL);
 	if (!trans_pcie->base_rb_stts) {
 		ret = -ENOMEM;
 		goto err;
@@ -868,8 +856,7 @@ static void iwl_pcie_rx_hw_init(struct iwl_trans *trans, struct iwl_rxq *rxq)
 		    (u32)(rxq->bd_dma >> 8));
 
 	/* Tell device where in DRAM to update its Rx status */
-	iwl_write32(trans, FH_RSCSR_CHNL0_STTS_WPTR_REG,
-		    rxq->rb_stts_dma >> 4);
+	iwl_write32(trans, FH_RSCSR_CHNL0_STTS_WPTR_REG, rxq->rb_stts_dma >> 4);
 
 	/* Enable Rx DMA
 	 * FH_RCSR_CHNL0_RX_IGNORE_RXF_EMPTY is set because of HW bug in
@@ -881,11 +868,12 @@ static void iwl_pcie_rx_hw_init(struct iwl_trans *trans, struct iwl_rxq *rxq)
 	 */
 	iwl_write32(trans, FH_MEM_RCSR_CHNL0_CONFIG_REG,
 		    FH_RCSR_RX_CONFIG_CHNL_EN_ENABLE_VAL |
-		    FH_RCSR_CHNL0_RX_IGNORE_RXF_EMPTY |
-		    FH_RCSR_CHNL0_RX_CONFIG_IRQ_DEST_INT_HOST_VAL |
-		    rb_size |
-		    (RX_RB_TIMEOUT << FH_RCSR_RX_CONFIG_REG_IRQ_RBTH_POS) |
-		    (rfdnlog << FH_RCSR_RX_CONFIG_RBDCB_SIZE_POS));
+			    FH_RCSR_CHNL0_RX_IGNORE_RXF_EMPTY |
+			    FH_RCSR_CHNL0_RX_CONFIG_IRQ_DEST_INT_HOST_VAL |
+			    rb_size |
+			    (RX_RB_TIMEOUT
+			     << FH_RCSR_RX_CONFIG_REG_IRQ_RBTH_POS) |
+			    (rfdnlog << FH_RCSR_RX_CONFIG_RBDCB_SIZE_POS));
 
 	iwl_trans_release_nic_access(trans);
 
@@ -931,16 +919,13 @@ static void iwl_pcie_rx_mq_hw_init(struct iwl_trans *trans)
 
 	for (i = 0; i < trans->info.num_rxqs; i++) {
 		/* Tell device where to find RBD free table in DRAM */
-		iwl_write_prph64_no_grab(trans,
-					 RFH_Q_FRBDCB_BA_LSB(i),
+		iwl_write_prph64_no_grab(trans, RFH_Q_FRBDCB_BA_LSB(i),
 					 trans_pcie->rxq[i].bd_dma);
 		/* Tell device where to find RBD used table in DRAM */
-		iwl_write_prph64_no_grab(trans,
-					 RFH_Q_URBDCB_BA_LSB(i),
+		iwl_write_prph64_no_grab(trans, RFH_Q_URBDCB_BA_LSB(i),
 					 trans_pcie->rxq[i].used_bd_dma);
 		/* Tell device where in DRAM to update its Rx status */
-		iwl_write_prph64_no_grab(trans,
-					 RFH_Q_URBD_STTS_WPTR_LSB(i),
+		iwl_write_prph64_no_grab(trans, RFH_Q_URBD_STTS_WPTR_LSB(i),
 					 trans_pcie->rxq[i].rb_stts_dma);
 		/* Reset device indice tables */
 		iwl_write_prph_no_grab(trans, RFH_Q_FRBDCB_WIDX(i), 0);
@@ -959,23 +944,24 @@ static void iwl_pcie_rx_mq_hw_init(struct iwl_trans *trans)
 	 */
 	iwl_write_prph_no_grab(trans, RFH_RXF_DMA_CFG,
 			       RFH_DMA_EN_ENABLE_VAL | rb_size |
-			       RFH_RXF_DMA_MIN_RB_4_8 |
-			       RFH_RXF_DMA_DROP_TOO_LARGE_MASK |
-			       RFH_RXF_DMA_RBDCB_SIZE_512);
+				       RFH_RXF_DMA_MIN_RB_4_8 |
+				       RFH_RXF_DMA_DROP_TOO_LARGE_MASK |
+				       RFH_RXF_DMA_RBDCB_SIZE_512);
 
 	/*
 	 * Activate DMA snooping.
 	 * Set RX DMA chunk size to 64B for IOSF and 128B for PCIe
 	 * Default queue is 0
 	 */
-	iwl_write_prph_no_grab(trans, RFH_GEN_CFG,
-			       RFH_GEN_CFG_RFH_DMA_SNOOP |
-			       RFH_GEN_CFG_VAL(DEFAULT_RXQ_NUM, 0) |
-			       RFH_GEN_CFG_SERVICE_DMA_SNOOP |
-			       RFH_GEN_CFG_VAL(RB_CHUNK_SIZE,
-					       trans->mac_cfg->integrated ?
-					       RFH_GEN_CFG_RB_CHUNK_SIZE_64 :
-					       RFH_GEN_CFG_RB_CHUNK_SIZE_128));
+	iwl_write_prph_no_grab(
+		trans, RFH_GEN_CFG,
+		RFH_GEN_CFG_RFH_DMA_SNOOP |
+			RFH_GEN_CFG_VAL(DEFAULT_RXQ_NUM, 0) |
+			RFH_GEN_CFG_SERVICE_DMA_SNOOP |
+			RFH_GEN_CFG_VAL(RB_CHUNK_SIZE,
+					trans->mac_cfg->integrated ?
+						RFH_GEN_CFG_RB_CHUNK_SIZE_64 :
+						RFH_GEN_CFG_RB_CHUNK_SIZE_128));
 	/* Enable the relevant rx queues */
 	iwl_write_prph_no_grab(trans, RFH_RXF_RXQ_ACTIVE, enabled);
 
@@ -997,7 +983,8 @@ void iwl_pcie_rx_init_rxb_lists(struct iwl_rxq *rxq)
 
 static int iwl_pcie_rx_handle(struct iwl_trans *trans, int queue, int budget);
 
-static inline struct iwl_trans_pcie *iwl_netdev_to_trans_pcie(struct net_device *dev)
+static inline struct iwl_trans_pcie *
+iwl_netdev_to_trans_pcie(struct net_device *dev)
 {
 	return *(struct iwl_trans_pcie **)netdev_priv(dev);
 }
@@ -1012,10 +999,21 @@ static int iwl_pcie_napi_poll(struct napi_struct *napi, int budget)
 	trans_pcie = iwl_netdev_to_trans_pcie(napi->dev);
 	trans = trans_pcie->trans;
 
+	/* Stop processing RX if firmware has crashed. Stale notifications
+	 * from dying firmware (e.g. TX completions with corrupt SSN values)
+	 * can cause use-after-free in reclaim paths.
+	 */
+	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status))) {
+		WARN_ONCE(1, "iwlwifi: NAPI poll[%d] invoked after FW error\n",
+			  rxq->id);
+		napi_complete_done(napi, 0);
+		return 0;
+	}
+
 	ret = iwl_pcie_rx_handle(trans, rxq->id, budget);
 
-	IWL_DEBUG_ISR(trans, "[%d] handled %d, budget %d\n",
-		      rxq->id, ret, budget);
+	IWL_DEBUG_ISR(trans, "[%d] handled %d, budget %d\n", rxq->id, ret,
+		      budget);
 
 	if (ret < budget) {
 		spin_lock(&trans_pcie->irq_lock);
@@ -1039,6 +1037,15 @@ static int iwl_pcie_napi_poll_msix(struct napi_struct *napi, int budget)
 	trans_pcie = iwl_netdev_to_trans_pcie(napi->dev);
 	trans = trans_pcie->trans;
 
+	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status))) {
+		WARN_ONCE(
+			1,
+			"iwlwifi: NAPI MSIX poll[%d] invoked after FW error\n",
+			rxq->id);
+		napi_complete_done(napi, 0);
+		return 0;
+	}
+
 	ret = iwl_pcie_rx_handle(trans, rxq->id, budget);
 	IWL_DEBUG_ISR(trans, "[%d] handled %d, budget %d\n", rxq->id, ret,
 		      budget);
@@ -1121,30 +1128,31 @@ static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 		memset(rxq->rb_stts, 0,
 		       (trans->mac_cfg->device_family >=
 			IWL_DEVICE_FAMILY_AX210) ?
-		       sizeof(__le16) : sizeof(struct iwl_rb_status));
+			       sizeof(__le16) :
+			       sizeof(struct iwl_rb_status));
 
 		iwl_pcie_rx_init_rxb_lists(rxq);
 
 		spin_unlock_bh(&rxq->lock);
 
 		if (!rxq->napi.poll) {
-			int (*poll)(struct napi_struct *, int) = iwl_pcie_napi_poll;
+			int (*poll)(struct napi_struct *, int) =
+				iwl_pcie_napi_poll;
 
 			if (trans_pcie->msix_enabled)
 				poll = iwl_pcie_napi_poll_msix;
 
-			netif_napi_add(trans_pcie->napi_dev, &rxq->napi,
-				       poll);
+			netif_napi_add(trans_pcie->napi_dev, &rxq->napi, poll);
 			napi_enable(&rxq->napi);
 		}
-
 	}
 
 	/* move the pool to the default queue and allocator ownerships */
 	queue_size = trans->mac_cfg->mq_rx_supported ?
-			trans_pcie->num_rx_bufs - 1 : RX_QUEUE_SIZE;
-	allocator_pool_size = trans->info.num_rxqs *
-		(RX_CLAIM_REQ_ALLOC - RX_POST_REQ_ALLOC);
+			     trans_pcie->num_rx_bufs - 1 :
+			     RX_QUEUE_SIZE;
+	allocator_pool_size =
+		trans->info.num_rxqs * (RX_CLAIM_REQ_ALLOC - RX_POST_REQ_ALLOC);
 	num_alloc = queue_size + allocator_pool_size;
 
 	for (i = 0; i < num_alloc; i++) {
@@ -1291,11 +1299,9 @@ static void iwl_pcie_rx_reuse_rbd(struct iwl_trans *trans,
 	}
 }
 
-static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
-				struct iwl_rxq *rxq,
-				struct iwl_rx_mem_buffer *rxb,
-				bool emergency,
-				int i)
+static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans, struct iwl_rxq *rxq,
+				  struct iwl_rx_mem_buffer *rxb, bool emergency,
+				  int i)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *txq = trans_pcie->txqs.txq[trans->conf.cmd_queue];
@@ -1330,19 +1336,21 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 		}
 
 		WARN((le32_to_cpu(pkt->len_n_flags) & FH_RSCSR_RXQ_MASK) >>
-			FH_RSCSR_RXQ_POS != rxq->id,
+				     FH_RSCSR_RXQ_POS !=
+			     rxq->id,
 		     "frame on invalid queue - is on %d and indicates %d\n",
 		     rxq->id,
 		     (le32_to_cpu(pkt->len_n_flags) & FH_RSCSR_RXQ_MASK) >>
-			FH_RSCSR_RXQ_POS);
+			     FH_RSCSR_RXQ_POS);
 
-		IWL_DEBUG_RX(trans,
-			     "Q %d: cmd at offset %d: %s (%.2x.%2x, seq 0x%x)\n",
-			     rxq->id, offset,
-			     iwl_get_cmd_string(trans,
-						WIDE_ID(pkt->hdr.group_id, pkt->hdr.cmd)),
-			     pkt->hdr.group_id, pkt->hdr.cmd,
-			     le16_to_cpu(pkt->hdr.sequence));
+		IWL_DEBUG_RX(
+			trans,
+			"Q %d: cmd at offset %d: %s (%.2x.%2x, seq 0x%x)\n",
+			rxq->id, offset,
+			iwl_get_cmd_string(trans, WIDE_ID(pkt->hdr.group_id,
+							  pkt->hdr.cmd)),
+			pkt->hdr.group_id, pkt->hdr.cmd,
+			le16_to_cpu(pkt->hdr.sequence));
 
 		len = iwl_rx_packet_len(pkt);
 		len += sizeof(u32); /* account for status word */
@@ -1367,7 +1375,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 
 			for (i = 0; i < trans->conf.n_no_reclaim_cmds; i++) {
 				if (trans->conf.no_reclaim_cmds[i] ==
-							pkt->hdr.cmd) {
+				    pkt->hdr.cmd) {
 					reclaim = false;
 					break;
 				}
@@ -1375,11 +1383,10 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 		}
 
 		if (rxq->id == IWL_DEFAULT_RX_QUEUE)
-			iwl_op_mode_rx(trans->op_mode, &rxq->napi,
-				       &rxcb);
+			iwl_op_mode_rx(trans->op_mode, &rxq->napi, &rxcb);
 		else
-			iwl_op_mode_rx_rss(trans->op_mode, &rxq->napi,
-					   &rxcb, rxq->id);
+			iwl_op_mode_rx_rss(trans->op_mode, &rxq->napi, &rxcb,
+					   rxq->id);
 
 		/*
 		 * After here, we should always check rxcb._page_stolen,
@@ -1419,10 +1426,9 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 	 * SKBs that fail to Rx correctly, add them back into the
 	 * rx_free list for reuse later. */
 	if (rxb->page != NULL) {
-		rxb->page_dma =
-			dma_map_page(trans->dev, rxb->page, rxb->offset,
-				     trans_pcie->rx_buf_bytes,
-				     DMA_FROM_DEVICE);
+		rxb->page_dma = dma_map_page(trans->dev, rxb->page, rxb->offset,
+					     trans_pcie->rx_buf_bytes,
+					     DMA_FROM_DEVICE);
 		if (dma_mapping_error(trans->dev, rxb->page_dma)) {
 			/*
 			 * free the page(s) as well to not break
@@ -1534,9 +1540,10 @@ static int iwl_pcie_rx_handle(struct iwl_trans *trans, int queue, int budget)
 			     !emergency)) {
 			iwl_pcie_rx_move_to_allocator(rxq, rba);
 			emergency = true;
-			IWL_DEBUG_TPT(trans,
-				      "RX path is in emergency. Pending allocations %d\n",
-				      rb_pending_alloc);
+			IWL_DEBUG_TPT(
+				trans,
+				"RX path is in emergency. Pending allocations %d\n",
+				rb_pending_alloc);
 		}
 
 		IWL_DEBUG_RX(trans, "Q %d: HW = %d, SW = %d\n", rxq->id, r, i);
@@ -1585,9 +1592,10 @@ static int iwl_pcie_rx_handle(struct iwl_trans *trans, int queue, int budget)
 			if (count == 8) {
 				count = 0;
 				if (rb_pending_alloc < rxq->queue_size / 3) {
-					IWL_DEBUG_TPT(trans,
-						      "RX path exited emergency. Pending allocations %d\n",
-						      rb_pending_alloc);
+					IWL_DEBUG_TPT(
+						trans,
+						"RX path exited emergency. Pending allocations %d\n",
+						rb_pending_alloc);
 					emergency = false;
 				}
 
@@ -1682,9 +1690,9 @@ static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 	if (trans->cfg->internal_wimax_coex &&
 	    !trans->mac_cfg->base->apmg_not_supported &&
 	    (!(iwl_read_prph(trans, APMG_CLK_CTRL_REG) &
-			     APMS_CLK_VAL_MRB_FUNC_MODE) ||
+	       APMS_CLK_VAL_MRB_FUNC_MODE) ||
 	     (iwl_read_prph(trans, APMG_PS_CTRL_REG) &
-			    APMG_PS_CTRL_VAL_RESET_REQ))) {
+	      APMG_PS_CTRL_VAL_RESET_REQ))) {
 		clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
 		iwl_op_mode_wimax_active(trans->op_mode);
 		wake_up(&trans_pcie->wait_command_queue);
@@ -1730,9 +1738,9 @@ static u32 iwl_pcie_int_cause_non_ict(struct iwl_trans *trans)
 }
 
 /* a device (PCI-E) page is 4096 bytes long */
-#define ICT_SHIFT	12
-#define ICT_SIZE	(1 << ICT_SHIFT)
-#define ICT_COUNT	(ICT_SIZE / sizeof(u32))
+#define ICT_SHIFT 12
+#define ICT_SIZE (1 << ICT_SHIFT)
+#define ICT_COUNT (ICT_SIZE / sizeof(u32))
 
 /* interrupt handler using ict table, with this interrupt driver will
  * stop using INTA register to get device's interrupt, reading this register
@@ -1766,7 +1774,7 @@ static u32 iwl_pcie_int_cause_ict(struct iwl_trans *trans)
 	do {
 		val |= read;
 		IWL_DEBUG_ISR(trans, "ICT index %d value 0x%08X\n",
-				trans_pcie->ict_index, read);
+			      trans_pcie->ict_index, read);
 		trans_pcie->ict_tbl[trans_pcie->ict_index] = 0;
 		trans_pcie->ict_index =
 			((trans_pcie->ict_index + 1) & (ICT_COUNT - 1));
@@ -1822,8 +1830,7 @@ void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans, bool from_irq)
 	mutex_unlock(&trans_pcie->mutex);
 
 	if (hw_rfkill) {
-		if (test_and_clear_bit(STATUS_SYNC_HCMD_ACTIVE,
-				       &trans->status))
+		if (test_and_clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status))
 			IWL_DEBUG_RF_KILL(trans,
 					  "Rfkill while SYNC HCMD in flight\n");
 		wake_up(&trans_pcie->wait_command_queue);
@@ -1866,9 +1873,8 @@ static void iwl_trans_pcie_handle_reset_interrupt(struct iwl_trans *trans)
 		}
 		fallthrough;
 	case CSR_IPC_STATE_RESET_NONE:
-		IWL_FW_CHECK_FAILED(trans,
-				    "Invalid reset interrupt (state=%d)!\n",
-				    state);
+		IWL_FW_CHECK_FAILED(
+			trans, "Invalid reset interrupt (state=%d)!\n", state);
 		break;
 	case CSR_IPC_STATE_RESET_TOP_FOLLOWER:
 		if (trans_pcie->fw_reset_state == FW_RESET_REQUESTED) {
@@ -1909,11 +1915,12 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 		inta = iwl_pcie_int_cause_non_ict(trans);
 
 	if (iwl_have_debug_level(IWL_DL_ISR)) {
-		IWL_DEBUG_ISR(trans,
-			      "ISR inta 0x%08x, enabled 0x%08x(sw), enabled(hw) 0x%08x, fh 0x%08x\n",
-			      inta, trans_pcie->inta_mask,
-			      iwl_read32(trans, CSR_INT_MASK),
-			      iwl_read32(trans, CSR_FH_INT_STATUS));
+		IWL_DEBUG_ISR(
+			trans,
+			"ISR inta 0x%08x, enabled 0x%08x(sw), enabled(hw) 0x%08x, fh 0x%08x\n",
+			inta, trans_pcie->inta_mask,
+			iwl_read32(trans, CSR_INT_MASK),
+			iwl_read32(trans, CSR_FH_INT_STATUS));
 		if (inta & (~trans_pcie->inta_mask))
 			IWL_DEBUG_ISR(trans,
 				      "We got a masked interrupt (0x%08x)\n",
@@ -1964,8 +1971,8 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 	iwl_write32(trans, CSR_INT, inta | ~trans_pcie->inta_mask);
 
 	if (iwl_have_debug_level(IWL_DL_ISR))
-		IWL_DEBUG_ISR(trans, "inta 0x%08x, enabled 0x%08x\n",
-			      inta, iwl_read32(trans, CSR_INT_MASK));
+		IWL_DEBUG_ISR(trans, "inta 0x%08x, enabled 0x%08x\n", inta,
+			      iwl_read32(trans, CSR_INT_MASK));
 
 	spin_unlock_bh(&trans_pcie->irq_lock);
 
@@ -1986,8 +1993,9 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 
 	/* NIC fires this, but we don't use it, redundant with WAKEUP */
 	if (inta & CSR_INT_BIT_SCD) {
-		IWL_DEBUG_ISR(trans,
-			      "Scheduler finished to transmit the frame/frames.\n");
+		IWL_DEBUG_ISR(
+			trans,
+			"Scheduler finished to transmit the frame/frames.\n");
 		isr_stats->sch++;
 	}
 
@@ -2029,8 +2037,10 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 
 	/* Error detected by uCode */
 	if (inta & CSR_INT_BIT_SW_ERR) {
-		IWL_ERR(trans, "Microcode SW error detected. "
-			" Restarting 0x%X.\n", inta);
+		IWL_ERR(trans,
+			"Microcode SW error detected. "
+			" Restarting 0x%X.\n",
+			inta);
 		isr_stats->sw++;
 		if (trans_pcie->fw_reset_state == FW_RESET_REQUESTED) {
 			trans_pcie->fw_reset_state = FW_RESET_ERROR;
@@ -2055,18 +2065,17 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 	/* All uCode command responses, including Tx command responses,
 	 * Rx "responses" (frame-received notification), and other
 	 * notifications from uCode come through here*/
-	if (inta & (CSR_INT_BIT_FH_RX | CSR_INT_BIT_SW_RX |
-		    CSR_INT_BIT_RX_PERIODIC)) {
+	if (inta &
+	    (CSR_INT_BIT_FH_RX | CSR_INT_BIT_SW_RX | CSR_INT_BIT_RX_PERIODIC)) {
 		IWL_DEBUG_ISR(trans, "Rx interrupt\n");
 		if (inta & (CSR_INT_BIT_FH_RX | CSR_INT_BIT_SW_RX)) {
 			handled |= (CSR_INT_BIT_FH_RX | CSR_INT_BIT_SW_RX);
 			iwl_write32(trans, CSR_FH_INT_STATUS,
-					CSR_FH_INT_RX_MASK);
+				    CSR_FH_INT_RX_MASK);
 		}
 		if (inta & CSR_INT_BIT_RX_PERIODIC) {
 			handled |= CSR_INT_BIT_RX_PERIODIC;
-			iwl_write32(trans,
-				CSR_INT, CSR_INT_BIT_RX_PERIODIC);
+			iwl_write32(trans, CSR_INT, CSR_INT_BIT_RX_PERIODIC);
 		}
 		/* Sending RX interrupt require many steps to be done in the
 		 * device:
@@ -2080,8 +2089,7 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 		 */
 
 		/* Disable periodic interrupt; we use it as just a one-shot. */
-		iwl_write8(trans, CSR_INT_PERIODIC_REG,
-			    CSR_INT_PERIODIC_DIS);
+		iwl_write8(trans, CSR_INT_PERIODIC_REG, CSR_INT_PERIODIC_DIS);
 
 		/*
 		 * Enable periodic interrupt in 8 msec only if we received
@@ -2164,8 +2172,7 @@ void iwl_pcie_free_ict(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
 	if (trans_pcie->ict_tbl) {
-		dma_free_coherent(trans->dev, ICT_SIZE,
-				  trans_pcie->ict_tbl,
+		dma_free_coherent(trans->dev, ICT_SIZE, trans_pcie->ict_tbl,
 				  trans_pcie->ict_tbl_dma);
 		trans_pcie->ict_tbl = NULL;
 		trans_pcie->ict_tbl_dma = 0;
@@ -2181,9 +2188,8 @@ int iwl_pcie_alloc_ict(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	trans_pcie->ict_tbl =
-		dma_alloc_coherent(trans->dev, ICT_SIZE,
-				   &trans_pcie->ict_tbl_dma, GFP_KERNEL);
+	trans_pcie->ict_tbl = dma_alloc_coherent(
+		trans->dev, ICT_SIZE, &trans_pcie->ict_tbl_dma, GFP_KERNEL);
 	if (!trans_pcie->ict_tbl)
 		return -ENOMEM;
 
@@ -2214,8 +2220,7 @@ void iwl_pcie_reset_ict(struct iwl_trans *trans)
 
 	val = trans_pcie->ict_tbl_dma >> ICT_SHIFT;
 
-	val |= CSR_DRAM_INT_TBL_ENABLE |
-	       CSR_DRAM_INIT_TBL_WRAP_CHECK |
+	val |= CSR_DRAM_INT_TBL_ENABLE | CSR_DRAM_INIT_TBL_WRAP_CHECK |
 	       CSR_DRAM_INIT_TBL_WRITE_POINTER;
 
 	IWL_DEBUG_ISR(trans, "CSR_DRAM_INT_TBL_REG =0x%x\n", val);
@@ -2298,10 +2303,11 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	}
 
 	if (iwl_have_debug_level(IWL_DL_ISR)) {
-		IWL_DEBUG_ISR(trans,
-			      "ISR[%d] inta_fh 0x%08x, enabled (sw) 0x%08x (hw) 0x%08x\n",
-			      entry->entry, inta_fh, trans_pcie->fh_mask,
-			      iwl_read32(trans, CSR_MSIX_FH_INT_MASK_AD));
+		IWL_DEBUG_ISR(
+			trans,
+			"ISR[%d] inta_fh 0x%08x, enabled (sw) 0x%08x (hw) 0x%08x\n",
+			entry->entry, inta_fh, trans_pcie->fh_mask,
+			iwl_read32(trans, CSR_MSIX_FH_INT_MASK_AD));
 		if (inta_fh & ~trans_pcie->fh_mask)
 			IWL_DEBUG_ISR(trans,
 				      "We got a masked interrupt (0x%08x)\n",
@@ -2400,10 +2406,11 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 
 	/* After checking FH register check HW register */
 	if (iwl_have_debug_level(IWL_DL_ISR)) {
-		IWL_DEBUG_ISR(trans,
-			      "ISR[%d] inta_hw 0x%08x, enabled (sw) 0x%08x (hw) 0x%08x\n",
-			      entry->entry, inta_hw, trans_pcie->hw_mask,
-			      iwl_read32(trans, CSR_MSIX_HW_INT_MASK_AD));
+		IWL_DEBUG_ISR(
+			trans,
+			"ISR[%d] inta_hw 0x%08x, enabled (sw) 0x%08x (hw) 0x%08x\n",
+			entry->entry, inta_hw, trans_pcie->hw_mask,
+			iwl_read32(trans, CSR_MSIX_HW_INT_MASK_AD));
 		if (inta_hw & ~trans_pcie->hw_mask)
 			IWL_DEBUG_ISR(trans,
 				      "We got a masked interrupt 0x%08x\n",
@@ -2433,9 +2440,10 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 
 		if (sleep_notif == IWL_D3_SLEEP_STATUS_SUSPEND ||
 		    sleep_notif == IWL_D3_SLEEP_STATUS_RESUME) {
-			IWL_DEBUG_ISR(trans,
-				      "Sx interrupt: sleep notification = 0x%x\n",
-				      sleep_notif);
+			IWL_DEBUG_ISR(
+				trans,
+				"Sx interrupt: sleep notification = 0x%x\n",
+				sleep_notif);
 			if (trans_pcie->sx_state == IWL_SX_WAITING) {
 				trans_pcie->sx_state = IWL_SX_COMPLETE;
 				wake_up(&trans_pcie->sx_waitq);
@@ -2465,8 +2473,7 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 		iwl_pcie_handle_rfkill_irq(trans, true);
 
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_HW_ERR) {
-		IWL_ERR(trans,
-			"Hardware error detected. Restarting.\n");
+		IWL_ERR(trans, "Hardware error detected. Restarting.\n");
 
 		isr_stats->hw++;
 		trans->dbg.hw_error = true;
-- 
2.52.0


