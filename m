Return-Path: <linux-wireless+bounces-21253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B36F6A7F4C9
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 08:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 448A17A16D6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 06:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ACE25F987;
	Tue,  8 Apr 2025 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DKnXUHgw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4760725F985
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092845; cv=none; b=uuQ2DCOYTkJ9qv71D4t4/sluy0hGRWb3YtHlFrzb9iJNqKUlKXNmNoBxLfbXaDKCuDfwQCQKD1n/S3o69KKOj7LDbKlYncMcrIKafuPvC2CTwj8TwTt74x60sCc0DJYyZUIoHoRvsedIkofjLY2fFAVPx7j47hX2Oa67Y1cS7+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092845; c=relaxed/simple;
	bh=lRdsgyk2PVwbTdF3/ou7/1EHozWl4HwuVjydW9UXQhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VYprlab1KLsH58K9GOQzcIVVpuWN0AlibJdnj7RG0XQRGY/hyKd6nI3qH+YgFvJxlOrlreirZEHEXiBvLtYqS3fgBDxRnfqQDrf5QcgI1jfzr5sj0wjNvgSc6MtOPTtio+J6+WCctdGlD0UkYy3cBbIVftJWsQXOxY2ZViviSnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DKnXUHgw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GOuF010519
	for <linux-wireless@vger.kernel.org>; Tue, 8 Apr 2025 06:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=olrNLy2pDRf
	TnemTktBOL55UfepkNvExCqdqi2eTMK0=; b=DKnXUHgwFyXUkd69i/6kR6Q+tw4
	p01JHmh8s+bMlg59ki+XGEixri09fqwBG5/FNOjsWnBgvJwIIx6qW9S7jsnYHDnc
	dkXeyq4jKLkyo8emIRnBgSXjJ7hbSo61W0dA8QsJ370QzwXR1wFuaado4qRIna9s
	SLpoTxiv4Iz9DwP1BqrBOrPbebFtMfDw+pu7mT2Oq8/LCar0q5yA1iQGUpRiAhlp
	+/ptjP0T0w01SpDtuzC/hZN3D7q3W+FGuFayvboch2g+kOS62jhDEp0qgMTYbPbs
	/NXhOBjyt2ncduch9+liPsAuMhZlIBpSfpn3d0hHkY8BuKwASwgNc8lGR3Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1ekep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 06:14:03 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso8825533a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 23:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092842; x=1744697642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olrNLy2pDRfTnemTktBOL55UfepkNvExCqdqi2eTMK0=;
        b=SKsSokGqf+Zzt3QMup6ZHbsxhkrDaVWG7JjBx54VZ5YRsPY6FD9Va0pA0tntDgVSA1
         mJkHOlCBhxDyaPbiCkmFI84xQAeqtFilL71OolS26tYOb1u1X/CLFb+h9vLMQNFyQCnE
         +FgyzdTkPQDn8Zmc2ekCVdUE60wUUFbXnhs4eFY8W3jMFt82d7dfS9wXDbRNRsfDRy5Z
         QHD+BwkW+nRq6kiNzPjxc6vyOhrYuSP387ML3q3BkjaTyVsnJ8NOl0co4JpgLMqzSzOr
         aHwhENx4An3wBApyuO8v44AUP152H78vwJlz3uUwkP9UHOm5zvDe2HA3QEqDbXUzLrP4
         MYPg==
X-Gm-Message-State: AOJu0YyN6VQ+Fr/6CFixqk4BhlXYAmiQRGjt1J2dDeP/lqAZbBQm9eoh
	ziHACJV9yOdlYS/U8ILNMQosLJqCfDYQMtQ+9YToaABio8LUZn0yvyglQ9Z0w96h2k+p64QBf7G
	R4/OVDBIfv939XEAUH/VyymEWFfpcOwa94FxZWvbHCyIRxE6AK2UkDIDLUdrw/tzukReuJXlxng
	==
X-Gm-Gg: ASbGncvsO9UayQV3cng7KPKB6LdjXvlqG47ZKOaztvYXWqqIDuwImR7hPSxagNiZwKT
	Gvg8xKt3nHp269AOdsmQduwUD3Yl08UW6Kd3p36sHV2L3gSHUsNtdwW2rtzJkcCP6j/OxPdNiY3
	DYVEGOSaUAQrs4d4ZSZ+PgKCJeojgz6CwYdmLtQN+nHFDE0ZH6n7MPsOg7I9o9SiW850xcxVbvg
	JLkjkYe8q4jjsf4toOCF7LdHjj+LzuOuCV8P54fxsvbkYt4gNKVRPNxbrdgdsnkBsjNs0hGvO17
	SwpkuDlR9wHOZSm+93COQzIz56deleQn0n+rIrx6AJbX4hKn3unX8dBR7mhURRDZZqS63iTfkKr
	rLXkjzbdibIs6oosxWyDd9qiIMP30tJ2YKg==
X-Received: by 2002:a17:90b:188c:b0:2ff:52b8:2767 with SMTP id 98e67ed59e1d1-306a6179a96mr12672344a91.19.1744092841800;
        Mon, 07 Apr 2025 23:14:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmOq7mvvxns/jU1l9GXGdqKsz3ASS5fX2Fd+UjuOJusmNSgIgcWzVv2cx4/ddu7CQ5sSqI9w==
X-Received: by 2002:a17:90b:188c:b0:2ff:52b8:2767 with SMTP id 98e67ed59e1d1-306a6179a96mr12672323a91.19.1744092841311;
        Mon, 07 Apr 2025 23:14:01 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb94f4esm10258444a91.46.2025.04.07.23.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 23:14:00 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v2 4/4] wifi: ath12k: Use skb->len for dma_unmap_single() length parameter
Date: Tue,  8 Apr 2025 11:43:43 +0530
Message-Id: <20250408061343.2774345-5-praneesh.p@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: hwDyY3pC2tby_-hcQhTKcA-dXGc3Phqn
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f4beab cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=HWa5UnKU9jpq--M6GMsA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: hwDyY3pC2tby_-hcQhTKcA-dXGc3Phqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_02,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080043

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
index 03ca45d10f7c..3bda44b41e34 100644
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
 
@@ -745,7 +745,7 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 	if (skb_cb->paddr_ext_desc) {
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
-				 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
+				 desc_params->skb_ext_desc->len, DMA_TO_DEVICE);
 		dev_kfree_skb_any(desc_params->skb_ext_desc);
 	}
 
-- 
2.34.1


