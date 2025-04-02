Return-Path: <linux-wireless+bounces-21104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E21DFA794E2
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 20:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2B61891B50
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 18:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BD31C863F;
	Wed,  2 Apr 2025 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cEFyo/jM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E7218B470
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617709; cv=none; b=aM6OOKdHxjVY5l+ZUduGFELyFEUnr2IqdTHDswIcezohbjbBbYhQ3vOJ175mb0NhueoEVSCOwWmBKGGORJhJZ1tfterHS+9Uo8ZBVkY1laPCYmyS3lgNmTzkdZumAO6yv8BemZQ39Xn8itPCeY1UpgmkG7ZbfiFagT23wpERalM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617709; c=relaxed/simple;
	bh=iH/oKptJ4Tn3npbEE4/ChGksxj7cV2GYvwg1zMRIioU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F8maGYCvAWGmydpiyuaJ7lch53wCIC3cEnfYVY+kLNHw5XdrSCF2zLThC1SGqpnmmYg5IlarZ1QX6aOFiiy94PFyANH+rxO/1qQtfu9sUlY4Es7vRlAe9THBfbse3Ztg9M8qB+eub/ytXVHJ8GdeEQ7DjN4CJ13+KTWVJdexkRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cEFyo/jM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532DJBwv024528
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 18:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3kH4mg/2LiL
	W0Qi7Za2o6tSno8k8nCOBPtgA07zpuTE=; b=cEFyo/jMAF1AYgiJZHmy3uenX+7
	Ig8WKhd+cDg47p0YrSNieJGBScqiHhgDPuz0CVYIoJAlgwpj8ipVXhXQcagmQRGo
	advDb2IzIlWcD0U2GJMISjEzSFUrncM6j2RKA3lY1ZIiqtc8zWCj3sVhmd0KihdR
	V20K0P9aWY1MrhakRdCxqztybpFXrvlPrPU+b6UR1e8SJ9zIWO0yo0iFNqE4Yow4
	PA+5tbzQrvU8VlnKVRHxXAAGaBXUeyYkCMcCuISfFJ6H08+02SeeJoVgoyPbtR5W
	GrGP+07zen6MolMe0WTacPdk8qxISfUhA2CPIdE1REJws+g77m9sQZ/X2Iw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rbpywdsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 18:15:06 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-af5268afde2so51190a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 11:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743617706; x=1744222506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kH4mg/2LiLW0Qi7Za2o6tSno8k8nCOBPtgA07zpuTE=;
        b=Du2bSrHsjKV8Ld5TJppJxZRCi+owDg3mvjESkzg/gQQPCONocEH+GzGycacv+AfN1Z
         OueNwkbTjBoptochc1rbDaeqjvoknMeHACPsEf1Ywq18E8AebwbJlqf8+njzs/Kn85eN
         XeWQq4kkRMIq+f0+2kLbCMdQOt0dQOXt/dq9EtxyhKRkvzZ43bslRd3UwUu86vZ1YiMi
         ZpAi/EO1x8SO68/hvwVJUVwUDtuyl5WWA3YNSXNkLIGs7xKIF8TyrfYZr+ErsjpkO4Yf
         CWhSIUI4lDrLHdk3HMxlBp+ji4PL91CIu1sfjpnFi8bms/qrK6MQ/eM1ESQCP87hjpSy
         Ue7g==
X-Gm-Message-State: AOJu0Yz9afAe8ABSEK0Jsbg0HMpNqgqKCh7CoWre6p9MYkft7XBeKQ8D
	aoBr21OGkufMzB9I2rtIQk6uXoPR/BH3F++Ox3pI8sQrJB84IgyxnrtaiMl3IziSiSbXzegz3qj
	7vReiSyM9KOeI82iuKxcN8/HTHgSVBHNyunORojt1Khngo6krWTAEQD3iiuac2HYjr2QwC/kyuw
	==
X-Gm-Gg: ASbGncskugKpkDixOdZJkIWTSRNUTd85yVH1mdanrKHfrbK9mI3cC64wD0GvulnxjXg
	kAaTaz5roQrMGre6/C7R56BSelkrPMV/0xqpRjj4ycGihjP95zD8yfEKBFrrSsJOY/SjFWvOpcx
	VRs2nC4Vmrn/dmEui6SF8/MnSxkOhZXtVBd4XeQEk7K8zOcnqYP05UdsOOJR0E+iSkYm+pOVuIQ
	6TErfiXxZUajqQnbAAFNDdEGav6QGbNVaXnv9Dguf2RUBf9OwHBlPqCa2QyxvpCEO767WyZTr7C
	ceaA2p2B+tGOcS5aipZaFbd7UD11MYQVHz3yvEZA7gVBZ3huYKR31J77v4dx/pE8kvPbaO0gMI2
	a+xskF5snT4K5nUy8fpc3z4vCDgaAFEeF7A==
X-Received: by 2002:a17:902:d551:b0:220:d439:2485 with SMTP id d9443c01a7336-2292f97a6a2mr308344445ad.29.1743617705634;
        Wed, 02 Apr 2025 11:15:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU6kLX6RDMozTZywWQC1yVew2IPm1v0hcV2dhZz6bqZOPGfrrv3sEM4qDnD6A9CgD+xdoKpQ==
X-Received: by 2002:a17:902:d551:b0:220:d439:2485 with SMTP id d9443c01a7336-2292f97a6a2mr308344145ad.29.1743617705198;
        Wed, 02 Apr 2025 11:15:05 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf14csm111689675ad.137.2025.04.02.11.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 11:15:04 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 1/4] wifi: ath12k: Handle error cases during extended skb allocation
Date: Wed,  2 Apr 2025 23:44:51 +0530
Message-Id: <20250402181454.2699777-2-praneesh.p@oss.qualcomm.com>
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
X-Proofpoint-GUID: x0gc2PXMzqvK1_6GCcmVLmJ5-JmQcuW-
X-Proofpoint-ORIG-GUID: x0gc2PXMzqvK1_6GCcmVLmJ5-JmQcuW-
X-Authority-Analysis: v=2.4 cv=ZNLXmW7b c=1 sm=1 tr=0 ts=67ed7eaa cx=c_pps a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=Qd23BeFobrpH1aaNZ9kA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_08,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020115

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
index 29e2715024ce..03c79becd59a 100644
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


