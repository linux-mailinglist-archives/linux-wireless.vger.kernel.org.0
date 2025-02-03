Return-Path: <linux-wireless+bounces-18313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA494A26587
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 22:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D3FF7A2520
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 21:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB3F20F09D;
	Mon,  3 Feb 2025 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sdwif3AC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B93A20E00E
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618024; cv=none; b=LjeofqSSgGBkyxyP3Dpm8pZojM4Qk3wwHiarcf/JS1UZsDo22hoTwT731DyM+GtLjCOto68u4gYID0/lC7HuCEyIfJir/mKvj2CsK39waUiKxrgm2u8YyJ9GzzcGZ5xK7CQ3siiFPz1ypNRwn7gi4Z+3ytjQxjRhsHmUYr64ZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618024; c=relaxed/simple;
	bh=CzVB4oIWazyjoPSCzWyiQEl6keTlkFGF+BvwU93HVdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlinI4DHeUiH60VP0G/or7oaxUoJ+S6FLiIJWsHw21seRLqRxAce7XL3Ds/yWYKzgMJH1HBiuy75MIB5kLmWV4MwWpCE3RlIwRyly8AW1X9UbVt4VAPYJijxOoZplHvx4sq5IB4bhFm6zt5s0RBxjxSU84SXplwtu1fLqCDITpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sdwif3AC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513IbTBt013109;
	Mon, 3 Feb 2025 21:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2oSL9mC+xKVG9I0n6pxlqyH1AI32m/2Xmj7Jm+TWa58=; b=Sdwif3ACUoeQCWpV
	y6uy6MT7HIKTtAaDZ9pP+DjwXY7TGXhUv4/Jr8dMamA1vIksAp8YKYqjkaPk8HAc
	reH0+z86PvKPDN8n+Mv6KF4kJIvBn30DaDdimyDCDpkn5EaWfqEkr4s2fMO4QMX0
	DTHA5fNuDFBiIfDL1x7BO381JmPnpI0ihBwR380nYuzzrJF2ygg9D6yFPVokr5u7
	OWv9+fVwhhSfZIFSLZUZeyjugBU8kczB0FHU/DUp8ho1uMruo+GErA8i1Z9jgZzR
	4e9ObPnZ2kiz4M4WPGL2mDchK9n5/6MrzUuLZWPYviq2NzA0/To934xoU+GvzE7e
	pJ0Hcg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k3890b0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 21:26:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 513LQwq4002633
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Feb 2025 21:26:58 GMT
Received: from hu-bmahalin-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Feb 2025 13:26:58 -0800
From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bmahalin@quicinc.com>
Subject: [PATCH v4 2/2] wifi: ath12k: Add support for MLO Multicast handling in driver
Date: Mon, 3 Feb 2025 13:26:47 -0800
Message-ID: <20250203212647.2694566-3-quic_bmahalin@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203212647.2694566-1-quic_bmahalin@quicinc.com>
References: <20250203212647.2694566-1-quic_bmahalin@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cltMXwnWJpUOA3hFoPQpJEYFQsHuQi2T
X-Proofpoint-GUID: cltMXwnWJpUOA3hFoPQpJEYFQsHuQi2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030155

For MLO netdevice, the broadcast frame should be transmitted with the
same sequence number on all the links.

Per IEEE 802.11be-2024 section 10.3.2.14.2 "Transmitter requirements",
An AP MLD shall use SNS11 in Table 10-5 (Transmitter sequence number
spaces) maintained by the MLD to determine the sequence number of a
group addressed data frame that is transmitted by an AP affiliated
with the AP MLD so that the same group addressed Data frame
transmitted over multiple links by the AP MLD uses the same
sequence number for transmission on each link.

Currently the MLO multicast handling is done in the mac80211 layer.
Enable support for handling MLO Multicast in the driver to update the
hardware descriptors in a custom way to handle the multicast frames.
Firmware expects the MLO multicast frames to the submitted to the
hardware with special vdev_id (actual vdev_id + 128) to recognize it as
a host inspected frame to avoid using the reinjected path and it also
uses the multicast global sequence number (GSN) provided by the host
in the HTT metadata to process and transmit it with the same sequence
number.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h  |   1 +
 drivers/net/wireless/ath/ath12k/dp.h    |   6 ++
 drivers/net/wireless/ath/ath12k/dp_tx.c |  16 ++-
 drivers/net/wireless/ath/ath12k/dp_tx.h |   4 +-
 drivers/net/wireless/ath/ath12k/mac.c   | 123 +++++++++++++++++++++++-
 5 files changed, 142 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 28db100cfac0..b8c336bc02d8 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -330,6 +330,7 @@ struct ath12k_vif {
 	u32 key_cipher;
 	u8 tx_encap_type;
 	bool ps;
+	atomic_t mcbc_gsn;
 
 	struct ath12k_link_vif deflink;
 	struct ath12k_link_vif __rcu *link[ATH12K_NUM_MAX_LINKS];
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 7cdc62aa35be..75435a931548 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -385,6 +385,12 @@ struct ath12k_dp {
 /* peer meta data */
 #define HTT_TCL_META_DATA_PEER_ID		GENMASK(15, 3)
 
+/* Global sequence number */
+#define HTT_TCL_META_DATA_TYPE_GLOBAL_SEQ_NUM		3
+#define HTT_TCL_META_DATA_GLOBAL_SEQ_HOST_INSPECTED	BIT(2)
+#define HTT_TCL_META_DATA_GLOBAL_SEQ_NUM		GENMASK(14, 3)
+#define HTT_TX_MLO_MCAST_HOST_REINJECT_BASE_VDEV_ID	128
+
 /* HTT tx completion is overlaid in wbm_release_ring */
 #define HTT_TX_WBM_COMP_INFO0_STATUS		GENMASK(16, 13)
 #define HTT_TX_WBM_COMP_INFO1_REINJECT_REASON	GENMASK(3, 0)
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index a7fb1e0b31ff..1896178d2d4f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -219,7 +219,7 @@ static int ath12k_dp_tx_align_payload(struct ath12k_base *ab,
 }
 
 int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
-		 struct sk_buff *skb)
+		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_dp *dp = &ab->dp;
@@ -292,13 +292,27 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		msdu_ext_desc = true;
 	}
 
