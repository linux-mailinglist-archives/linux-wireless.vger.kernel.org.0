Return-Path: <linux-wireless+bounces-21417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB3FA853DC
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3341A3B578B
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 06:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCD327C875;
	Fri, 11 Apr 2025 06:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K0k87+Ib"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003BF1D5ADE
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744351341; cv=none; b=QJDePfmAccLvR8xCYBjPxMEgoN1iZPLCvLRXgLHo6qAxBCZzJkKJDcqqCJAuZGD6PP4uIm+dZMrgV443hnBLq2OEn2awzpntfI1WA+hav3eomeUMgd/1iLqcwKoj/4xD7sXSei/tq4BjvnEaTG9hM31cxwyFXw4SH2hT6XCm4kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744351341; c=relaxed/simple;
	bh=+OFPyyemslXXgBXsQgaBwAv9gWcvXPRIr0/1/WdivDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jw6mBY3H8AwmgHtmbTOs68e6yVWyNoLbYp/dH7VPqeFFuH1lY7Ro7b29U5HW1Ox3ZPY2LBVaATjzwfwErv1cZGrn2SAMy98lKQwA9ZhEcxoQtG2Z3i0lvNVER6YMxkzUYJxms9cVODXQYF7OpqAbKaqywMfFPdWCEWbQ6txlvDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K0k87+Ib; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ALf2ue006137
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2wjvw48IRBR
	Hm7OUe7JcfSIfNWxDA2eN83zFkdDNCBU=; b=K0k87+Ib90uBvLPVjzgA1YzxZZ4
	VXPKshjUcWaCewDJYzDhvfz9pyGuScbfNklxcabmd2JdnBAxbHCtAmCarzYDXUlo
	YkVEOmQZMcKnwEFaRyn4uWCcGXyzJTaE32Wi5k41ztAiyZomEHB6rrYUPkk+iEpo
	0dC9SvFlX2TgDiHo7MIz8OA0R4QJ6yWtFRMBos6/Wjqn4lLDoFx7HNInqch7Bl9Z
	m94GjdPFi7g3cUB4jB58IDS3/VwgaYTFrhGQw6mWMXil1hGtbuyN6srkvOaPivS4
	GDA6ckvpg2bCczIMJJRitzNO0zPEUf1+5WTeC3OL21MED46O7ieOAV3k0ng==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpmh92d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:02:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-227e2faab6dso14476085ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 23:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744351338; x=1744956138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wjvw48IRBRHm7OUe7JcfSIfNWxDA2eN83zFkdDNCBU=;
        b=rdnqYjmrGr++T1ZcwddtCVKqyMcPs5tmk7y9LwcYK6GybOmzuICXaAZQzNLH1K7Omw
         D/h0pmYd2MXosJdCBCAwmMXnSVPrOaePF5AunpCO+qHDrpk/HfgqKAOn0i6TCCMy1SJN
         c4hw5h0jVlpIuYt219VfuUkl6ISDlLcHVEByDlerIzACFoCZNub7HmNyVDCWh67JMobB
         YRfCuFMq08VpWR5MppKVHOq44mzvCJ5Rz1a8guyrZhrDsYfQexFAs9og3orB64JRcxkC
         EX+rjiTp/9cv1upAlTy7jUcIQQatZWwNFzCr9Oflf0ZMuho1vLJcc6aZb5NkxhkFDNUd
         kMNw==
X-Gm-Message-State: AOJu0Ywlh3GM1d7vXvZkXY/yWro8rTIt7uDUI/jlOfX5tPRiwfm8PUBj
	AP7uzJaDG1d69gKKFN8+RUwexMLQUSFz2urud0liNLFC4HH5GNCT49NJP+plM/Kom1Rq6ca4M1n
	B+gjWIqM2g0Y0BmNggidSPSLk7MaL35mfuDYmq38m7JHn/QewyKSKNbn+NhG0KkAAwsYfdMm9FQ
	==
X-Gm-Gg: ASbGncvwXOWgg35JJGsMozTyqhJTG8oQBfUoPkbu5cVazs9i91lAHkqJUAQ+KmozprW
	vDJYvIhjWALYVvB15f/piVZQLryyGAMQlnrlzN0lj/zCklOeTLpdbJAP8Wa1nQnF3/u6r1mJXu1
	Zbp4BdVhROf0vm4Lj1afjE+eFfL8XBMtqYl3ki+suPgIYahY05rrEKtbbr/SK+p1AXhAzELs1HB
	UevU32R8aoaYzjGaEHFqUWqh59gtzvL4TpUmXEFur2HN/ylggQ92rprPcyTc7QlwwDiFZCF7J1y
	lsClcDQUBfHKtnPuHWKfoTTJqSn8+wAYOrIbCrwtfr01hOpHv+XOftURAvtsYMNl5rz6wMwSvBy
	UJwZ4JirycU3Ci4yRPDNOFhzM3Y3oKw==
