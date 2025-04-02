Return-Path: <linux-wireless+bounces-21084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E08F0A7921A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A394817096C
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 15:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0767620E70F;
	Wed,  2 Apr 2025 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iulTPzdx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9A023C392
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607560; cv=none; b=pMMgtKHwEr1hIKRpkzQwFh3wyk068Ghtut1iR174edRVi5+TbLc73CpZNENjCilLUJPn5YuytmTvw3bSTf9eeQB+Sc2iwjuU/gQy0cAPWMzHxpFW8XoZml0utTUaPQik6ncjSAuWE67obmJhSfbExkqQ2ib9nHkHn13zhm1wKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607560; c=relaxed/simple;
	bh=kD/ZYJBN90WJwioBl0fAT8pt97EpxwSvKMUHuiNi9Y0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQHZaw8tBVPk3OOGWSucL5nh0P5c++ZYYzU2cWj0GjRJPN7F6VHWkFjqY3Ny+le4wbgm0/iq1+aVDWeS/d90D+gNajACpETADjjmLd+mym2NHb79uTSMui5UcIiyP8nY1L7cP9Ur6nCckM+VUWMRScsO4HTLpLyLIaX3wL7bHDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iulTPzdx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532E39CQ009193;
	Wed, 2 Apr 2025 15:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+emXAJ49E6ufJVe/gaCXSnwQ
	aHee/5JMOHactXrBVsA=; b=iulTPzdxZ+C4aNnSE0Y9ZweiSTYD+fcd66n8lL11
	4tpHnJhJcM/Lja4DiHlIPLe20WjMZkFlhuRFG1M2Ikv9RTwCqnvzZBwpO5xhwi4f
	Lfs6qt1lkcdTiabdw9OvZ/wIBNwf72JLy7lI7UKP9PyKIZFKJktEOZn3xjCTwqfe
	n2fBQ0BkBhRDQBnQVg9BgV3/IcBdvoqKo0HfmHrDPZXmIE8l7xfuYo4Yydb68pH5
	aK8T2aazgdZho3HQ4JD+FEKmu3jcAPlHfgS56FSNjM1JIssSm0enhAuzcFm4HpwY
	VGL179TgVKKUo0Fh6ImTDksOfzeFTYdu3dg9F8WpTskXKQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rxb01tpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 15:25:56 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 532FPuaQ013083
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Apr 2025 15:25:56 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 2 Apr 2025 08:25:54 -0700
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Nithyanantham Paramasivam <quic_nithp@quicinc.com>
Subject: [PATCH ath-next v4 1/3] wifi: ath12k: Fix the enabling of REO queue lookup table feature
Date: Wed, 2 Apr 2025 20:55:27 +0530
Message-ID: <20250402152529.1649402-2-quic_nithp@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250402152529.1649402-1-quic_nithp@quicinc.com>
References: <20250402152529.1649402-1-quic_nithp@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zZJJx0BG6P1iNvUmtktckLpCCL-RAUsu
X-Proofpoint-GUID: zZJJx0BG6P1iNvUmtktckLpCCL-RAUsu
X-Authority-Analysis: v=2.4 cv=BavY0qt2 c=1 sm=1 tr=0 ts=67ed5704 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=dhpUuReOw4GaK_-c5ysA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_06,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=11 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020097

From: Sriram R <quic_srirrama@quicinc.com>

Instead of storing the REO queue address inside peer entries, REO
hardware module prefers them to be stored in SRAM which could be
directly accessed by REO using peer_ID/TID based lookup table
mechanism.

Fix the enabling of the REO queue lookup table(LUT) feature by
configuring the LUT address information in the REO hardware register
and setting the host service flags.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c    | 77 +++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/dp.h    |  5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c | 10 +++-
 drivers/net/wireless/ath/ath12k/hal.h   |  6 ++
 drivers/net/wireless/ath/ath12k/hw.c    |  2 +
 drivers/net/wireless/ath/ath12k/hw.h    |  3 +
 drivers/net/wireless/ath/ath12k/wmi.c   |  8 ++-
 drivers/net/wireless/ath/ath12k/wmi.h   |  1 +
 8 files changed, 83 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index b1f27c3ac723..80b9f4594dee 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1261,22 +1261,24 @@ static void ath12k_dp_reoq_lut_cleanup(struct ath12k_base *ab)
 	if (!ab->hw_params->reoq_lut_support)
 		return;
 
