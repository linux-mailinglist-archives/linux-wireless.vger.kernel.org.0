Return-Path: <linux-wireless+bounces-21418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CBFA853E1
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4602C1B827BB
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 06:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9A827D761;
	Fri, 11 Apr 2025 06:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n5NmWVci"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6E727CCF6
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744351343; cv=none; b=N9Oc+ZbpNk3CAGnS9KNZcHEucySZezwv5RvDedv5Loi6m99Wr/KJgSO4WTS/T4ANFMmxWCqFYJ9Tcse9iHSIfb0VXXbVajrkbv0yRFosNXCZiTPgIGLn23GlBeaq/pR9rHE6iQaKslGr30RTegp08hjUeF9S2K0VmbZlEFlnRq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744351343; c=relaxed/simple;
	bh=kkZN04hvg7ZnlJzsBQNhiH9OQTP5Te0AQrWwtbTXk5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DW+QhFQoPB7+WB3tFSki98V9SyKaALyEcnSVMv95af46NZf+A7oSLJ39ygeyOfEr5okbUhAeK3kzZBXPRqLek+OHOlexkw7xKO+Re/JnG5hvhmdKYrN0YJJfWEExrp0CBhrHEf52MwjPXrWe7ngt5QQyxCpZgI3m+gRXC48cHFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n5NmWVci; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B5Z4po032024
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3LI+y2nA3KG
	cyfqaaKLuNSW0EzMKBoBYWbhA47+9hn8=; b=n5NmWVcim6UTtkkacyU56Hbz6jd
	Q6SiZiwvyMKhsOKStSPBvzkWdvn2zAub580WJq5s0SkGZfkiZJUsuLCphImYb9/G
	SNEq2IbX3GhnhQrgQCsfpxc8LUtx/GMiPRu9RZT7EOry16w7afj02Dc2mHdCuJtI
	wkv8M8OPw70ZNoNixRhnxI7DtKxL7uEifDbhYw94WiSjLL8Lo2jEEoTKssf59YXg
	RZwzYIDYCXtAyDkFIPpsgmyl1UJhHSFKBCyJn8yrrx7+rteyMPY8LHRtL2ZdUkKB
	jBhP67QLGCrZ46Vh6UuBr7Mn6mgRzcqCYzWif9+yvwNt1PpOcE7xE0nJtaA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpmh92h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:02:20 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-736c7d0d35aso2043410b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 23:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744351340; x=1744956140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LI+y2nA3KGcyfqaaKLuNSW0EzMKBoBYWbhA47+9hn8=;
        b=SeXnsBRPxy3ygOv45t4HpldYsbdhRxb+dUzods7RKt75jQGumj4h/pR8hZdCwHorOt
         jUqZ3iNVc2EfTuPCWwY48j+RF9TJGy/9ZlOjBjyvDqVaVkBFMReXHBIgjCwZnVLpbtfn
         9TLfPiQQkBZaZ8kA/+TYu1zPwMS8t+fg2KOhIqXjh4WPDU2C+Ms4V3/33uG0NnjCSDF5
         INEmmw2FxgBi3Sy4773+D3Ka949vz/d1ZFoVRO5ZZ+0e/w17+RoWs7OBBSgH6vRqTtu9
         cHBJASaXys1SEsvvt1OQpuYRsCDq/Ug7uwwjEH8T4Px7wmjPHFW72LwztCkQPnKq6/Ej
         uvaw==
X-Gm-Message-State: AOJu0YxVuVYXyjI8lJZ1K5gK5Q86dXib6a5Eb34Reu/nRXewZ9Rd9yqQ
	xPox+/HDVK9OvyeHDSPPYBSA30vHmT031+yfIaizZstvbkcmiekygkLEvvWSsdM/LuDhY/erdO2
	bim31Lj+Afce/3WOtC1VM1uvq6Xf1xJLjtCNwwLsyBWQoDPkCL/rdZVIPwHwz8YvgPZRnPk8+rw
	==
X-Gm-Gg: ASbGncsOTSUHmsaZSEV+s07tx2neuQ1GfYV/UAGX6TnnIfmJfVokoCGyz5W6xmkbx4I
	yUVK3vmhnHBfCrXNfakenir9IiyIsT9KUnsOucKjfQ2Ch1/ey4UbFqJEsn15jgA2YSlNaV6NrXU
	byv8tZPbT0JigBJX28OtO+GeWkg5NMMwpLnMDaIh6XNN7ow6yNgtKwJDsr9Cqy4Cz5oDv50rpPg
	rlFhnrSqBYrgXiMfSLNXbezwIydBzQRaxL8uMs8sFhPmROkH63YZ5nV768YQX2Nm5lofPgdK5m8
	7alIYfj8W7SkYrVzGgkqGS4dO4wK77BCXh1GiRQ+ca4vweX9UUvGwZcUJTKaZTE7qS5lD+76JLw
	9a1rEIDsu3HQSKIuj3ffGRtX21dy7Pw==
X-Received: by 2002:a05:6a00:1482:b0:736:55ec:ea94 with SMTP id d2e1a72fcca58-73bd1293b3amr2318920b3a.20.1744351339636;
        Thu, 10 Apr 2025 23:02:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeE2pYHLFT4X13kg4+fpoiqxepA5LEoDfh+AVs7ZQVLKyLO6oscajfotgM2Yn76JUwcsL0qg==
X-Received: by 2002:a05:6a00:1482:b0:736:55ec:ea94 with SMTP id d2e1a72fcca58-73bd1293b3amr2318850b3a.20.1744351339095;
        Thu, 10 Apr 2025 23:02:19 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2328435sm624567b3a.157.2025.04.10.23.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 23:02:18 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v3 4/4] wifi: ath12k: Use skb->len for dma_unmap_single() length parameter
Date: Fri, 11 Apr 2025 11:31:54 +0530
Message-Id: <20250411060154.1388159-5-praneesh.p@oss.qualcomm.com>
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
X-Proofpoint-GUID: 29eTukpqgirO06BOIheqOLy0XQ6_vi8h
X-Proofpoint-ORIG-GUID: 29eTukpqgirO06BOIheqOLy0XQ6_vi8h
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f8b06c cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=HWa5UnKU9jpq--M6GMsA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110042

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
index 9bcd20712888..2136eeb278af 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -493,7 +493,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 fail_unmap_dma_ext:
 	if (skb_cb->paddr_ext_desc)
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
-				 sizeof(struct hal_tx_msdu_ext_desc),
+				 skb_ext_desc->len,
 				 DMA_TO_DEVICE);
 fail_free_ext_skb:
 	kfree_skb(skb_ext_desc);
@@ -529,7 +529,7 @@ static void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 	if (skb_cb->paddr_ext_desc) {
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
-				 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
+				 desc_params->skb_ext_desc->len, DMA_TO_DEVICE);
 		dev_kfree_skb_any(desc_params->skb_ext_desc);
 	}
 
@@ -564,7 +564,7 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 	if (skb_cb->paddr_ext_desc) {
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
-				 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
+				 desc_params->skb_ext_desc->len, DMA_TO_DEVICE);
 		dev_kfree_skb_any(desc_params->skb_ext_desc);
 	}
 
@@ -781,7 +781,7 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 	if (skb_cb->paddr_ext_desc) {
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
-				 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
+				 desc_params->skb_ext_desc->len, DMA_TO_DEVICE);
 		dev_kfree_skb_any(desc_params->skb_ext_desc);
 	}
 
-- 
2.34.1