+	if (gsn_valid) {
+		/* Reset and Initialize meta_data_flags with Global Sequence
+		 * Number (GSN) info.
+		 */
+		ti.meta_data_flags =
+			u32_encode_bits(HTT_TCL_META_DATA_TYPE_GLOBAL_SEQ_NUM,
+					HTT_TCL_META_DATA_TYPE) |
+			u32_encode_bits(mcbc_gsn, HTT_TCL_META_DATA_GLOBAL_SEQ_NUM);
+	}
+
 	ti.encap_type = ath12k_dp_tx_get_encap_type(arvif, skb);
 	ti.addr_search_flags = arvif->hal_addr_search_flags;
 	ti.search_type = arvif->search_type;
 	ti.type = HAL_TCL_DESC_TYPE_BUFFER;
 	ti.pkt_offset = 0;
 	ti.lmac_id = ar->lmac_id;
+
 	ti.vdev_id = arvif->vdev_id;
+	if (gsn_valid)
+		ti.vdev_id += HTT_TX_MLO_MCAST_HOST_REINJECT_BASE_VDEV_ID;
+
 	ti.bss_ast_hash = arvif->ast_hash;
 	ti.bss_ast_idx = arvif->ast_idx;
 	ti.dscp_tid_tbl_idx = 0;
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.h b/drivers/net/wireless/ath/ath12k/dp_tx.h
index 46dce23501f3..a5904097dc34 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_DP_TX_H
@@ -17,7 +17,7 @@ struct ath12k_dp_htt_wbm_tx_status {
 
 int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab);
 int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
-		 struct sk_buff *skb);
+		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn);
 void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id);
 
 int ath12k_dp_tx_htt_h2t_ppdu_stats_req(struct ath12k *ar, u32 mask);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4fb7e235be66..b3907ac05f69 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7151,6 +7151,22 @@ static void ath12k_mac_add_p2p_noa_ie(struct ath12k *ar,
 	spin_unlock_bh(&ar->data_lock);
 }
 
+/* Note: called under rcu_read_lock() */
+static void ath12k_mlo_mcast_update_tx_link_address(struct ieee80211_vif *vif,
+						    u8 link_id, struct sk_buff *skb,
+						    u32 info_flags)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_bss_conf *bss_conf;
+
+	if (info_flags & IEEE80211_TX_CTL_HW_80211_ENCAP)
+		return;
+
+	bss_conf = rcu_dereference(vif->link_conf[link_id]);
+	if (bss_conf)
+		ether_addr_copy(hdr->addr2, bss_conf->addr);
+}
+
 /* Note: called under rcu_read_lock() */
 static u8 ath12k_mac_get_tx_link(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 				 u8 link, struct sk_buff *skb, u32 info_flags)
@@ -7262,9 +7278,16 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_key_conf *key = info->control.hw_key;
 	struct ieee80211_sta *sta = control->sta;
+	struct ath12k_link_vif *tmp_arvif;
 	u32 info_flags = info->flags;
-	struct ath12k *ar;
+	struct sk_buff *msdu_copied;
+	struct ath12k *ar, *tmp_ar;
+	struct ath12k_peer *peer;
+	unsigned long links_map;
+	bool is_mcast = false;
+	struct ethhdr *eth;
 	bool is_prb_rsp;
+	u16 mcbc_gsn;
 	u8 link_id;
 	int ret;
 
@@ -7301,6 +7324,9 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 	is_prb_rsp = ieee80211_is_probe_resp(hdr->frame_control);
 
 	if (info_flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
+		eth = (struct ethhdr *)skb->data;
+		is_mcast = is_multicast_ether_addr(eth->h_dest);
+
 		skb_cb->flags |= ATH12K_SKB_HW_80211_ENCAP;
 	} else if (ieee80211_is_mgmt(hdr->frame_control)) {
 		ret = ath12k_mac_mgmt_tx(ar, skb, is_prb_rsp);
@@ -7312,14 +7338,99 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 		return;
 	}
 