-	if (dp->reoq_lut.vaddr) {
+	if (dp->reoq_lut.vaddr_unaligned) {
 		ath12k_hif_write32(ab,
 				   HAL_SEQ_WCSS_UMAC_REO_REG +
 				   HAL_REO1_QDESC_LUT_BASE0(ab), 0);
-		dma_free_coherent(ab->dev, DP_REOQ_LUT_SIZE,
-				  dp->reoq_lut.vaddr, dp->reoq_lut.paddr);
-		dp->reoq_lut.vaddr = NULL;
+		dma_free_coherent(ab->dev, dp->reoq_lut.size,
+				  dp->reoq_lut.vaddr_unaligned,
+				  dp->reoq_lut.paddr_unaligned);
+		dp->reoq_lut.vaddr_unaligned = NULL;
 	}
 
-	if (dp->ml_reoq_lut.vaddr) {
+	if (dp->ml_reoq_lut.vaddr_unaligned) {
 		ath12k_hif_write32(ab,
 				   HAL_SEQ_WCSS_UMAC_REO_REG +
 				   HAL_REO1_QDESC_LUT_BASE1(ab), 0);
-		dma_free_coherent(ab->dev, DP_REOQ_LUT_SIZE,
-				  dp->ml_reoq_lut.vaddr, dp->ml_reoq_lut.paddr);
-		dp->ml_reoq_lut.vaddr = NULL;
+		dma_free_coherent(ab->dev, dp->ml_reoq_lut.size,
+				  dp->ml_reoq_lut.vaddr_unaligned,
+				  dp->ml_reoq_lut.paddr_unaligned);
+		dp->ml_reoq_lut.vaddr_unaligned = NULL;
 	}
 }
 
@@ -1608,39 +1610,66 @@ static int ath12k_dp_cc_init(struct ath12k_base *ab)
 	return ret;
 }
 
+static int ath12k_dp_alloc_reoq_lut(struct ath12k_base *ab,
+				    struct ath12k_reo_q_addr_lut *lut)
+{
+	lut->size =  DP_REOQ_LUT_SIZE + HAL_REO_QLUT_ADDR_ALIGN - 1;
+	lut->vaddr_unaligned = dma_alloc_coherent(ab->dev, lut->size,
+						  &lut->paddr_unaligned,
+						  GFP_KERNEL | __GFP_ZERO);
+	if (!lut->vaddr_unaligned)
+		return -ENOMEM;
+
+	lut->vaddr = PTR_ALIGN(lut->vaddr_unaligned, HAL_REO_QLUT_ADDR_ALIGN);
+	lut->paddr = lut->paddr_unaligned +
+		     ((unsigned long)lut->vaddr - (unsigned long)lut->vaddr_unaligned);
+	return 0;
+}
+
 static int ath12k_dp_reoq_lut_setup(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
+	u32 val;
+	int ret;
 
 	if (!ab->hw_params->reoq_lut_support)
 		return 0;
 
-	dp->reoq_lut.vaddr = dma_alloc_coherent(ab->dev,
-						DP_REOQ_LUT_SIZE,
-						&dp->reoq_lut.paddr,
-						GFP_KERNEL | __GFP_ZERO);
-	if (!dp->reoq_lut.vaddr) {
+	ret = ath12k_dp_alloc_reoq_lut(ab, &dp->reoq_lut);
+	if (ret) {
 		ath12k_warn(ab, "failed to allocate memory for reoq table");
-		return -ENOMEM;
+		return ret;
 	}
 
-	dp->ml_reoq_lut.vaddr = dma_alloc_coherent(ab->dev,
-						   DP_REOQ_LUT_SIZE,
-						   &dp->ml_reoq_lut.paddr,
-						   GFP_KERNEL | __GFP_ZERO);
-	if (!dp->ml_reoq_lut.vaddr) {
+	ret = ath12k_dp_alloc_reoq_lut(ab, &dp->ml_reoq_lut);
+	if (ret) {
 		ath12k_warn(ab, "failed to allocate memory for ML reoq table");
-		dma_free_coherent(ab->dev, DP_REOQ_LUT_SIZE,
-				  dp->reoq_lut.vaddr, dp->reoq_lut.paddr);
-		dp->reoq_lut.vaddr = NULL;
-		return -ENOMEM;
+		dma_free_coherent(ab->dev, dp->reoq_lut.size,
+				  dp->reoq_lut.vaddr_unaligned,
+				  dp->reoq_lut.paddr_unaligned);
+		dp->reoq_lut.vaddr_unaligned = NULL;
+		return ret;
 	}
 
+	/* Bits in the register have address [39:8] LUT base address to be
+	 * allocated such that LSBs are assumed to be zero. Also, current
+	 * design supports paddr upto 4 GB max hence it fits in 32 bit register only
+	 */
+
 	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_LUT_BASE0(ab),
-			   dp->reoq_lut.paddr);
+			   dp->reoq_lut.paddr >> 8);
+
 	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_LUT_BASE1(ab),
 			   dp->ml_reoq_lut.paddr >> 8);
 
