Return-Path: <linux-wireless+bounces-7174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9184D8BBE3D
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 23:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED76C1F23593
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 21:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7396384DE8;
	Sat,  4 May 2024 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G14VbTNJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9548083CD6;
	Sat,  4 May 2024 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714859130; cv=none; b=kJ0KqEvbaePeA3CAgG55E3OkYo/lKCECGAoP0CGzGcZpJnzPBBWhZADp4rAoqTWReAbOkvmsnNQtIdZRR4xm1VSvqKC1SenIGLlpxefzanKXg97zAWIj/tDt1+V8C3B5AWvAaOlQ/j71aQ8Jp4aLwligxvFya21azJilZUBxkdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714859130; c=relaxed/simple;
	bh=HCQwWzc6a/bIRDucw/9QQioXa5eIPrIOJmqMzpC2+Lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QXRUmfJXLQ9SWBsAgvehNMW6we0i59xnDtXCUUPpmzI+fS45WYJXyOymMk3l6TFj7BUBLvASCOsNxC7/sgLXflfa0gGmgtgmUTYar9N8jYYHDLO7fBkGSZ8DoRZ+03Wvgl3INT03Ya0yItmPxhCvaG+qSrxjliHcRWFY8UhukWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G14VbTNJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 444LjM9w003086;
	Sat, 4 May 2024 21:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=HL6xyrmzkqS9vwEKWOdhPETL6KTAcHK5kTESagRZbiE
	=; b=G14VbTNJPTjj4JZylJLVl2p18Wvstlyk4uQWYjTRehkl1kl10ASvJkuLR7X
	LK4F5KUUa1SGz52n7rFtsAwCqOYI8/+tK+xtLucJgkhKwP6GME+/cVuS9CW5Sa62
	U/ElhTT5BQ+X95fDrKEC9K+qcjC43324q/72MIE9WWfAFQacVet2Eb3vafqnbYls
	UpVysMp7xfMsyLNUqueeQFf/UpAAqVhHlbG+YOt7mirUeszP4O5rBWmF4bN2kayY
	UPYDiqn8re78Q8dYT1MxJ8who7XtjhTkaC97GHH3HIY61L36mf2UctEY7GE97v8S
	sDFRpAJrbSCWf4i+VV2wYaJ5z6w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwcbph3k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 21:45:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 444LjLYE001237
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 4 May 2024 21:45:21 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 4 May 2024
 14:45:18 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 4 May 2024 14:45:17 -0700
Subject: [PATCH 1/2] wifi: ath12k: fix misspelling of "dma" in
 num_rxmda_per_pdev
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240504-ath12k_dp_rxdma_ring_sel_config_wcn7850-ret-v1-1-44d2843a2857@quicinc.com>
References: <20240504-ath12k_dp_rxdma_ring_sel_config_wcn7850-ret-v1-0-44d2843a2857@quicinc.com>
In-Reply-To: <20240504-ath12k_dp_rxdma_ring_sel_config_wcn7850-ret-v1-0-44d2843a2857@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cFAY5Tkt7bYGpz_o2I_MINY81dQBaa02
X-Proofpoint-GUID: cFAY5Tkt7bYGpz_o2I_MINY81dQBaa02
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-04_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 mlxlogscore=838 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405040140

