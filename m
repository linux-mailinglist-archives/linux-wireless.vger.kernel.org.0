Return-Path: <linux-wireless+bounces-21776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8791A94B0F
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 04:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B53188ED76
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 02:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92C72571DD;
	Mon, 21 Apr 2025 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oTRlBkH9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65F244C63
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202943; cv=none; b=EKWI8RbMxkBG1s7rUacSyIZHfAprupC3Q2eLIrWqwx/9XVOz9jfAcdj99MW5uv/k0BNTqe34y4D33JTsYS26hv3OEUq/8NHCh4WxC6Aewm3XOHfsDIrtp/rfTzlCgHmQanGqQDSIOgpfG470WSsFAzZuKua1RrB+k/J01karrro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202943; c=relaxed/simple;
	bh=7AbosIqyZX+TWyTYHtdoP9fkPt5BmoydZtD6LRZbrL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oESRn0sYmBDGOWkKBr9xK0TJAqBYOCRRtTVtDjraQRaeHNYI3rGnYczDomdlwY3iI4+f69vkgMAZ6JVznc4sDhvz40VeMzp55dE8gcLMoD8IWIRlE+SA6JVCRLuwN8VwGs9+6zASx0kkBVPytadPeGsu8YRHXDZUu4e9ZxPetTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oTRlBkH9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53L0NJRQ023105
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5GANNV6oVj+
	ynefjA8lZ1Q4dBfFUbWKfBAr9zn5iRes=; b=oTRlBkH939TgEXDbEAzaPdney3t
	e0gZ5pyiiWJohnIvmLghbbnVaxMHDXSU3aqEv0Yb0SZM8Lk09sCxGFxqvD24wNRe
	U+8UenguoAtcHYEF+HZ1m8s7FPKocrQ/RIzx09B60d8LYKz5BCEt1kYcaTUNCovP
	rnErmeLoEF4Q520CKNu7Vq0fF7Rj0g+g9eBBPYATK5o+McuBGS4z/ihdeUfflnEs
	OiI46Vl5JZR4HIl8EIAa1E2U5tgk+8CtuaLQPJiqcHDEbULmvYJ3dm1ZGLmbKPDN
	i8rumvi1g7+DYnI1D/BspmBqfCgxB9er8Y1fwsYw8AUAV+0hWKhd3FSAqPQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4644kjaq3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22aa75e6653so29247945ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 19:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745202927; x=1745807727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GANNV6oVj+ynefjA8lZ1Q4dBfFUbWKfBAr9zn5iRes=;
        b=KNXx+qifqrgeAA0YlDXz4uh3CcIlaLIYUtfFuMJjjS8g4I8YfRtmPmCGniQsFXqDe9
         oSmZdZ4yiypx8mvmIJu0bQ5oMnuYfY7iR78SHu9m20JGkoJnBjTnsJtzyDKreqIfwlyx
         DT6Br2csjPq5XM5sTtZKPInRJY7yDHspie7tIG6nCxrEZyXEqBA//HfM4KgtJ6JFQ7lI
         9Uwz+O4f9m8Ov5SXSlX+yw917L8xHo6QgiRTHkMtcTI17kBObYVyaDFkip9tztq45Qne
         dKNIJec/vM1qU6qk/XwdrXpQ7wxqf2R2hvFyEEt5pEJiOnMOTrZhm4toFRij61NOH2bB
         TIFQ==
X-Gm-Message-State: AOJu0YwXVpojPYab2ASfuvd7smMdyLE7WoybcAK4Smnnj6PNZ6TGesUh
	Gynr3GwEyDnx2E9S4ITX7kc6UdvuBKz8pID9D8ZNMPtUdVPgO7/WiuaGDToaRjOSvqV2myMRg46
	LVTBZB+TlF5f/RjEop+n8lawSmfxOOC1xFO/6s/1pUbB4E1WZB8JGCZQNjtSB9DhITGvbNIVJ4T
	m7