+	val = ath12k_hif_read32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_ADDR(ab));
+
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_ADDR(ab),
+			   val | HAL_REO_QDESC_ADDR_READ_LUT_ENABLE);
+
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_MAX_PEERID(ab),
+			   HAL_REO_QDESC_MAX_PEERID);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 427a87b63dec..e8dbba0c3bb7 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -311,8 +311,11 @@ struct ath12k_reo_queue_ref {
 } __packed;
 
 struct ath12k_reo_q_addr_lut {
-	dma_addr_t paddr;
+	u32 *vaddr_unaligned;
 	u32 *vaddr;
+	dma_addr_t paddr_unaligned;
+	dma_addr_t paddr;
+	u32 size;
 };
 
 struct ath12k_dp {
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 66603e9c154b..81e036f1d70f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -3242,8 +3242,14 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 	reo_ent_ring->rx_mpdu_info.peer_meta_data =
 		reo_dest_ring->rx_mpdu_info.peer_meta_data;
 
-	reo_ent_ring->queue_addr_lo = cpu_to_le32(lower_32_bits(rx_tid->paddr));
-	queue_addr_hi = upper_32_bits(rx_tid->paddr);
+	if (ab->hw_params->reoq_lut_support) {
+		reo_ent_ring->queue_addr_lo = reo_dest_ring->rx_mpdu_info.peer_meta_data;
+		queue_addr_hi = 0;
+	} else {
+		reo_ent_ring->queue_addr_lo = cpu_to_le32(lower_32_bits(rx_tid->paddr));
+		queue_addr_hi = upper_32_bits(rx_tid->paddr);
+	}
+
 	reo_ent_ring->info0 = le32_encode_bits(queue_addr_hi,
 					       HAL_REO_ENTR_RING_INFO0_QUEUE_ADDR_HI) |
 			      le32_encode_bits(dst_ind,
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 9f12ed84a653..76bb095c62e6 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -22,6 +22,7 @@ struct ath12k_base;
 #define HAL_MAX_AVAIL_BLK_RES			3
 
 #define HAL_RING_BASE_ALIGN	8
+#define HAL_REO_QLUT_ADDR_ALIGN 256
 
 #define HAL_WBM_IDLE_SCATTER_BUF_SIZE_MAX	32704
 /* TODO: Check with hw team on the supported scatter buf size */
@@ -40,6 +41,7 @@ struct ath12k_base;
 #define HAL_OFFSET_FROM_HP_TO_TP		4
 
 #define HAL_SHADOW_REG(x) (HAL_SHADOW_BASE_ADDR + (4 * (x)))
+#define HAL_REO_QDESC_MAX_PEERID		8191
 
 /* WCSS Relative address */
 #define HAL_SEQ_WCSS_CMEM_OFFSET		0x00100000
@@ -141,6 +143,8 @@ struct ath12k_base;
 #define HAL_REO1_DEST_RING_CTRL_IX_1		0x00000008
 #define HAL_REO1_DEST_RING_CTRL_IX_2		0x0000000c
 #define HAL_REO1_DEST_RING_CTRL_IX_3		0x00000010
+#define HAL_REO1_QDESC_ADDR(ab)		((ab)->hw_params->regs->hal_reo1_qdesc_addr)
+#define HAL_REO1_QDESC_MAX_PEERID(ab)	((ab)->hw_params->regs->hal_reo1_qdesc_max_peerid)
 #define HAL_REO1_SW_COOKIE_CFG0(ab)	((ab)->hw_params->regs->hal_reo1_sw_cookie_cfg0)
 #define HAL_REO1_SW_COOKIE_CFG1(ab)	((ab)->hw_params->regs->hal_reo1_sw_cookie_cfg1)
 #define HAL_REO1_QDESC_LUT_BASE0(ab)	((ab)->hw_params->regs->hal_reo1_qdesc_lut_base0)
@@ -328,6 +332,8 @@ struct ath12k_base;
 #define HAL_REO1_SW_COOKIE_CFG_ALIGN			BIT(18)
 #define HAL_REO1_SW_COOKIE_CFG_ENABLE			BIT(19)
 #define HAL_REO1_SW_COOKIE_CFG_GLOBAL_ENABLE		BIT(20)
+#define HAL_REO_QDESC_ADDR_READ_LUT_ENABLE		BIT(7)
+#define HAL_REO_QDESC_ADDR_READ_CLEAR_QDESC_ARRAY	BIT(6)
 
 /* CE ring bit field mask and shift */
 #define HAL_CE_DST_R0_DEST_CTRL_MAX_LEN			GENMASK(15, 0)
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 0ba6aedc8405..1d1a59819bbe 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -997,6 +997,8 @@ static const struct ath12k_hw_regs qcn9274_v2_regs = {
 	.hal_reo1_sw_cookie_cfg1 = 0x00000070,
 	.hal_reo1_qdesc_lut_base0 = 0x00000074,
 	.hal_reo1_qdesc_lut_base1 = 0x00000078,
+	.hal_reo1_qdesc_addr = 0x0000007c,
+	.hal_reo1_qdesc_max_peerid = 0x00000088,
 	.hal_reo1_ring_base_lsb = 0x00000500,
 	.hal_reo1_ring_base_msb = 0x00000504,
 	.hal_reo1_ring_id = 0x00000508,
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index d4a2e47169d9..a9fc24074c9f 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -311,6 +311,9 @@ struct ath12k_hw_regs {
 
 	u32 hal_tcl_status_ring_base_lsb;
 
+	u32 hal_reo1_qdesc_addr;
+	u32 hal_reo1_qdesc_max_peerid;
+
 	u32 hal_wbm_idle_ring_base_lsb;
 	u32 hal_wbm_idle_ring_misc_addr;
 	u32 hal_wbm_r0_idle_list_cntl_addr;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index c8248675354c..00b3c0f8741c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3684,7 +3684,8 @@ ath12k_fill_band_to_mac_param(struct ath12k_base  *soc,
 }
 
 static void
-ath12k_wmi_copy_resource_config(struct ath12k_wmi_resource_config_params *wmi_cfg,
+ath12k_wmi_copy_resource_config(struct ath12k_base *ab,
+				struct ath12k_wmi_resource_config_params *wmi_cfg,
 				struct ath12k_wmi_resource_config_arg *tg_cfg)
 {
 	wmi_cfg->num_vdevs = cpu_to_le32(tg_cfg->num_vdevs);
@@ -3751,6 +3752,9 @@ ath12k_wmi_copy_resource_config(struct ath12k_wmi_resource_config_params *wmi_cf
 					   WMI_RSRC_CFG_FLAGS2_RX_PEER_METADATA_VERSION);
 	wmi_cfg->host_service_flags = cpu_to_le32(tg_cfg->is_reg_cc_ext_event_supported <<
 				WMI_RSRC_CFG_HOST_SVC_FLAG_REG_CC_EXT_SUPPORT_BIT);
+	if (ab->hw_params->reoq_lut_support)
+		wmi_cfg->host_service_flags |=
+			cpu_to_le32(1 << WMI_RSRC_CFG_HOST_SVC_FLAG_REO_QREF_SUPPORT_BIT);
 	wmi_cfg->ema_max_vap_cnt = cpu_to_le32(tg_cfg->ema_max_vap_cnt);
 	wmi_cfg->ema_max_profile_period = cpu_to_le32(tg_cfg->ema_max_profile_period);
 	wmi_cfg->flags2 |= cpu_to_le32(WMI_RSRC_CFG_FLAGS2_CALC_NEXT_DTIM_COUNT_SET);
@@ -3791,7 +3795,7 @@ static int ath12k_init_cmd_send(struct ath12k_wmi_pdev *wmi,
 	ptr = skb->data + sizeof(*cmd);
 	cfg = ptr;
 
-	ath12k_wmi_copy_resource_config(cfg, &arg->res_cfg);
+	ath12k_wmi_copy_resource_config(ab, cfg, &arg->res_cfg);
 
 	cfg->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_RESOURCE_CONFIG,
 						 sizeof(*cfg));
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index be4ac91dd34f..bd7312f3cf24 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2461,6 +2461,7 @@ struct wmi_init_cmd {
 } __packed;
 
 #define WMI_RSRC_CFG_HOST_SVC_FLAG_REG_CC_EXT_SUPPORT_BIT 4
+#define WMI_RSRC_CFG_HOST_SVC_FLAG_REO_QREF_SUPPORT_BIT   12
 #define WMI_RSRC_CFG_FLAGS2_RX_PEER_METADATA_VERSION		GENMASK(5, 4)
 #define WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64	BIT(5)
 #define WMI_RSRC_CFG_FLAGS2_CALC_NEXT_DTIM_COUNT_SET      BIT(9)
-- 
2.17.1


