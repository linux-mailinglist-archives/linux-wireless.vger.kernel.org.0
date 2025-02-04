Return-Path: <linux-wireless+bounces-18404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C819A26EA8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 10:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A1918870A8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 09:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17691207DE0;
	Tue,  4 Feb 2025 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Igb9/2fH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC5C207DF2
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738661954; cv=none; b=ZMWEZuQT/v0FtkOW7wN8RIJXGQfZx9HPE8Go5unjl0yGGVdws2lrxiHEfHoB8XPmEe4BDZ7yJD64pbpi76SHGXaI/GfkcbhHpFYkfsHm2zpChYAkWsAtoE3otj/joGFFu88aDyRJvnWZeV6uy7mz9XgbkkCCakkIgdyIMmvFEzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738661954; c=relaxed/simple;
	bh=rMzyRa42UZerKnLUGqepe8DgQSwAfT9hjjUKEgR7w0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEqaKARaaRZPVIKgi+dfyhP0X/1a9LNo7O8YN1ChTjnGYNwvYP36mukR65QRZDjrD5VyW8Kw4pxNZLD2A8NCUrkn2IP8fAi4scMp2NdTtdpJtvE7eh2o+tPIBJOvXilrq6w+KaaozR0CibHg2fnQTtsXLgdV1KDxdP5l/TrHjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Igb9/2fH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5148TepM004747;
	Tue, 4 Feb 2025 09:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G5mFaYwEUiXYuYZMFh5dmBOnVdXNOvi7Lg25Y3pPRrc=; b=Igb9/2fH8NiZwNJv
	NQDqIzHze1zvOwAVrJ24j4XdX6Hgb+HOkzPj//muJZIZq1CKWPZDWaH7yIKoMqoE
	LUQyJxWuHtj7pbOIgHKoODmLYn7poaEXTJFqb00uRv8S/CEAL5PSYAmek18CCn/z
	Qt6J3lVQfD7EMXJyDh9tkHjjTKnJ1yditZPQH1YqyIELC2PD7dsLr/8uAA17StXL
	3OPEWDlJQ5sjVTdJ62FKbms2azH5L6pUGUqCE3IJNgL56M46rwMp5NoXtEyZ+e16
	raG3NBfkbwnPkMM1Z6aJ91timjTh5CQGKHkMbBm+gV67HESiShIKS3kRkQ2dBn39
	CnG2PQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kfe9g62s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 09:39:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5149d7cn025459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 09:39:07 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Feb 2025 01:39:05 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Nicolas Escande
	<nico.escande@gmail.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH v4 2/7] wifi: ath12k: Add extra TLV tag parsing support in monitor Rx path
Date: Tue, 4 Feb 2025 15:06:51 +0530
Message-ID: <20250204093656.3682278-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204093656.3682278-1-quic_periyasa@quicinc.com>
References: <20250204093656.3682278-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pBrZ9IWITRrvUK5XRNB79aVaK342zUDq
X-Proofpoint-GUID: pBrZ9IWITRrvUK5XRNB79aVaK342zUDq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040077

From: P Praneesh <quic_ppranees@quicinc.com>

Currently, the monitor Rx parser handler is inherited from the ath11k.
However, the ath12k 802.11be hardware does not report the Rx TLV header
in the MSDU data. Instead, the hardware reports those TLVs under the
following TLV tags:

1. Buffer address
2. MPDU start
3. MPDU end
4. MSDU end

Therefore, add support for parsing the above TLVs in the Rx monitor path
and use this information for MSDU buffer and status updates.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Tested-by: Nicolas Escande <nico.escande@gmail.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp.h     |   4 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c | 157 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/dp_mon.h |   4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  |   1 +
 drivers/net/wireless/ath/ath12k/hal_rx.h |  12 +-
 5 files changed, 170 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index f68bb78d4a11..27efd37f0955 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_DP_H