X-Gm-Gg: ASbGncsFeTSdDNsUkqtHiyWNeM3hjR4snDz9JHRctiEdwuJvCN7MbQObEmytStvSEVY
	C2b0J8Au3uXYESftalODeuXnG3nYg5vCI7jB9ytumNRUiofRbkjGNM1k9DeHFg9G12SWoisPaPR
	4GMWaCVtM7VLaYPwzim9QCssBbKpWOwDBJxBbR2DSmtMx5fM2ADmXiDMBQ9PCMQrtfNhaEdGp/G
	nAnVbWw8+7hWTYyFa3Cyac7/XmVykUwVnYv+ZjjwHy+dN7otsJqZ2Gf07rqQc9hOuXLfNX0PZEG
	e4fC/4Rassr2+hZYJA6fSMqPYKdV77sazkFcucSRnTx/7WUK2bFKngiFW47mf8kztETU0Z3qx5H
	VNrXfqX6zSxM=
X-Received: by 2002:a17:903:3c6b:b0:223:5c33:56a2 with SMTP id d9443c01a7336-22c535ac9bfmr162517635ad.28.1745202927523;
        Sun, 20 Apr 2025 19:35:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRr0smnK1NdojnxpwCSUqg4Dyvf8nrvqRhSYegMFwP0d3YuzIGBYuLA/UYnWSYF2rwwZlnvQ==
X-Received: by 2002:a17:903:3c6b:b0:223:5c33:56a2 with SMTP id d9443c01a7336-22c535ac9bfmr162517345ad.28.1745202927051;
        Sun, 20 Apr 2025 19:35:27 -0700 (PDT)
Received: from kangyang.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4287sm54631685ad.130.2025.04.20.19.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 19:35:26 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 05/13] wifi: ath12k: add interrupt configuration for mon status ring
Date: Mon, 21 Apr 2025 10:34:36 +0800
Message-Id: <20250421023444.1778-6-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
References: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CiQMsS55Mjy5KIaw9-AYrhL-FN8pjXkd
X-Authority-Analysis: v=2.4 cv=f5pIBPyM c=1 sm=1 tr=0 ts=6805aefd cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=8wUhg8T_1bdp2XeRaFAA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: CiQMsS55Mjy5KIaw9-AYrhL-FN8pjXkd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210018

The monitor mode design is:
1. Hardware captures packets on the air.
2. Hardware stores the packets into related rings.
3. When the ring buffer reaches the interrupt threshold, it triggers
the interrupt.
4. Reap and process the ring buffer in ath12k_dp_service_srng().

Here the interrupt thresholds are intr_timer_thres_us, low_threshold and
intr_batch_cntr_thres_entries. An interrupt will be triggered once:
1. Number of packets in the ring reaches intr_batch_cntr_thres_entries.
2. Number of packets in the ring reaches low_threshold(by timer).
3. Timer reaches intr_timer_thres_us.

