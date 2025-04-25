Return-Path: <linux-wireless+bounces-22030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABA1A9BC4F
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 03:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4730C4655EC
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 01:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC1A35959;
	Fri, 25 Apr 2025 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LXpi9KqW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1C526AEC
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745544511; cv=none; b=oFvusHAmJoM8Wx4FYwyYoWydgSpG74MvuMI7KNyfcTU56VP2gidq96CSIx10DkmyvAvnYkbczMsZZI77KPDj/34brtzDJzZQFwuINCmdTwCeeF6W1BbC++B5vx7E7777nbbBwzQRa7dTTst32u5HCe4Gy9EdrZNGTPoafx7r5fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745544511; c=relaxed/simple;
	bh=m7EYE017I58smdCcSPqI/TuvDeI68RBNpc7Qpr6UkWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RmC0rfW7nyFkMQoQHA06aHjFIdlhaUv9/A05Fe8/rS4a6Gild/rOAYGF99DSvBw6iDIyByYNL5BKavzAGhIOLFpJEmxEjP7XH0OLkrrjCSDJqbpmypnTIbFKLgOYV+v+CGdVBMMeIRWcVsLZS9M9rVixynIXySP3NNmCDN3NaA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LXpi9KqW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P17NVa021569
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=DbNetrenFL1DiA64vSRQhgg3J1PE5szG/6oYm4zTscw=; b=LX
	pi9KqWsbsdTEeBorncChk2fgmu+I+mdtG0yZcNuZugcEKbo7b7y/00qkuPaS+DNi
	VoV6VriNOuIsCmHVCBnmbWRCFRBV6OehpGeShvf/tyMRlwy33VbxawUIVvS4NDV8
	N4YvgyxWdAhtnxknuCf3Wg8OxPE7XlwSDMC9mFzJ1R6xmBCSpkfnYrO9oxKI6sKx
	AXfZ8W20z02UzRBLIwJ5MaGYBZbPExStg64p7HzVDt0g/LantfYYqmPpw/GO73bd
	oaaSH9skE8TJ8w6K0AKkXwnaKUXcBHF4v5C+HijiGTpQwvEBjGIKhyNfCtE6jr2E
	i8THv2rsrJNQRlnv+Nag==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh5fbn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:28:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff7f9a0b9bso1575744a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 18:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745544506; x=1746149306;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbNetrenFL1DiA64vSRQhgg3J1PE5szG/6oYm4zTscw=;
        b=jifgK6AeS0uWxkjEtUJb0qPUzoAmR88Rfaji1Z1hxGk/5aM39KqHYQItLH1j0khzms
         O95SbtM/849nMWJWJZTYdx0XdKMcsuxe4SGYol39hvBqHk7x8KfPpO09OU96DtWHZ0OZ
         murMBfFbyxYmu1bG8J+vqnhMHx1eC7EQpwOHqLU7zhVP4iYMEFwob17NeTPyvJQI+cJc
         VZ4/hPykBJQ+jcS+WjuvTJ1uINVocbLxwZpUFO+zHn41F7eBqZmw1qi9YeE9p09Yeda5
         VjXCTDq6w7K0Q8oCb1s0iF0eWpTUEK50NcDJWU4ubX0l9gy4qFmLKWk7KoesCfnXipvR
         RcuA==
X-Gm-Message-State: AOJu0YxjB4kqKTYAuhjKGM7BmfDaJ4UGPLY8ZOzaKqbnia91BPt07pYk
	JtIqmz//h1xMPjv4KyOV7k185EYfT4aLBMZ14MMdLz4rVnPIyqpI/1C1BqdahtTFYN9f7vOphG2
	cGebhZwTCjyUvwSWt0sYpITXupBwMQMc4Gtvx4h9wbFMHZ1l5/CgRJ/Lc8NIwFcrt5j2ugN62Ew
	==
X-Gm-Gg: ASbGncuMr/jOzkLyCMMy8Np3vZ7MJ5pNyFCDTRWSIQILY9vwZ4HHukmqadHy5B74ukq
	XNrav8yVki/PqbuX3x2J+1usOH0N+mm8qPhVeCPDHvaQDPkcraaWXA3UgZtHVmPvfHzD3Xi+NEY
	DtujqyxGV8mSO6hh9mDNtZFrTokrP2jwrwqskwlXy4Zxbcv7eAaGPfDGGPEpoV5lSVTmDImKKM/
	YVlBOW6F0lLX3gMigsl3pPiiADTaJnyKSWJ8GfR7vgVKQYdgX72PLqtX1EI7QcQeOwUJXytSpSR
	YqCHnm3i5gbSdu/nkBJh0wG/BuQRWmQrPcHlYTel9ioiSmM4Oqubft2zJSbKk3FNLnWZsIu9Nz/
	F5q5sn7dp0o8RzA4ZCr/qxbT5vbO1IMznEgvbR0lbUBP8Gw==
