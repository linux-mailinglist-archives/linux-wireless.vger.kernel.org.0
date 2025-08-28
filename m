Return-Path: <linux-wireless+bounces-26828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B8FB3A84C
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 19:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CB67C36A0
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0907322C78;
	Thu, 28 Aug 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mzyiGIJ0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3819338F36
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402601; cv=none; b=aZ+pHuxdbTauaw4LSVVVTuXjeIBh9MzE4nVEU5QGvLq8uUXpi6sNKWMovhEVx7oQaizyYA2wXEeAD5AMvnGVHNBNeAojAAIHs/YTy35fgUXztX+6IEL8E9nSue12x8DvzshFIuP+o/iuTK8XVx8jmYoHdHXdZJAygwY8QqGTRL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402601; c=relaxed/simple;
	bh=3gO97VuZtyfkKEmNTh0+9GSRb8aZU4OPByhHYmSMdXM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+//hIfUBSzol6mukzmS3K3M3VmFVSqECdjAlI+Rdp5sef6Tl84a+cluqdhC4dWgl07j1+vCFSUw/NgtA2U0KCBqksS9nmr4oJKpo/705Ywc317QgCizS6Rdu4RI1UyRryK8v7dgIyb1snGtIP/Q5ohEThP0wZ7ZgJGpGw9FQtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mzyiGIJ0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SESEo7030526;
	Thu, 28 Aug 2025 17:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KH5qZxmUXiZhTLtQIDFx222yBl0wpYXZterBlHec6As=; b=mzyiGIJ00s51jUh/
	mOAEtZglhez2UNbiVZ7ofWbDZzmvKTIips92ecJTwhG3pTovhwCEQ1n3fkW45y/G
	x7QYFVA2vruIszIrC1xU0hK6DLffuc9oxKlZLInWUMfjurXq2+tKG4G75LHLq6gz
	zbOy5EUTutVKklQym1LNlogwMCIl7z3Npkt9btA3IH8V2BtMnqY7ohJmEdDpsEng
	LPJZDnzjGIer9tZu7a3o7LqrVeBRAMuRHwRhtULlbJU6pNGdRxH4H1rB72B50FyW
	rn7fpu8TmMscrz7mBH+MJ2P0cogUm11UCVzNx7n7FpiQP6H3ShKnXKEGpB9eGRY9
	CT6oIA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5up103g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SHaXsg014363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:33 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 10:36:31 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 15/20] wifi: ath12k: Move arch specific tx APIs to wifi7 directory
Date: Thu, 28 Aug 2025 23:05:48 +0530
Message-ID: <20250828173553.3341351-16-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
References: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pRy4adi62YIYJ1EQ_XDmbOOB2XoCyiRV
X-Proofpoint-ORIG-GUID: pRy4adi62YIYJ1EQ_XDmbOOB2XoCyiRV
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68b093a2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=5RRWBY4WAAAA:8
 a=wDYpwt8iPoErVh6w9V4A:9 a=TjNXssC_j7lpFel5tvFf:22 a=drtMOSl5Q_Tsf-UZi3mY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX2CgPkECSGChT
 40nQ3qbGgA0BIDM/49VkmOA/oEWlsNzDjCZ2KxLkJzetgS50K1ArGovjsQltqcc4CU87eKRQ/Id
 qvBvhwdmgjgsj1WvTpjVwvHux947R/yBL1uiO3waXTf1QnCRcN98Y8/ofPjIQOb+D2n078GrmXk
 qCyBs6UqIHsaRbSZSTW4VWInrf4iC7MSABbTQMCTWcTyaZeXkwW2xNM+ik30rmvj5riyOgDeOWn
 KBXNqkfvFtu0rMCLKVOZ60iyGJk7iEdT6IcviKcK+t0buhEaTtZUy1/EwAiUnpjfzjkZgp03BbT
 nJuFo77yKDhFYA8wW+fGZKYmTbxvKxPPbvOCuLjIF4sCiZQZurrbuMhWRW0cgQN8W8yAHPL2nMa
 j6USRWgM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move arch specific TX data path to wifi7 directory as part of Next
Generation (NG) Driver Framework.

Architecture specific APIs:
ath12k_dp_tx_htt_tx_complete_buf
ath12k_dp_tx_process_htt_tx_complete
ath12k_dp_tx_update_txcompl
ath12k_dp_tx_complete_msdu
ath12k_dp_tx_status_parse
ath12k_dp_tx_completion_handler

The moved APIs will be a part of dp_tx.c file inside wifi7 directory.
wifi7/dp_tx.c file will continue to be part of ath12k.ko temporarily
until the corresponding infra for movement to ath12k_wifi7.ko arrives
in upcoming patches.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile      |   1 +
 drivers/net/wireless/ath/ath12k/dp_tx.c       | 564 +-----------------
 drivers/net/wireless/ath/ath12k/dp_tx.h       |  18 +-
 drivers/net/wireless/ath/ath12k/mac.c         |   3 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp.c    |   1 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c | 545 +++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |  11 +
 7 files changed, 591 insertions(+), 552 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index ed1f1dba3d3b..e72b52d5af6d 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -25,6 +25,7 @@ ath12k-$(CONFIG_ATH12K_AHB) += ahb.o
 ath12k-y += wifi7/hal_tx.o \
 	    wifi7/hal_rx.o \
 	    wifi7/dp_rx.o \
+	    wifi7/dp_tx.o \
 	    wifi7/dp.o
 
 obj-$(CONFIG_ATH12K) += wifi7/
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index abc84ca8467a..f1649744c78b 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "core.h"
@@ -12,7 +12,7 @@
 #include "peer.h"
 #include "mac.h"
 
-static enum hal_tcl_encap_type
+enum hal_tcl_encap_type
 ath12k_dp_tx_get_encap_type(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
@@ -26,7 +26,7 @@ ath12k_dp_tx_get_encap_type(struct ath12k_base *ab, struct sk_buff *skb)
 	return HAL_TCL_ENCAP_TYPE_NATIVE_WIFI;
 }
 
-static void ath12k_dp_tx_encap_nwifi(struct sk_buff *skb)
+void ath12k_dp_tx_encap_nwifi(struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	u8 *qos_ctl;
@@ -43,7 +43,7 @@ static void ath12k_dp_tx_encap_nwifi(struct sk_buff *skb)
 	hdr->frame_control &= ~__cpu_to_le16(IEEE80211_STYPE_QOS_DATA);
 }
 
-static u8 ath12k_dp_tx_get_tid(struct sk_buff *skb)
+u8 ath12k_dp_tx_get_tid(struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ath12k_skb_cb *cb = ATH12K_SKB_CB(skb);
@@ -78,9 +78,9 @@ enum hal_encrypt_type ath12k_dp_tx_get_encrypt_type(u32 cipher)
 	}
 }
 
