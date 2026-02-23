Return-Path: <linux-wireless+bounces-32107-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLm9BlpMnGnYDQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32107-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 13:47:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B33176678
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 13:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BCDD305B4A3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 12:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E8D3659EA;
	Mon, 23 Feb 2026 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="S3UkBVTD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C683644CF
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850451; cv=none; b=afaaLyf1OrqlCtMZjqjFZZj7Fy/SJeKTv03UVQ6WzXKjJwXoMdm7g+s7mtJUeXcKrWDDjDsbXCF5CSHNgOxVdhAV9bfEhAVB4onEb5XCij+egI3/twEZY/dZGH6WAIDf7AqOc1nJsHcisXmsW/Z00JhP1bjvKIjz5YFjchu37FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850451; c=relaxed/simple;
	bh=kbmc3vTDtj3/PkH5XedUP/gaL2/SoJlUeEJD6rMGjiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtWXJhu+AIB+YSC8bghAMu4M5nSnDrOa6/d9eu/LaDrcyLqM4tPwFFncbNW29ZDHoFv0ZZM5Cx1mJjcnG5hIJq8gHlXTcRdVtGVj2XrFQ6UDnaUlk8XtTAdP0x9G2V9o/Pm8oSGgbWpUgLNkBv34bC5eyrc7lwD4vKtuu1YxANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=S3UkBVTD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=l58ByOIWZMTuNoUXMD6JHDf7i3Nhv8stVpQp+VvvrAw=;
	t=1771850449; x=1773060049; b=S3UkBVTDKzNh/2stk0oJ3NI8ZDQVrqbk04tV1XSCAa/L0WU
	WqpOTTOX0XTCd/zmkqYwRn+06ROPc8wExN6RjNFEFuropQG+cqpTxAqZhw+reCn9vlzltz3gvDX6h
	0I/jF2tZOphu1TJjNxPhTSVJozXEs3fxH6rwEDh1y8OtKpaHlkDwsZ2PVHiDUsQbyjx5jAOVAY9Sl
	fm8e/v+BXlhv6UIJ2gjp7tH84nACfMRqroKpyNSR0BEcyH1G+x9tvVUnuLWfGipKozE5AxwqXiEQ/
	ll0cL+56dfXbapSqdv3IMUgylU2W5f3UiG2nqpcIJBwZZSAorVVc5m8fzRL/nEhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vuVEz-0000000H2xI-3RTv;
	Mon, 23 Feb 2026 13:40:46 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH v2 1/8] wifi: iwlwifi: use link_sta internally to the driver
Date: Mon, 23 Feb 2026 13:38:20 +0100
Message-ID: <20260223133818.d6f57dc57d23.I41df561f8129fac1327a07729cf4734b8752bcd6@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223123818.384184-10-benjamin@sipsolutions.net>
References: <20260223123818.384184-10-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-32107-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: A4B33176678
X-Rspamd-Action: no action

From: Benjamin Berg <benjamin.berg@intel.com>

Using the link_sta is a natural way to pass both the STA and the link ID
information at the same time. Use that internally to the driver in
preparation to mac80211 changing its API and adopting the same method.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/agg.c  | 21 +++++----
 drivers/net/wireless/intel/iwlwifi/mld/agg.h  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   | 45 ++++++++++---------
 drivers/net/wireless/intel/iwlwifi/mld/rx.h   |  2 +-
 .../wireless/intel/iwlwifi/mld/tests/agg.c    |  7 +--
 5 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/agg.c b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
index 3bf36f8f6874..c4f3552bd2ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/agg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
@@ -1,13 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #include "agg.h"
 #include "sta.h"
 #include "hcmd.h"
 
 static void
