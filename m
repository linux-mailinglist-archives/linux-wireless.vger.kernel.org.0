Return-Path: <linux-wireless+bounces-16724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEA09FAA2B
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 07:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7728A161757
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 06:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1D018A6B5;
	Mon, 23 Dec 2024 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mZ9zpiuF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604F185B5F
	for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734933736; cv=none; b=cNYxfODdkQxt6kUV18Mp1CGNfms3KuDYYcXvZA7dq3WhK1z9LSbiFgl/GzIdftUgAacB/P3stl1GUngMmrar5b4RnOyX8PSXCAk7Qsk4piGEIlDYD8+WaR33sGy27Z1BZ/X2HLuXpvPB+7+/vAIPAIvCAbhecRf0ksJhnWde11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734933736; c=relaxed/simple;
	bh=5Ed85gmI8T5ihSLR1lw/8JHxMhfnU5rSsRR7jqwTlZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0fGWy1OxtRyt/qwKzvfBPj4RJeE3R/CU23pgvJBy37DGPS+uNd0eeuBTXCNokVVzFSQviQpY4QvqffJ0f5esf7WWzIiD5gLqdS35GYdZn5yBBf/2uZ4ymE3qFPK/+ittHrjTzCN9aTpCBuiywvMfCEj1areC+3T0PNPekDR1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mZ9zpiuF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN2ruWq024937;
	Mon, 23 Dec 2024 06:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bwBAlWdLm/ZrxIwm4bMfyTlx/G2eqBfVTVg0OLjo/kA=; b=mZ9zpiuFqHd9igfK
	Icx+2R/4BKyaFLdqtZmnFhRp2E7NozIgF5FgRndcmYbXm9/+JP5ctVcSr1sIXWgb
	7VOPs9pFj6LeqgNr2QAjCvp0UgPP0+Z9qf+KxtJJe/BdVzVWojtyZ9Qwj4WBPm/k
	JBaVsaEGAffJtg6NAENR4sEc1X4woTt54u8KVpbcBfis8ICWOWScL6PtCsmO6HoV
	OYXmiBDi3f9IPDI+5pqYt72HISpDVZXfEc8970VAai83KMFscDT+paqAPeYe/odF
	7w9eyKc5Tj5pAOwVhOqBzjiNlTTOzsgrviBalGXZ3d+MZg4DyCTebI6R1PdvQ2Wz
	iJM/oA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43pyft0k17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 06:02:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BN62AVi018615
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 06:02:10 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 22 Dec 2024 22:02:08 -0800
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH v2 12/14] wifi: ath12k: Avoid memory leak while enabling statistics
Date: Mon, 23 Dec 2024 11:31:30 +0530
Message-ID: <20241223060132.3506372-13-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241223060132.3506372-1-quic_ppranees@quicinc.com>
References: <20241223060132.3506372-1-quic_ppranees@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Eq9KynPHsv4cg7MnjKRbo7IhqlAf44Of
X-Proofpoint-GUID: Eq9KynPHsv4cg7MnjKRbo7IhqlAf44Of
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230051

Driver uses monitor destination rings for extended statistics mode and
standalone monitor mode. In extended statistics mode, TLVs are parsed from
the buffer received from the monitor destination ring and assigned to the
ppdu_info structure to update per-packet statistics. In standalone monitor
mode, along with per-packet statistics, the packet data (payload) is
captured, and the driver updates per MSDU to mac80211.

When the AP interface is enabled, only extended statistics mode is
activated. As part of enabling monitor rings for collecting statistics,
the driver subscribes to HAL_RX_MPDU_START TLV in the filter
configuration. This TLV is received from the monitor destination ring, and
kzalloc for the mon_mpdu object occurs, which is not freed, leading to a
memory leak. The kzalloc for the mon_mpdu object is only required while
enabling the standalone monitor interface. This causes a memory leak while
enabling extended statistics mode in the driver.

Fix this memory leak by removing the kzalloc for the mon_mpdu object in
the HAL_RX_MPDU_START TLV handling. Additionally, remove the standalone
monitor mode handlings in the HAL_MON_BUF_ADDR and HAL_RX_MSDU_END TLVs.
These TLV tags will be handled properly when enabling standalone monitor
mode in the future.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 65 ++++--------------------
 drivers/net/wireless/ath/ath12k/hal_rx.h |  3 ++
 2 files changed, 12 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 4b35dfcbdfe1..23b1a41c6fd2 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -567,7 +567,6 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 				  struct ath12k_mon_data *pmon,
 				  const struct hal_tlv_64_hdr *tlv)
 {
-	struct ath12k_base *ab = ar->ab;
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
 	const void *tlv_data = tlv->value;
 	u32 info[7], userid;
@@ -748,7 +747,6 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 	}
 	case HAL_RX_MPDU_START: {
 		const struct hal_rx_mpdu_start *mpdu_start = tlv_data;
-		struct dp_mon_mpdu *mon_mpdu = pmon->mon_mpdu;
 		u16 peer_id;
 
 		info[1] = __le32_to_cpu(mpdu_start->info1);
@@ -765,65 +763,17 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 				u32_get_bits(info[0], HAL_RX_MPDU_START_INFO1_PEERID);
 		}
 