-static void ath12k_dp_tx_release_txbuf(struct ath12k_dp *dp,
-				       struct ath12k_tx_desc_info *tx_desc,
-				       u8 pool_id)
+void ath12k_dp_tx_release_txbuf(struct ath12k_dp *dp,
+				struct ath12k_tx_desc_info *tx_desc,
+				u8 pool_id)
 {
 	spin_lock_bh(&dp->tx_desc_lock[pool_id]);
 	tx_desc->skb_ext_desc = NULL;
@@ -88,8 +88,8 @@ static void ath12k_dp_tx_release_txbuf(struct ath12k_dp *dp,
 	spin_unlock_bh(&dp->tx_desc_lock[pool_id]);
 }
 
-static struct ath12k_tx_desc_info *ath12k_dp_tx_assign_buffer(struct ath12k_dp *dp,
-							      u8 pool_id)
+struct ath12k_tx_desc_info *ath12k_dp_tx_assign_buffer(struct ath12k_dp *dp,
+						       u8 pool_id)
 {
 	struct ath12k_tx_desc_info *desc;
 
@@ -129,7 +129,7 @@ static void ath12k_hal_tx_cmd_ext_desc_setup(struct ath12k_base *ab,
 
 #define HTT_META_DATA_ALIGNMENT 0x8
 
-static void *ath12k_dp_metadata_align_skb(struct sk_buff *skb, u8 tail_len)
+void *ath12k_dp_metadata_align_skb(struct sk_buff *skb, u8 tail_len)
 {
 	struct sk_buff *tail;
 	void *metadata;
@@ -182,8 +182,8 @@ static void ath12k_dp_tx_move_payload(struct sk_buff *skb,
 	}
 }
 
-static int ath12k_dp_tx_align_payload(struct ath12k_base *ab,
-				      struct sk_buff **pskb)
+int ath12k_dp_tx_align_payload(struct ath12k_base *ab,
+			       struct sk_buff **pskb)
 {
 	u32 iova_mask = ab->hw_params->iova_mask;
 	unsigned long offset, delta1, delta2;
@@ -539,9 +539,9 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	return ret;
 }
 
-static void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
-				    struct dp_tx_ring *tx_ring,
-				    struct ath12k_tx_desc_params *desc_params)
+void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
+			     struct dp_tx_ring *tx_ring,
+			     struct ath12k_tx_desc_params *desc_params)
 {
 	struct ath12k *ar;
 	struct sk_buff *msdu = desc_params->skb;
@@ -564,540 +564,6 @@ static void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
 		wake_up(&ar->dp.tx_empty_waitq);
 }
 
-static void
-ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
-				 struct ath12k_tx_desc_params *desc_params,
-				 struct dp_tx_ring *tx_ring,
-				 struct ath12k_dp_htt_wbm_tx_status *ts,
-				 u16 peer_id)
-{
-	struct ieee80211_tx_info *info;
-	struct ath12k_link_vif *arvif;
-	struct ath12k_skb_cb *skb_cb;
-	struct ieee80211_vif *vif;
-	struct ath12k_vif *ahvif;
-	struct ath12k *ar;
-	struct sk_buff *msdu = desc_params->skb;
-	s32 noise_floor;
-	struct ieee80211_tx_status status = {};
-	struct ath12k_peer *peer;
-
-	skb_cb = ATH12K_SKB_CB(msdu);
-	info = IEEE80211_SKB_CB(msdu);
-
-	ar = skb_cb->ar;
-	ab->device_stats.tx_completed[tx_ring->tcl_data_ring_id]++;
-
-	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
-		wake_up(&ar->dp.tx_empty_waitq);
-
-	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
-	if (skb_cb->paddr_ext_desc) {
-		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
-				 desc_params->skb_ext_desc->len, DMA_TO_DEVICE);
-		dev_kfree_skb_any(desc_params->skb_ext_desc);
-	}
-
-	vif = skb_cb->vif;
-	if (vif) {
-		ahvif = ath12k_vif_to_ahvif(vif);
-		rcu_read_lock();
-		arvif = rcu_dereference(ahvif->link[skb_cb->link_id]);
-		if (arvif) {
-			spin_lock_bh(&arvif->link_stats_lock);
-			arvif->link_stats.tx_completed++;
-			spin_unlock_bh(&arvif->link_stats_lock);
-		}
-		rcu_read_unlock();
-	}
-
-	memset(&info->status, 0, sizeof(info->status));
-
-	if (ts->acked) {
-		if (!(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
-			info->flags |= IEEE80211_TX_STAT_ACK;
-			info->status.ack_signal = ts->ack_rssi;
-
-			if (!test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
-				      ab->wmi_ab.svc_map)) {
-				spin_lock_bh(&ar->data_lock);
-				noise_floor = ath12k_pdev_get_noise_floor(ar);
-				spin_unlock_bh(&ar->data_lock);
-
-				info->status.ack_signal += noise_floor;
-			}
-
-			info->status.flags = IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
-		} else {
-			info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
-		}
-	}
-	rcu_read_lock();
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_peer_find_by_id(ab, peer_id);
-	if (!peer || !peer->sta) {
-		ath12k_dbg(ab, ATH12K_DBG_DATA,
-			   "dp_tx: failed to find the peer with peer_id %d\n", peer_id);
-		spin_unlock_bh(&ab->base_lock);
-		ieee80211_free_txskb(ath12k_ar_to_hw(ar), msdu);
-		goto exit;
-	} else {
-		status.sta = peer->sta;
-	}
-	spin_unlock_bh(&ab->base_lock);
-
-	status.info = info;
-	status.skb = msdu;
-	ieee80211_tx_status_ext(ath12k_ar_to_hw(ar), &status);
-exit:
-	rcu_read_unlock();
-}
-
-static void
-ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab, void *desc,
-				     struct dp_tx_ring *tx_ring,
-				     struct ath12k_tx_desc_params *desc_params)
-{
-	struct htt_tx_wbm_completion *status_desc;
-	struct ath12k_dp_htt_wbm_tx_status ts = {};
-	enum hal_wbm_htt_tx_comp_status wbm_status;
-	u16 peer_id;
-
-	status_desc = desc;
-
-	wbm_status = le32_get_bits(status_desc->info0,
-				   HTT_TX_WBM_COMP_INFO0_STATUS);
-	ab->device_stats.fw_tx_status[wbm_status]++;
-
-	switch (wbm_status) {
-	case HAL_WBM_REL_HTT_TX_COMP_STATUS_OK:
-		ts.acked = (wbm_status == HAL_WBM_REL_HTT_TX_COMP_STATUS_OK);
-		ts.ack_rssi = le32_get_bits(status_desc->info2,
-					    HTT_TX_WBM_COMP_INFO2_ACK_RSSI);
-
-		peer_id = le32_get_bits(((struct hal_wbm_completion_ring_tx *)desc)->
-				info3, HAL_WBM_COMPL_TX_INFO3_PEER_ID);
-
-		ath12k_dp_tx_htt_tx_complete_buf(ab, desc_params, tx_ring, &ts, peer_id);
-		break;
-	case HAL_WBM_REL_HTT_TX_COMP_STATUS_DROP:
-	case HAL_WBM_REL_HTT_TX_COMP_STATUS_TTL:
-	case HAL_WBM_REL_HTT_TX_COMP_STATUS_REINJ:
-	case HAL_WBM_REL_HTT_TX_COMP_STATUS_INSPECT:
-	case HAL_WBM_REL_HTT_TX_COMP_STATUS_VDEVID_MISMATCH:
-		ath12k_dp_tx_free_txbuf(ab, tx_ring, desc_params);
-		break;
-	case HAL_WBM_REL_HTT_TX_COMP_STATUS_MEC_NOTIFY:
-		/* This event is to be handled only when the driver decides to
-		 * use WDS offload functionality.
-		 */
-		break;
-	default:
-		ath12k_warn(ab, "Unknown htt wbm tx status %d\n", wbm_status);
-		break;
-	}
-}
-
-static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status *ts)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_peer *peer;
-	struct ieee80211_sta *sta;
-	struct ath12k_sta *ahsta;
-	struct ath12k_link_sta *arsta;
-	struct rate_info txrate = {};
-	u16 rate, ru_tones;
-	u8 rate_idx = 0;
-	int ret;
-
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_peer_find_by_id(ab, ts->peer_id);
-	if (!peer || !peer->sta) {
-		ath12k_dbg(ab, ATH12K_DBG_DP_TX,
-			   "failed to find the peer by id %u\n", ts->peer_id);
-		spin_unlock_bh(&ab->base_lock);
-		return;
-	}
-	sta = peer->sta;
-	ahsta = ath12k_sta_to_ahsta(sta);
-	arsta = &ahsta->deflink;
-
-	/* This is to prefer choose the real NSS value arsta->last_txrate.nss,
-	 * if it is invalid, then choose the NSS value while assoc.
-	 */
-	if (arsta->last_txrate.nss)
-		txrate.nss = arsta->last_txrate.nss;
-	else
-		txrate.nss = arsta->peer_nss;
-	spin_unlock_bh(&ab->base_lock);
-
-	switch (ts->pkt_type) {
-	case HAL_TX_RATE_STATS_PKT_TYPE_11A:
-	case HAL_TX_RATE_STATS_PKT_TYPE_11B:
-		ret = ath12k_mac_hw_ratecode_to_legacy_rate(ts->mcs,
-							    ts->pkt_type,
-							    &rate_idx,
-							    &rate);
-		if (ret < 0) {
-			ath12k_warn(ab, "Invalid tx legacy rate %d\n", ret);
-			return;
-		}
-
-		txrate.legacy = rate;
-		break;
-	case HAL_TX_RATE_STATS_PKT_TYPE_11N:
-		if (ts->mcs > ATH12K_HT_MCS_MAX) {
-			ath12k_warn(ab, "Invalid HT mcs index %d\n", ts->mcs);
-			return;
-		}
-
-		if (txrate.nss != 0)
-			txrate.mcs = ts->mcs + 8 * (txrate.nss - 1);
-
-		txrate.flags = RATE_INFO_FLAGS_MCS;
-
-		if (ts->sgi)
-			txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
-		break;
-	case HAL_TX_RATE_STATS_PKT_TYPE_11AC:
-		if (ts->mcs > ATH12K_VHT_MCS_MAX) {
-			ath12k_warn(ab, "Invalid VHT mcs index %d\n", ts->mcs);
-			return;
-		}
-
-		txrate.mcs = ts->mcs;
-		txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
-
-		if (ts->sgi)
-			txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
-		break;
-	case HAL_TX_RATE_STATS_PKT_TYPE_11AX:
-		if (ts->mcs > ATH12K_HE_MCS_MAX) {
-			ath12k_warn(ab, "Invalid HE mcs index %d\n", ts->mcs);
-			return;
-		}
-
-		txrate.mcs = ts->mcs;
-		txrate.flags = RATE_INFO_FLAGS_HE_MCS;
-		txrate.he_gi = ath12k_he_gi_to_nl80211_he_gi(ts->sgi);
-		break;
-	case HAL_TX_RATE_STATS_PKT_TYPE_11BE:
-		if (ts->mcs > ATH12K_EHT_MCS_MAX) {
-			ath12k_warn(ab, "Invalid EHT mcs index %d\n", ts->mcs);
-			return;
-		}
-
-		txrate.mcs = ts->mcs;
-		txrate.flags = RATE_INFO_FLAGS_EHT_MCS;
-		txrate.eht_gi = ath12k_mac_eht_gi_to_nl80211_eht_gi(ts->sgi);
-		break;
-	default:
-		ath12k_warn(ab, "Invalid tx pkt type: %d\n", ts->pkt_type);
-		return;
-	}
-
-	txrate.bw = ath12k_mac_bw_to_mac80211_bw(ts->bw);
-
-	if (ts->ofdma && ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
-		txrate.bw = RATE_INFO_BW_HE_RU;
-		ru_tones = ath12k_mac_he_convert_tones_to_ru_tones(ts->tones);
-		txrate.he_ru_alloc =
-			ath12k_he_ru_tones_to_nl80211_he_ru_alloc(ru_tones);
-	}
-
-	if (ts->ofdma && ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11BE) {
-		txrate.bw = RATE_INFO_BW_EHT_RU;
-		txrate.eht_ru_alloc =
-			ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(ts->tones);
-	}
-
-	spin_lock_bh(&ab->base_lock);
-	arsta->txrate = txrate;
-	spin_unlock_bh(&ab->base_lock);
-}
-
-static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
-				       struct ath12k_tx_desc_params *desc_params,
-				       struct hal_tx_status *ts,
-				       int ring)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_hw *ah = ar->ah;
-	struct ieee80211_tx_info *info;
-	struct ath12k_link_vif *arvif;
-	struct ath12k_skb_cb *skb_cb;
-	struct ieee80211_vif *vif;
-	struct ath12k_vif *ahvif;
-	struct sk_buff *msdu = desc_params->skb;
-	s32 noise_floor;
-	struct ieee80211_tx_status status = {};
-	struct ieee80211_rate_status status_rate = {};
-	struct ath12k_peer *peer;
-	struct ath12k_link_sta *arsta;
-	struct ath12k_sta *ahsta;
-	struct rate_info rate;
-
-	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
-		/* Must not happen */
-		return;
-	}
-
-	skb_cb = ATH12K_SKB_CB(msdu);
-	ab->device_stats.tx_completed[ring]++;
-
-	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
-	if (skb_cb->paddr_ext_desc) {
-		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
-				 desc_params->skb_ext_desc->len, DMA_TO_DEVICE);
-		dev_kfree_skb_any(desc_params->skb_ext_desc);
-	}
-
-	rcu_read_lock();
-
-	if (!rcu_dereference(ab->pdevs_active[ar->pdev_idx])) {
-		ieee80211_free_txskb(ah->hw, msdu);
-		goto exit;
-	}
-
-	if (!skb_cb->vif) {
-		ieee80211_free_txskb(ah->hw, msdu);
-		goto exit;
-	}
-
-	vif = skb_cb->vif;
-	if (vif) {
-		ahvif = ath12k_vif_to_ahvif(vif);
-		arvif = rcu_dereference(ahvif->link[skb_cb->link_id]);
-		if (arvif) {
-			spin_lock_bh(&arvif->link_stats_lock);
-			arvif->link_stats.tx_completed++;
-			spin_unlock_bh(&arvif->link_stats_lock);
-		}
-	}
-
-	info = IEEE80211_SKB_CB(msdu);
-	memset(&info->status, 0, sizeof(info->status));
-
-	/* skip tx rate update from ieee80211_status*/
-	info->status.rates[0].idx = -1;
-
-	switch (ts->status) {
-	case HAL_WBM_TQM_REL_REASON_FRAME_ACKED:
-		if (!(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
-			info->flags |= IEEE80211_TX_STAT_ACK;
-			info->status.ack_signal = ts->ack_rssi;
-
-			if (!test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
-				      ab->wmi_ab.svc_map)) {
-				spin_lock_bh(&ar->data_lock);
-				noise_floor = ath12k_pdev_get_noise_floor(ar);
-				spin_unlock_bh(&ar->data_lock);
-
-				info->status.ack_signal += noise_floor;
-			}
-
-			info->status.flags = IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
-		}
-		break;
-	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_TX:
-		if (info->flags & IEEE80211_TX_CTL_NO_ACK) {
-			info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
-			break;
-		}
-		fallthrough;
-	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_MPDU:
-	case HAL_WBM_TQM_REL_REASON_DROP_THRESHOLD:
-	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_AGED_FRAMES:
-		/* The failure status is due to internal firmware tx failure
-		 * hence drop the frame; do not update the status of frame to
-		 * the upper layer
-		 */
-		ieee80211_free_txskb(ah->hw, msdu);
-		goto exit;
-	default:
-		ath12k_dbg(ab, ATH12K_DBG_DP_TX, "tx frame is not acked status %d\n",
-			   ts->status);
-		break;
-	}
-
-	/* NOTE: Tx rate status reporting. Tx completion status does not have
-	 * necessary information (for example nss) to build the tx rate.
-	 * Might end up reporting it out-of-band from HTT stats.
-	 */
-
-	ath12k_dp_tx_update_txcompl(ar, ts);
-
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_peer_find_by_id(ab, ts->peer_id);
-	if (!peer || !peer->sta) {
-		ath12k_err(ab,
-			   "dp_tx: failed to find the peer with peer_id %d\n",
-			   ts->peer_id);
-		spin_unlock_bh(&ab->base_lock);
-		ieee80211_free_txskb(ath12k_ar_to_hw(ar), msdu);
-		goto exit;
-	}
-	ahsta = ath12k_sta_to_ahsta(peer->sta);
-	arsta = &ahsta->deflink;
-
-	spin_unlock_bh(&ab->base_lock);
-
-	status.sta = peer->sta;
-	status.info = info;
-	status.skb = msdu;
-	rate = arsta->last_txrate;
-
-	status_rate.rate_idx = rate;
-	status_rate.try_count = 1;
-
-	status.rates = &status_rate;
-	status.n_rates = 1;
-	ieee80211_tx_status_ext(ath12k_ar_to_hw(ar), &status);
-
-exit:
-	rcu_read_unlock();
-}
-
-static void ath12k_dp_tx_status_parse(struct ath12k_base *ab,
-				      struct hal_wbm_completion_ring_tx *desc,
-				      struct hal_tx_status *ts)
-{
-	u32 info0 = le32_to_cpu(desc->rate_stats.info0);
-
-	ts->buf_rel_source =
-		le32_get_bits(desc->info0, HAL_WBM_COMPL_TX_INFO0_REL_SRC_MODULE);
-	if (ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_FW &&
-	    ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)
-		return;
-
-	if (ts->buf_rel_source == HAL_WBM_REL_SRC_MODULE_FW)
-		return;
-
-	ts->status = le32_get_bits(desc->info0,
-				   HAL_WBM_COMPL_TX_INFO0_TQM_RELEASE_REASON);
-
-	ts->ppdu_id = le32_get_bits(desc->info1,
-				    HAL_WBM_COMPL_TX_INFO1_TQM_STATUS_NUMBER);
-
-	ts->peer_id = le32_get_bits(desc->info3, HAL_WBM_COMPL_TX_INFO3_PEER_ID);
-
-	ts->ack_rssi = le32_get_bits(desc->info2,
-				     HAL_WBM_COMPL_TX_INFO2_ACK_FRAME_RSSI);
-
-	if (info0 & HAL_TX_RATE_STATS_INFO0_VALID) {
-		ts->pkt_type = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_PKT_TYPE);
-		ts->mcs = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_MCS);
-		ts->sgi = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_SGI);
-		ts->bw = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_BW);
-		ts->tones = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_TONES_IN_RU);
-		ts->ofdma = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_OFDMA_TX);
-	}
-}
-
-void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
-{
-	struct ath12k *ar;
-	struct ath12k_dp *dp = &ab->dp;
-	int hal_ring_id = dp->tx_ring[ring_id].tcl_comp_ring.ring_id;
-	struct hal_srng *status_ring = &ab->hal.srng_list[hal_ring_id];
-	struct ath12k_tx_desc_info *tx_desc = NULL;
-	struct hal_tx_status ts = {};
-	struct ath12k_tx_desc_params desc_params;
-	struct dp_tx_ring *tx_ring = &dp->tx_ring[ring_id];
-	struct hal_wbm_release_ring *desc;
-	u8 pdev_id;
-	u64 desc_va;
-	enum hal_wbm_rel_src_module buf_rel_source;
-	enum hal_wbm_tqm_rel_reason rel_status;
-
-	spin_lock_bh(&status_ring->lock);
-
-	ath12k_hal_srng_access_begin(ab, status_ring);
-
-	while (ATH12K_TX_COMPL_NEXT(ab, tx_ring->tx_status_head) !=
-	       tx_ring->tx_status_tail) {
-		desc = ath12k_hal_srng_dst_get_next_entry(ab, status_ring);
-		if (!desc)
-			break;
-
-		memcpy(&tx_ring->tx_status[tx_ring->tx_status_head],
-		       desc, sizeof(*desc));
-		tx_ring->tx_status_head =
-			ATH12K_TX_COMPL_NEXT(ab, tx_ring->tx_status_head);
-	}
-
-	if (ath12k_hal_srng_dst_peek(ab, status_ring) &&
-	    (ATH12K_TX_COMPL_NEXT(ab, tx_ring->tx_status_head) ==
-	     tx_ring->tx_status_tail)) {
-		/* TODO: Process pending tx_status messages when kfifo_is_full() */
-		ath12k_warn(ab, "Unable to process some of the tx_status ring desc because status_fifo is full\n");
-	}
-
-	ath12k_hal_srng_access_end(ab, status_ring);
-
-	spin_unlock_bh(&status_ring->lock);
-
-	while (ATH12K_TX_COMPL_NEXT(ab, tx_ring->tx_status_tail) !=
-	       tx_ring->tx_status_head) {
-		struct hal_wbm_completion_ring_tx *tx_status;
-		u32 desc_id;
-
-		tx_ring->tx_status_tail =
-			ATH12K_TX_COMPL_NEXT(ab, tx_ring->tx_status_tail);
-		tx_status = &tx_ring->tx_status[tx_ring->tx_status_tail];
-		ath12k_dp_tx_status_parse(ab, tx_status, &ts);
-
-		if (le32_get_bits(tx_status->info0, HAL_WBM_COMPL_TX_INFO0_CC_DONE)) {
-			/* HW done cookie conversion */
-			desc_va = ((u64)le32_to_cpu(tx_status->buf_va_hi) << 32 |
-				   le32_to_cpu(tx_status->buf_va_lo));
-			tx_desc = (struct ath12k_tx_desc_info *)((unsigned long)desc_va);
-		} else {
-			/* SW does cookie conversion to VA */
-			desc_id = le32_get_bits(tx_status->buf_va_hi,
-						BUFFER_ADDR_INFO1_SW_COOKIE);
-
-			tx_desc = ath12k_dp_get_tx_desc(ab, desc_id);
-		}
-		if (!tx_desc) {
-			ath12k_warn(ab, "unable to retrieve tx_desc!");
-			continue;
-		}
-
-		desc_params.mac_id = tx_desc->mac_id;
-		desc_params.skb = tx_desc->skb;
-		desc_params.skb_ext_desc = tx_desc->skb_ext_desc;
-
-		/* Find the HAL_WBM_RELEASE_INFO0_REL_SRC_MODULE value */
-		buf_rel_source = le32_get_bits(tx_status->info0,
-					       HAL_WBM_RELEASE_INFO0_REL_SRC_MODULE);
-		ab->device_stats.tx_wbm_rel_source[buf_rel_source]++;
-
-		rel_status = le32_get_bits(tx_status->info0,
-					   HAL_WBM_COMPL_TX_INFO0_TQM_RELEASE_REASON);
-		ab->device_stats.tqm_rel_reason[rel_status]++;
-
-		/* Release descriptor as soon as extracting necessary info
-		 * to reduce contention
-		 */
-		ath12k_dp_tx_release_txbuf(dp, tx_desc, tx_desc->pool_id);
-		if (ts.buf_rel_source == HAL_WBM_REL_SRC_MODULE_FW) {
-			ath12k_dp_tx_process_htt_tx_complete(ab, (void *)tx_status,
-							     tx_ring, &desc_params);
-			continue;
-		}
-
-		pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, desc_params.mac_id);
-		ar = ab->pdevs[pdev_id].ar;
-
-		if (atomic_dec_and_test(&ar->dp.num_tx_pending))
-			wake_up(&ar->dp.tx_empty_waitq);
-
-		ath12k_dp_tx_complete_msdu(ar, &desc_params, &ts,
-					   tx_ring->tcl_data_ring_id);
-	}
-}
-
 static int
 ath12k_dp_tx_get_ring_id_type(struct ath12k_base *ab,
 			      int mac_id, u32 ring_id,
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.h b/drivers/net/wireless/ath/ath12k/dp_tx.h
index aa2f6397bc83..67ab7b3f55ea 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.h
@@ -19,8 +19,6 @@ int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab);
 int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
 		 bool is_mcast);