@@ -106,6 +106,8 @@ struct dp_mon_mpdu {
 	struct list_head list;
 	struct sk_buff *head;
 	struct sk_buff *tail;
+	u32 err_bitmap;
+	u8 decap_format;
 };
 
 #define DP_MON_MAX_STATUS_BUF 32
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 12224fea9801..61770bd8aceb 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1647,7 +1647,7 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 				u32_get_bits(info[0], HAL_RX_MPDU_START_INFO0_PPDU_ID);
 		}
 
-		break;
+		return HAL_RX_MON_STATUS_MPDU_START;
 	}
 	case HAL_RX_MSDU_START:
 		/* TODO: add msdu start parsing logic */
@@ -2090,6 +2090,144 @@ static int ath12k_dp_mon_rx_deliver(struct ath12k *ar,
 	return -EINVAL;
 }
 
+static int ath12k_dp_pkt_set_pktlen(struct sk_buff *skb, u32 len)
+{
+	if (skb->len > len) {
+		skb_trim(skb, len);
+	} else {
+		if (skb_tailroom(skb) < len - skb->len) {
+			if ((pskb_expand_head(skb, 0,
+					      len - skb->len - skb_tailroom(skb),
+					      GFP_ATOMIC))) {
+				return -ENOMEM;
+			}
+		}
+		skb_put(skb, (len - skb->len));
+	}
+
+	return 0;
+}
+
+static void ath12k_dp_mon_parse_rx_msdu_end_err(u32 info, u32 *errmap)
+{
+	if (info & RX_MSDU_END_INFO13_FCS_ERR)
+		*errmap |= HAL_RX_MPDU_ERR_FCS;
+
+	if (info & RX_MSDU_END_INFO13_DECRYPT_ERR)
+		*errmap |= HAL_RX_MPDU_ERR_DECRYPT;
+
+	if (info & RX_MSDU_END_INFO13_TKIP_MIC_ERR)
+		*errmap |= HAL_RX_MPDU_ERR_TKIP_MIC;
+
+	if (info & RX_MSDU_END_INFO13_A_MSDU_ERROR)
+		*errmap |= HAL_RX_MPDU_ERR_AMSDU_ERR;
+
+	if (info & RX_MSDU_END_INFO13_OVERFLOW_ERR)
+		*errmap |= HAL_RX_MPDU_ERR_OVERFLOW;
+
+	if (info & RX_MSDU_END_INFO13_MSDU_LEN_ERR)
+		*errmap |= HAL_RX_MPDU_ERR_MSDU_LEN;
+
+	if (info & RX_MSDU_END_INFO13_MPDU_LEN_ERR)
+		*errmap |= HAL_RX_MPDU_ERR_MPDU_LEN;
+}
+
+static int
+ath12k_dp_mon_parse_status_msdu_end(struct ath12k_mon_data *pmon,
+				    const struct hal_rx_msdu_end *msdu_end)
+{
+	struct dp_mon_mpdu *mon_mpdu = pmon->mon_mpdu;
+
+	ath12k_dp_mon_parse_rx_msdu_end_err(__le32_to_cpu(msdu_end->info2),
+					    &mon_mpdu->err_bitmap);
+
+	mon_mpdu->decap_format = le32_get_bits(msdu_end->info1,
+					       RX_MSDU_END_INFO11_DECAP_FORMAT);
+
+	return 0;
+}
+
+static int
+ath12k_dp_mon_parse_status_buf(struct ath12k *ar,
+			       struct ath12k_mon_data *pmon,
+			       const struct dp_mon_packet_info *packet_info)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct dp_rxdma_mon_ring *buf_ring = &ab->dp.rxdma_mon_buf_ring;
+	struct sk_buff *msdu;
+	int buf_id;
+	u32 offset;
+
+	buf_id = u32_get_bits(packet_info->cookie, DP_RXDMA_BUF_COOKIE_BUF_ID);
+
+	spin_lock_bh(&buf_ring->idr_lock);
+	msdu = idr_remove(&buf_ring->bufs_idr, buf_id);
+	spin_unlock_bh(&buf_ring->idr_lock);
+
+	if (unlikely(!msdu)) {
+		ath12k_warn(ab, "mon dest desc with inval buf_id %d\n", buf_id);
+		return 0;
+	}
+
+	dma_unmap_single(ab->dev, ATH12K_SKB_RXCB(msdu)->paddr,
+			 msdu->len + skb_tailroom(msdu),
+			 DMA_FROM_DEVICE);
+
+	offset = packet_info->dma_length + ATH12K_MON_RX_DOT11_OFFSET;
+	if (ath12k_dp_pkt_set_pktlen(msdu, offset)) {
+		dev_kfree_skb_any(msdu);
+		goto dest_replenish;
+	}
+
+	if (!pmon->mon_mpdu->head)
+		pmon->mon_mpdu->head = msdu;
+	else
+		pmon->mon_mpdu->tail->next = msdu;
+
+	pmon->mon_mpdu->tail = msdu;
+
+dest_replenish:
+	ath12k_dp_mon_buf_replenish(ab, buf_ring, 1);
+
+	return 0;
+}
+
+static int
+ath12k_dp_mon_parse_rx_dest_tlv(struct ath12k *ar,
+				struct ath12k_mon_data *pmon,
+				enum hal_rx_mon_status hal_status,
+				const void *tlv_data)
+{
+	switch (hal_status) {
+	case HAL_RX_MON_STATUS_MPDU_START:
+		if (WARN_ON_ONCE(pmon->mon_mpdu))
+			break;
+
+		pmon->mon_mpdu = kzalloc(sizeof(*pmon->mon_mpdu), GFP_ATOMIC);
+		if (!pmon->mon_mpdu)
+			return -ENOMEM;
+		break;
+	case HAL_RX_MON_STATUS_BUF_ADDR:
+		return ath12k_dp_mon_parse_status_buf(ar, pmon, tlv_data);
+	case HAL_RX_MON_STATUS_MPDU_END:
+		/* If no MSDU then free empty MPDU */
+		if (pmon->mon_mpdu->tail) {
+			pmon->mon_mpdu->tail->next = NULL;
+			list_add_tail(&pmon->mon_mpdu->list, &pmon->dp_rx_mon_mpdu_list);
+		} else {
+			kfree(pmon->mon_mpdu);
+		}
+		pmon->mon_mpdu = NULL;
+		break;
+	case HAL_RX_MON_STATUS_MSDU_END:
+		return ath12k_dp_mon_parse_status_msdu_end(pmon, tlv_data);
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static enum hal_rx_mon_status
 ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
 			    struct sk_buff *skb)
@@ -2116,14 +2254,20 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
 			tlv_len = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_LEN);
 
 		hal_status = ath12k_dp_mon_rx_parse_status_tlv(ar, pmon, tlv);
