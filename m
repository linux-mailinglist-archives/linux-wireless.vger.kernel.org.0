Return-Path: <linux-wireless+bounces-22029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEC9A9BC4E
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 03:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF71A1B61F96
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 01:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BA149620;
	Fri, 25 Apr 2025 01:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dIlM4Ghk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E826AEC
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745544502; cv=none; b=MbDD1ktHFKD/+f2uFRER99EIUCtNdH9WZxDAv8o3zO4xiQIUyP1LoBES/a8h3XX2RDuVpSqvl0B+ijL0btrUy+8WlHYfIMun3mEoDLZ5yhJgXb1hMS6tLmxXeTynsIcF8X0frxViJ0zipl+xtrvrPs4Psra+DBVQEpwCZBMDvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745544502; c=relaxed/simple;
	bh=ovJqNrGKXwCzp+R60JzmtbURPfR815u7yv8Qk5fx1sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DIFspUdGT9xKBg8mtN0xCsENSWm1YXhbiXhVPFk8omOtzYdFkUftEb9+IldBabhdOjnw3AO6Wc1XLIoVtnTjiWUE0tZeg5MFbiaPCS9YjG6xG1D/H280SMU4sonXwfd0Cr4Dl+MDVFRjZh9E/pyh6w4frt79z0GrUwutI0hVs/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dIlM4Ghk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P17DMu004459
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=iaYpndAzlwZd+QuwVejNqGf6VpXXSOyszO0Ty/vDhqY=; b=dI
	lM4Ghk5xOFN2pupbGRaF7VSWC3B5wG8lMLY+bLumYJ8CIsc4ktXei14W5KoJC9IW
	blh0cvOiF0QReC2sQMHg97in9/YuOHgW8mYZPOE6T7c+bt6XAVcm4DGw8weZKxXy
	673IRCTuJfEN4RFLoAZoa1700G7M5uLoA/d6GJVd35KrwsdbC3hAv82GS+bRZ4uG
	0cs5UNLk1ZbpSQ28mUq9718dstbKYKIvgzL+xIcMGuZpyDlUN20YCzBIXpEvzcMF
	6HI1XlAIyFYFbAaOClAyGTF27+pvc+9jB+3ZkSMEE5dfzjvfuPQVktJf1NM0pXic
	Zhy39VVFzOEJGiJQZedA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh1788a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:28:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff68033070so1502656a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 18:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745544498; x=1746149298;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iaYpndAzlwZd+QuwVejNqGf6VpXXSOyszO0Ty/vDhqY=;
        b=lDyWHnsujAoSWjGgenkSVBIBnMKLeAinTM+o7b0t2e7n006Q1w3JAP6FZ7JvKfSCZZ
         +D14KezeAiatjGqYTC/zrY48DfxZbrVKzyVDvI0w0H2y9DXIEYd/6o638tlM7I1LNQFm
         3uyee42Yr4/WRAF4Aozp1kPBwVgzC2RTEJFUSCQlR+tG1OogBiz5wUrF37zQ7hf0V8Zk
         W6B1uxC4kDPWuS3HXXGowC5iNm4upvLokyCscC1qYmBy/QhX4ZglF7+MyNkVHxpB6tqG
         aPe2FVWQI6D5fr77UuxzU7EzhADPn0v/iudv1286kyQnKcpsjY3IF1wwRBM3HzrdCenZ
         ih7A==
X-Gm-Message-State: AOJu0YybymJ6n3n4EAgyBi+3Xw3EgYfz9qZJUXQTVH6avihOLoBnAeY1
	rgsLhVVtHkhp+EUTtyv7yN5rKjNuWSBMVw6W+NgQRcJyHqsZPMNnLX2wxkHt9atgHyNlOrn49Y9
	rcPfK9OdVB8b2VkTbuO19906GtdIDYqZF6OA6fmvNC7F+MLGwHEY/XW0FMMMwP4Y6dA==