-		mon_mpdu = kzalloc(sizeof(*mon_mpdu), GFP_ATOMIC);
-		if (!mon_mpdu)
-			return HAL_RX_MON_STATUS_PPDU_NOT_DONE;
-
 		break;
 	}
 	case HAL_RX_MSDU_START:
 		/* TODO: add msdu start parsing logic */
 		break;
-	case HAL_MON_BUF_ADDR: {
-		struct dp_rxdma_mon_ring *buf_ring = &ab->dp.rxdma_mon_buf_ring;
-		const struct dp_mon_packet_info *packet_info = tlv_data;
-		int buf_id = u32_get_bits(packet_info->cookie,
-					  DP_RXDMA_BUF_COOKIE_BUF_ID);
-		struct sk_buff *msdu;
-		struct dp_mon_mpdu *mon_mpdu = pmon->mon_mpdu;
-		struct ath12k_skb_rxcb *rxcb;
-
-		spin_lock_bh(&buf_ring->idr_lock);
-		msdu = idr_remove(&buf_ring->bufs_idr, buf_id);
-		spin_unlock_bh(&buf_ring->idr_lock);
-
-		if (unlikely(!msdu)) {
-			ath12k_warn(ab, "monitor destination with invalid buf_id %d\n",
-				    buf_id);
-			return HAL_RX_MON_STATUS_PPDU_NOT_DONE;
-		}
-
-		rxcb = ATH12K_SKB_RXCB(msdu);
-		dma_unmap_single(ab->dev, rxcb->paddr,
-				 msdu->len + skb_tailroom(msdu),
-				 DMA_FROM_DEVICE);
-
-		if (mon_mpdu->tail)
-			mon_mpdu->tail->next = msdu;
-		else
-			mon_mpdu->tail = msdu;
-
-		ath12k_dp_mon_buf_replenish(ab, buf_ring, 1);
-
-		break;
-	}
-	case HAL_RX_MSDU_END: {
-		const struct rx_msdu_end_qcn9274 *msdu_end = tlv_data;
-		bool is_first_msdu_in_mpdu;
-		u16 msdu_end_info;
-
-		msdu_end_info = __le16_to_cpu(msdu_end->info5);
-		is_first_msdu_in_mpdu = u32_get_bits(msdu_end_info,
-						     RX_MSDU_END_INFO5_FIRST_MSDU);
-		if (is_first_msdu_in_mpdu) {
-			pmon->mon_mpdu->head = pmon->mon_mpdu->tail;
-			pmon->mon_mpdu->tail = NULL;
-		}
-		break;
-	}
+	case HAL_MON_BUF_ADDR:
+		return HAL_RX_MON_STATUS_BUF_ADDR;
+	case HAL_RX_MSDU_END:
+		return HAL_RX_MON_STATUS_MSDU_END;
 	case HAL_RX_MPDU_END:
-		list_add_tail(&pmon->mon_mpdu->list, &pmon->dp_rx_mon_mpdu_list);
-		break;
+		return HAL_RX_MON_STATUS_MPDU_END;
 	case HAL_DUMMY:
 		return HAL_RX_MON_STATUS_BUF_DONE;
 	case HAL_RX_PPDU_END_STATUS_DONE:
@@ -1215,7 +1165,10 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
 		if ((ptr - skb->data) >= DP_RX_BUFFER_SIZE)
 			break;
 
-	} while (hal_status == HAL_RX_MON_STATUS_PPDU_NOT_DONE);
+	} while ((hal_status == HAL_RX_MON_STATUS_PPDU_NOT_DONE) ||
+		 (hal_status == HAL_RX_MON_STATUS_BUF_ADDR) ||
+		 (hal_status == HAL_RX_MON_STATUS_MPDU_END) ||
+		 (hal_status == HAL_RX_MON_STATUS_MSDU_END));
 
 	return hal_status;
 }
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 294583edd7a2..e4f9e21158dc 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -108,6 +108,9 @@ enum hal_rx_mon_status {
 	HAL_RX_MON_STATUS_PPDU_NOT_DONE,
 	HAL_RX_MON_STATUS_PPDU_DONE,
 	HAL_RX_MON_STATUS_BUF_DONE,
+	HAL_RX_MON_STATUS_BUF_ADDR,
+	HAL_RX_MON_STATUS_MPDU_END,
+	HAL_RX_MON_STATUS_MSDU_END,
 };
 
 #define HAL_RX_MAX_MPDU		256
-- 
2.34.1


