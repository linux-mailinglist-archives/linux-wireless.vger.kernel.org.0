Return-Path: <linux-wireless+bounces-21250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32E4A7F4CC
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 08:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91BA16B2DA
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 06:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB6B33FE;
	Tue,  8 Apr 2025 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fAVbN+bk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0A822F3B0
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092841; cv=none; b=P675R/HztyNz3P45Lh2xI5ihnT9Jl44h6JezQ8WUOn9wAQ1fFNQ2isVDrWco25bQmsBLqkPWE1Q3iC0R1RkRpao43Bz6c2vOsE9RTmXtxlnBJnm9T/iYtXStGS1PqI7dD0gPFkYmDcjEOJAVfFcvqO1Yb6yLb8Pch5jH+FXAeHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092841; c=relaxed/simple;
	bh=gLmGN2rJds9DsaVH8kLiJdokT6D3F4D/NR5T1hFPwXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hVELwIDoOkVvytk5U9Z9Ln+vgHmkQrLvCyqJFyJWt/+LcRoqRc+1CNRZccPsEhAxaEk6G34Vs5szRFZ+VtSOZKkb4XQ78NO8nHE4TQ7uqXjR1uYaMb2NVuEhT5nAwp5vf/9pU15KlTGo/DAomsTlMrWaQyXMQDc9i3oOkAyDwbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fAVbN+bk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GObA019576
	for <linux-wireless@vger.kernel.org>; Tue, 8 Apr 2025 06:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jf4X7nmgLLt
	sPPYdxMAbBPiLSQqDc/fGOuZSKINRik0=; b=fAVbN+bky0rov6hMrPPFx6voZOc
	S2vb9bl+LZg4A6qb/4TZ1gUk42BaODUCS0sgkkKU0Mks4zEDluJs36bal42FFIdf
	duTHZXyeF13zmlCE8Sgm1xnFcassjYRWy06XfWO9WggFYpKz0KzE1dw4/JOEC7pn
	v2qheem4BKJu4YyQE/nl6n1Pv+4Zr/QVgoEon6Xmt5SvDrj9TnU4FUPmHaISIcXy
	+UNST43YkjrZEKAaBfrza2YXjgy8OOVLRPjb17etckQpBMUTJE9beUU/A16Be05P
	SuvOZMISdVn52lhAJjB+a7CAW3q1ToV3LWjDxCPutw5GRu2dshr3knpqQjQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twg3enfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 06:13:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff55176edcso5111509a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 23:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092837; x=1744697637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jf4X7nmgLLtsPPYdxMAbBPiLSQqDc/fGOuZSKINRik0=;
        b=PdUQ0yyy6QXo3PenGvUNHBFnu3yE6yRfYAgHR5o/Q/TX6ra9k8NdPuFkziVcjQ9mYr
         itu0z/bhXpVlZMMH/v+6JPyZALrSDfNBK4q1VSlBck0QfrqmD/dIJa/6clKCEbhR/Btn
         kqBmEcsWKBy9WqIWjmwCy8RLqPPBQwHujpI/Mziuh8h8bRhDslkK6M2tWvuCbPg0Bzun
         Ym8VkKAe4LRErcWo/xnYxygYFijfwhqcZ1yPOiHqI0as8aUXXam+PGjOzhwDPsce+TE6
         +aWkXUbyPkufxqm2XvRyNXFCwebbabB/LlZYe/MxwI6HpE/G/L5ctCnx12JSACmVMqte
         ZSCw==
X-Gm-Message-State: AOJu0YyVYbhREU3BuAqRfsvxQ44cbANVsknTtS2KpFvqy8BkBj/yfJHv
	kTCQHOCLYH6CPSW8IUudHRkRVoeBEDri9lNJi8vdDsoSGA7EyUWJRMSspaFsHZggAwXd+ZDfEBn
	0eT38wimUHxeAw+Sxn7pM9z6puIYGO3xGqgTPy+OrqmLZle+NXhVDQC5vkKeD2K/BnXmiq8Cpdw
	==
X-Gm-Gg: ASbGncu1SwNwG74+0Ns3fwYcrzSmbXmqzoVUlUkeSFHyYWTUokb+SriPdR07pU3qfsA
	jD3RwxRbGOsFNft8EOrcD6+4mQzO+xGEgk0Rhg4W29KumS3Bb0IFvdOzMkoHCb/Ten7T946j5Md
	PX/hiOD+kZuGytdGGqBmusj6Le+auLesUuJHNNisYD6f/fVhwWDfFdaX8Lv0uJv5sYkhRDKNgfU
	LveH9IufLbvc09GbEcNOtueBkp3Z7vKAwAocYZRf8X6cq1HpjUZERUXAC6ujrApYAzKR6lSpLAx
	bHjNt1SYU7igVVVygwaylawYM9Bul30sMpP2IarxmdndzY9gkMePl0iuP9AEq2S3obhxILUbgAk
	g2MFbv8zMbYpIaK3wLmTwa2J6t+5AgVSneQ==