+	if (!(info_flags & IEEE80211_TX_CTL_HW_80211_ENCAP))
+		is_mcast = is_multicast_ether_addr(hdr->addr1);
+
 	/* This is case only for P2P_GO */
 	if (vif->type == NL80211_IFTYPE_AP && vif->p2p)
 		ath12k_mac_add_p2p_noa_ie(ar, vif, skb, is_prb_rsp);
 
-	ret = ath12k_dp_tx(ar, arvif, skb);
-	if (ret) {
-		ath12k_warn(ar->ab, "failed to transmit frame %d\n", ret);
-		ieee80211_free_txskb(hw, skb);
+	if (!vif->valid_links || !is_mcast ||
+	    test_bit(ATH12K_FLAG_RAW_MODE, &ar->ab->dev_flags)) {
+		ret = ath12k_dp_tx(ar, arvif, skb, false, 0);
+		if (unlikely(ret)) {
+			ath12k_warn(ar->ab, "failed to transmit frame %d\n", ret);
+			ieee80211_free_txskb(ar->ah->hw, skb);
+			return;
+		}
+	} else {
+		mcbc_gsn = atomic_inc_return(&ahvif->mcbc_gsn) & 0xfff;
+
+		links_map = ahvif->links_map;
+		for_each_set_bit(link_id, &links_map,
+				 IEEE80211_MLD_MAX_NUM_LINKS) {
+			tmp_arvif = rcu_dereference(ahvif->link[link_id]);
+			if (!tmp_arvif || !tmp_arvif->is_up)
+				continue;
+
+			tmp_ar = tmp_arvif->ar;
+			msdu_copied = skb_copy(skb, GFP_ATOMIC);
+			if (!msdu_copied) {
+				ath12k_err(ar->ab,
+					   "skb copy failure link_id 0x%X vdevid 0x%X\n",
+					   link_id, tmp_arvif->vdev_id);
+				continue;
+			}
+
+			ath12k_mlo_mcast_update_tx_link_address(vif, link_id,
+								msdu_copied,
+								info_flags);
+
+			skb_cb = ATH12K_SKB_CB(msdu_copied);
+			info = IEEE80211_SKB_CB(msdu_copied);
+			skb_cb->link_id = link_id;
+
+			/* For open mode, skip peer find logic */
+			if (unlikely(ahvif->key_cipher == WMI_CIPHER_NONE))
+				goto skip_peer_find;
+
+			spin_lock_bh(&tmp_ar->ab->base_lock);
+			peer = ath12k_peer_find_by_addr(tmp_ar->ab, tmp_arvif->bssid);
+			if (!peer) {
+				spin_unlock_bh(&tmp_ar->ab->base_lock);
+				ath12k_warn(tmp_ar->ab,
+					    "failed to find peer for vdev_id 0x%X addr %pM link_map 0x%X\n",
+					    tmp_arvif->vdev_id, tmp_arvif->bssid,
+					    ahvif->links_map);
+				dev_kfree_skb_any(msdu_copied);
+				continue;
+			}
+
+			key = peer->keys[peer->mcast_keyidx];
+			if (key) {
+				skb_cb->cipher = key->cipher;
+				skb_cb->flags |= ATH12K_SKB_CIPHER_SET;
+				info->control.hw_key = key;
+
+				hdr = (struct ieee80211_hdr *)msdu_copied->data;
+				if (!ieee80211_has_protected(hdr->frame_control))
+					hdr->frame_control |=
+						cpu_to_le16(IEEE80211_FCTL_PROTECTED);
+			}
+			spin_unlock_bh(&tmp_ar->ab->base_lock);
+
+skip_peer_find:
+			ret = ath12k_dp_tx(tmp_ar, tmp_arvif,
+					   msdu_copied, true, mcbc_gsn);
+			if (unlikely(ret)) {
+				if (ret == -ENOMEM) {
+					/* Drops are expected during heavy multicast
+					 * frame flood. Print with debug log
+					 * level to avoid lot of console prints
+					 */
+					ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+						   "failed to transmit frame %d\n",
+						   ret);
+				} else {
+					ath12k_warn(ar->ab,
+						    "failed to transmit frame %d\n",
+						    ret);
+				}
+
+				dev_kfree_skb_any(msdu_copied);
+			}
+		}
+		ieee80211_free_txskb(ar->ah->hw, skb);
 	}
 }
 
@@ -11098,6 +11209,8 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 		ath12k_iftypes_ext_capa[2].eml_capabilities = cap->eml_cap;
 		ath12k_iftypes_ext_capa[2].mld_capa_and_ops = cap->mld_cap;
 		wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
+
+		ieee80211_hw_set(hw, MLO_MCAST_MULTI_LINK_TX);
 	}
 
 	hw->queues = ATH12K_HW_MAX_QUEUES;
-- 
2.34.1


