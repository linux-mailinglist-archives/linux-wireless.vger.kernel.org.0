Return-Path: <linux-wireless+bounces-17262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD9FA08023
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 19:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76458167C1E
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 18:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC721AA1D8;
	Thu,  9 Jan 2025 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HvWJtZ3Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937ED19E7F8
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448592; cv=none; b=LSAoWJJok61dFZwZhfZYSVk7ByfavnNeEwvpiWnsEKH6wrjwQht87IdVQc1hWE4cs286X8dsae4WEsUJQ7xzekB8C6KkPsA3E1ZASQmOUu8XE8kehFXWPpzYF+sf4JZX+gnbVZ7tAzfgz0YAlYfPvJOaasKbGudeSOthgyWfedo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448592; c=relaxed/simple;
	bh=6NLqdZqwJOkaQyaYF4IoincHBCTrzusWn5VZZ4T9CFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d40BkP/20FQkFsBfJo529mnC47zcBe0oFEiUPTjKUP5KFzFeb5VcllGBUxhqnVHEkz8hH153J8gaN1Rg3b9O44hx2y8U0Ix3fkPKNDIvQoh9jD9xr8Vi2xYrAw4PkhrNstAGUpLbf0R7xYvE0i+AYiAWzUzSuiCyLgSMzHA7QUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HvWJtZ3Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509CBde4002608;
	Thu, 9 Jan 2025 18:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eCLHdIWdJY+6hOd+ftjd+1+9vmYkcUx7IxJfr7UhrEc=; b=HvWJtZ3Z8M5IsB3i
	RBSyud31/YmYcBqgzl3iRiSAdTMeMrduGVFBqxqjOZfx+wiTaSdKVIZppBfE94gy
	IFS1wXUpdqaG28EqJBUb21qIFDDzYIm2AGyRwmJNANv1LuKe+PHa1sGNJt2ZvHHj
	x4VFo0Jbzos8AkXb7bgSXKiu/OqEtjyRW7TyWtp7I8myfnpwsbI1RoV9QTVJqDl5
	ZLeRJHgOX/LsHXHiArdUN0UdE6a65VkdQu9P4bsAOMRZHgS/eiSyas3ojkiyIXBh
	mOBRrfHCgP0+XsaDNPcdmP5zHHayd6/1fBXBAt4ha/I5QtP+LsTsvXEJYXciSTaz
	E7UTrA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442e8cgycv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 18:49:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 509InjYd026499
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 18:49:45 GMT
Received: from hu-bmahalin-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 10:49:44 -0800
From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bmahalin@quicinc.com>
Subject: [PATCH 2/2] wifi: ath12k: Add support for MLO Multicast handling in driver
Date: Thu, 9 Jan 2025 10:49:32 -0800
Message-ID: <20250109184932.1593157-3-quic_bmahalin@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109184932.1593157-1-quic_bmahalin@quicinc.com>
References: <20250109184932.1593157-1-quic_bmahalin@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3AtgAP0CxgfbbyI2YA-kdItXc80LOgD8
X-Proofpoint-ORIG-GUID: 3AtgAP0CxgfbbyI2YA-kdItXc80LOgD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090149

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
 drivers/net/wireless/ath/ath12k/core.h  |  3 +-
 drivers/net/wireless/ath/ath12k/dp.h    |  6 ++
 drivers/net/wireless/ath/ath12k/dp_tx.c | 15 +++-
 drivers/net/wireless/ath/ath12k/dp_tx.h |  4 +-
 drivers/net/wireless/ath/ath12k/mac.c   | 94 +++++++++++++++++++++++--
 5 files changed, 111 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3dd01ad100c5..203255081221 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_CORE_H
@@ -327,6 +327,7 @@ struct ath12k_vif {
 	u32 key_cipher;
 	u8 tx_encap_type;
 	bool ps;
+	atomic_t mcbc_gsn;
 
 	struct ath12k_link_vif deflink;
 	struct ath12k_link_vif __rcu *link[ATH12K_NUM_MAX_LINKS];
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 98012e8cb30d..b2f978f50304 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -386,6 +386,12 @@ struct ath12k_dp {
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
index 76626d925adf..9d05fe7a870c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -217,7 +217,7 @@ static int ath12k_dp_tx_align_payload(struct ath12k_base *ab,
 }
 
 int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
-		 struct sk_buff *skb)
+		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_dp *dp = &ab->dp;
@@ -290,13 +290,24 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		msdu_ext_desc = true;
 	}
 
+	if (gsn_valid) {
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
-	ti.vdev_id = arvif->vdev_id;
+	if (gsn_valid)
+		ti.vdev_id = arvif->vdev_id +
+			     HTT_TX_MLO_MCAST_HOST_REINJECT_BASE_VDEV_ID;
+	else
+		ti.vdev_id = arvif->vdev_id;
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
index 48d110e2a7de..562135893926 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <net/mac80211.h>
@@ -7064,6 +7064,22 @@ static void ath12k_mac_add_p2p_noa_ie(struct ath12k *ar,
 	spin_unlock_bh(&ar->data_lock);
 }
 
+/* Note: called under rcu_read_lock() */
+static void ath12k_mlo_mcast_update_tx_link_address(struct ieee80211_vif *vif,
+						    u8 link, struct sk_buff *skb,
+						    u32 info_flags)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_bss_conf *bss_conf;
+
+	if (info_flags & IEEE80211_TX_CTL_HW_80211_ENCAP)
+		return;
+
+	bss_conf = rcu_dereference(vif->link_conf[link]);
+	if (bss_conf)
+		ether_addr_copy(hdr->addr2, bss_conf->addr);
+}
+
 /* Note: called under rcu_read_lock() */
 static u8 ath12k_mac_get_tx_link(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 				 u8 link, struct sk_buff *skb, u32 info_flags)
@@ -7175,9 +7191,15 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_key_conf *key = info->control.hw_key;
 	struct ieee80211_sta *sta = control->sta;
+	struct ath12k_link_vif *tmp_arvif;
 	u32 info_flags = info->flags;
-	struct ath12k *ar;
+	struct sk_buff *msdu_copied;
+	struct ath12k *ar, *tmp_ar;
+	unsigned long links_map;
+	bool is_mcast = false;
+	struct ethhdr *eth;
 	bool is_prb_rsp;
+	u16 mcbc_gsn;
 	u8 link_id;
 	int ret;
 
@@ -7214,7 +7236,9 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 	is_prb_rsp = ieee80211_is_probe_resp(hdr->frame_control);
 
 	if (info_flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
+		eth = (struct ethhdr *)skb->data;
 		skb_cb->flags |= ATH12K_SKB_HW_80211_ENCAP;
+		is_mcast = is_multicast_ether_addr(eth->h_dest);
 	} else if (ieee80211_is_mgmt(hdr->frame_control)) {
 		ret = ath12k_mac_mgmt_tx(ar, skb, is_prb_rsp);
 		if (ret) {
@@ -7225,14 +7249,70 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
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
+			ret = ath12k_dp_tx(tmp_ar, tmp_arvif,
+					   msdu_copied, true, mcbc_gsn);
+
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
 
@@ -10944,6 +11024,8 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 		ath12k_iftypes_ext_capa[2].eml_capabilities = cap->eml_cap;
 		ath12k_iftypes_ext_capa[2].mld_capa_and_ops = cap->mld_cap;
 		wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
+
+		ieee80211_hw_set(hw, MLO_MCAST_MULTI_LINK_TX);
 	}
 
 	hw->queues = ATH12K_HW_MAX_QUEUES;
-- 
2.34.1


