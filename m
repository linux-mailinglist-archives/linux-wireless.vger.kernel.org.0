Return-Path: <linux-wireless+bounces-32108-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIT6E89LnGnYDQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32108-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 13:45:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DC61765E1
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 13:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4AFC3038738
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 12:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE16366043;
	Mon, 23 Feb 2026 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FABPncrU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE2D364EA4
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850451; cv=none; b=LtzJbtrSAjo4iuG6lhw3jnSPHm0dKIrk5FNIu0zlgVsGfG9BdFgfgyzvkO90Uxaxeen8oqQAYYl3V69xcaEkHyM2WBDiKdQPOd3IKO512efkbgLSQfz3p9Ex5o2N1DZqbuMSUAVTIr/522TNXgDQz6ZlqgwkVJLZKLgsdn86PBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850451; c=relaxed/simple;
	bh=UHza/Jz4aYo8jQ86t49eWvNKI9EAGCuHAfNleNjAnNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRgcsj67tweGzt78p/0ezaDqsuYBRUWdLoqORapoVdr7mwfcQnjTsFiQBAjdCAwjwHJOQe7VBJXmbibOB5bJv7IUW9BzYBwiAD5FSNc91oimW1NVNRI4X+fy0hlnH85xDNk7sLizok7O5BeYS9slTeb+suBIK5CLAcImbo8TLHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FABPncrU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ba71ECfgy14sDywb3r8LjkJe53mqwr4B/AW3li9Tveg=;
	t=1771850449; x=1773060049; b=FABPncrU5zTUuzKkwI7d6qmHKMfI6bgghFkSS9ZiHsbbEdX
	VpPa0d5OOdGsHNd8nVlwdx3/LNaoUZzQiAGDbEfjymM3NElohtbcDR0EK4yJxTAm1t7hCrzbW/PqP
	oI/sjuFerfkVc9sVgkSNgN8x+3QvLnxwjVCihP/3dj0t55SPiaOvtI44iZwZmbemcvS/zOiXlcxTB
	5uRuBUehzERS0qK7l1Auapbof6SghcUmo00ldpY3dj5xPsG6XoWbZxXJ2Ass1dbv5QGkRxUdlDJat
	bEFpvaYDafsDghNYHsWp9rAmOWpP1bXSovQwegKxvGzjAvFxKmHlYTVz7r3f4vAA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vuVF0-0000000H2xI-1pAW;
	Mon, 23 Feb 2026 13:40:46 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH v2 2/8] wifi: mac80211: change public RX API to use link stations
Date: Mon, 23 Feb 2026 13:38:21 +0100
Message-ID: <20260223133818.f2ed2b718c41.I4a2d45609e94b52654b10ec572e59a45d09c41f4@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-32108-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9DC61765E1
X-Rspamd-Action: no action

From: Benjamin Berg <benjamin.berg@intel.com>

If a station is passed then the link ID also needs to be known. As such,
it is a more natural API to simply pass the link station directly rather
than pushing the link information into the RX status.

Furthermore, having the link ID in the RX status is not actually correct
because the link IDs are VIF specific and there may be multiple VIFs. In
the case of a station this relationship is clear, but then one may as
well use the link station.

This patch only changes the API and emulates the old (incorrect)
behaviour for now. The mac80211 RX code will be updated in later
patches.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c       |  2 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 18 +++++++--------
 drivers/net/wireless/ath/ath12k/dp_rx.c       | 15 +++++++++----
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |  7 +-----
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  6 ++---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 22 +++++++++++--------
 drivers/net/wireless/realtek/rtw89/core.c     |  6 -----
 drivers/net/wireless/virtual/mac80211_hwsim.c |  3 ---
 include/net/mac80211.h                        | 16 ++++++++++----
 net/mac80211/rx.c                             | 20 ++++++++++++-----
 11 files changed, 65 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index b9e976ddcbbf..911e40178234 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2500,7 +2500,7 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
 	    !(is_mcbc && rx_status->flag & RX_FLAG_DECRYPTED))
 		rx_status->flag |= RX_FLAG_8023;
 
-	ieee80211_rx_napi(ar->hw, pubsta, msdu, napi);
+	ieee80211_rx_napi(ar->hw, &pubsta->deflink, msdu, napi);
 }
 
 static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 737287a9aa46..71f14f2e15bd 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -508,7 +508,7 @@ void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
 	};
 	struct ieee80211_rx_status *rx_status;
 	struct ieee80211_radiotap_he *he = NULL;