+
+		if (ar->monitor_started &&
+		    ath12k_dp_mon_parse_rx_dest_tlv(ar, pmon, hal_status, tlv->value))
+			return HAL_RX_MON_STATUS_PPDU_DONE;
+
 		ptr += sizeof(*tlv) + tlv_len;
 		ptr = PTR_ALIGN(ptr, HAL_TLV_64_ALIGN);
 
-		if ((ptr - skb->data) >= DP_RX_BUFFER_SIZE)
+		if ((ptr - skb->data) > skb->len)
 			break;
 
 	} while ((hal_status == HAL_RX_MON_STATUS_PPDU_NOT_DONE) ||
 		 (hal_status == HAL_RX_MON_STATUS_BUF_ADDR) ||
+		 (hal_status == HAL_RX_MON_STATUS_MPDU_START) ||
 		 (hal_status == HAL_RX_MON_STATUS_MPDU_END) ||
 		 (hal_status == HAL_RX_MON_STATUS_MSDU_END));
 
@@ -2144,9 +2288,11 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 	struct dp_mon_mpdu *tmp;
 	struct dp_mon_mpdu *mon_mpdu = pmon->mon_mpdu;
 	struct sk_buff *head_msdu, *tail_msdu;
-	enum hal_rx_mon_status hal_status = HAL_RX_MON_STATUS_BUF_DONE;
+	enum hal_rx_mon_status hal_status;
 