The ath12k_hw_params member num_rxmda_per_pdev contains a misspelling
of "dma" so fix it.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c    | 10 +++++-----
 drivers/net/wireless/ath/ath12k/dp_rx.c | 14 +++++++-------
 drivers/net/wireless/ath/ath12k/dp_tx.c |  2 +-
 drivers/net/wireless/ath/ath12k/hw.c    |  6 +++---
 drivers/net/wireless/ath/ath12k/hw.h    |  2 +-
 drivers/net/wireless/ath/ath12k/wmi.c   |  2 +-
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 72ea9baaf8d7..aa3d799c903b 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -923,8 +923,8 @@ int ath12k_dp_service_srng(struct ath12k_base *ab,
 		monitor_mode = ATH12K_DP_RX_MONITOR_MODE;
 		ring_mask = ab->hw_params->ring_mask->rx_mon_dest[grp_id];
 		for (i = 0; i < ab->num_radios; i++) {
-			for (j = 0; j < ab->hw_params->num_rxmda_per_pdev; j++) {
-				int id = i * ab->hw_params->num_rxmda_per_pdev + j;
+			for (j = 0; j < ab->hw_params->num_rxdma_per_pdev; j++) {
+				int id = i * ab->hw_params->num_rxdma_per_pdev + j;
 
 				if (ring_mask & BIT(id)) {
 					work_done =
@@ -944,8 +944,8 @@ int ath12k_dp_service_srng(struct ath12k_base *ab,
 		monitor_mode = ATH12K_DP_TX_MONITOR_MODE;
 		ring_mask = ab->hw_params->ring_mask->tx_mon_dest[grp_id];
 		for (i = 0; i < ab->num_radios; i++) {
-			for (j = 0; j < ab->hw_params->num_rxmda_per_pdev; j++) {
-				int id = i * ab->hw_params->num_rxmda_per_pdev + j;
+			for (j = 0; j < ab->hw_params->num_rxdma_per_pdev; j++) {
+				int id = i * ab->hw_params->num_rxdma_per_pdev + j;
 
 				if (ring_mask & BIT(id)) {
 					work_done =
@@ -1033,7 +1033,7 @@ static void ath12k_dp_service_mon_ring(struct timer_list *t)
 	struct ath12k_base *ab = from_timer(ab, t, mon_reap_timer);
 	int i;
 
-	for (i = 0; i < ab->hw_params->num_rxmda_per_pdev; i++)
+	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++)
 		ath12k_dp_mon_process_ring(ab, i, NULL, DP_MON_SERVICE_BUDGET,
 					   ATH12K_DP_RX_MONITOR_MODE);
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 18030c9e735d..2adcb4238c3e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -496,7 +496,7 @@ static void ath12k_dp_rx_pdev_srng_free(struct ath12k *ar)
 	struct ath12k_base *ab = ar->ab;
 	int i;
 
-	for (i = 0; i < ab->hw_params->num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
 		ath12k_dp_srng_cleanup(ab, &dp->rxdma_mon_dst_ring[i]);
 		ath12k_dp_srng_cleanup(ab, &dp->tx_mon_dst_ring[i]);
 	}
@@ -543,7 +543,7 @@ static int ath12k_dp_rx_pdev_srng_alloc(struct ath12k *ar)
 	int ret;
 	u32 mac_id = dp->mac_id;
 
-	for (i = 0; i < ab->hw_params->num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
 		ret = ath12k_dp_srng_setup(ar->ab,
 					   &dp->rxdma_mon_dst_ring[i],
 					   HAL_RXDMA_MONITOR_DST,
@@ -3962,7 +3962,7 @@ void ath12k_dp_rx_free(struct ath12k_base *ab)
 
 	ath12k_dp_srng_cleanup(ab, &dp->rx_refill_buf_ring.refill_buf_ring);
 
-	for (i = 0; i < ab->hw_params->num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
 		if (ab->hw_params->rx_mac_buf_ring)
 			ath12k_dp_srng_cleanup(ab, &dp->rx_mac_buf_ring[i]);
 	}
@@ -4055,7 +4055,7 @@ int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 	 * and modify the rx_desc struct
 	 */
 
-	for (i = 0; i < ab->hw_params->num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
 		ring_id = dp->rx_mac_buf_ring[i].ring_id;
 		ret = ath12k_dp_tx_htt_rx_filter_setup(ab, ring_id, i,
 						       HAL_RXDMA_BUF,
@@ -4082,7 +4082,7 @@ int ath12k_dp_rx_htt_setup(struct ath12k_base *ab)
 	}
 
 	if (ab->hw_params->rx_mac_buf_ring) {
-		for (i = 0; i < ab->hw_params->num_rxmda_per_pdev; i++) {
+		for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
 			ring_id = dp->rx_mac_buf_ring[i].ring_id;
 			ret = ath12k_dp_tx_htt_srng_setup(ab, ring_id,
 							  i, HAL_RXDMA_BUF);
@@ -4155,7 +4155,7 @@ int ath12k_dp_rx_alloc(struct ath12k_base *ab)
 	}
 
 	if (ab->hw_params->rx_mac_buf_ring) {
-		for (i = 0; i < ab->hw_params->num_rxmda_per_pdev; i++) {
+		for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
 			ret = ath12k_dp_srng_setup(ab,
 						   &dp->rx_mac_buf_ring[i],
 						   HAL_RXDMA_BUF, 1,
@@ -4224,7 +4224,7 @@ int ath12k_dp_rx_pdev_alloc(struct ath12k_base *ab, int mac_id)
 		return ret;
 	}
 
-	for (i = 0; i < ab->hw_params->num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
 		ring_id = dp->rxdma_mon_dst_ring[i].ring_id;
 		ret = ath12k_dp_tx_htt_srng_setup(ab, ring_id,
 						  mac_id + i,
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index a7c7a868c14c..15522adf67c9 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -873,7 +873,7 @@ int ath12k_dp_tx_htt_h2t_ppdu_stats_req(struct ath12k *ar, u32 mask)
 	int ret;
 	int i;
 
-	for (i = 0; i < ab->hw_params->num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
 		skb = ath12k_htc_alloc_skb(ab, len);
 		if (!skb)
 			return -ENOMEM;
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index f4c827015821..06f443216488 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -884,7 +884,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.hal_params = &ath12k_hw_hal_params_qcn9274,
 
 		.rxdma1_enable = false,
-		.num_rxmda_per_pdev = 1,
+		.num_rxdma_per_pdev = 1,
 		.num_rxdma_dst_ring = 0,
 		.rx_mac_buf_ring = false,
 		.vdev_start_delay = false,
@@ -956,7 +956,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.hal_params = &ath12k_hw_hal_params_wcn7850,
 
 		.rxdma1_enable = false,
-		.num_rxmda_per_pdev = 2,
+		.num_rxdma_per_pdev = 2,
 		.num_rxdma_dst_ring = 1,
 		.rx_mac_buf_ring = true,
 		.vdev_start_delay = true,
@@ -1029,7 +1029,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.hal_params = &ath12k_hw_hal_params_qcn9274,
 
 		.rxdma1_enable = false,
-		.num_rxmda_per_pdev = 1,
+		.num_rxdma_per_pdev = 1,
 		.num_rxdma_dst_ring = 0,
 		.rx_mac_buf_ring = false,
 		.vdev_start_delay = false,
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 3f450ee93f34..2a5a9d638d93 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -174,7 +174,7 @@ struct ath12k_hw_params {
 	const struct ath12k_hw_hal_params *hal_params;
 
 	bool rxdma1_enable:1;
-	int num_rxmda_per_pdev;
+	int num_rxdma_per_pdev;
 	int num_rxdma_dst_ring;
 	bool rx_mac_buf_ring:1;
 	bool vdev_start_delay:1;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 7a52d2082b79..004e12da01d2 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -5693,7 +5693,7 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 		 * event. Otherwise, it goes to fallback.
 		 */
 		if (ab->hw_params->single_pdev_only &&
-		    pdev_idx < ab->hw_params->num_rxmda_per_pdev)
+		    pdev_idx < ab->hw_params->num_rxdma_per_pdev)
 			goto mem_free;
 		else
 			goto fallback;

-- 
2.42.0