-	struct ieee80211_sta *pubsta = NULL;
+	struct ieee80211_link_sta *link_pubsta = NULL;
 	struct ath12k_dp_link_peer *peer;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	struct hal_rx_desc_data rx_info;
@@ -517,8 +517,6 @@ void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
 	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
 	u8 addr[ETH_ALEN] = {};
 
-	status->link_valid = 0;
-
 	if ((status->encoding == RX_ENC_HE) && !(status->flag & RX_FLAG_RADIOTAP_HE) &&
 	    !(status->flag & RX_FLAG_SKIP_MONITOR)) {
 		he = skb_push(msdu, sizeof(known));
@@ -532,12 +530,11 @@ void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
 	spin_lock_bh(&dp->dp_lock);
 	peer = ath12k_dp_rx_h_find_link_peer(dp_pdev, msdu, &rx_info);
 	if (peer && peer->sta) {
-		pubsta = peer->sta;
-		memcpy(addr, peer->addr, ETH_ALEN);
-		if (pubsta->valid_links) {
-			status->link_valid = 1;
-			status->link_id = peer->link_id;
-		}
+		if (peer->sta->valid_links)
+			link_pubsta =
+				rcu_dereference(peer->sta->link[peer->link_id]);
+		else
+			link_pubsta = &peer->sta->deflink;
 	}
 
 	spin_unlock_bh(&dp->dp_lock);
@@ -583,7 +580,8 @@ void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
 	    !(is_mcbc && rx_status->flag & RX_FLAG_DECRYPTED))
 		rx_status->flag |= RX_FLAG_8023;
 
-	ieee80211_rx_napi(ath12k_pdev_dp_to_hw(dp_pdev), pubsta, msdu, napi);
+	ieee80211_rx_napi(ath12k_pdev_dp_to_hw(dp_pdev), link_pubsta, msdu,
+			  napi);
 }
 EXPORT_SYMBOL(ath12k_dp_mon_rx_deliver_msdu);
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index a32ee9f8061a..49b161c5a878 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1329,6 +1329,7 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ieee80211_rx_status *rx_status;
 	struct ieee80211_sta *pubsta;
+	struct ieee80211_link_sta *link_pubsta = NULL;
 	struct ath12k_dp_peer *peer;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	struct ieee80211_rx_status *status = rx_info->rx_status;
@@ -1340,9 +1341,14 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 
 	pubsta = peer ? peer->sta : NULL;
 
-	if (pubsta && pubsta->valid_links) {
-		status->link_valid = 1;
-		status->link_id = peer->hw_links[rxcb->hw_link_id];
+	if (pubsta) {
+		if (pubsta->valid_links) {
+			u8 link_id = peer->hw_links[rxcb->hw_link_id];
+			link_pubsta =
+				rcu_dereference(pubsta->link[link_id]);
+		} else {
+			link_pubsta = &pubsta->deflink;
+		}
 	}
 
 	ath12k_dbg(dp->ab, ATH12K_DBG_DATA,
@@ -1388,7 +1394,8 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 	    !(is_mcbc && rx_status->flag & RX_FLAG_DECRYPTED))
 		rx_status->flag |= RX_FLAG_8023;
 
-	ieee80211_rx_napi(ath12k_pdev_dp_to_hw(dp_pdev), pubsta, msdu, napi);
+	ieee80211_rx_napi(ath12k_pdev_dp_to_hw(dp_pdev), link_pubsta, msdu,
+			  napi);
 }
 EXPORT_SYMBOL(ath12k_dp_rx_deliver_msdu);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index de2feeb74009..2a12ae412bfd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -131,7 +131,7 @@ void iwl_mld_pass_packet_to_mac80211(struct iwl_mld *mld,
 		return;
 	}
 
-	ieee80211_rx_napi(mld->hw, link_sta->sta, skb, napi);
+	ieee80211_rx_napi(mld->hw, link_sta, skb, napi);
 }
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_pass_packet_to_mac80211);
 
