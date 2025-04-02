Return-Path: <linux-wireless+bounces-21107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEE5A794E5
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 20:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFD6D7A4B70
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223BB1C84D0;
	Wed,  2 Apr 2025 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UCRmKddX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3F21DB346
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617715; cv=none; b=Ecbu/yg4agpxuO8JJdXh/4qUIGI9M0Fo2ToPHeYPXG/JOEHSTYbKSat/zYn84xwcRnugI134kla998QXQp84NbcAidyvkwxmMvdBCTc57/KpzOY/hhFAvN0nVFT58FKHc+PNGXrIfaAV+Qe8fvw11OnBFMzfXKKUbQ+pV1wc/5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617715; c=relaxed/simple;
	bh=FUt/K4ZhZV51PSLWua8xfxLnRheJ77w55l4hDOYJIZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2MuuKumlqBK1qoivO8NlNMS0WHIQ14PI6+sxgybrFcWFuhLz4mM8XSsKpWtLgwDRMYh/OPa9M6ZQ6F0Dcv36QLZQ4u7HWwTJ48S4Zc/aW4qHpW0rquTGSE7DCXTX1CQWFNy+nWIOa40lDg4StszvkzT0vyhjQxA4ea3nJyh1Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UCRmKddX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532D2pPK007649
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 18:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=m03BhA+Eey2
	Yr/TfX0IC374Y+t6keO9nkzVIy0TvCT4=; b=UCRmKddXynx9DvMBn0aTozq/4UR
	LKjOO5bGKd2LhpJ0YmQqzj0D/3qcUmqJzMdIz0lEMejijSOGvh4FFaZxmcD+7qoG
	bJwW1E4QbgJjAZexF5TX+WW/8Ty8DL+scyoKjWlTxiD+gwA9YBeqga1Vwgq+PN4s
	pHect1ye0Wp8zqqELA0dWrRhnu0+QuNq3SGEIdUoqKgnTscyx2I5/qRUSTjppknE
	817E6BNys6JKIevR02QYZCEKlZ5R92Iwo/7G/l+54O4jkbv1ADjq3BXwThIBfiQi
	GFiH9t7yjEo0n0Bv/dmCPHK3kB+dwnq8/6YMAYbRHnkv8GRosFuTBxgFeSA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rxb02a2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 18:15:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22403329f9eso950185ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 11:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743617711; x=1744222511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m03BhA+Eey2Yr/TfX0IC374Y+t6keO9nkzVIy0TvCT4=;
        b=PX7EpvYQ1RGNJK4sAJZCNSnunH5Naph8KdSr7pXq2sdhRxkn68DSZgsy9G5WacKbHj
         0oRh5uxdkh3RicRanSWUQ4rXIvBmiRbzJ85lfcdG88rJwNbE/7FqhVFzqDRgo2JNUQ1w
         1EdFcZgbfRRIm0YATK1OXV73PhZNtTBLUFqJ8behzpAnw89ecegdlVXyzWNHDjm+MBZ6
         BKWJZ0Be21nyMZ+2wI9G4+jUV6VwCQfy0b7C/TknXu4jjVqBwuERSVjH+ProusgCFb3C
         KkWLPaRaFyYZPzQp2xuMqpVMPYeZ1iushmEab7xj5i4Ss8KEXM/KmJ556QK6K0P3qtCW
         VPqQ==
X-Gm-Message-State: AOJu0Yw8IL1pQNOav0OUCU0QTg6LuUpfGIfXV7iw711vKeItRV497Hyf
	Ld/hRBMr/NiWTNEPT1jA2DUrJafRsz2V4PBHM1EI7SuSDcRFd0kpvebyUQya8xCKJcMSD9+/BXu
	HUuy+n3LzLIsIq6o8qdyOhw2hkqeXd+Vz32EuwLCVsDPL2cwrbpT2/UawIKxBqK/KZbelnxtISw
	==
X-Gm-Gg: ASbGnctB6QtCKWPr8kNK9uBYkGoeKTa6XtuGQaqYLsT9QssHcS+2qWhiHPWaRvDNT0z
	qUVxxsgWoNE46g9/XwHKta62VKwapln7GmvZ85Uh1rWNORRKz6Ot0aeLg0W0/8KbhYaqLA0f8yD
	ovm5sBZ7oDbkZLVOXuwu/X/k1aps0+dmp+OQ0Q51ks/rS4O7Gnue/OM3T3SqP2eKD87Ozeb+21i
	wobGW9Mqi15HMyJ5BDZM0RmFUfaS4uDfxGkFMwu4dlw+8pS2oK4nEAoagLqh7UAjIAfjpD+/g4l
	MHZtYaY9MTbhMtwSjWPJ3p0nxGh56PJ7o25Bwls49QJ+aeveVRhRwUy4SpWrCcqQMpk7EPLItZu
	FowMXVfnNzV4P7lSRTANi7vpS7hO/j6mktg==
X-Received: by 2002:a17:903:2a8e:b0:223:4816:3e9e with SMTP id d9443c01a7336-2292f96119cmr238413905ad.13.1743617709236;
        Wed, 02 Apr 2025 11:15:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE+bCar7mS11SpplOV1+I1khRJyowGdhKycatdsXZAcukRn1PzceNnpaVBBIfUKPBvLyIuxQ==
X-Received: by 2002:a17:903:2a8e:b0:223:4816:3e9e with SMTP id d9443c01a7336-2292f96119cmr238413475ad.13.1743617708422;
        Wed, 02 Apr 2025 11:15:08 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf14csm111689675ad.137.2025.04.02.11.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 11:15:08 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 3/4] wifi: ath12k: Fix memory leak during extended skb allocation
Date: Wed,  2 Apr 2025 23:44:53 +0530
Message-Id: <20250402181454.2699777-4-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402181454.2699777-1-praneesh.p@oss.qualcomm.com>
References: <20250402181454.2699777-1-praneesh.p@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZpfPxQ-1venp_YmLsJM75U_5sSpVa4yd
X-Proofpoint-GUID: ZpfPxQ-1venp_YmLsJM75U_5sSpVa4yd
X-Authority-Analysis: v=2.4 cv=BavY0qt2 c=1 sm=1 tr=0 ts=67ed7eaf cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=iFgiq4A1vBvqtHBMXJkA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_08,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 impostorscore=0 priorityscore=1501 bulkscore=1 adultscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=1 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020116

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
index b1f27c3ac723..34c72a1b5ae1 100644
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
index e26a9c3477d9..c8e0c70a4d26 100644
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
index 45f4c8bd78e6..ab359483472f 100644
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
 
@@ -736,9 +742,11 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	skb_cb = ATH12K_SKB_CB(msdu);
 
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
-	if (skb_cb->paddr_ext_desc)
+	if (skb_cb->paddr_ext_desc) {
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
 				 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
+		dev_kfree_skb_any(desc_params->skb_ext_desc);
+	}
 
 	rcu_read_lock();
 
@@ -905,6 +913,7 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 
 		desc_params.mac_id = tx_desc->mac_id;
 		desc_params.skb = tx_desc->skb;
+		desc_params.skb_ext_desc = tx_desc->skb_ext_desc;
 
 		/* Release descriptor as soon as extracting necessary info
 		 * to reduce contention
-- 
2.34.1