X-Received: by 2002:a17:90a:d60c:b0:2fa:f8d:65de with SMTP id 98e67ed59e1d1-306a62137c1mr14778028a91.22.1744092836905;
        Mon, 07 Apr 2025 23:13:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4zeDZwRMBgzLBqfd01jymT1YpR7b25k588jo1J2XTWsT6kjoa3QT980ig55+H9URMzQROHQ==
X-Received: by 2002:a17:90a:d60c:b0:2fa:f8d:65de with SMTP id 98e67ed59e1d1-306a62137c1mr14778011a91.22.1744092836327;
        Mon, 07 Apr 2025 23:13:56 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb94f4esm10258444a91.46.2025.04.07.23.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 23:13:55 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v2 1/4] wifi: ath12k: Handle error cases during extended skb allocation
Date: Tue,  8 Apr 2025 11:43:40 +0530
Message-Id: <20250408061343.2774345-2-praneesh.p@oss.qualcomm.com>
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
X-Proofpoint-GUID: zMml_YRsSTDom7KxniIkpMjpB3BGmz6o
X-Proofpoint-ORIG-GUID: zMml_YRsSTDom7KxniIkpMjpB3BGmz6o
X-Authority-Analysis: v=2.4 cv=I/9lRMgg c=1 sm=1 tr=0 ts=67f4bea6 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=Qd23BeFobrpH1aaNZ9kA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_02,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080043

Currently, in the case of extended skb allocation, the buffer is freed
before the DMA unmap operation. This premature deletion can result in
skb->data corruption, as the memory region could be re-allocated for other
purposes. Fix this issue by reordering the failure cases by calling
dma_unmap_single() first, then followed by the corresponding kfree_skb().
This helps avoid data corruption in case of failures in dp_tx().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index b93669348f35..6b394534e3a2 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -230,7 +230,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB(skb);
 	struct hal_tcl_data_cmd *hal_tcl_desc;
 	struct hal_tx_msdu_ext_desc *msg;
-	struct sk_buff *skb_ext_desc;
+	struct sk_buff *skb_ext_desc = NULL;
 	struct hal_srng *tcl_ring;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ath12k_vif *ahvif = arvif->ahvif;
@@ -416,18 +416,15 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 			if (ret < 0) {
 				ath12k_dbg(ab, ATH12K_DBG_DP_TX,
 					   "Failed to add HTT meta data, dropping packet\n");
-				kfree_skb(skb_ext_desc);
-				goto fail_unmap_dma;
+				goto fail_free_ext_skb;
 			}
 		}
 
 		ti.paddr = dma_map_single(ab->dev, skb_ext_desc->data,
 					  skb_ext_desc->len, DMA_TO_DEVICE);
 		ret = dma_mapping_error(ab->dev, ti.paddr);
-		if (ret) {
-			kfree_skb(skb_ext_desc);
-			goto fail_unmap_dma;
-		}
+		if (ret)
+			goto fail_free_ext_skb;
 
 		ti.data_len = skb_ext_desc->len;
 		ti.type = HAL_TCL_DESC_TYPE_EXT_DESC;
@@ -463,7 +460,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 			ring_selector++;
 		}
 
-		goto fail_unmap_dma;
+		goto fail_unmap_dma_ext;
 	}
 
 	ath12k_hal_tx_cmd_desc_setup(ab, hal_tcl_desc, &ti);
@@ -479,13 +476,16 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 
 	return 0;
 
-fail_unmap_dma:
-	dma_unmap_single(ab->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);
-
+fail_unmap_dma_ext:
 	if (skb_cb->paddr_ext_desc)
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
 				 sizeof(struct hal_tx_msdu_ext_desc),
 				 DMA_TO_DEVICE);
+fail_free_ext_skb:
+	kfree_skb(skb_ext_desc);
+
+fail_unmap_dma:
+	dma_unmap_single(ab->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);
 
 fail_remove_tx_buf:
 	ath12k_dp_tx_release_txbuf(dp, tx_desc, pool_id);
-- 
2.34.1