-void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id);
-
 int ath12k_dp_tx_htt_h2t_ppdu_stats_req(struct ath12k *ar, u32 mask);
 int
 ath12k_dp_tx_htt_h2t_ext_stats_req(struct ath12k *ar, u8 type,
@@ -38,4 +36,20 @@ int ath12k_dp_tx_htt_tx_filter_setup(struct ath12k_base *ab, u32 ring_id,
 				     int tx_buf_size,
 				     struct htt_tx_ring_tlv_filter *htt_tlv_filter);
 int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset);
+
+enum hal_tcl_encap_type
+ath12k_dp_tx_get_encap_type(struct ath12k_base *ab, struct sk_buff *skb);
+void ath12k_dp_tx_encap_nwifi(struct sk_buff *skb);
+u8 ath12k_dp_tx_get_tid(struct sk_buff *skb);
+void *ath12k_dp_metadata_align_skb(struct sk_buff *skb, u8 tail_len);
+int ath12k_dp_tx_align_payload(struct ath12k_base *ab,
+			       struct sk_buff **pskb);
+void ath12k_dp_tx_release_txbuf(struct ath12k_dp *dp,
+				struct ath12k_tx_desc_info *tx_desc,
+				u8 pool_id);
+struct ath12k_tx_desc_info *ath12k_dp_tx_assign_buffer(struct ath12k_dp *dp,
+						       u8 pool_id);
+void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
+			     struct dp_tx_ring *tx_ring,
+			     struct ath12k_tx_desc_params *desc_params);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index bd1ec3b2c084..996d0b425c10 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <net/mac80211.h>
@@ -14,6 +14,7 @@
 #include "wmi.h"
 #include "hw.h"
 #include "dp_tx.h"