-	ath12k_dp_mon_parse_rx_dest(ar, pmon, skb);
+	hal_status = ath12k_dp_mon_parse_rx_dest(ar, pmon, skb);
+	if (hal_status != HAL_RX_MON_STATUS_PPDU_DONE)
+		return hal_status;
 
 	list_for_each_entry_safe(mon_mpdu, tmp, &pmon->dp_rx_mon_mpdu_list, list) {
 		list_del(&mon_mpdu->list);
@@ -2160,6 +2306,7 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 
 		kfree(mon_mpdu);
 	}
+
 	return hal_status;
 }
 
@@ -3346,7 +3493,7 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 		ath12k_dp_mon_rx_memset_ppdu_info(ppdu_info);
 
 	while ((skb = __skb_dequeue(&skb_list))) {
-		hal_status = ath12k_dp_mon_parse_rx_dest(ar, pmon, skb);
+		hal_status = ath12k_dp_mon_rx_parse_mon_status(ar, pmon, skb, napi);
 		if (hal_status != HAL_RX_MON_STATUS_PPDU_DONE) {
 			ppdu_info->ppdu_continuation = true;
 			dev_kfree_skb_any(skb);
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index e4368eb42aca..b039f6b9277c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_DP_MON_H
@@ -9,6 +9,8 @@
 
 #include "core.h"
 
+#define ATH12K_MON_RX_DOT11_OFFSET	5
+
 enum dp_monitor_mode {
 	ATH12K_DP_TX_MONITOR_MODE,
 	ATH12K_DP_RX_MONITOR_MODE
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 95c9056642cf..44e47ec5b3ee 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -4442,6 +4442,7 @@ int ath12k_dp_rx_pdev_mon_attach(struct ath12k *ar)
 
 	pmon->mon_last_linkdesc_paddr = 0;
 	pmon->mon_last_buf_cookie = DP_RX_DESC_COOKIE_MAX + 1;
+	INIT_LIST_HEAD(&pmon->dp_rx_mon_mpdu_list);
 	spin_lock_init(&pmon->mon_lock);
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 6bdcd0867d86..6f10e4222ba6 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -108,11 +108,12 @@ enum hal_rx_mon_status {
 	HAL_RX_MON_STATUS_PPDU_DONE,
 	HAL_RX_MON_STATUS_BUF_DONE,
 	HAL_RX_MON_STATUS_BUF_ADDR,
+	HAL_RX_MON_STATUS_MPDU_START,
 	HAL_RX_MON_STATUS_MPDU_END,
 	HAL_RX_MON_STATUS_MSDU_END,
 };
 
-#define HAL_RX_MAX_MPDU		256
+#define HAL_RX_MAX_MPDU				1024
 #define HAL_RX_NUM_WORDS_PER_PPDU_BITMAP	(HAL_RX_MAX_MPDU >> 5)
 
 struct hal_rx_user_status {
@@ -506,6 +507,15 @@ struct hal_rx_mpdu_start {
 	__le32 rsvd2[16];
 } __packed;
 
+struct hal_rx_msdu_end {
+	__le32 info0;
+	__le32 rsvd0[18];
+	__le32 info1;
+	__le32 rsvd1[10];
+	__le32 info2;
+	__le32 rsvd2;
+} __packed;
+
 #define HAL_RX_PPDU_END_DURATION	GENMASK(23, 0)
 struct hal_rx_ppdu_end_duration {
 	__le32 rsvd0[9];
-- 
2.34.1


