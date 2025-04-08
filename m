Return-Path: <linux-wireless+bounces-21252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8C4A7F4D3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 08:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE2916C2BD
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 06:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28502063FA;
	Tue,  8 Apr 2025 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a9SEMjOM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EAE22F3B0
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092844; cv=none; b=ChyDIULzsHKT6Lrn+azaUVmeaUBFS9fJ3tgkTLl8fNad+IhfyGkfMxIDZlmeqI/BVeREq9W6uBu/9JlmByYNFWJkwdpX4pGBg8p8qV6hIs3ZIpmsjhkzToiDw4Ha4N96chHTxhXtSY43i1mLV0K7gfGdQSizcN9W3gIu+wWqXuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092844; c=relaxed/simple;
	bh=Psk+6L4iEn0jpEyew6q62CSgzF7i7b+HoJSnfw8Z1us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jrcQuC/WhgbPhaHoX+vRmyM0WLL31vypCo2nrsQUr5f2CJlpTEnfdt7sMGC5WnISfQRppA/h1aEGrspEYKWPCwlYjZ7XOYZpkW26EBgBIGkZMKD2pxoaWdbhRqJVs+lH3Sed3N2nsq1YV+rfweY/8I5oUf1TyHxc+UZ86ASCCDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a9SEMjOM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GcMv029774
	for <linux-wireless@vger.kernel.org>; Tue, 8 Apr 2025 06:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RVJEK1IFLVo
	Re3I9On+Sj5DwxTBvPTi7jowA3qHQFAw=; b=a9SEMjOMor+Zcyv0aEgPpmsJ2b2
	Z6sDQFYAIrcBl2xRZ8OhGHmHswuLbOnS9xIaP6EjoMml2W9Bpqc9YObTtNZ2oXyZ
	pog66ajCssK7Wb6L0VkauqkeddexjugldVkPd2/J5dUUFZd+9m2SOzDmwSxJ76ai
	1kChv+fHnb+BTp6azAYNk3KRYx77AB9et8UK0queLoWsPvqVdyKaXxo5JoVrvMAY
	YHKYeRkQZHogPH7wL2KVPtG/kwmvWgNtXae6XQPIkw1bniUvVHw6DB991CGT+LfZ
	q6n551HX5J/awg//IZ+NkmvF+R3z2dJXRylOAaQXDoa9EfTdAU1NnDq+iiA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrepf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 06:14:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff5296726fso8010267a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 23:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092840; x=1744697640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVJEK1IFLVoRe3I9On+Sj5DwxTBvPTi7jowA3qHQFAw=;
        b=m2Cus9vtZBRlt5toGvmgeDdfUPJhwJYevdWKcH8WUCnVXckbStakrssukjha5nBaxi
         EtO7ZSS7XbFlfsAeRgrVrZciqsScnmEZgS76Kn016n9NHMCTFKoq/pUOfcN+UEbtUk/Z
         dtJfRvsUfkOxACia/M4qvYgelddvydmDaWRdphpB5YUVdBwqEGtuTNo9L9ttTWZeLLVu
         xs/BThPJQrWOC9X7LHemXTPr0iWYuNp6mI89mOSeZ3kfZyNWuXXXWQBxTjBvxA3oWExx
         hJdlINNSEgOO3ipMTU55Ao8+4zO5gZ4XNiMNNqx8pYsHobPb3N2i11g4vbfNS4zEMxaJ
         v3YA==
X-Gm-Message-State: AOJu0YwYvwGYLpanPUvJgUBqD3qb0gTh6PUklyP6qQXAqpRVHbHmMf//
	E5YZaMz4Wz7tsAA6Gmf2KCnq3kx1j1CuYjbzX0lvaTUcNfqooBCf+VIbLmevehVxzrfCfOdSdIJ
	vPIkBLtIdbrx0CGx5mm00wbdlRmx4aUFJdX2utqWblKspbc+UtCTLEjCHtakeVK1sW91O3S1SKA
	==
X-Gm-Gg: ASbGnct52+zfeGaKb1xneE14LQgEdxmLtGxxbzu92Y4i1nhgi+0IVzgem6PJHTztiGx
	HX4WAuOY7oQoumz+/B+PHRAniV84JuwyMogL5ZveyRl3IL5CjWCZobJFneTdm7pSiaYkzEjd5NX
	5/uBnDSVyQI4cDY9Z4f3BwiRdcexkoXSB8Z8o37wktbb3ogSHNoNcFCF6q8qrALDL0OFYyQ3Y2l
	nByc0QjocuOjOp4nDvOVeY12+GSISL0mZS+aT7qDHahh17eTZctM+jIy//9izzX/OL53J62wgXx
	4hsLEj1i+gDjhurjVyWc4lKl6HK8drq71HeM0c78DrgY2gTbBuztAuBEiJmAK9FPRleplOzbtyT
	0nJllwulrOHqULR7IDhU6PdKPsjkXsBDdjA==
X-Received: by 2002:a17:90a:f950:b0:2fe:b907:562f with SMTP id 98e67ed59e1d1-306af732f86mr16004706a91.14.1744092840187;
        Mon, 07 Apr 2025 23:14:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPVFLRffPlSEHQVibT4tkJnPFyrG1oTmGsUikApM+bvRcTGIMMfyJvJ5orXb5VTo0HJ3nfcg==