X-Gm-Gg: ASbGnctyQ+mKHZSa7PXfCx1/A7ZSxaC4YtS8YqJ5YbL/A8WsUrQA/c4uYAlvB3M/gSA
	8pK/XqMVzkhx89Q3K+WkP71sSSEcAPF8169Q2RK+1DC14osWux/rdiDFmZqlNDJVEMTPayxMEPV
	OONLBsLVDA8ln3nWx58L/W79VXD3d7ChRdfreWLJWzoyQOT/CFul6nXKoBF+70bgzdXnGE6oUKt
	dAVvrFYcxNPyez6v8FrjV6ZPYsFjkPXwWMSoK7MnTZ5e9AwssJ6F7XERlfCh+Rth2Ybp4auIVfP
	bDoanBdcurpzg4Cjur1JylU8kdq9D0aLVEGImJiA6lVIA9mdJ5W6l5jOfXXIaIbJMBX2+CSDCGH
	ydnS7LYZglZF48wV0+MiLX1LilSml9MT2HHmnykpNI5xO2Q==
X-Received: by 2002:a17:90b:350d:b0:2fc:3264:3666 with SMTP id 98e67ed59e1d1-309f8e0b499mr337364a91.30.1745544497814;
        Thu, 24 Apr 2025 18:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5hMsmPuKWVO8Z7Zo0RkHY/oOcdJ5ctIxDn70mi5u4eOlaPt56pmhJNVbOD2iooGfb//SzPA==
X-Received: by 2002:a17:90b:350d:b0:2fc:3264:3666 with SMTP id 98e67ed59e1d1-309f8e0b499mr337345a91.30.1745544497385;
        Thu, 24 Apr 2025 18:28:17 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb1asm2160107a91.7.2025.04.24.18.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 18:28:16 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Vinith Kumar R <quic_vinithku@quicinc.com>,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-next 1/3] wifi: ath12k: change soc name to device name
Date: Fri, 25 Apr 2025 06:58:00 +0530
Message-Id: <20250425012802.698914-2-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250425012802.698914-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250425012802.698914-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Proofpoint-GUID: sLkOc2RUnccpE3aLC38JUhUdGt2BvK0L
X-Authority-Analysis: v=2.4 cv=OY6YDgTY c=1 sm=1 tr=0 ts=680ae533 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=vYOk1OfDmVSuLYKSXuQA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: sLkOc2RUnccpE3aLC38JUhUdGt2BvK0L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAwOCBTYWx0ZWRfX9XHG1juPItqP 0HZ6vrixEsznsc5BsxW8Km4TsSkwJDQeFo0ke1Tx9DWZDg5EK0VEEt0K7e3p2xiGI0QFkJ9pmxw bmWb1bw2uiUXqprlnBTPHPYGoR6A4DSyvf3Q6I1GR6MncqyPHs+WPL/+tJhT1noDk404O1tUXAO
 2Vl9CxUlr9JnSeIudjh1rJHDRK6o0bg20IAtwn/sJ27dwWXN7FiExnIfi3OjtwQPFAO66/bsLL3 U1WHoGissmLdn+teKFiZgW9cIghLrj265rW+Nrqfo68qal6wUFVWN1obSjp50p4hef9OdsqasTd 8wDOiIISCYHgB+Uja/EELIG8FBrxErq7fESnu5Ne6y0GXoZgWltlnkiMf7ZjZpQfXL5jl8niDtJ
 ry9NUg3sqykvcgdmyvAXPgYDPkJeArDVJUjytbkomnNsIxnxTlbKfZmg2fD6lWC1tcpWnsls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250008
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

From: Vinith Kumar R <quic_vinithku@quicinc.com>