-iwl_mld_reorder_release_frames(struct iwl_mld *mld, struct ieee80211_sta *sta,
+iwl_mld_reorder_release_frames(struct iwl_mld *mld,
+			       struct ieee80211_link_sta *link_sta,
 			       struct napi_struct *napi,
 			       struct iwl_mld_baid_data *baid_data,
 			       struct iwl_mld_reorder_buffer *reorder_buf,
@@ -32,7 +33,7 @@ iwl_mld_reorder_release_frames(struct iwl_mld *mld, struct ieee80211_sta *sta,
 		while ((skb = __skb_dequeue(skb_list))) {
 			iwl_mld_pass_packet_to_mac80211(mld, napi, skb,
 							reorder_buf->queue,
-							sta);
+							link_sta);
 			reorder_buf->num_stored--;
 		}
 	}
@@ -71,7 +72,7 @@ static void iwl_mld_release_frames_from_notif(struct iwl_mld *mld,
 
 	reorder_buf = &ba_data->reorder_buf[queue];
 
-	iwl_mld_reorder_release_frames(mld, link_sta->sta, napi, ba_data,
+	iwl_mld_reorder_release_frames(mld, link_sta, napi, ba_data,
 				       reorder_buf, nssn);
 out_unlock:
 	rcu_read_unlock();
@@ -174,7 +175,7 @@ void iwl_mld_del_ba(struct iwl_mld *mld, int queue,
 	reorder_buf = &ba_data->reorder_buf[queue];
 
 	/* release all frames that are in the reorder buffer to the stack */
-	iwl_mld_reorder_release_frames(mld, link_sta->sta, NULL,
+	iwl_mld_reorder_release_frames(mld, link_sta, NULL,
 				       ba_data, reorder_buf,
 				       ieee80211_sn_add(reorder_buf->head_sn,
 							ba_data->buf_size));
@@ -187,14 +188,14 @@ void iwl_mld_del_ba(struct iwl_mld *mld, int queue,
  */
 enum iwl_mld_reorder_result
 iwl_mld_reorder(struct iwl_mld *mld, struct napi_struct *napi,
-		int queue, struct ieee80211_sta *sta,
+		int queue, struct ieee80211_link_sta *link_sta,
 		struct sk_buff *skb, struct iwl_rx_mpdu_desc *desc)
 {
 	struct ieee80211_hdr *hdr = (void *)skb_mac_header(skb);
 	struct iwl_mld_baid_data *baid_data;
 	struct iwl_mld_reorder_buffer *buffer;
 	struct iwl_mld_reorder_buf_entry *entries;
-	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+	struct iwl_mld_sta *mld_sta;
 	struct iwl_mld_link_sta *mld_link_sta;
 	u32 reorder = le32_to_cpu(desc->reorder_data);
 	bool amsdu, last_subframe, is_old_sn, is_dup;
@@ -217,10 +218,12 @@ iwl_mld_reorder(struct iwl_mld *mld, struct napi_struct *napi,
 		return IWL_MLD_PASS_SKB;
 
 	/* no sta yet */
-	if (WARN_ONCE(!sta,
+	if (WARN_ONCE(!link_sta,
 		      "Got valid BAID without a valid station assigned\n"))
 		return IWL_MLD_PASS_SKB;
 
+	mld_sta = iwl_mld_sta_from_mac80211(link_sta->sta);
+
 	/* not a data packet */
 	if (!ieee80211_is_data_qos(hdr->frame_control) ||
 	    is_multicast_ether_addr(hdr->addr1))
@@ -310,7 +313,7 @@ iwl_mld_reorder(struct iwl_mld *mld, struct napi_struct *napi,
 	 * will be released when the frame release notification arrives.
 	 */
 	if (!amsdu || last_subframe)
-		iwl_mld_reorder_release_frames(mld, sta, napi, baid_data,
+		iwl_mld_reorder_release_frames(mld, link_sta, napi, baid_data,
 					       buffer, nssn);
 	else if (buffer->num_stored == 1)
 		buffer->head_sn = nssn;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/agg.h b/drivers/net/wireless/intel/iwlwifi/mld/agg.h
index 651c80d1c7cd..c6cd5fa219be 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/agg.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/agg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024, 2026 Intel Corporation
  */
 #ifndef __iwl_agg_h__
 #define __iwl_agg_h__
@@ -106,7 +106,7 @@ int iwl_mld_ampdu_rx_stop(struct iwl_mld *mld, struct ieee80211_sta *sta,
 
 enum iwl_mld_reorder_result
 iwl_mld_reorder(struct iwl_mld *mld, struct napi_struct *napi,
-		int queue, struct ieee80211_sta *sta,
+		int queue, struct ieee80211_link_sta *link_sta,
 		struct sk_buff *skb, struct iwl_rx_mpdu_desc *desc);
 
 void iwl_mld_handle_frame_release_notif(struct iwl_mld *mld,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index 214dcfde2fb4..de2feeb74009 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -48,7 +48,8 @@ iwl_mld_fill_phy_data_from_mpdu(struct iwl_mld *mld,
 }
 
 static inline int iwl_mld_check_pn(struct iwl_mld *mld, struct sk_buff *skb,
-				   int queue, struct ieee80211_sta *sta)
+				   int queue,
+				   struct ieee80211_link_sta *link_sta)
 {
 	struct ieee80211_hdr *hdr = (void *)skb_mac_header(skb);
 	struct ieee80211_rx_status *stats = IEEE80211_SKB_RXCB(skb);
@@ -72,13 +73,13 @@ static inline int iwl_mld_check_pn(struct iwl_mld *mld, struct sk_buff *skb,
 		return 0;
 
 	/* if we are here - this for sure is either CCMP or GCMP */
-	if (!sta) {
+	if (!link_sta) {
 		IWL_DEBUG_DROP(mld,
 			       "expected hw-decrypted unicast frame for station\n");
 		return -1;
 	}
 
-	mld_sta = iwl_mld_sta_from_mac80211(sta);
+	mld_sta = iwl_mld_sta_from_mac80211(link_sta->sta);
 
 	extiv = (u8 *)hdr + ieee80211_hdrlen(hdr->frame_control);
 	keyidx = extiv[3] >> 6;
@@ -120,17 +121,17 @@ static inline int iwl_mld_check_pn(struct iwl_mld *mld, struct sk_buff *skb,
 void iwl_mld_pass_packet_to_mac80211(struct iwl_mld *mld,
 				     struct napi_struct *napi,
 				     struct sk_buff *skb, int queue,
-				     struct ieee80211_sta *sta)
+				     struct ieee80211_link_sta *link_sta)
 {
 	KUNIT_STATIC_STUB_REDIRECT(iwl_mld_pass_packet_to_mac80211,
-				   mld, napi, skb, queue, sta);
+				   mld, napi, skb, queue, link_sta);
 
-	if (unlikely(iwl_mld_check_pn(mld, skb, queue, sta))) {
+	if (unlikely(iwl_mld_check_pn(mld, skb, queue, link_sta))) {
 		kfree_skb(skb);
 		return;
 	}
 
-	ieee80211_rx_napi(mld->hw, sta, skb, napi);
+	ieee80211_rx_napi(mld->hw, link_sta->sta, skb, napi);
 }
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_pass_packet_to_mac80211);
 
@@ -1728,7 +1729,7 @@ static void iwl_mld_update_last_rx_timestamp(struct iwl_mld *mld, u8 baid)
  * Sets *drop to true if the packet should be dropped.
  * Returns the station if found, or NULL otherwise.
  */
-static struct ieee80211_sta *
+static struct ieee80211_link_sta *
 iwl_mld_rx_with_sta(struct iwl_mld *mld, struct ieee80211_hdr *hdr,
 		    struct sk_buff *skb,
 		    const struct iwl_rx_mpdu_desc *mpdu_desc,
@@ -1803,10 +1804,10 @@ iwl_mld_rx_with_sta(struct iwl_mld *mld, struct ieee80211_hdr *hdr,
 							    queue);
 	}
 
-	return sta;
+	return link_sta;
 }
 
-static int iwl_mld_rx_mgmt_prot(struct ieee80211_sta *sta,
+static int iwl_mld_rx_mgmt_prot(struct ieee80211_link_sta *link_sta,
 				struct ieee80211_hdr *hdr,
 				struct ieee80211_rx_status *rx_status,
 				u32 mpdu_status,
@@ -1820,7 +1821,6 @@ static int iwl_mld_rx_mgmt_prot(struct ieee80211_sta *sta,
 	struct ieee80211_key_conf *key;
 	const u8 *frame = (void *)hdr;
 	const u8 *mmie;
-	u8 link_id;
 
 	if ((mpdu_status & IWL_RX_MPDU_STATUS_SEC_MASK) ==
 	     IWL_RX_MPDU_STATUS_SEC_NONE)
@@ -1836,10 +1836,10 @@ static int iwl_mld_rx_mgmt_prot(struct ieee80211_sta *sta,
 	if (!ieee80211_is_beacon(hdr->frame_control))
 		return 0;
 
-	if (!sta)
+	if (!link_sta)
 		return -1;
 
-	mld_sta = iwl_mld_sta_from_mac80211(sta);
+	mld_sta = iwl_mld_sta_from_mac80211(link_sta->sta);
 	mld_vif = iwl_mld_vif_from_mac80211(mld_sta->vif);
 
 	/* key mismatch - will also report !MIC_OK but we shouldn't count it */
@@ -1853,8 +1853,7 @@ static int iwl_mld_rx_mgmt_prot(struct ieee80211_sta *sta,
 		return 0;
 	}
 
-	link_id = rx_status->link_valid ? rx_status->link_id : 0;
-	link = rcu_dereference(mld_vif->link[link_id]);
+	link = rcu_dereference(mld_vif->link[link_sta->link_id]);
 	if (WARN_ON_ONCE(!link))
 		return -1;
 
@@ -1905,7 +1904,7 @@ static int iwl_mld_rx_mgmt_prot(struct ieee80211_sta *sta,
 }
 
 static int iwl_mld_rx_crypto(struct iwl_mld *mld,
-			     struct ieee80211_sta *sta,
+			     struct ieee80211_link_sta *link_sta,
 			     struct ieee80211_hdr *hdr,
 			     struct ieee80211_rx_status *rx_status,
 			     struct iwl_rx_mpdu_desc *desc, int queue,
@@ -1915,7 +1914,7 @@ static int iwl_mld_rx_crypto(struct iwl_mld *mld,
 
 	if (unlikely(ieee80211_is_mgmt(hdr->frame_control) &&
 		     !ieee80211_has_protected(hdr->frame_control)))
-		return iwl_mld_rx_mgmt_prot(sta, hdr, rx_status, status,
+		return iwl_mld_rx_mgmt_prot(link_sta, hdr, rx_status, status,
 					    le16_to_cpu(desc->mpdu_len));
 
 	if (!ieee80211_has_protected(hdr->frame_control) ||
@@ -2023,7 +2022,7 @@ void iwl_mld_rx_mpdu(struct iwl_mld *mld, struct napi_struct *napi,
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_mld_rx_phy_data phy_data = {};
 	struct iwl_rx_mpdu_desc *mpdu_desc = (void *)pkt->data;
-	struct ieee80211_sta *sta;
+	struct ieee80211_link_sta *link_sta;
 	struct ieee80211_hdr *hdr;
 	struct sk_buff *skb;
 	size_t mpdu_desc_size = sizeof(*mpdu_desc);
@@ -2086,7 +2085,8 @@ void iwl_mld_rx_mpdu(struct iwl_mld *mld, struct napi_struct *napi,
 
 	rcu_read_lock();
 
-	sta = iwl_mld_rx_with_sta(mld, hdr, skb, mpdu_desc, pkt, queue, &drop);
+	link_sta = iwl_mld_rx_with_sta(mld, hdr, skb, mpdu_desc, pkt, queue,
+				       &drop);
 	if (drop)
 		goto drop;
 
@@ -2127,7 +2127,7 @@ void iwl_mld_rx_mpdu(struct iwl_mld *mld, struct napi_struct *napi,
 
 	iwl_mld_rx_fill_status(mld, link_id, hdr, skb, &phy_data);
 
-	if (iwl_mld_rx_crypto(mld, sta, hdr, rx_status, mpdu_desc, queue,
+	if (iwl_mld_rx_crypto(mld, link_sta, hdr, rx_status, mpdu_desc, queue,
 			      le32_to_cpu(pkt->len_n_flags), &crypto_len))
 		goto drop;
 
@@ -2140,7 +2140,8 @@ void iwl_mld_rx_mpdu(struct iwl_mld *mld, struct napi_struct *napi,
 	if (iwl_mld_time_sync_frame(mld, skb, hdr->addr2))
 		goto out;
 
-	reorder_res = iwl_mld_reorder(mld, napi, queue, sta, skb, mpdu_desc);
+	reorder_res = iwl_mld_reorder(mld, napi, queue, link_sta, skb,
+				      mpdu_desc);
 	switch (reorder_res) {
 	case IWL_MLD_PASS_SKB:
 		break;
@@ -2153,7 +2154,7 @@ void iwl_mld_rx_mpdu(struct iwl_mld *mld, struct napi_struct *napi,
 		goto drop;
 	}
 
-	iwl_mld_pass_packet_to_mac80211(mld, napi, skb, queue, sta);
+	iwl_mld_pass_packet_to_mac80211(mld, napi, skb, queue, link_sta);
 
 	goto out;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.h b/drivers/net/wireless/intel/iwlwifi/mld/rx.h
index 09dddbd40f55..a54f1a6146ee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.h
@@ -64,7 +64,7 @@ void iwl_mld_handle_rx_queues_sync_notif(struct iwl_mld *mld,
 void iwl_mld_pass_packet_to_mac80211(struct iwl_mld *mld,
 				     struct napi_struct *napi,
 				     struct sk_buff *skb, int queue,
-				     struct ieee80211_sta *sta);
+				     struct ieee80211_link_sta *link_sta);
 
 void iwl_mld_handle_phy_air_sniffer_notif(struct iwl_mld *mld,
 					  struct napi_struct *napi,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c
index 29b0248cec3d..e9efe2996f07 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c
@@ -2,7 +2,7 @@
 /*
  * KUnit tests for channel helper functions
  *
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #include <kunit/test.h>
 #include <kunit/static_stub.h>
@@ -441,7 +441,7 @@ static void
 fake_iwl_mld_pass_packet_to_mac80211(struct iwl_mld *mld,
 				     struct napi_struct *napi,
 				     struct sk_buff *skb, int queue,
-				     struct ieee80211_sta *sta)
+				     struct ieee80211_link_sta *link_sta)
 {
 	__skb_queue_tail(&g_released_skbs, skb);
 	g_num_released_skbs++;
@@ -630,7 +630,8 @@ static void test_reorder_buffer(struct kunit *test)
 	mpdu_desc = setup_mpdu_desc();
 
 	rcu_read_lock();
-	reorder_res = iwl_mld_reorder(mld, NULL, QUEUE, sta, skb, mpdu_desc);
+	reorder_res = iwl_mld_reorder(mld, NULL, QUEUE, &sta->deflink, skb,
+				      mpdu_desc);
 	rcu_read_unlock();
 
 	KUNIT_ASSERT_EQ(test, reorder_res, param->expected.reorder_res);
-- 
2.53.0