X-Received: by 2002:a17:90a:f950:b0:2fe:b907:562f with SMTP id 98e67ed59e1d1-306af732f86mr16004678a91.14.1744092839705;
        Mon, 07 Apr 2025 23:13:59 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb94f4esm10258444a91.46.2025.04.07.23.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 23:13:59 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v2 3/4] wifi: ath12k: Fix memory leak during extended skb allocation
Date: Tue,  8 Apr 2025 11:43:42 +0530
Message-Id: <20250408061343.2774345-4-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408061343.2774345-1-praneesh.p@oss.qualcomm.com>
References: <20250408061343.2774345-1-praneesh.p@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VQsAeYlRiQrTd80zN6rCH7u0EvT1gSh-
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f4bea9 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=iFgiq4A1vBvqtHBMXJkA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: VQsAeYlRiQrTd80zN6rCH7u0EvT1gSh-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_02,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=1 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=1 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080043

In ath12k_dp_tx(), memory allocated for extended skb is not freed
properly, causing a memory leak even when the host receives tx
completion for those skbs. Fix this issue by storing skb_ext_desc
in the host tx descriptor and using this skb_ext_desc field during
completion or during ath12k_dp_cc_cleanup().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp.c    | 10 +++++++++-
 drivers/net/wireless/ath/ath12k/dp.h    |  2 ++
 drivers/net/wireless/ath/ath12k/dp_tx.c | 15 ++++++++++++---
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 59f61341383a..e04415517860 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1206,11 +1206,19 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 			if (!skb)
 				continue;
 
+			skb_cb = ATH12K_SKB_CB(skb);
+			if (skb_cb->paddr_ext_desc) {
+				dma_unmap_single(ab->dev,
+						 skb_cb->paddr_ext_desc,
+						 tx_desc_info->skb_ext_desc->len,
+						 DMA_TO_DEVICE);
+				dev_kfree_skb_any(tx_desc_info->skb_ext_desc);
+			}
+
 			/* if we are unregistering, hw would've been destroyed and
 			 * ar is no longer valid.
 			 */
 			if (!(test_bit(ATH12K_FLAG_UNREGISTERING, &ab->dev_flags))) {
-				skb_cb = ATH12K_SKB_CB(skb);
 				ar = skb_cb->ar;
 
 				if (atomic_dec_and_test(&ar->dp.num_tx_pending))
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index d982e9638517..c839f2fb7c0a 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -295,6 +295,7 @@ struct ath12k_rx_desc_info {
 struct ath12k_tx_desc_info {
 	struct list_head list;
 	struct sk_buff *skb;
+	struct sk_buff *skb_ext_desc;
 	u32 desc_id; /* Cookie */
 	u8 mac_id;
 	u8 pool_id;
@@ -302,6 +303,7 @@ struct ath12k_tx_desc_info {
 
 struct ath12k_tx_desc_params {
 	struct sk_buff *skb;
+	struct sk_buff *skb_ext_desc;
 	u8 mac_id;
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 08af7edd3f25..03ca45d10f7c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -84,6 +84,7 @@ static void ath12k_dp_tx_release_txbuf(struct ath12k_dp *dp,
 				       u8 pool_id)
 {
 	spin_lock_bh(&dp->tx_desc_lock[pool_id]);
+	tx_desc->skb_ext_desc = NULL;
 	list_move_tail(&tx_desc->list, &dp->tx_desc_free_list[pool_id]);
 	spin_unlock_bh(&dp->tx_desc_lock[pool_id]);
 }
@@ -430,6 +431,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		ti.type = HAL_TCL_DESC_TYPE_EXT_DESC;
 
 		skb_cb->paddr_ext_desc = ti.paddr;
+		tx_desc->skb_ext_desc = skb_ext_desc;
 	}
 
 	hal_ring_id = tx_ring->tcl_data_ring.ring_id;
@@ -508,9 +510,11 @@ static void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
 	ar = ab->pdevs[pdev_id].ar;
 
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
-	if (skb_cb->paddr_ext_desc)
+	if (skb_cb->paddr_ext_desc) {
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
 				 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
+		dev_kfree_skb_any(desc_params->skb_ext_desc);
+	}
 
 	ieee80211_free_txskb(ar->ah->hw, msdu);
 
@@ -538,9 +542,11 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 		wake_up(&ar->dp.tx_empty_waitq);
 
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
-	if (skb_cb->paddr_ext_desc)
+	if (skb_cb->paddr_ext_desc) {
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
 				 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
+		dev_kfree_skb_any(desc_params->skb_ext_desc);
+	}
 
 	memset(&info->status, 0, sizeof(info->status));
 
@@ -737,9 +743,11 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	skb_cb = ATH12K_SKB_CB(msdu);
 
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
-	if (skb_cb->paddr_ext_desc)
+	if (skb_cb->paddr_ext_desc) {
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
 				 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
+		dev_kfree_skb_any(desc_params->skb_ext_desc);
+	}
 
 	rcu_read_lock();
 
@@ -906,6 +914,7 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 
 		desc_params.mac_id = tx_desc->mac_id;
 		desc_params.skb = tx_desc->skb;
+		desc_params.skb_ext_desc = tx_desc->skb_ext_desc;
 
 		/* Release descriptor as soon as extracting necessary info
 		 * to reduce contention
-- 
2.34.1