X-Received: by 2002:a17:902:c951:b0:21f:68ae:56e3 with SMTP id d9443c01a7336-22bea4f009amr24034805ad.39.1744351337802;
        Thu, 10 Apr 2025 23:02:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLRteCVlMEaQjh10Hbrr4gt/Q1E8StKnZJ2JTliMj6Xe5gP346m01uvv3afIMpzn7jCnbWPw==
X-Received: by 2002:a17:902:c951:b0:21f:68ae:56e3 with SMTP id d9443c01a7336-22bea4f009amr24034555ad.39.1744351337401;
        Thu, 10 Apr 2025 23:02:17 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2328435sm624567b3a.157.2025.04.10.23.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 23:02:17 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v3 3/4] wifi: ath12k: Fix memory leak during extended skb allocation
Date: Fri, 11 Apr 2025 11:31:53 +0530
Message-Id: <20250411060154.1388159-4-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411060154.1388159-1-praneesh.p@oss.qualcomm.com>
References: <20250411060154.1388159-1-praneesh.p@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xjK6su7e6rMrIV13XVzvEsqiCSzjs1Yh
X-Proofpoint-ORIG-GUID: xjK6su7e6rMrIV13XVzvEsqiCSzjs1Yh
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f8b06b cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=iFgiq4A1vBvqtHBMXJkA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=2
 mlxlogscore=999 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=2 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110042

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
index b8e63f489e7d..ad873013e46c 100644
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
index 241da2a3bd34..706d766d8c81 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -296,6 +296,7 @@ struct ath12k_rx_desc_info {
 struct ath12k_tx_desc_info {
 	struct list_head list;
 	struct sk_buff *skb;
+	struct sk_buff *skb_ext_desc;
 	u32 desc_id; /* Cookie */
 	u8 mac_id;
 	u8 pool_id;
@@ -303,6 +304,7 @@ struct ath12k_tx_desc_info {
 
 struct ath12k_tx_desc_params {
 	struct sk_buff *skb;
+	struct sk_buff *skb_ext_desc;
 	u8 mac_id;
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index a272d5b8a51c..9bcd20712888 100644
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
@@ -431,6 +432,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		ti.type = HAL_TCL_DESC_TYPE_EXT_DESC;
 
 		skb_cb->paddr_ext_desc = ti.paddr;
+		tx_desc->skb_ext_desc = skb_ext_desc;
 	}
 
 	hal_ring_id = tx_ring->tcl_data_ring.ring_id;
@@ -525,9 +527,11 @@ static void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
 	ar = ab->pdevs[pdev_id].ar;
 
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
-	if (skb_cb->paddr_ext_desc)
+	if (skb_cb->paddr_ext_desc) {
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
 				 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
+		dev_kfree_skb_any(desc_params->skb_ext_desc);
+	}
 
 	ieee80211_free_txskb(ar->ah->hw, msdu);
 
@@ -558,9 +562,11 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 		wake_up(&ar->dp.tx_empty_waitq);
 
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
-	if (skb_cb->paddr_ext_desc)
+	if (skb_cb->paddr_ext_desc) {
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
 				 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
+		dev_kfree_skb_any(desc_params->skb_ext_desc);
+	}
 
 	vif = skb_cb->vif;
 	if (vif) {
@@ -773,9 +779,11 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	skb_cb = ATH12K_SKB_CB(msdu);
 
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
-	if (skb_cb->paddr_ext_desc)
+	if (skb_cb->paddr_ext_desc) {
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
 				 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
+		dev_kfree_skb_any(desc_params->skb_ext_desc);
+	}
 
 	rcu_read_lock();
 
@@ -953,6 +961,7 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 
 		desc_params.mac_id = tx_desc->mac_id;
 		desc_params.skb = tx_desc->skb;
+		desc_params.skb_ext_desc = tx_desc->skb_ext_desc;
 
 		/* Release descriptor as soon as extracting necessary info
 		 * to reduce contention
-- 
2.34.1