@@ -1765,11 +1765,6 @@ iwl_mld_rx_with_sta(struct iwl_mld *mld, struct ieee80211_hdr *hdr,
 
 	rx_status = IEEE80211_SKB_RXCB(skb);
 
-	if (link_sta && sta->valid_links) {
-		rx_status->link_valid = true;
-		rx_status->link_id = link_sta->link_id;
-	}
-
 	/* fill checksum */
 	if (ieee80211_is_data(hdr->frame_control) &&
 	    pkt->len_n_flags & cpu_to_le32(FH_RSCSR_RPA_EN)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index d0c0faae0122..a83bede06487 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -90,7 +90,7 @@ static void iwl_mvm_pass_packet_to_mac80211(struct iwl_mvm *mvm,
 				fraglen, rxb->truesize);
 	}
 
-	ieee80211_rx_napi(mvm->hw, sta, skb, napi);
+	ieee80211_rx_napi(mvm->hw, &sta->deflink, skb, napi);
 }
 
 /*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 7f0b4f5daa21..fe5a2d0a798b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -243,7 +243,7 @@ static void iwl_mvm_pass_packet_to_mac80211(struct iwl_mvm *mvm,
 		return;
 	}
 
-	ieee80211_rx_napi(mvm->hw, sta, skb, napi);
+	ieee80211_rx_napi(mvm->hw, &sta->deflink, skb, napi);
 }
 
 static bool iwl_mvm_used_average_energy(struct iwl_mvm *mvm,
@@ -2528,7 +2528,7 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	}
 
 	rcu_read_lock();
-	ieee80211_rx_napi(mvm->hw, sta, skb, napi);
+	ieee80211_rx_napi(mvm->hw, &sta->deflink, skb, napi);
 	rcu_read_unlock();
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 75772979f438..a0b887c83591 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1232,7 +1232,7 @@ EXPORT_SYMBOL(mt76_rx_signal);
 static void
 mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
 		struct ieee80211_hw **hw,
-		struct ieee80211_sta **sta)
+		struct ieee80211_link_sta **link_sta)
 {
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
@@ -1279,11 +1279,15 @@ mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
 	       sizeof(mstat.chain_signal));
 
 	if (mstat.wcid) {
-		status->link_valid = mstat.wcid->link_valid;
-		status->link_id = mstat.wcid->link_id;
+		struct ieee80211_sta *sta = wcid_to_sta(mstat.wcid);
+
+		if (mstat.wcid->link_valid)
+			*link_sta =
+				rcu_dereference(sta->link[mstat.wcid->link_id]);
+		else
+			*link_sta = &sta->deflink;
 	}
 
-	*sta = wcid_to_sta(mstat.wcid);
 	*hw = mt76_phy_hw(dev, mstat.phy_idx);
 }
 
@@ -1507,7 +1511,7 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
 		      struct napi_struct *napi)
 {
-	struct ieee80211_sta *sta;
+	struct ieee80211_link_sta *link_sta;
 	struct ieee80211_hw *hw;
 	struct sk_buff *skb, *tmp;
 	LIST_HEAD(list);
@@ -1518,8 +1522,8 @@ void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
 
 		mt76_check_ccmp_pn(skb);
 		skb_shinfo(skb)->frag_list = NULL;
-		mt76_rx_convert(dev, skb, &hw, &sta);
-		ieee80211_rx_list(hw, sta, skb, &list);
+		mt76_rx_convert(dev, skb, &hw, &link_sta);
+		ieee80211_rx_list(hw, link_sta, skb, &list);
 
 		/* subsequent amsdu frames */
 		while (nskb) {
@@ -1527,8 +1531,8 @@ void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
 			nskb = nskb->next;
 			skb->next = NULL;
 
-			mt76_rx_convert(dev, skb, &hw, &sta);
-			ieee80211_rx_list(hw, sta, skb, &list);
+			mt76_rx_convert(dev, skb, &hw, &link_sta);
+			ieee80211_rx_list(hw, link_sta, skb, &list);
 		}
 	}
 	spin_unlock(&dev->rx_lock);
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 6e77522bcd8f..f6bcf309936d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2953,7 +2953,6 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.cur_pkt_stat;
 	struct rtw89_rx_desc_info *desc_info = iter_data->desc_info;
 	struct sk_buff *skb = iter_data->skb;
-	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct rtw89_rx_phy_ppdu *phy_ppdu = iter_data->phy_ppdu;
 	bool is_mld = ieee80211_vif_is_mld(vif);
@@ -2988,11 +2987,6 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	if (!ether_addr_equal(target_bssid, bssid))
 		goto out;
 