+#include "wifi7/dp_tx.h"
 #include "dp_rx.h"
 #include "testmode.h"
 #include "peer.h"
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.c b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
index 2e7b9bbd3d8e..afe791394e6b 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
@@ -10,6 +10,7 @@
 #include "../dp_mon.h"
 #include "dp_rx.h"
 #include "dp.h"
+#include "dp_tx.h"
 
 int ath12k_dp_service_srng(struct ath12k_base *ab,
 			   struct ath12k_ext_irq_grp *irq_grp,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
new file mode 100644
index 000000000000..149e211aa225
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -0,0 +1,545 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "../core.h"
+#include "../debug.h"
+#include "../dp_tx.h"
+#include "../peer.h"
+#include "dp_tx.h"
+
+static void
+ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
+				 struct ath12k_tx_desc_params *desc_params,
+				 struct dp_tx_ring *tx_ring,
+				 struct ath12k_dp_htt_wbm_tx_status *ts,
+				 u16 peer_id)
+{
+	struct ieee80211_tx_info *info;
+	struct ath12k_link_vif *arvif;
+	struct ath12k_skb_cb *skb_cb;
+	struct ieee80211_vif *vif;
+	struct ath12k_vif *ahvif;
+	struct ath12k *ar;
+	struct sk_buff *msdu = desc_params->skb;
+	s32 noise_floor;
+	struct ieee80211_tx_status status = {};
+	struct ath12k_peer *peer;
+
+	skb_cb = ATH12K_SKB_CB(msdu);
+	info = IEEE80211_SKB_CB(msdu);
+
+	ar = skb_cb->ar;
+	ab->device_stats.tx_completed[tx_ring->tcl_data_ring_id]++;
+
+	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
+		wake_up(&ar->dp.tx_empty_waitq);
+
+	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
+	if (skb_cb->paddr_ext_desc) {
+		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
+				 desc_params->skb_ext_desc->len, DMA_TO_DEVICE);
+		dev_kfree_skb_any(desc_params->skb_ext_desc);
+	}
+
+	vif = skb_cb->vif;
+	if (vif) {
+		ahvif = ath12k_vif_to_ahvif(vif);
+		rcu_read_lock();
+		arvif = rcu_dereference(ahvif->link[skb_cb->link_id]);
+		if (arvif) {
+			spin_lock_bh(&arvif->link_stats_lock);
+			arvif->link_stats.tx_completed++;
+			spin_unlock_bh(&arvif->link_stats_lock);
+		}
+		rcu_read_unlock();
+	}
+
+	memset(&info->status, 0, sizeof(info->status));
+
+	if (ts->acked) {
+		if (!(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
+			info->flags |= IEEE80211_TX_STAT_ACK;
+			info->status.ack_signal = ts->ack_rssi;
+
+			if (!test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
+				      ab->wmi_ab.svc_map)) {
+				spin_lock_bh(&ar->data_lock);
+				noise_floor = ath12k_pdev_get_noise_floor(ar);
+				spin_unlock_bh(&ar->data_lock);
+
+				info->status.ack_signal += noise_floor;
+			}
+
+			info->status.flags = IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
+		} else {
+			info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
+		}
+	}
+	rcu_read_lock();
+	spin_lock_bh(&ab->base_lock);
+	peer = ath12k_peer_find_by_id(ab, peer_id);
+	if (!peer || !peer->sta) {
+		ath12k_dbg(ab, ATH12K_DBG_DATA,
+			   "dp_tx: failed to find the peer with peer_id %d\n", peer_id);
+		spin_unlock_bh(&ab->base_lock);
+		ieee80211_free_txskb(ath12k_ar_to_hw(ar), msdu);
+		goto exit;
+	} else {
+		status.sta = peer->sta;
+	}
+	spin_unlock_bh(&ab->base_lock);
+
+	status.info = info;
+	status.skb = msdu;
+	ieee80211_tx_status_ext(ath12k_ar_to_hw(ar), &status);
+exit:
+	rcu_read_unlock();
+}
+
+static void
+ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab, void *desc,
+				     struct dp_tx_ring *tx_ring,
+				     struct ath12k_tx_desc_params *desc_params)
+{
+	struct htt_tx_wbm_completion *status_desc;
+	struct ath12k_dp_htt_wbm_tx_status ts = {};
+	enum hal_wbm_htt_tx_comp_status wbm_status;
+	u16 peer_id;
+
+	status_desc = desc;
+
+	wbm_status = le32_get_bits(status_desc->info0,
+				   HTT_TX_WBM_COMP_INFO0_STATUS);
+	ab->device_stats.fw_tx_status[wbm_status]++;
+
+	switch (wbm_status) {
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_OK:
+		ts.acked = (wbm_status == HAL_WBM_REL_HTT_TX_COMP_STATUS_OK);
+		ts.ack_rssi = le32_get_bits(status_desc->info2,
+					    HTT_TX_WBM_COMP_INFO2_ACK_RSSI);
+
+		peer_id = le32_get_bits(((struct hal_wbm_completion_ring_tx *)desc)->
+				info3, HAL_WBM_COMPL_TX_INFO3_PEER_ID);
+
+		ath12k_dp_tx_htt_tx_complete_buf(ab, desc_params, tx_ring, &ts, peer_id);
+		break;
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_DROP:
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_TTL:
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_REINJ:
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_INSPECT:
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_VDEVID_MISMATCH:
+		ath12k_dp_tx_free_txbuf(ab, tx_ring, desc_params);
+		break;
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_MEC_NOTIFY:
+		/* This event is to be handled only when the driver decides to
+		 * use WDS offload functionality.
+		 */
+		break;
+	default:
+		ath12k_warn(ab, "Unknown htt wbm tx status %d\n", wbm_status);
+		break;
+	}
+}
+
+static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status *ts)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_peer *peer;
+	struct ieee80211_sta *sta;
+	struct ath12k_sta *ahsta;
+	struct ath12k_link_sta *arsta;
+	struct rate_info txrate = {};
+	u16 rate, ru_tones;
+	u8 rate_idx = 0;
+	int ret;
+
+	spin_lock_bh(&ab->base_lock);
+	peer = ath12k_peer_find_by_id(ab, ts->peer_id);
+	if (!peer || !peer->sta) {
+		ath12k_dbg(ab, ATH12K_DBG_DP_TX,
+			   "failed to find the peer by id %u\n", ts->peer_id);
+		spin_unlock_bh(&ab->base_lock);
+		return;
+	}
+	sta = peer->sta;
+	ahsta = ath12k_sta_to_ahsta(sta);
+	arsta = &ahsta->deflink;
+
+	/* This is to prefer choose the real NSS value arsta->last_txrate.nss,
+	 * if it is invalid, then choose the NSS value while assoc.
+	 */
+	if (arsta->last_txrate.nss)
+		txrate.nss = arsta->last_txrate.nss;
+	else
+		txrate.nss = arsta->peer_nss;
+	spin_unlock_bh(&ab->base_lock);
+
+	switch (ts->pkt_type) {
+	case HAL_TX_RATE_STATS_PKT_TYPE_11A:
+	case HAL_TX_RATE_STATS_PKT_TYPE_11B:
+		ret = ath12k_mac_hw_ratecode_to_legacy_rate(ts->mcs,
+							    ts->pkt_type,
+							    &rate_idx,
+							    &rate);
+		if (ret < 0) {
+			ath12k_warn(ab, "Invalid tx legacy rate %d\n", ret);
+			return;
+		}
+
+		txrate.legacy = rate;
+		break;
+	case HAL_TX_RATE_STATS_PKT_TYPE_11N:
+		if (ts->mcs > ATH12K_HT_MCS_MAX) {
+			ath12k_warn(ab, "Invalid HT mcs index %d\n", ts->mcs);
+			return;
+		}
+
+		if (txrate.nss != 0)
+			txrate.mcs = ts->mcs + 8 * (txrate.nss - 1);
+
+		txrate.flags = RATE_INFO_FLAGS_MCS;
+
+		if (ts->sgi)
+			txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case HAL_TX_RATE_STATS_PKT_TYPE_11AC:
+		if (ts->mcs > ATH12K_VHT_MCS_MAX) {
+			ath12k_warn(ab, "Invalid VHT mcs index %d\n", ts->mcs);
+			return;
+		}
+
+		txrate.mcs = ts->mcs;
+		txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
+
+		if (ts->sgi)
+			txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case HAL_TX_RATE_STATS_PKT_TYPE_11AX:
+		if (ts->mcs > ATH12K_HE_MCS_MAX) {
+			ath12k_warn(ab, "Invalid HE mcs index %d\n", ts->mcs);
+			return;
+		}
+
+		txrate.mcs = ts->mcs;
+		txrate.flags = RATE_INFO_FLAGS_HE_MCS;
+		txrate.he_gi = ath12k_he_gi_to_nl80211_he_gi(ts->sgi);
+		break;
+	case HAL_TX_RATE_STATS_PKT_TYPE_11BE:
+		if (ts->mcs > ATH12K_EHT_MCS_MAX) {
+			ath12k_warn(ab, "Invalid EHT mcs index %d\n", ts->mcs);
+			return;
+		}
+
+		txrate.mcs = ts->mcs;
+		txrate.flags = RATE_INFO_FLAGS_EHT_MCS;
+		txrate.eht_gi = ath12k_mac_eht_gi_to_nl80211_eht_gi(ts->sgi);
+		break;
+	default:
+		ath12k_warn(ab, "Invalid tx pkt type: %d\n", ts->pkt_type);
+		return;
+	}
+
+	txrate.bw = ath12k_mac_bw_to_mac80211_bw(ts->bw);
+
+	if (ts->ofdma && ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
+		txrate.bw = RATE_INFO_BW_HE_RU;
+		ru_tones = ath12k_mac_he_convert_tones_to_ru_tones(ts->tones);
+		txrate.he_ru_alloc =
+			ath12k_he_ru_tones_to_nl80211_he_ru_alloc(ru_tones);
+	}
+
+	if (ts->ofdma && ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11BE) {
+		txrate.bw = RATE_INFO_BW_EHT_RU;
+		txrate.eht_ru_alloc =
+			ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(ts->tones);
+	}
+
+	spin_lock_bh(&ab->base_lock);
+	arsta->txrate = txrate;
+	spin_unlock_bh(&ab->base_lock);
+}
+
+static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
+				       struct ath12k_tx_desc_params *desc_params,
+				       struct hal_tx_status *ts,
+				       int ring)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ar->ah;
+	struct ieee80211_tx_info *info;
+	struct ath12k_link_vif *arvif;
+	struct ath12k_skb_cb *skb_cb;
+	struct ieee80211_vif *vif;
+	struct ath12k_vif *ahvif;
+	struct sk_buff *msdu = desc_params->skb;
+	s32 noise_floor;
+	struct ieee80211_tx_status status = {};
+	struct ieee80211_rate_status status_rate = {};
+	struct ath12k_peer *peer;
+	struct ath12k_link_sta *arsta;
+	struct ath12k_sta *ahsta;
+	struct rate_info rate;
+
+	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
+		/* Must not happen */
+		return;
+	}
+
+	skb_cb = ATH12K_SKB_CB(msdu);
+	ab->device_stats.tx_completed[ring]++;
+
+	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
+	if (skb_cb->paddr_ext_desc) {
+		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
+				 desc_params->skb_ext_desc->len, DMA_TO_DEVICE);
+		dev_kfree_skb_any(desc_params->skb_ext_desc);
+	}
+
+	rcu_read_lock();
+
+	if (!rcu_dereference(ab->pdevs_active[ar->pdev_idx])) {
+		ieee80211_free_txskb(ah->hw, msdu);
+		goto exit;
+	}
+
+	if (!skb_cb->vif) {
+		ieee80211_free_txskb(ah->hw, msdu);
+		goto exit;
+	}
+
+	vif = skb_cb->vif;
+	if (vif) {
+		ahvif = ath12k_vif_to_ahvif(vif);
+		arvif = rcu_dereference(ahvif->link[skb_cb->link_id]);
+		if (arvif) {
+			spin_lock_bh(&arvif->link_stats_lock);
+			arvif->link_stats.tx_completed++;
+			spin_unlock_bh(&arvif->link_stats_lock);
+		}
+	}
+
+	info = IEEE80211_SKB_CB(msdu);
+	memset(&info->status, 0, sizeof(info->status));
+
+	/* skip tx rate update from ieee80211_status*/
+	info->status.rates[0].idx = -1;
+
+	switch (ts->status) {
+	case HAL_WBM_TQM_REL_REASON_FRAME_ACKED:
+		if (!(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
+			info->flags |= IEEE80211_TX_STAT_ACK;
+			info->status.ack_signal = ts->ack_rssi;
+
+			if (!test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
+				      ab->wmi_ab.svc_map)) {
+				spin_lock_bh(&ar->data_lock);
+				noise_floor = ath12k_pdev_get_noise_floor(ar);
+				spin_unlock_bh(&ar->data_lock);
+
+				info->status.ack_signal += noise_floor;
+			}
+
+			info->status.flags = IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
+		}
+		break;
+	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_TX:
+		if (info->flags & IEEE80211_TX_CTL_NO_ACK) {
+			info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
+			break;
+		}
+		fallthrough;
+	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_MPDU:
+	case HAL_WBM_TQM_REL_REASON_DROP_THRESHOLD:
+	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_AGED_FRAMES:
+		/* The failure status is due to internal firmware tx failure
+		 * hence drop the frame; do not update the status of frame to
+		 * the upper layer
+		 */
+		ieee80211_free_txskb(ah->hw, msdu);
+		goto exit;
+	default:
+		ath12k_dbg(ab, ATH12K_DBG_DP_TX, "tx frame is not acked status %d\n",
+			   ts->status);
+		break;
+	}
+
+	/* NOTE: Tx rate status reporting. Tx completion status does not have
+	 * necessary information (for example nss) to build the tx rate.
+	 * Might end up reporting it out-of-band from HTT stats.
+	 */
+
+	ath12k_dp_tx_update_txcompl(ar, ts);
+
+	spin_lock_bh(&ab->base_lock);
+	peer = ath12k_peer_find_by_id(ab, ts->peer_id);
+	if (!peer || !peer->sta) {
+		ath12k_err(ab,
+			   "dp_tx: failed to find the peer with peer_id %d\n",
+			   ts->peer_id);
+		spin_unlock_bh(&ab->base_lock);
+		ieee80211_free_txskb(ath12k_ar_to_hw(ar), msdu);
+		goto exit;
+	}
+	ahsta = ath12k_sta_to_ahsta(peer->sta);
+	arsta = &ahsta->deflink;
+
+	spin_unlock_bh(&ab->base_lock);
+
+	status.sta = peer->sta;
+	status.info = info;
+	status.skb = msdu;
+	rate = arsta->last_txrate;
+
+	status_rate.rate_idx = rate;
+	status_rate.try_count = 1;
+
+	status.rates = &status_rate;
+	status.n_rates = 1;
+	ieee80211_tx_status_ext(ath12k_ar_to_hw(ar), &status);
+
+exit:
+	rcu_read_unlock();
+}
+
+static void ath12k_dp_tx_status_parse(struct ath12k_base *ab,
+				      struct hal_wbm_completion_ring_tx *desc,
+				      struct hal_tx_status *ts)
+{
+	u32 info0 = le32_to_cpu(desc->rate_stats.info0);
+
+	ts->buf_rel_source =
+		le32_get_bits(desc->info0, HAL_WBM_COMPL_TX_INFO0_REL_SRC_MODULE);
+	if (ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_FW &&
+	    ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)
+		return;
+
+	if (ts->buf_rel_source == HAL_WBM_REL_SRC_MODULE_FW)
+		return;
+
+	ts->status = le32_get_bits(desc->info0,
+				   HAL_WBM_COMPL_TX_INFO0_TQM_RELEASE_REASON);
+
+	ts->ppdu_id = le32_get_bits(desc->info1,
+				    HAL_WBM_COMPL_TX_INFO1_TQM_STATUS_NUMBER);
+
+	ts->peer_id = le32_get_bits(desc->info3, HAL_WBM_COMPL_TX_INFO3_PEER_ID);
+
+	ts->ack_rssi = le32_get_bits(desc->info2,
+				     HAL_WBM_COMPL_TX_INFO2_ACK_FRAME_RSSI);
+
+	if (info0 & HAL_TX_RATE_STATS_INFO0_VALID) {
+		ts->pkt_type = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_PKT_TYPE);
+		ts->mcs = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_MCS);
+		ts->sgi = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_SGI);
+		ts->bw = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_BW);
+		ts->tones = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_TONES_IN_RU);
+		ts->ofdma = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_OFDMA_TX);
+	}
+}
+
+void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
+{
+	struct ath12k *ar;
+	struct ath12k_dp *dp = &ab->dp;
+	int hal_ring_id = dp->tx_ring[ring_id].tcl_comp_ring.ring_id;
+	struct hal_srng *status_ring = &ab->hal.srng_list[hal_ring_id];
+	struct ath12k_tx_desc_info *tx_desc = NULL;
+	struct hal_tx_status ts = {};
+	struct ath12k_tx_desc_params desc_params;
+	struct dp_tx_ring *tx_ring = &dp->tx_ring[ring_id];
+	struct hal_wbm_release_ring *desc;
+	u8 pdev_id;
+	u64 desc_va;
+	enum hal_wbm_rel_src_module buf_rel_source;
+	enum hal_wbm_tqm_rel_reason rel_status;
+
+	spin_lock_bh(&status_ring->lock);
+
+	ath12k_hal_srng_access_begin(ab, status_ring);
+
+	while (ATH12K_TX_COMPL_NEXT(ab, tx_ring->tx_status_head) !=
+	       tx_ring->tx_status_tail) {
+		desc = ath12k_hal_srng_dst_get_next_entry(ab, status_ring);
+		if (!desc)
+			break;
+
+		memcpy(&tx_ring->tx_status[tx_ring->tx_status_head],
+		       desc, sizeof(*desc));
+		tx_ring->tx_status_head =
+			ATH12K_TX_COMPL_NEXT(ab, tx_ring->tx_status_head);
+	}
+
+	if (ath12k_hal_srng_dst_peek(ab, status_ring) &&
+	    (ATH12K_TX_COMPL_NEXT(ab, tx_ring->tx_status_head) ==
+	     tx_ring->tx_status_tail)) {
+		/* TODO: Process pending tx_status messages when kfifo_is_full() */
+		ath12k_warn(ab, "Unable to process some of the tx_status ring desc because status_fifo is full\n");
+	}
+
+	ath12k_hal_srng_access_end(ab, status_ring);
+
+	spin_unlock_bh(&status_ring->lock);
+
+	while (ATH12K_TX_COMPL_NEXT(ab, tx_ring->tx_status_tail) !=
+	       tx_ring->tx_status_head) {
+		struct hal_wbm_completion_ring_tx *tx_status;
+		u32 desc_id;
+
+		tx_ring->tx_status_tail =
+			ATH12K_TX_COMPL_NEXT(ab, tx_ring->tx_status_tail);
+		tx_status = &tx_ring->tx_status[tx_ring->tx_status_tail];
+		ath12k_dp_tx_status_parse(ab, tx_status, &ts);
+
+		if (le32_get_bits(tx_status->info0, HAL_WBM_COMPL_TX_INFO0_CC_DONE)) {
+			/* HW done cookie conversion */
+			desc_va = ((u64)le32_to_cpu(tx_status->buf_va_hi) << 32 |
+				   le32_to_cpu(tx_status->buf_va_lo));
+			tx_desc = (struct ath12k_tx_desc_info *)((unsigned long)desc_va);
+		} else {
+			/* SW does cookie conversion to VA */
+			desc_id = le32_get_bits(tx_status->buf_va_hi,
+						BUFFER_ADDR_INFO1_SW_COOKIE);
+
+			tx_desc = ath12k_dp_get_tx_desc(ab, desc_id);
+		}
+		if (!tx_desc) {
+			ath12k_warn(ab, "unable to retrieve tx_desc!");
+			continue;
+		}
+
+		desc_params.mac_id = tx_desc->mac_id;
+		desc_params.skb = tx_desc->skb;
+		desc_params.skb_ext_desc = tx_desc->skb_ext_desc;
+
+		/* Find the HAL_WBM_RELEASE_INFO0_REL_SRC_MODULE value */
+		buf_rel_source = le32_get_bits(tx_status->info0,
+					       HAL_WBM_RELEASE_INFO0_REL_SRC_MODULE);
+		ab->device_stats.tx_wbm_rel_source[buf_rel_source]++;
+
+		rel_status = le32_get_bits(tx_status->info0,
+					   HAL_WBM_COMPL_TX_INFO0_TQM_RELEASE_REASON);
+		ab->device_stats.tqm_rel_reason[rel_status]++;
+
+		/* Release descriptor as soon as extracting necessary info
+		 * to reduce contention
+		 */
+		ath12k_dp_tx_release_txbuf(dp, tx_desc, tx_desc->pool_id);
+		if (ts.buf_rel_source == HAL_WBM_REL_SRC_MODULE_FW) {
+			ath12k_dp_tx_process_htt_tx_complete(ab, (void *)tx_status,
+							     tx_ring, &desc_params);
+			continue;
+		}
+
+		pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, desc_params.mac_id);
+		ar = ab->pdevs[pdev_id].ar;
+
+		if (atomic_dec_and_test(&ar->dp.num_tx_pending))
+			wake_up(&ar->dp.tx_empty_waitq);
+
+		ath12k_dp_tx_complete_msdu(ar, &desc_params, &ts,
+					   tx_ring->tcl_data_ring_id);
+	}
+}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
new file mode 100644
index 000000000000..4361beb99666
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef ATH12K_DP_TX_WIFI7_H
+#define ATH12K_DP_TX_WIFI7_H
+
+void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id);
+#endif
-- 
2.34.1


