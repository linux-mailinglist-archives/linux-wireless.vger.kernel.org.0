Return-Path: <linux-wireless+bounces-21106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4274A794E4
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 20:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C910F3AE618
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 18:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DBC1A238F;
	Wed,  2 Apr 2025 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mfK/No/3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7BB1D61A3
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617714; cv=none; b=cuO9GvVQOB8Iu+DqYTIGO+qp//3B3NHuVEOYZstDmnhdG0EZDEDIr3TeM6VWxkXi0ixA5WGNWHd+QbHIYSArJbdlNux/SupIQGZnfslOfG9YAnKV3DT6sKU0AuisyEGMcu897Rsj0a7RcXrP6x8HwzJ49oxJIwG73R5TRxh0AjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617714; c=relaxed/simple;
	bh=ozsQOViJqNZgQuUtzc+HxmcKrwraFQHmMN6DAhks7mM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o7uCyfol3YjxWRlUENeO0u26YpYklo8QxRnaCNRR//3R0kuxXj8oZzuWUF8kxOnVX1qjyIF8msIEN7oELPYmPnI2nr9IyiWpWZ/e0muEF3drXe1SnAtOF0qvwKTSwQ/1uJ20p+pbD+/laPQiALf7SBEgoadpGFDNSiCNqECDMC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mfK/No/3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532D2pT0023738
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 18:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=BfQKh9W0ONV
	XpnR6TE/4zg4F3jk/hUWyS7VSMd4+DYk=; b=mfK/No/3+mWyMiV4YPZOfGrK+LM
	lzE50XIk+UlxxLGc2woXYY/k9AW0x4fYq24LRhp0qE+gWZ1unn95+nGNSbbpTK/t
	Tyfc0MOFItBUx2W+lr48qSX6lZ31+2gN07sOR6S51zwhWf7Wz3C6VkOFMiuOfPlm
	04A4HX2/jDLeOkd790cFAfDfTnsKWZVbPd4MzCf+shNeq3HbOVZGu8HEfITq5B3L
	2OlPnlQA0ZnMspyMdaQHZhXjYN9brBRkKP9rzPVP8rne2kCpd8wOkMBERTH5PBdL
	fO3tXpolCNOdvHGx/B+WQ1odB/xV4WosAGS27sHYzPXW5pnde+VsrnuzPsw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rxapt9p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 18:15:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22647ff3cf5so1105675ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 11:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743617711; x=1744222511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfQKh9W0ONVXpnR6TE/4zg4F3jk/hUWyS7VSMd4+DYk=;
        b=G+ym1rT2wkzWHmBpqZpU0/Bw3rN3C52h/W5w4RIYwkwvW9q6qfnTvpKV5IpT1DUx/t
         p8mUltPNQQ2Xth4hF7aYfQFbBW91E/kFsHC5cieSoCp5nlXIZXfNU5yeGhqdAIfkOdlT
         jxLyz+LTwKCgsOYRe3Qp2K3m46mEDO4YfBrbCbH8Ja6f9tu6h9NLc/7pVH6Yc3zYx3Wt
         kf755cnyKGUMrUc3fq9q4RdIhIizkyAx1biqvy2jQwbF1XsSpkMIwZAE67BcdVV78vq7
         OHw1Pf4en8t64PCXIX/1DiwuBVjz7je/9uUVBy5APsbS/IRmbmb3hbavNNI26VvPhklM
         wlCA==
X-Gm-Message-State: AOJu0YzxtbqDOo5uAxEj6nwcKINiXzu4Oa7M+/LKvgQK1FI0ZJ1ZfMw+
	1nL1ZweLG+CnC4jXXVwcoAJTRrg3L/1WSmb6ziP4e8C+gh0hGbcdoJueHQmtFaivYXQaHOXP9HM
	Gh8rLOvoz8QtjjOGe3uOl51idZmxX7aWCNCknszNJPvPkRM3izlkip8hLFQTlUc/qgmkVau0s9Q
	==