So, add interrupt configuration for the mon status ring, then start
to process ring buffers when the interrupt arrives.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp.c  | 24 +++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/hw.c  | 10 ++++++++++
 drivers/net/wireless/ath/ath12k/hw.h  |  1 +
 drivers/net/wireless/ath/ath12k/pci.c |  3 ++-
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index ad873013e46c..5eec14a7b1ea 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -168,6 +168,8 @@ static int ath12k_dp_srng_calculate_msi_group(struct ath12k_base *ab,
 		grp_mask = &ab->hw_params->ring_mask->reo_status[0];
 		break;
 	case HAL_RXDMA_MONITOR_STATUS:
+		grp_mask = &ab->hw_params->ring_mask->rx_mon_status[0];
+		break;
 	case HAL_RXDMA_MONITOR_DST:
 		grp_mask = &ab->hw_params->ring_mask->rx_mon_dest[0];
 		break;
@@ -274,12 +276,17 @@ int ath12k_dp_srng_setup(struct ath12k_base *ab, struct dp_srng *ring,
 		break;
 	case HAL_RXDMA_BUF:
 	case HAL_RXDMA_MONITOR_BUF:
-	case HAL_RXDMA_MONITOR_STATUS:
 		params.low_threshold = num_entries >> 3;
 		params.flags |= HAL_SRNG_FLAGS_LOW_THRESH_INTR_EN;
 		params.intr_batch_cntr_thres_entries = 0;
 		params.intr_timer_thres_us = HAL_SRNG_INT_TIMER_THRESHOLD_RX;
 		break;
+	case HAL_RXDMA_MONITOR_STATUS:
+		params.low_threshold = num_entries >> 3;
+		params.flags |= HAL_SRNG_FLAGS_LOW_THRESH_INTR_EN;
+		params.intr_batch_cntr_thres_entries = 1;
+		params.intr_timer_thres_us = HAL_SRNG_INT_TIMER_THRESHOLD_RX;
+		break;
 	case HAL_TX_MONITOR_DST:
 		params.low_threshold = DP_TX_MONITOR_BUF_SIZE_MAX >> 3;
 		params.flags |= HAL_SRNG_FLAGS_LOW_THRESH_INTR_EN;
@@ -919,6 +926,21 @@ int ath12k_dp_service_srng(struct ath12k_base *ab,
 			goto done;
 	}
 
+	if (ab->hw_params->ring_mask->rx_mon_status[grp_id]) {
+		ring_mask = ab->hw_params->ring_mask->rx_mon_status[grp_id];
+		for (i = 0; i < ab->num_radios; i++) {
+			for (j = 0; j < ab->hw_params->num_rxdma_per_pdev; j++) {
+				int id = i * ab->hw_params->num_rxdma_per_pdev + j;
+
+				if (ring_mask & BIT(id)) {
+					/* TODO: add monitor mode function */
+					if (budget <= 0)
+						goto done;
+				}
+			}
+		}
+	}
+
 	if (ab->hw_params->ring_mask->rx_mon_dest[grp_id]) {
 		monitor_mode = ATH12K_DP_RX_MONITOR_MODE;
 		ring_mask = ab->hw_params->ring_mask->rx_mon_dest[grp_id];
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index a46d82857c5d..482b0f4e8f95 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -118,6 +118,10 @@ static const struct ath12k_hw_ops wcn7850_ops = {
 #define ATH12K_TX_MON_RING_MASK_0 0x1
 #define ATH12K_TX_MON_RING_MASK_1 0x2
 
+#define ATH12K_RX_MON_STATUS_RING_MASK_0 0x1
+#define ATH12K_RX_MON_STATUS_RING_MASK_1 0x2
+#define ATH12K_RX_MON_STATUS_RING_MASK_2 0x4
+
 /* Target firmware's Copy Engine configuration. */
 static const struct ce_pipe_config ath12k_target_ce_config_wlan_qcn9274[] = {
 	/* CE0: host->target HTC control and raw streams */
@@ -836,6 +840,12 @@ static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_wcn7850 = {
 	},
 	.rx_mon_dest = {
 	},
+	.rx_mon_status = {
+		0, 0, 0, 0,
+		ATH12K_RX_MON_STATUS_RING_MASK_0,
+		ATH12K_RX_MON_STATUS_RING_MASK_1,
+		ATH12K_RX_MON_STATUS_RING_MASK_2,
+	},
 	.rx = {
 		0, 0, 0,
 		ATH12K_RX_RING_MASK_0,
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 024cfcd2cc15..0fbc17649df4 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -135,6 +135,7 @@ enum hal_encrypt_type;
 struct ath12k_hw_ring_mask {
 	u8 tx[ATH12K_EXT_IRQ_GRP_NUM_MAX];
 	u8 rx_mon_dest[ATH12K_EXT_IRQ_GRP_NUM_MAX];
+	u8 rx_mon_status[ATH12K_EXT_IRQ_GRP_NUM_MAX];
 	u8 rx[ATH12K_EXT_IRQ_GRP_NUM_MAX];
 	u8 rx_err[ATH12K_EXT_IRQ_GRP_NUM_MAX];
 	u8 rx_wbm_rel[ATH12K_EXT_IRQ_GRP_NUM_MAX];
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 528a4a57d136..5c012f7fcd97 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -600,7 +600,8 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 		    ab->hw_params->ring_mask->rx_wbm_rel[i] ||
 		    ab->hw_params->ring_mask->reo_status[i] ||
 		    ab->hw_params->ring_mask->host2rxdma[i] ||
-		    ab->hw_params->ring_mask->rx_mon_dest[i]) {
+		    ab->hw_params->ring_mask->rx_mon_dest[i] ||
+		    ab->hw_params->ring_mask->rx_mon_status[i]) {
 			num_irq = 1;
 		}
 
-- 
2.34.1