To have consistent nomenclature, replace the use of the term "soc"
with the term "device".

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Vinith Kumar R <quic_vinithku@quicinc.com>
Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c   |  4 +--
 drivers/net/wireless/ath/ath12k/core.h   | 16 +++++------
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 36 ++++++++++++------------
 drivers/net/wireless/ath/ath12k/dp_tx.c  |  6 ++--
 drivers/net/wireless/ath/ath12k/hal_rx.c |  6 ++--
 5 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 7eccd9cf9036..2cfeb853289d 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1812,9 +1812,9 @@ static int ath12k_core_get_wsi_info(struct ath12k_hw_group *ag,
 		of_node_put(next_rx_endpoint);
 
 		device_count++;
-		if (device_count > ATH12K_MAX_SOCS) {
+		if (device_count > ATH12K_MAX_DEVICES) {
 			ath12k_warn(ab, "device count in DT %d is more than limit %d\n",
-				    device_count, ATH12K_MAX_SOCS);
+				    device_count, ATH12K_MAX_DEVICES);
 			of_node_put(next_wsi_dev);
 			return -EINVAL;
 		}
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 4b8f434e3e9a..00c58fc0cc4b 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -63,8 +63,8 @@
 #define ATH12K_RECONFIGURE_TIMEOUT_HZ		(10 * HZ)
 #define ATH12K_RECOVER_START_TIMEOUT_HZ		(20 * HZ)
 
-#define ATH12K_MAX_SOCS 3
-#define ATH12K_GROUP_MAX_RADIO (ATH12K_MAX_SOCS * MAX_RADIOS)
+#define ATH12K_MAX_DEVICES 3
+#define ATH12K_GROUP_MAX_RADIO (ATH12K_MAX_DEVICES * MAX_RADIOS)
 #define ATH12K_INVALID_GROUP_ID  0xFF
 #define ATH12K_INVALID_DEVICE_ID 0xFF
 
@@ -875,7 +875,7 @@ struct ath12k_board_data {
 	size_t len;
 };
 
-struct ath12k_soc_dp_tx_err_stats {
+struct ath12k_device_dp_tx_err_stats {
 	/* TCL Ring Descriptor unavailable */
 	u32 desc_na[DP_TCL_NUM_RING_MAX];
 	/* Other failures during dp_tx due to mem allocation failure
@@ -884,13 +884,13 @@ struct ath12k_soc_dp_tx_err_stats {
 	atomic_t misc_fail;
 };
 
-struct ath12k_soc_dp_stats {
+struct ath12k_device_dp_stats {
 	u32 err_ring_pkts;
 	u32 invalid_rbm;
 	u32 rxdma_error[HAL_REO_ENTR_RING_RXDMA_ECODE_MAX];
 	u32 reo_error[HAL_REO_DEST_RING_ERROR_CODE_MAX];
 	u32 hal_reo_error[DP_REO_DST_RING_MAX];
-	struct ath12k_soc_dp_tx_err_stats tx_err;
+	struct ath12k_device_dp_tx_err_stats tx_err;
 };
 
 struct ath12k_reg_freq {
@@ -919,7 +919,7 @@ struct ath12k_hw_group {
 	u8 num_probed;
 	u8 num_started;
 	unsigned long flags;
-	struct ath12k_base *ab[ATH12K_MAX_SOCS];
+	struct ath12k_base *ab[ATH12K_MAX_DEVICES];
 
 	/* protects access to this struct */
 	struct mutex mutex;
@@ -933,7 +933,7 @@ struct ath12k_hw_group {
 	struct ath12k_hw *ah[ATH12K_GROUP_MAX_RADIO];
 	u8 num_hw;
 	bool mlo_capable;
-	struct device_node *wsi_node[ATH12K_MAX_SOCS];
+	struct device_node *wsi_node[ATH12K_MAX_DEVICES];
 	struct ath12k_mlo_memory mlo_mem;
 	struct ath12k_hw_link hw_links[ATH12K_GROUP_MAX_RADIO];
 	bool hw_link_id_init_done;
@@ -1043,7 +1043,7 @@ struct ath12k_base {
 
 	/* Current DFS Regulatory */
 	enum ath12k_dfs_region dfs_region;
-	struct ath12k_soc_dp_stats soc_stats;
+	struct ath12k_device_dp_stats device_stats;
 #ifdef CONFIG_ATH12K_DEBUGFS
 	struct dentry *debugfs_soc;
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 1abfbd15f13c..e81a117cbc06 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2592,7 +2592,7 @@ static bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
 	if ((likely(hdr_len <= DP_MAX_NWIFI_HDR_LEN)))
 		return true;
 
-	ab->soc_stats.invalid_rbm++;
+	ab->device_stats.invalid_rbm++;
 	WARN_ON_ONCE(1);
 	return false;
 }
@@ -2755,9 +2755,9 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 			 struct napi_struct *napi, int budget)
 {
 	struct ath12k_hw_group *ag = ab->ag;
-	struct list_head rx_desc_used_list[ATH12K_MAX_SOCS];
+	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
 	struct ath12k_hw_link *hw_links = ag->hw_links;
-	int num_buffs_reaped[ATH12K_MAX_SOCS] = {};
+	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
 	struct ath12k_rx_desc_info *desc_info;
 	struct ath12k_dp *dp = &ab->dp;
 	struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
@@ -2774,7 +2774,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 
 	__skb_queue_head_init(&msdu_list);
 
-	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++)
+	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++)
 		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
 
 	srng = &ab->hal.srng_list[dp->reo_dst_ring[ring_id].ring_id];
@@ -2841,7 +2841,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 		if (push_reason !=
 		    HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
 			dev_kfree_skb_any(msdu);
-			ab->soc_stats.hal_reo_error[ring_id]++;
+			ab->device_stats.hal_reo_error[ring_id]++;
 			continue;
 		}
 
@@ -2891,7 +2891,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 	if (!total_msdu_reaped)
 		goto exit;
 
-	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++) {
+	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++) {
 		if (!num_buffs_reaped[device_id])
 			continue;
 
@@ -3608,9 +3608,9 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 			     int budget)
 {
 	struct ath12k_hw_group *ag = ab->ag;
-	struct list_head rx_desc_used_list[ATH12K_MAX_SOCS];
+	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
 	u32 msdu_cookies[HAL_NUM_RX_MSDUS_PER_LINK_DESC];
-	int num_buffs_reaped[ATH12K_MAX_SOCS] = {};
+	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
 	struct dp_link_desc_bank *link_desc_banks;
 	enum hal_rx_buf_return_buf_manager rbm;
 	struct hal_rx_msdu_link *link_desc_va;
@@ -3632,7 +3632,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 	tot_n_bufs_reaped = 0;
 	quota = budget;
 
-	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++)
+	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++)
 		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
 
 	reo_except = &ab->dp.reo_except_ring;