X-Received: by 2002:a17:90b:4a:b0:2fe:d766:ad95 with SMTP id 98e67ed59e1d1-309f8d9a8edmr481869a91.9.1745544506541;
        Thu, 24 Apr 2025 18:28:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzm1Z0GWISgsxWzkyhe6WN9QI3WbghwQilt8K+EEgEyD7BHLsuG54B+tvNZfcNxIwuLMJkSw==
X-Received: by 2002:a17:90b:4a:b0:2fe:d766:ad95 with SMTP id 98e67ed59e1d1-309f8d9a8edmr481840a91.9.1745544506174;
        Thu, 24 Apr 2025 18:28:26 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb1asm2160107a91.7.2025.04.24.18.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 18:28:25 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Vinith Kumar R <quic_vinithku@quicinc.com>,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-next 2/3] wifi: ath12k: Add device dp stats support
Date: Fri, 25 Apr 2025 06:58:01 +0530
Message-Id: <20250425012802.698914-3-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250425012802.698914-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250425012802.698914-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAwOCBTYWx0ZWRfX1tMSjRn4AuHu IWWkao/vYnsvql6IB0OhBFnjIfUjjX273SLNFFggaufmscrYW0IU+pSIposdSQ1TqEKTGeclPjR ORMrfM8rlnzSBPkZbJUHIQq+rE8Em2yDKVJjh5qJjzvwS7buz8JNBZlYQqikbJnEg4jtPv9wmdw
 16kIhnpkk9xAU8GJr5fEoWFJBJ6lCtHlLViMqhcoDMJnmeFEFs7yfz6EseJJl+AS5pYUfijVaOJ a91t2WxpIrT/4mQhc4QCgPuCGapoeKFPOJtNFTdWC4RGQWXUSJRkT3rba5E40mNnXhzOKiPMWor uoOdIGJaNNSzWqCuQNK9xbNLtnchfhL9dGTMVou5dfySq4/lZoLFtZX+zw49E4IrQawgeRLAGHb
 eOBpSi+5y2cFNKqSDO/utj+kK0rWP6eO+eWD8jKn41ysv3bOC6JbcUsBtKHaQj0NQxbw113R
X-Proofpoint-GUID: stgVTERGYsxUZJqMrOhXy1UQ7YIQKtTl
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=680ae53c cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=j3SS7jZd-hT91be9-fYA:9 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: stgVTERGYsxUZJqMrOhXy1UQ7YIQKtTl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250008
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

From: Vinith Kumar R <quic_vinithku@quicinc.com>

Add support for data path related device specific stats. This
information helps to debug connectivity and performance issues
in AP, STA, and Mesh modes.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Vinith Kumar R <quic_vinithku@quicinc.com>
Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h     |  7 +++++++
 drivers/net/wireless/ath/ath12k/dp.h       |  3 +++
 drivers/net/wireless/ath/ath12k/dp_rx.c    |  8 ++++++++
 drivers/net/wireless/ath/ath12k/dp_tx.c    | 22 ++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/hal_desc.h |  5 +++++
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 00c58fc0cc4b..99ef000aad7e 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -891,6 +891,13 @@ struct ath12k_device_dp_stats {
 	u32 reo_error[HAL_REO_DEST_RING_ERROR_CODE_MAX];
 	u32 hal_reo_error[DP_REO_DST_RING_MAX];
 	struct ath12k_device_dp_tx_err_stats tx_err;
+	u32 reo_rx[DP_REO_DST_RING_MAX][ATH12K_MAX_DEVICES];
+	u32 rx_wbm_rel_source[HAL_WBM_REL_SRC_MODULE_MAX][ATH12K_MAX_DEVICES];
+	u32 tqm_rel_reason[MAX_TQM_RELEASE_REASON];
+	u32 fw_tx_status[MAX_FW_TX_STATUS];
+	u32 tx_wbm_rel_source[HAL_WBM_REL_SRC_MODULE_MAX];
+	u32 tx_enqueued[DP_TCL_NUM_RING_MAX];
+	u32 tx_completed[DP_TCL_NUM_RING_MAX];
 };
 
 struct ath12k_reg_freq {
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 706d766d8c81..c4ddf30aa79f 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -266,6 +266,9 @@ struct ath12k_pdev_dp {
 /* Invalid TX Bank ID value */
 #define DP_INVALID_BANK_ID -1
 
+#define MAX_TQM_RELEASE_REASON 15
+#define MAX_FW_TX_STATUS 7
+
 struct ath12k_dp_tx_bank_profile {
 	u8 is_configured;
 	u32 num_users;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index e81a117cbc06..313b11421a26 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2835,6 +2835,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 				 DMA_FROM_DEVICE);
 
 		num_buffs_reaped[device_id]++;
+		ab->device_stats.reo_rx[ring_id][ab->device_id]++;
 
 		push_reason = le32_get_bits(desc->info0,
 					    HAL_REO_DEST_RING_INFO0_PUSH_REASON);
@@ -3982,6 +3983,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
 	int total_num_buffs_reaped = 0;
 	struct ath12k_rx_desc_info *desc_info;
+	struct ath12k_device_dp_stats *device_stats = &ab->device_stats;
 	struct ath12k_hw_link *hw_links = ag->hw_links;
 	struct ath12k_base *partner_ab;
 	u8 hw_link_id, device_id;
@@ -4155,6 +4157,12 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 			dev_kfree_skb_any(msdu);
 			continue;
 		}
+
+		if (rxcb->err_rel_src < HAL_WBM_REL_SRC_MODULE_MAX) {
+			device_id = ar->ab->device_id;
+			device_stats->rx_wbm_rel_source[rxcb->err_rel_src][device_id]++;
+		}
+
 		ath12k_dp_rx_wbm_err(ar, napi, msdu, &msdu_list);
 	}
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 128fa0e3c229..5a2b9c3f5e4b 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -477,6 +477,8 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		arvif->link_stats.tx_enqueued++;
 	spin_unlock_bh(&arvif->link_stats_lock);
 