-	if (is_mld) {
-		rx_status->link_valid = true;
-		rx_status->link_id = rtwvif_link->link_id;
-	}
-
 	if (ieee80211_is_beacon(hdr->frame_control)) {
 		if (vif->type == NL80211_IFTYPE_STATION &&
 		    !test_bit(RTW89_FLAG_WOWLAN, rtwdev->flags)) {
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 4d9f5f87e814..7d529aa129f8 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1755,9 +1755,6 @@ static void mac80211_hwsim_rx(struct mac80211_hwsim_data *data,
 				sp->active_links_rx &= ~BIT(link_id);
 			else
 				sp->active_links_rx |= BIT(link_id);
-
-			rx_status->link_valid = true;
-			rx_status->link_id = link_id;
 		}
 		rcu_read_unlock();
 	}
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7f9d96939a4e..4d9dbd35369b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5207,14 +5207,18 @@ void ieee80211_restart_hw(struct ieee80211_hw *hw);
  * mixed for a single hardware. Must not run concurrently with
  * ieee80211_tx_status_skb() or ieee80211_tx_status_ni().
  *
+ * For data frames, when hardware has done address translation, a link station
+ * has to be provided and the frequency information may be skipped.
+ *
  * This function must be called with BHs disabled and RCU read lock
  *
  * @hw: the hardware this frame came in on
- * @sta: the station the frame was received from, or %NULL
+ * @link_sta: the link station the data frame was received from, or %NULL
  * @skb: the buffer to receive, owned by mac80211 after this call
  * @list: the destination list
  */
-void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
+void ieee80211_rx_list(struct ieee80211_hw *hw,
+		       struct ieee80211_link_sta *link_sta,
 		       struct sk_buff *skb, struct list_head *list);
 
 /**
@@ -5232,14 +5236,18 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
  * mixed for a single hardware. Must not run concurrently with
  * ieee80211_tx_status_skb() or ieee80211_tx_status_ni().
  *
+ * For data frames, when hardware has done address translation, a link station
+ * has to be provided and the frequency information may be skipped.
+ *
  * This function must be called with BHs disabled.
  *
  * @hw: the hardware this frame came in on
- * @sta: the station the frame was received from, or %NULL
+ * @link_sta: the link station the data frame was received from, or %NULL
  * @skb: the buffer to receive, owned by mac80211 after this call
  * @napi: the NAPI context
  */
-void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
+void ieee80211_rx_napi(struct ieee80211_hw *hw,
+		       struct ieee80211_link_sta *link_sta,
 		       struct sk_buff *skb, struct napi_struct *napi);
 
 /**
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 11d6c56c9d7e..4098f63ec824 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5432,7 +5432,8 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
  * This is the receive path handler. It is called by a low level driver when an
  * 802.11 MPDU is received from the hardware.
  */
-void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
+void ieee80211_rx_list(struct ieee80211_hw *hw,
+		       struct ieee80211_link_sta *link_pubsta,
 		       struct sk_buff *skb, struct list_head *list)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
@@ -5440,6 +5441,7 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_sta *pubsta;
 
 	WARN_ON_ONCE(softirq_count() == 0);
 
@@ -5562,8 +5564,15 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 		}
 	}
 
-	if (WARN_ON_ONCE(status->link_id >= IEEE80211_LINK_UNSPECIFIED))
-		goto drop;
+	/* FIXME: Emulate the old driver behaviour for now */
+	if (link_pubsta) {
+		status->link_valid = 1;
+		status->link_id = link_pubsta->link_id;
+		pubsta = link_pubsta->sta;
+	} else {
+		status->link_valid = 0;
+		pubsta = NULL;
+	}
 
 	status->rx_flags = 0;
 
@@ -5595,7 +5604,8 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 }
 EXPORT_SYMBOL(ieee80211_rx_list);
 
-void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
+void ieee80211_rx_napi(struct ieee80211_hw *hw,
+		       struct ieee80211_link_sta *link_pubsta,
 		       struct sk_buff *skb, struct napi_struct *napi)
 {
 	struct sk_buff *tmp;
@@ -5608,7 +5618,7 @@ void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 	 * receive processing
 	 */
 	rcu_read_lock();
-	ieee80211_rx_list(hw, pubsta, skb, &list);
+	ieee80211_rx_list(hw, link_pubsta, skb, &list);
 	rcu_read_unlock();
 
 	if (!napi) {
-- 
2.53.0