@@ -3646,7 +3646,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 	while (budget &&
 	       (reo_desc = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
 		drop = false;
-		ab->soc_stats.err_ring_pkts++;
+		ab->device_stats.err_ring_pkts++;
 
 		ret = ath12k_hal_desc_reo_parse_err(ab, reo_desc, &paddr,
 						    &desc_bank);
@@ -3673,7 +3673,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 		if (rbm != partner_ab->dp.idle_link_rbm &&
 		    rbm != HAL_RX_BUF_RBM_SW3_BM &&
 		    rbm != partner_ab->hw_params->hal_params->rx_buf_rbm) {
-			ab->soc_stats.invalid_rbm++;
+			ab->device_stats.invalid_rbm++;
 			ath12k_warn(ab, "invalid return buffer manager %d\n", rbm);
 			ath12k_dp_rx_link_desc_return(partner_ab, reo_desc,
 						      HAL_WBM_REL_BM_ACT_REL_MSDU);
@@ -3720,7 +3720,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 
 	spin_unlock_bh(&srng->lock);
 
-	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++) {
+	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++) {
 		if (!num_buffs_reaped[device_id])
 			continue;
 
@@ -3836,7 +3836,7 @@ static bool ath12k_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	bool drop = false;
 
-	ar->ab->soc_stats.reo_error[rxcb->err_code]++;
+	ar->ab->device_stats.reo_error[rxcb->err_code]++;
 
 	switch (rxcb->err_code) {
 	case HAL_REO_DEST_RING_ERROR_CODE_DESC_ADDR_ZERO:
@@ -3909,7 +3909,7 @@ static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
 	bool drop = false;
 	u32 err_bitmap;
 
-	ar->ab->soc_stats.rxdma_error[rxcb->err_code]++;
+	ar->ab->device_stats.rxdma_error[rxcb->err_code]++;
 
 	switch (rxcb->err_code) {
 	case HAL_REO_ENTR_RING_RXDMA_ECODE_DECRYPT_ERR:
@@ -3968,7 +3968,7 @@ static void ath12k_dp_rx_wbm_err(struct ath12k *ar,
 int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 				 struct napi_struct *napi, int budget)
 {
-	struct list_head rx_desc_used_list[ATH12K_MAX_SOCS];
+	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
 	struct ath12k_hw_group *ag = ab->ag;
 	struct ath12k *ar;
 	struct ath12k_dp *dp = &ab->dp;
@@ -3979,7 +3979,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	struct sk_buff_head msdu_list, scatter_msdu_list;
 	struct ath12k_skb_rxcb *rxcb;
 	void *rx_desc;
-	int num_buffs_reaped[ATH12K_MAX_SOCS] = {};
+	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
 	int total_num_buffs_reaped = 0;
 	struct ath12k_rx_desc_info *desc_info;
 	struct ath12k_hw_link *hw_links = ag->hw_links;
@@ -3991,7 +3991,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	__skb_queue_head_init(&msdu_list);
 	__skb_queue_head_init(&scatter_msdu_list);
 
-	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++)
+	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++)
 		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
 
 	srng = &ab->hal.srng_list[dp->rx_rel_ring.ring_id];
@@ -4115,7 +4115,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	if (!total_num_buffs_reaped)
 		goto done;
 
-	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++) {
+	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++) {
 		if (!num_buffs_reaped[device_id])
 			continue;
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 2136eeb278af..128fa0e3c229 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -350,7 +350,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	default:
 		/* TODO: Take care of other encap modes as well */
 		ret = -EINVAL;
-		atomic_inc(&ab->soc_stats.tx_err.misc_fail);
+		atomic_inc(&ab->device_stats.tx_err.misc_fail);
 		goto fail_remove_tx_buf;
 	}
 
@@ -373,7 +373,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 map:
 	ti.paddr = dma_map_single(ab->dev, skb->data, skb->len, DMA_TO_DEVICE);
 	if (dma_mapping_error(ab->dev, ti.paddr)) {
-		atomic_inc(&ab->soc_stats.tx_err.misc_fail);
+		atomic_inc(&ab->device_stats.tx_err.misc_fail);
 		ath12k_warn(ab, "failed to DMA map data Tx buffer\n");
 		ret = -ENOMEM;
 		goto fail_remove_tx_buf;
@@ -448,7 +448,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		 * desc because the desc is directly enqueued onto hw queue.
 		 */
 		ath12k_hal_srng_access_end(ab, tcl_ring);
-		ab->soc_stats.tx_err.desc_na[ti.ring_id]++;
+		ab->device_stats.tx_err.desc_na[ti.ring_id]++;
 		spin_unlock_bh(&tcl_ring->lock);
 		ret = -ENOMEM;
 
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.c b/drivers/net/wireless/ath/ath12k/hal_rx.c
index 98eeccc68fcd..38af714b313e 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.c
@@ -326,7 +326,7 @@ int ath12k_hal_desc_reo_parse_err(struct ath12k_base *ab,
 				    HAL_REO_DEST_RING_INFO0_PUSH_REASON);
 	err_code = le32_get_bits(desc->info0,
 				 HAL_REO_DEST_RING_INFO0_ERROR_CODE);
-	ab->soc_stats.reo_error[err_code]++;
+	ab->device_stats.reo_error[err_code]++;
 
 	if (push_reason != HAL_REO_DEST_RING_PUSH_REASON_ERR_DETECTED &&
 	    push_reason != HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
@@ -381,7 +381,7 @@ int ath12k_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
 		val = le32_get_bits(wbm_desc->buf_addr_info.info1,
 				    BUFFER_ADDR_INFO1_RET_BUF_MGR);
 		if (val != HAL_RX_BUF_RBM_SW3_BM) {
-			ab->soc_stats.invalid_rbm++;
+			ab->device_stats.invalid_rbm++;
 			return -EINVAL;
 		}
 
@@ -393,7 +393,7 @@ int ath12k_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
 		val = le32_get_bits(wbm_cc_desc->info0,
 				    HAL_WBM_RELEASE_RX_CC_INFO0_RBM);
 		if (val != HAL_RX_BUF_RBM_SW3_BM) {
-			ab->soc_stats.invalid_rbm++;
+			ab->device_stats.invalid_rbm++;
 			return -EINVAL;
 		}
 
-- 
2.17.1