+	ab->device_stats.tx_enqueued[ti.ring_id]++;
+
 	ath12k_hal_tx_cmd_desc_setup(ab, hal_tcl_desc, &ti);
 
 	ath12k_hal_srng_access_end(ab, tcl_ring);
@@ -557,6 +559,7 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 	info = IEEE80211_SKB_CB(msdu);
 
 	ar = skb_cb->ar;
+	ab->device_stats.tx_completed[tx_ring->tcl_data_ring_id]++;
 
 	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
 		wake_up(&ar->dp.tx_empty_waitq);
@@ -614,6 +617,7 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab, void *desc,
 
 	wbm_status = le32_get_bits(status_desc->info0,
 				   HTT_TX_WBM_COMP_INFO0_STATUS);
+	ab->device_stats.fw_tx_status[wbm_status]++;
 
 	switch (wbm_status) {
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_OK:
@@ -760,7 +764,8 @@ static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status
 
 static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 				       struct ath12k_tx_desc_params *desc_params,
-				       struct hal_tx_status *ts)
+				       struct hal_tx_status *ts,
+				       int ring)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_hw *ah = ar->ah;
@@ -777,6 +782,7 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	}
 
 	skb_cb = ATH12K_SKB_CB(msdu);
+	ab->device_stats.tx_completed[ring]++;
 
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 	if (skb_cb->paddr_ext_desc) {
@@ -907,6 +913,8 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 	struct hal_wbm_release_ring *desc;
 	u8 pdev_id;
 	u64 desc_va;
+	enum hal_wbm_rel_src_module buf_rel_source;
+	enum hal_wbm_tqm_rel_reason rel_status;
 
 	spin_lock_bh(&status_ring->lock);
 
@@ -963,6 +971,15 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 		desc_params.skb = tx_desc->skb;
 		desc_params.skb_ext_desc = tx_desc->skb_ext_desc;
 
+		/* Find the HAL_WBM_RELEASE_INFO0_REL_SRC_MODULE value */
+		buf_rel_source = le32_get_bits(tx_status->info0,
+					       HAL_WBM_RELEASE_INFO0_REL_SRC_MODULE);
+		ab->device_stats.tx_wbm_rel_source[buf_rel_source]++;
+
+		rel_status = le32_get_bits(tx_status->info0,
+					   HAL_WBM_COMPL_TX_INFO0_TQM_RELEASE_REASON);
+		ab->device_stats.tqm_rel_reason[rel_status]++;
+
 		/* Release descriptor as soon as extracting necessary info
 		 * to reduce contention
 		 */
@@ -979,7 +996,8 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 		if (atomic_dec_and_test(&ar->dp.num_tx_pending))
 			wake_up(&ar->dp.tx_empty_waitq);
 
-		ath12k_dp_tx_complete_msdu(ar, &desc_params, &ts);
+		ath12k_dp_tx_complete_msdu(ar, &desc_params, &ts,
+					   tx_ring->tcl_data_ring_id);
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index 49eededbfa9d..f31b4a37ee35 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -1008,6 +1008,10 @@ enum hal_reo_entr_rxdma_ecode {
 	HAL_REO_ENTR_RING_RXDMA_ECODE_FLOW_TIMEOUT_ERR,
 	HAL_REO_ENTR_RING_RXDMA_ECODE_FLUSH_REQUEST_ERR,
 	HAL_REO_ENTR_RING_RXDMA_ECODE_AMSDU_FRAG_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_MULTICAST_ECHO_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_AMSDU_MISMATCH_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_UNAUTH_WDS_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_GRPCAST_AMSDU_WDS_ERR,
 	HAL_REO_ENTR_RING_RXDMA_ECODE_MAX,
 };
 
@@ -1809,6 +1813,7 @@ enum hal_wbm_rel_src_module {
 	HAL_WBM_REL_SRC_MODULE_REO,
 	HAL_WBM_REL_SRC_MODULE_FW,
 	HAL_WBM_REL_SRC_MODULE_SW,
+	HAL_WBM_REL_SRC_MODULE_MAX,
 };
 
 enum hal_wbm_rel_desc_type {
-- 
2.17.1