X-Gm-Gg: ASbGncsRw/RPPogrZyjxXMxDrPJXseEHlRaiUWbPI4AJDQW3jbvpeNZzpmg3q6ji92x
	jEZAdCQUPTqvN5sloFUIMVBb4UBPqhOeKRJQct3Fs5S5ADnsPk6vsy+5IYFVdj6kj6J4IF1JMwG
	Sy6ZmfwckCglNDG0zYuLNVoTOkLz86iAEr1woWay5asBhDd8PpZSAY6NSssetlJvNXMUZaErZ6/
	a+cOmvLsSGwjLrZh7L3IBhmq5RYgZhfIXszBoiQsTCiQOJlbVAHZn6s/G3AIAcPWvewGAwxD9dH
	6VV2pvyMOaSE/7mtPVTX5dOM1sW5bAE2aZP9b3xrYqp70jB1c+WKNrQMmUx8yPIAUTNcpvcI0g6
	H1yUNPjnl8yoyTe18x24TH3zn4lUUDY3xyQ==
X-Received: by 2002:a17:902:e5c5:b0:223:3396:15e8 with SMTP id d9443c01a7336-2296c6821bfmr43794165ad.22.1743617710970;
        Wed, 02 Apr 2025 11:15:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDLD8/RfIj/Y/+RSGHKxY9YJrRooy+dzn16LPNSwmIfHzQhWbkjgZHdlZ9sKnsUrmpQ+k3cw==
X-Received: by 2002:a17:902:e5c5:b0:223:3396:15e8 with SMTP id d9443c01a7336-2296c6821bfmr43793715ad.22.1743617710206;
        Wed, 02 Apr 2025 11:15:10 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf14csm111689675ad.137.2025.04.02.11.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 11:15:09 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 4/4] wifi: ath12k: Use skb->len for dma_unmap_single() length parameter
Date: Wed,  2 Apr 2025 23:44:54 +0530
Message-Id: <20250402181454.2699777-5-praneesh.p@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Vbj3PEp9 c=1 sm=1 tr=0 ts=67ed7eb0 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=HWa5UnKU9jpq--M6GMsA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: ETYHjzeYC2NexpCpdEP8Ht08JVo64lqi
X-Proofpoint-GUID: ETYHjzeYC2NexpCpdEP8Ht08JVo64lqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_08,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020116

During dma_unmap_single() for extended skb, the driver currently uses
sizeof() of the corresponding structure. When the allocation size changes,
one of the parameters of dma_unmap_single() needs to be updated everywhere.
Improve code readability by using skb->len instead of sizeof() the structure.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index ab359483472f..9e598a585020 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -481,7 +481,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 fail_unmap_dma_ext:
 	if (skb_cb->paddr_ext_desc)
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
-				 sizeof(struct hal_tx_msdu_ext_desc),
+				 skb_ext_desc->len,
 				 DMA_TO_DEVICE);
 fail_free_ext_skb:
 	kfree_skb(skb_ext_desc);
@@ -512,7 +512,7 @@ static void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 	if (skb_cb->paddr_ext_desc) {
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
-				 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
+				 desc_params->skb_ext_desc->len, DMA_TO_DEVICE);
 		dev_kfree_skb_any(desc_params->skb_ext_desc);
 	}
 
@@ -544,7 +544,7 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 	if (skb_cb->paddr_ext_desc) {
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
-				 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
+				 desc_params->skb_ext_desc->len, DMA_TO_DEVICE);
 		dev_kfree_skb_any(desc_params->skb_ext_desc);
 	}
 
@@ -744,7 +744,7 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 	if (skb_cb->paddr_ext_desc) {
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
-				 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
+				 desc_params->skb_ext_desc->len, DMA_TO_DEVICE);
 		dev_kfree_skb_any(desc_params->skb_ext_desc);
 	}
 
-- 
2.34.1


