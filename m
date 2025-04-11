Return-Path: <linux-wireless+bounces-21415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4055A853DD
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86F31B81D68
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 06:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8DE27C864;
	Fri, 11 Apr 2025 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pKQXs+tS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16A1D5ADE
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744351338; cv=none; b=oH6HQTX3+VtosVZicu17LVVCtM2pssenQgvnR2xuAPibxakUvvNrhvTppOaLiLgnuruS9AeGvDG8Umx+p3vQWqhN7LbpKN4e9HHG65zTBFHr9CUtbiozib1N3iDkCbz5h/+sWNpe0uErdHEqMVdL93AsyoxaGMqL91kB9GQ3WuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744351338; c=relaxed/simple;
	bh=F24u63wnC/dR8Yxjy8Zvu9k7RVF09WzPYgQKBTPvtaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ecOHW2/u8SbXYrJEBHNUspDhEbUHgQkz/RvCNKPGE/2ZQLXpMr/WS0Nc/8PRV31+xnIDtFp/rsv/VPObhwQGP7VM6PL6sWKs+4zVPyQTSXrMAJxPV5zlbOpcDj/4wGOgjwUuKST5E43Yllqdu0viNsnouh39gRbqrhJZPxlPGjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pKQXs+tS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AH7whP030632
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JlHK4YKuTzk
	w/iX1UXQiiH6p3r2tB5QEn0INjW1eDb0=; b=pKQXs+tS0Bt7f6KeZUKfYTp3HQE
	0ItrmB6whA902585eXlgxZARk6vAnSxoCba/Y60SIeyaC/3gjiEbq1uD9wHD037w
	IWSFH/f/6HKAvM2nfDQ9JSmjEOQuqdIN/cp1t24fjkUWcSs9veKfnr+/R0yxciC2
	40BUiup6DiCrdA4CQR54qo9LINBaS9xU0dQik43llc342sLNGtdLvrg2u4feKraE
	LyRvUzVSufFNuJ92xZICA5XRmKfHPyGNMmShxOrMRbJoHinnTSuU9fsaE+2hhAk9
	9mul6mRvAm4A9uZbJ/ErUzYFRhzScXQR8yVuLhSSxpM4OzHUNLwuAD9sWNA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twfts4j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:02:15 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-736bf7eb149so1247890b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 23:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744351335; x=1744956135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JlHK4YKuTzkw/iX1UXQiiH6p3r2tB5QEn0INjW1eDb0=;
        b=IyhIfAYYenYcQyghQ5tPV71ulw1bGlOxWXvt50n3ex2DFIvMI558RlG/VDmwK6aRiS
         EfanfPP1iGm7KbwWziQd7TIJGVgBZJ2SQqWyJcAhg8ytnE/9jt4fX0irT6f18tMDgZDG
         BeDzyZpRkjoq9j+7jw8SlrZNeIKf1OU/DsNte7aBnwDjYXvkdoIm7qaYKLB2AYRSbeWw
         w7ubgH/xNwo8xXIzcdD2Dwk2sojT70GUPvKrkZVItDOSN818IZiXhsLgtFUUw+34Jtxc
         g5yRe7ZFihYjMLtHhVEHdVAgE61oyBqOJlfPa9pYe4xdxtzpk3bUP713XcxBccBNJiMN
         1E6g==
X-Gm-Message-State: AOJu0YzeonhXir1upkN+62IbqTYq4bm4jDYDuWzVNgsmgMTZFpSiT+Z9
	Sg2Uzsx9Eko+rcZbMUyE66hSSrgQU17fcDx26ycQK+PjxeNLW95ynpe1XoFElHOoleizPFYLb1u
	u0A6u+VJzBDsw8+5Ju81dPgyzbMRonRtxGHHJnIb15IytMTDcDTGJ7SsaCTSIBnHnabfPs8Urjg
	==
X-Gm-Gg: ASbGncsBiUDZbwu9hQ4fZlLXSvlK8XsimsYYE3TOk+TF4MLkONVTzKvP5YS4L/DGJtD
	E05h7CKzmCsi/9yRSikbwF5GZ7KmhQDX2xmN0HaeCchosPUoxC/0HEDp6Z7gNJTo542MYTL39Ep
	ZwP6NDdIWtjKFMLpzd7nwR+zjR5gFZOMuTu3OteIKwJHBHB2GvPgIfJECVyjseIKIJhwU5F0biY
	ZsEy7+lOU67MY3ep5Ld8kjpi2dQBxbhtjbDIu+d0UTwNhBI3RgVQP67eSDFE8ryAnQYkWiOl1L6
	V0h9OMwqxb2MTP5pXHkCcXsDKlwJicaJgMvsPXvR9tapPA9uw26oigLDck6WOdvFkrMXue5wABH
	JFf27I6OrQygj3u/xxMETPioWUBdvAA==
X-Received: by 2002:a05:6a20:2d0e:b0:1f5:6b36:f574 with SMTP id adf61e73a8af0-201799908cemr2526355637.38.1744351334681;
        Thu, 10 Apr 2025 23:02:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5sfpUjKl0m3+LJ6poTjKB4m7DlLGLpImnll9SAYXKJuyQ38HG2wIwpl2Ghcg0ArHJgQUbxg==
X-Received: by 2002:a05:6a20:2d0e:b0:1f5:6b36:f574 with SMTP id adf61e73a8af0-201799908cemr2526314637.38.1744351334173;
        Thu, 10 Apr 2025 23:02:14 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2328435sm624567b3a.157.2025.04.10.23.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 23:02:13 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v3 1/4] wifi: ath12k: Handle error cases during extended skb allocation
Date: Fri, 11 Apr 2025 11:31:51 +0530
Message-Id: <20250411060154.1388159-2-praneesh.p@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67f8b067 cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=Qd23BeFobrpH1aaNZ9kA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: cgYaXyVddKsxQbPl9otWAug-6H78h2tU
X-Proofpoint-ORIG-GUID: cgYaXyVddKsxQbPl9otWAug-6H78h2tU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110042

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
index 91da0805706f..9d58a9a9cbff 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -231,7 +231,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB(skb);
 	struct hal_tcl_data_cmd *hal_tcl_desc;
 	struct hal_tx_msdu_ext_desc *msg;
-	struct sk_buff *skb_ext_desc;
+	struct sk_buff *skb_ext_desc = NULL;
 	struct hal_srng *tcl_ring;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ath12k_vif *ahvif = arvif->ahvif;
@@ -417,18 +417,15 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
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
@@ -464,7 +461,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 			ring_selector++;
 		}
 
-		goto fail_unmap_dma;
+		goto fail_unmap_dma_ext;
 	}
 
 	spin_lock_bh(&arvif->link_stats_lock);
@@ -491,13 +488,16 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 
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


