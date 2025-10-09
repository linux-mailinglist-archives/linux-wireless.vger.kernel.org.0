Return-Path: <linux-wireless+bounces-27906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FD2BC8B59
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 179274EFB1B
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B130B2DFA3B;
	Thu,  9 Oct 2025 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lo12PPDy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E62DFF33
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008278; cv=none; b=fDdTWoJIuBYYZqnwX9kn+V51FRCg8haqm89cMs2wX+DoNJvbjRxK+CeupBKVFC1SuGH8WNoFQXb1gkMlqWE7gRgvS4LsgJ14/UnjVSeyrZ4182gHPWM0Wff0PqkXS9Hxn4qmXid+SiccQDN/umcv4CWvt/5yBTEaHEdiTOJSxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008278; c=relaxed/simple;
	bh=NoljDGW6ig2gseRbIcYwKQDboyajoS02aoLVStS6viE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aO7K1XSB+OClHp/Luous8raafeaAHZUJh78OxiQKeb5pl3/lswNy5MZBGXCBc+vVTcbdXQwBxHKocCvUwtf50fd5t0XarPh92RmxBN7BIqZvunQMAiX2b+VqYhQFh2N8+bUQX4v63avfxiBeHSqsBUcaIwCpDvG2nLak+Vq5Z6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lo12PPDy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EIeb029053;
	Thu, 9 Oct 2025 11:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q8TQ99tXfOqrqk2Auad7QNvzwI+9fZ27eVUsbut1zoI=; b=Lo12PPDyf0hSfwVD
	Iuz/rLtYJXu34JLTa5xprM6AC8xxMrZXmFvhdZgZl/cnB+0zs/EDZFFeqPcrIERi
	I8JrQBMCQofCsHKCwpb2uh2S6N7IxzwQtnQdA73N02wsj+sk1N++OGfaZHTpr/Ze
	28vW0rL5Z+Tz/jw9Cai6VrjcBGCYseQoWFva4avlW1JcgilAMsmii443zACVEjWu
	/AjurmXW3/dcZpuUxJm7IfYhpGuAIRyGoWPpRcMOZiSSjLYgHEFELA8maptO4ubW
	+DsBZKePqaVe5EmZ/zgau/JansjiO5EuzZ/bYc8nnt5hsUgdKCPz0LJR1eKPbvTe
	05TbFA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kthbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BBDJO008440
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:13 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:11:12 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 08/18] wifi: ath12k: Move HAL CE setup and SRNG related APIs to wifi7 directory
Date: Thu, 9 Oct 2025 16:40:35 +0530
Message-ID: <20251009111045.1763001-9-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
References: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX4SlLYWD/7Tbz
 F3JJVhliL0ww6AxdTO5i+Csuva1u2N3Hxtvkw7MG771XtSlOVze7RAtDQymyfZbfIXcE5/mca0+
 GTq5lLhTeUqUWdOszh0+gWTkg/FeqhLooV5Pl7Lf34WfxFp8D8mVUSsQxShzlaDL0+C6gVQlxBN
 IMXtm/wjKwE2tOqv77y4ZlVKq3QJbXV8ijf3FvctjIXAh93KY7qPQcKp7SSCibU+LCzBjfXprZs
 7v5830ykXTP/G5kPNQUZ5tMiJPv2YveFxTWZ3aVV7O8HW3mms/616BsEFUSs7h5hQijmofgBg00
 iu+Wkhq0oI/KqGleyWHT6CoG17w+1ptNd3A6a54rUzEniThhH84mL6Nx+OX2jDrCC6e733QEFcW
 ohcT3Fuca/4oQv1+5a3qyhj23NBdYQ==
X-Authority-Analysis: v=2.4 cv=CbcFJbrl c=1 sm=1 tr=0 ts=68e79852 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=27DVpA_xr4Z5sDaGcpkA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 05fxNOC4jHTLBUaDc6nz3QIQsem1cdoO
X-Proofpoint-ORIG-GUID: 05fxNOC4jHTLBUaDc6nz3QIQsem1cdoO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move the hardware specific HAL APIs to hal.c file
inside wifi7 directory. These APIs will be called
through the hal_ops mechanism, which are registered
separately by qcn and wcn

Handling following APIs:
ath12k_wifi7_hal_ce_dst_setup
ath12k_wifi7_hal_srng_src_hw_init
ath12k_wifi7_hal_srng_dst_hw_init
ath12k_wifi7_hal_set_umac_srng_ptr_addr

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.c         | 260 +---------------
 drivers/net/wireless/ath/ath12k/hal.h         |   6 +
 drivers/net/wireless/ath/ath12k/wifi7/hal.c   | 277 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/hal.h   |   8 +
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |   4 +
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |   4 +
 6 files changed, 313 insertions(+), 246 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index fb369f464b2d..67a7285dc769 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -12,49 +12,28 @@
 #include "wifi7/hal_qcn9274.h"
 #include "wifi7/hal_wcn7850.h"
 
-static unsigned int ath12k_hal_reo1_ring_id_offset(struct ath12k_hal *hal)
-{
-	return HAL_REO1_RING_ID(hal) - HAL_REO1_RING_BASE_LSB(hal);
-}
-
-static unsigned int ath12k_hal_reo1_ring_msi1_base_lsb_offset(struct ath12k_hal *hal)
-{
-	return HAL_REO1_RING_MSI1_BASE_LSB(hal) - HAL_REO1_RING_BASE_LSB(hal);
-}
-
-static unsigned int ath12k_hal_reo1_ring_msi1_base_msb_offset(struct ath12k_hal *hal)
-{
-	return HAL_REO1_RING_MSI1_BASE_MSB(hal) - HAL_REO1_RING_BASE_LSB(hal);
-}
-
-static unsigned int ath12k_hal_reo1_ring_msi1_data_offset(struct ath12k_hal *hal)
-{
-	return HAL_REO1_RING_MSI1_DATA(hal) - HAL_REO1_RING_BASE_LSB(hal);
-}
-
-static unsigned int ath12k_hal_reo1_ring_base_msb_offset(struct ath12k_hal *hal)
-{
-	return HAL_REO1_RING_BASE_MSB(hal) - HAL_REO1_RING_BASE_LSB(hal);
-}
-
-static unsigned int ath12k_hal_reo1_ring_producer_int_setup_offset(struct ath12k_hal *hal)
+static void ath12k_hal_ce_dst_setup(struct ath12k_base *ab,
+				    struct hal_srng *srng, int ring_num)
 {
-	return HAL_REO1_RING_PRODUCER_INT_SETUP(hal) - HAL_REO1_RING_BASE_LSB(hal);
+	ab->hal.hal_ops->ce_dst_setup(ab, srng, ring_num);
 }
 
-static unsigned int ath12k_hal_reo1_ring_hp_addr_lsb_offset(struct ath12k_hal *hal)
+static void ath12k_hal_srng_src_hw_init(struct ath12k_base *ab,
+					struct hal_srng *srng)
 {
-	return HAL_REO1_RING_HP_ADDR_LSB(hal) - HAL_REO1_RING_BASE_LSB(hal);
+	ab->hal.hal_ops->srng_src_hw_init(ab, srng);
 }
 
-static unsigned int ath12k_hal_reo1_ring_hp_addr_msb_offset(struct ath12k_hal *hal)
+static void ath12k_hal_srng_dst_hw_init(struct ath12k_base *ab,
+					struct hal_srng *srng)
 {
-	return HAL_REO1_RING_HP_ADDR_MSB(hal) - HAL_REO1_RING_BASE_LSB(hal);
+	ab->hal.hal_ops->srng_dst_hw_init(ab, srng);
 }
 
-static unsigned int ath12k_hal_reo1_ring_misc_offset(struct ath12k_hal *hal)
+static void ath12k_hal_set_umac_srng_ptr_addr(struct ath12k_base *ab,
+					      struct hal_srng *srng)
 {
-	return HAL_REO1_RING_MISC(hal) - HAL_REO1_RING_BASE_LSB(hal);
+	ab->hal.hal_ops->set_umac_srng_ptr_addr(ab, srng);
 }
 
 static int ath12k_hal_alloc_cont_rdp(struct ath12k_hal *hal)
@@ -109,195 +88,6 @@ static void ath12k_hal_free_cont_wrp(struct ath12k_hal *hal)
 	hal->wrp.vaddr = NULL;
 }
 
-static void ath12k_hal_ce_dst_setup(struct ath12k_base *ab,
-				    struct hal_srng *srng, int ring_num)
-{
-	struct hal_srng_config *srng_config = &ab->hal.srng_config[HAL_CE_DST];
-	u32 addr;
-	u32 val;
-
-	addr = HAL_CE_DST_RING_CTRL +
-	       srng_config->reg_start[HAL_SRNG_REG_GRP_R0] +
-	       ring_num * srng_config->reg_size[HAL_SRNG_REG_GRP_R0];
-
-	val = ath12k_hif_read32(ab, addr);
-	val &= ~HAL_CE_DST_R0_DEST_CTRL_MAX_LEN;
-	val |= u32_encode_bits(srng->u.dst_ring.max_buffer_length,
-			       HAL_CE_DST_R0_DEST_CTRL_MAX_LEN);
-	ath12k_hif_write32(ab, addr, val);
-}
-
-static void ath12k_hal_srng_dst_hw_init(struct ath12k_base *ab,
-					struct hal_srng *srng)
-{
-	struct ath12k_hal *hal = &ab->hal;
-	u32 val;
-	u64 hp_addr;
-	u32 reg_base;
-
-	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R0];
-
-	if (srng->flags & HAL_SRNG_FLAGS_MSI_INTR) {
-		ath12k_hif_write32(ab, reg_base +
-				   ath12k_hal_reo1_ring_msi1_base_lsb_offset(hal),
-				   srng->msi_addr);
-
-		val = u32_encode_bits(((u64)srng->msi_addr >> HAL_ADDR_MSB_REG_SHIFT),
-				      HAL_REO1_RING_MSI1_BASE_MSB_ADDR) |
-				      HAL_REO1_RING_MSI1_BASE_MSB_MSI1_ENABLE;
-		ath12k_hif_write32(ab, reg_base +
-				   ath12k_hal_reo1_ring_msi1_base_msb_offset(hal), val);
-
-		ath12k_hif_write32(ab,
-				   reg_base + ath12k_hal_reo1_ring_msi1_data_offset(hal),
-				   srng->msi_data);
-	}
-
-	ath12k_hif_write32(ab, reg_base, srng->ring_base_paddr);
-
-	val = u32_encode_bits(((u64)srng->ring_base_paddr >> HAL_ADDR_MSB_REG_SHIFT),
-			      HAL_REO1_RING_BASE_MSB_RING_BASE_ADDR_MSB) |
-	      u32_encode_bits((srng->entry_size * srng->num_entries),
-			      HAL_REO1_RING_BASE_MSB_RING_SIZE);
-	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_base_msb_offset(hal), val);
-
-	val = u32_encode_bits(srng->ring_id, HAL_REO1_RING_ID_RING_ID) |
-	      u32_encode_bits(srng->entry_size, HAL_REO1_RING_ID_ENTRY_SIZE);
-	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_id_offset(hal), val);
-
-	/* interrupt setup */
-	val = u32_encode_bits((srng->intr_timer_thres_us >> 3),
-			      HAL_REO1_RING_PRDR_INT_SETUP_INTR_TMR_THOLD);
-
-	val |= u32_encode_bits((srng->intr_batch_cntr_thres_entries * srng->entry_size),
-				HAL_REO1_RING_PRDR_INT_SETUP_BATCH_COUNTER_THOLD);
-
-	ath12k_hif_write32(ab,
-			   reg_base + ath12k_hal_reo1_ring_producer_int_setup_offset(hal),
-			   val);
-
-	hp_addr = hal->rdp.paddr +
-		  ((unsigned long)srng->u.dst_ring.hp_addr -
-		   (unsigned long)hal->rdp.vaddr);
-	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_hp_addr_lsb_offset(hal),
-			   hp_addr & HAL_ADDR_LSB_REG_MASK);
-	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_hp_addr_msb_offset(hal),
-			   hp_addr >> HAL_ADDR_MSB_REG_SHIFT);
-
-	/* Initialize head and tail pointers to indicate ring is empty */
-	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R2];
-	ath12k_hif_write32(ab, reg_base, 0);
-	ath12k_hif_write32(ab, reg_base + HAL_REO1_RING_TP_OFFSET, 0);
-	*srng->u.dst_ring.hp_addr = 0;
-
-	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R0];
-	val = 0;
-	if (srng->flags & HAL_SRNG_FLAGS_DATA_TLV_SWAP)
-		val |= HAL_REO1_RING_MISC_DATA_TLV_SWAP;
-	if (srng->flags & HAL_SRNG_FLAGS_RING_PTR_SWAP)
-		val |= HAL_REO1_RING_MISC_HOST_FW_SWAP;
-	if (srng->flags & HAL_SRNG_FLAGS_MSI_SWAP)
-		val |= HAL_REO1_RING_MISC_MSI_SWAP;
-	val |= HAL_REO1_RING_MISC_SRNG_ENABLE;
-
-	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_misc_offset(hal), val);
-}
-
-static void ath12k_hal_srng_src_hw_init(struct ath12k_base *ab,
-					struct hal_srng *srng)
-{
-	struct ath12k_hal *hal = &ab->hal;
-	u32 val;
-	u64 tp_addr;
-	u32 reg_base;
-
-	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R0];
-
-	if (srng->flags & HAL_SRNG_FLAGS_MSI_INTR) {
-		ath12k_hif_write32(ab, reg_base +
-				   HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET(hal),
-				   srng->msi_addr);
-
-		val = u32_encode_bits(((u64)srng->msi_addr >> HAL_ADDR_MSB_REG_SHIFT),
-				      HAL_TCL1_RING_MSI1_BASE_MSB_ADDR) |
-				      HAL_TCL1_RING_MSI1_BASE_MSB_MSI1_ENABLE;
-		ath12k_hif_write32(ab, reg_base +
-				       HAL_TCL1_RING_MSI1_BASE_MSB_OFFSET(hal),
-				   val);
-
-		ath12k_hif_write32(ab, reg_base +
-				       HAL_TCL1_RING_MSI1_DATA_OFFSET(hal),
-				   srng->msi_data);
-	}
-
-	ath12k_hif_write32(ab, reg_base, srng->ring_base_paddr);
-
-	val = u32_encode_bits(((u64)srng->ring_base_paddr >> HAL_ADDR_MSB_REG_SHIFT),
-			      HAL_TCL1_RING_BASE_MSB_RING_BASE_ADDR_MSB) |
-	      u32_encode_bits((srng->entry_size * srng->num_entries),
-			      HAL_TCL1_RING_BASE_MSB_RING_SIZE);
-	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_BASE_MSB_OFFSET(hal), val);
-
-	val = u32_encode_bits(srng->entry_size, HAL_REO1_RING_ID_ENTRY_SIZE);
-	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_ID_OFFSET(hal), val);
-
-	val = u32_encode_bits(srng->intr_timer_thres_us,
-			      HAL_TCL1_RING_CONSR_INT_SETUP_IX0_INTR_TMR_THOLD);
-
-	val |= u32_encode_bits((srng->intr_batch_cntr_thres_entries * srng->entry_size),
-			       HAL_TCL1_RING_CONSR_INT_SETUP_IX0_BATCH_COUNTER_THOLD);
-
-	ath12k_hif_write32(ab,
-			   reg_base + HAL_TCL1_RING_CONSR_INT_SETUP_IX0_OFFSET(hal),
-			   val);
-
-	val = 0;
-	if (srng->flags & HAL_SRNG_FLAGS_LOW_THRESH_INTR_EN) {
-		val |= u32_encode_bits(srng->u.src_ring.low_threshold,
-				       HAL_TCL1_RING_CONSR_INT_SETUP_IX1_LOW_THOLD);
-	}
-	ath12k_hif_write32(ab,
-			   reg_base + HAL_TCL1_RING_CONSR_INT_SETUP_IX1_OFFSET(hal),
-			   val);
-
-	if (srng->ring_id != HAL_SRNG_RING_ID_WBM_IDLE_LINK) {
-		tp_addr = hal->rdp.paddr +
-			  ((unsigned long)srng->u.src_ring.tp_addr -
-			   (unsigned long)hal->rdp.vaddr);
-		ath12k_hif_write32(ab,
-				   reg_base + HAL_TCL1_RING_TP_ADDR_LSB_OFFSET(hal),
-				   tp_addr & HAL_ADDR_LSB_REG_MASK);
-		ath12k_hif_write32(ab,
-				   reg_base + HAL_TCL1_RING_TP_ADDR_MSB_OFFSET(hal),
-				   tp_addr >> HAL_ADDR_MSB_REG_SHIFT);
-	}
-
-	/* Initialize head and tail pointers to indicate ring is empty */
-	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R2];
-	ath12k_hif_write32(ab, reg_base, 0);
-	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_TP_OFFSET, 0);
-	*srng->u.src_ring.tp_addr = 0;
-
-	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R0];
-	val = 0;
-	if (srng->flags & HAL_SRNG_FLAGS_DATA_TLV_SWAP)
-		val |= HAL_TCL1_RING_MISC_DATA_TLV_SWAP;
-	if (srng->flags & HAL_SRNG_FLAGS_RING_PTR_SWAP)
-		val |= HAL_TCL1_RING_MISC_HOST_FW_SWAP;
-	if (srng->flags & HAL_SRNG_FLAGS_MSI_SWAP)
-		val |= HAL_TCL1_RING_MISC_MSI_SWAP;
-
-	/* Loop count is not used for SRC rings */
-	val |= HAL_TCL1_RING_MISC_MSI_LOOPCNT_DISABLE;
-
-	val |= HAL_TCL1_RING_MISC_SRNG_ENABLE;
-
-	if (srng->ring_id == HAL_SRNG_RING_ID_WBM_IDLE_LINK)
-		val |= HAL_TCL1_RING_MISC_MSI_RING_ID_DISABLE;
-
-	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_MISC_OFFSET(hal), val);
-}
-
 static void ath12k_hal_srng_hw_init(struct ath12k_base *ab,
 				    struct hal_srng *srng)
 {
@@ -828,7 +618,6 @@ int ath12k_hal_srng_setup(struct ath12k_base *ab, enum hal_ring_type type,
 	int ring_id;
 	u32 idx;
 	int i;
-	u32 reg_base;
 
 	ring_id = ath12k_hal_srng_get_ring_id(ab, type, ring_num, mac_id);
 	if (ring_id < 0)
@@ -863,8 +652,6 @@ int ath12k_hal_srng_setup(struct ath12k_base *ab, enum hal_ring_type type,
 	memset(srng->ring_base_vaddr, 0,
 	       (srng->entry_size * srng->num_entries) << 2);
 
-	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R2];
-
 	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 		srng->u.src_ring.hp = 0;
 		srng->u.src_ring.cached_tp = 0;
@@ -873,16 +660,7 @@ int ath12k_hal_srng_setup(struct ath12k_base *ab, enum hal_ring_type type,
 		srng->u.src_ring.low_threshold = params->low_threshold *
 						 srng->entry_size;
 		if (srng_config->mac_type == ATH12K_HAL_SRNG_UMAC) {
-			if (!ab->hw_params->supports_shadow_regs)
-				srng->u.src_ring.hp_addr =
-					(u32 *)((unsigned long)ab->mem + reg_base);
-			else
-				ath12k_dbg(ab, ATH12K_DBG_HAL,
-					   "hal type %d ring_num %d reg_base 0x%x shadow 0x%lx\n",
-					   type, ring_num,
-					   reg_base,
-					   (unsigned long)srng->u.src_ring.hp_addr -
-					   (unsigned long)ab->mem);
+			ath12k_hal_set_umac_srng_ptr_addr(ab, srng);
 		} else {
 			idx = ring_id - HAL_SRNG_RING_ID_DMAC_CMN_ID_START;
 			srng->u.src_ring.hp_addr = (void *)(hal->wrp.vaddr +
@@ -903,17 +681,7 @@ int ath12k_hal_srng_setup(struct ath12k_base *ab, enum hal_ring_type type,
 		srng->u.dst_ring.cached_hp = 0;
 		srng->u.dst_ring.hp_addr = (void *)(hal->rdp.vaddr + ring_id);
 		if (srng_config->mac_type == ATH12K_HAL_SRNG_UMAC) {
-			if (!ab->hw_params->supports_shadow_regs)
-				srng->u.dst_ring.tp_addr =
-					(u32 *)((unsigned long)ab->mem + reg_base +
-					(HAL_REO1_RING_TP - HAL_REO1_RING_HP));
-			else
-				ath12k_dbg(ab, ATH12K_DBG_HAL,
-					   "type %d ring_num %d target_reg 0x%x shadow 0x%lx\n",
-					   type, ring_num,
-					   reg_base + HAL_REO1_RING_TP - HAL_REO1_RING_HP,
-					   (unsigned long)srng->u.dst_ring.tp_addr -
-					   (unsigned long)ab->mem);
+			ath12k_hal_set_umac_srng_ptr_addr(ab, srng);
 		} else {
 			/* For PMAC & DMAC rings, tail pointer updates will be done
 			 * through FW by writing to a shared memory location
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 087e9a08f628..32c6a7d5ea99 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1696,6 +1696,12 @@ struct hal_ops {
 	u32 (*rx_desc_get_mpdu_ppdu_id)(struct hal_rx_desc *desc);
 	u8 (*rx_desc_get_l3_pad_bytes)(struct hal_rx_desc *desc);
 	u8 *(*rx_desc_get_msdu_payload)(struct hal_rx_desc *desc);
+	void (*ce_dst_setup)(struct ath12k_base *ab,
+			     struct hal_srng *srng, int ring_num);
+	void (*set_umac_srng_ptr_addr)(struct ath12k_base *ab,
+				       struct hal_srng *srng);
+	void (*srng_src_hw_init)(struct ath12k_base *ab, struct hal_srng *srng);
+	void (*srng_dst_hw_init)(struct ath12k_base *ab, struct hal_srng *srng);
 };
 
 u32 ath12k_wifi7_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index 25963ac18cb9..2b81d70e60df 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -7,6 +7,8 @@
 #include "hal_desc.h"
 #include "../hal.h"
 #include "hal.h"
+#include "../debug.h"
+#include "../hif.h"
 #include "hal_qcn9274.h"
 #include "hal_wcn7850.h"
 
@@ -56,3 +58,278 @@ int ath12k_wifi7_hal_init(struct ath12k_base *ab)
 	return 0;
 }
 EXPORT_SYMBOL(ath12k_wifi7_hal_init);
+
+static unsigned int ath12k_wifi7_hal_reo1_ring_id_offset(struct ath12k_hal *hal)
+{
+	return HAL_REO1_RING_ID(hal) - HAL_REO1_RING_BASE_LSB(hal);
+}
+
+static unsigned
+int ath12k_wifi7_hal_reo1_ring_msi1_base_lsb_offset(struct ath12k_hal *hal)
+{
+	return HAL_REO1_RING_MSI1_BASE_LSB(hal) - HAL_REO1_RING_BASE_LSB(hal);
+}
+
+static unsigned
+int ath12k_wifi7_hal_reo1_ring_msi1_base_msb_offset(struct ath12k_hal *hal)
+{
+	return HAL_REO1_RING_MSI1_BASE_MSB(hal) - HAL_REO1_RING_BASE_LSB(hal);
+}
+
+static unsigned int ath12k_wifi7_hal_reo1_ring_msi1_data_offset(struct ath12k_hal *hal)
+{
+	return HAL_REO1_RING_MSI1_DATA(hal) - HAL_REO1_RING_BASE_LSB(hal);
+}
+
+static unsigned int ath12k_wifi7_hal_reo1_ring_base_msb_offset(struct ath12k_hal *hal)
+{
+	return HAL_REO1_RING_BASE_MSB(hal) - HAL_REO1_RING_BASE_LSB(hal);
+}
+
+static unsigned
+int ath12k_wifi7_hal_reo1_ring_producer_int_setup_offset(struct ath12k_hal *hal)
+{
+	return HAL_REO1_RING_PRODUCER_INT_SETUP(hal) - HAL_REO1_RING_BASE_LSB(hal);
+}
+
+static unsigned int ath12k_wifi7_hal_reo1_ring_hp_addr_lsb_offset(struct ath12k_hal *hal)
+{
+	return HAL_REO1_RING_HP_ADDR_LSB(hal) - HAL_REO1_RING_BASE_LSB(hal);
+}
+
+static unsigned int ath12k_wifi7_hal_reo1_ring_hp_addr_msb_offset(struct ath12k_hal *hal)
+{
+	return HAL_REO1_RING_HP_ADDR_MSB(hal) - HAL_REO1_RING_BASE_LSB(hal);
+}
+
+static unsigned int ath12k_wifi7_hal_reo1_ring_misc_offset(struct ath12k_hal *hal)
+{
+	return HAL_REO1_RING_MISC(hal) - HAL_REO1_RING_BASE_LSB(hal);
+}
+
+void ath12k_wifi7_hal_ce_dst_setup(struct ath12k_base *ab,
+				   struct hal_srng *srng, int ring_num)
+{
+	struct hal_srng_config *srng_config = &ab->hal.srng_config[HAL_CE_DST];
+	u32 addr;
+	u32 val;
+
+	addr = HAL_CE_DST_RING_CTRL +
+	       srng_config->reg_start[HAL_SRNG_REG_GRP_R0] +
+	       ring_num * srng_config->reg_size[HAL_SRNG_REG_GRP_R0];
+
+	val = ath12k_hif_read32(ab, addr);
+	val &= ~HAL_CE_DST_R0_DEST_CTRL_MAX_LEN;
+	val |= u32_encode_bits(srng->u.dst_ring.max_buffer_length,
+			       HAL_CE_DST_R0_DEST_CTRL_MAX_LEN);
+	ath12k_hif_write32(ab, addr, val);
+}
+
+void ath12k_wifi7_hal_srng_dst_hw_init(struct ath12k_base *ab,
+				       struct hal_srng *srng)
+{
+	struct ath12k_hal *hal = &ab->hal;
+	u32 val;
+	u64 hp_addr;
+	u32 reg_base;
+
+	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R0];
+
+	if (srng->flags & HAL_SRNG_FLAGS_MSI_INTR) {
+		ath12k_hif_write32(ab, reg_base +
+				   ath12k_wifi7_hal_reo1_ring_msi1_base_lsb_offset(hal),
+				   srng->msi_addr);
+
+		val = u32_encode_bits(((u64)srng->msi_addr >> HAL_ADDR_MSB_REG_SHIFT),
+				      HAL_REO1_RING_MSI1_BASE_MSB_ADDR) |
+				      HAL_REO1_RING_MSI1_BASE_MSB_MSI1_ENABLE;
+		ath12k_hif_write32(ab, reg_base +
+				   ath12k_wifi7_hal_reo1_ring_msi1_base_msb_offset(hal),
+				   val);
+
+		ath12k_hif_write32(ab,
+				   reg_base +
+				   ath12k_wifi7_hal_reo1_ring_msi1_data_offset(hal),
+				   srng->msi_data);
+	}
+
+	ath12k_hif_write32(ab, reg_base, srng->ring_base_paddr);
+
+	val = u32_encode_bits(((u64)srng->ring_base_paddr >> HAL_ADDR_MSB_REG_SHIFT),
+			      HAL_REO1_RING_BASE_MSB_RING_BASE_ADDR_MSB) |
+	      u32_encode_bits((srng->entry_size * srng->num_entries),
+			      HAL_REO1_RING_BASE_MSB_RING_SIZE);
+	ath12k_hif_write32(ab, reg_base + ath12k_wifi7_hal_reo1_ring_base_msb_offset(hal),
+			   val);
+
+	val = u32_encode_bits(srng->ring_id, HAL_REO1_RING_ID_RING_ID) |
+	      u32_encode_bits(srng->entry_size, HAL_REO1_RING_ID_ENTRY_SIZE);
+	ath12k_hif_write32(ab, reg_base + ath12k_wifi7_hal_reo1_ring_id_offset(hal), val);
+
+	/* interrupt setup */
+	val = u32_encode_bits((srng->intr_timer_thres_us >> 3),
+			      HAL_REO1_RING_PRDR_INT_SETUP_INTR_TMR_THOLD);
+
+	val |= u32_encode_bits((srng->intr_batch_cntr_thres_entries * srng->entry_size),
+				HAL_REO1_RING_PRDR_INT_SETUP_BATCH_COUNTER_THOLD);
+
+	ath12k_hif_write32(ab,
+			   reg_base +
+			   ath12k_wifi7_hal_reo1_ring_producer_int_setup_offset(hal),
+			   val);
+
+	hp_addr = hal->rdp.paddr +
+		  ((unsigned long)srng->u.dst_ring.hp_addr -
+		   (unsigned long)hal->rdp.vaddr);
+	ath12k_hif_write32(ab, reg_base +
+			   ath12k_wifi7_hal_reo1_ring_hp_addr_lsb_offset(hal),
+			   hp_addr & HAL_ADDR_LSB_REG_MASK);
+	ath12k_hif_write32(ab, reg_base +
+			   ath12k_wifi7_hal_reo1_ring_hp_addr_msb_offset(hal),
+			   hp_addr >> HAL_ADDR_MSB_REG_SHIFT);
+
+	/* Initialize head and tail pointers to indicate ring is empty */
+	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R2];
+	ath12k_hif_write32(ab, reg_base, 0);
+	ath12k_hif_write32(ab, reg_base + HAL_REO1_RING_TP_OFFSET, 0);
+	*srng->u.dst_ring.hp_addr = 0;
+
+	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R0];
+	val = 0;
+	if (srng->flags & HAL_SRNG_FLAGS_DATA_TLV_SWAP)
+		val |= HAL_REO1_RING_MISC_DATA_TLV_SWAP;
+	if (srng->flags & HAL_SRNG_FLAGS_RING_PTR_SWAP)
+		val |= HAL_REO1_RING_MISC_HOST_FW_SWAP;
+	if (srng->flags & HAL_SRNG_FLAGS_MSI_SWAP)
+		val |= HAL_REO1_RING_MISC_MSI_SWAP;
+	val |= HAL_REO1_RING_MISC_SRNG_ENABLE;
+
+	ath12k_hif_write32(ab, reg_base + ath12k_wifi7_hal_reo1_ring_misc_offset(hal),
+			   val);
+}
+
+void ath12k_wifi7_hal_srng_src_hw_init(struct ath12k_base *ab,
+				       struct hal_srng *srng)
+{
+	struct ath12k_hal *hal = &ab->hal;
+	u32 val;
+	u64 tp_addr;
+	u32 reg_base;
+
+	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R0];
+
+	if (srng->flags & HAL_SRNG_FLAGS_MSI_INTR) {
+		ath12k_hif_write32(ab, reg_base +
+				   HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET(hal),
+				   srng->msi_addr);
+
+		val = u32_encode_bits(((u64)srng->msi_addr >> HAL_ADDR_MSB_REG_SHIFT),
+				      HAL_TCL1_RING_MSI1_BASE_MSB_ADDR) |
+				      HAL_TCL1_RING_MSI1_BASE_MSB_MSI1_ENABLE;
+		ath12k_hif_write32(ab, reg_base +
+				       HAL_TCL1_RING_MSI1_BASE_MSB_OFFSET(hal),
+				   val);
+
+		ath12k_hif_write32(ab, reg_base +
+				       HAL_TCL1_RING_MSI1_DATA_OFFSET(hal),
+				   srng->msi_data);
+	}
+
+	ath12k_hif_write32(ab, reg_base, srng->ring_base_paddr);
+
+	val = u32_encode_bits(((u64)srng->ring_base_paddr >> HAL_ADDR_MSB_REG_SHIFT),
+			      HAL_TCL1_RING_BASE_MSB_RING_BASE_ADDR_MSB) |
+	      u32_encode_bits((srng->entry_size * srng->num_entries),
+			      HAL_TCL1_RING_BASE_MSB_RING_SIZE);
+	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_BASE_MSB_OFFSET(hal), val);
+
+	val = u32_encode_bits(srng->entry_size, HAL_REO1_RING_ID_ENTRY_SIZE);
+	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_ID_OFFSET(hal), val);
+
+	val = u32_encode_bits(srng->intr_timer_thres_us,
+			      HAL_TCL1_RING_CONSR_INT_SETUP_IX0_INTR_TMR_THOLD);
+
+	val |= u32_encode_bits((srng->intr_batch_cntr_thres_entries * srng->entry_size),
+			       HAL_TCL1_RING_CONSR_INT_SETUP_IX0_BATCH_COUNTER_THOLD);
+
+	ath12k_hif_write32(ab,
+			   reg_base + HAL_TCL1_RING_CONSR_INT_SETUP_IX0_OFFSET(hal),
+			   val);
+
+	val = 0;
+	if (srng->flags & HAL_SRNG_FLAGS_LOW_THRESH_INTR_EN) {
+		val |= u32_encode_bits(srng->u.src_ring.low_threshold,
+				       HAL_TCL1_RING_CONSR_INT_SETUP_IX1_LOW_THOLD);
+	}
+	ath12k_hif_write32(ab,
+			   reg_base + HAL_TCL1_RING_CONSR_INT_SETUP_IX1_OFFSET(hal),
+			   val);
+
+	if (srng->ring_id != HAL_SRNG_RING_ID_WBM_IDLE_LINK) {
+		tp_addr = hal->rdp.paddr +
+			  ((unsigned long)srng->u.src_ring.tp_addr -
+			   (unsigned long)hal->rdp.vaddr);
+		ath12k_hif_write32(ab,
+				   reg_base + HAL_TCL1_RING_TP_ADDR_LSB_OFFSET(hal),
+				   tp_addr & HAL_ADDR_LSB_REG_MASK);
+		ath12k_hif_write32(ab,
+				   reg_base + HAL_TCL1_RING_TP_ADDR_MSB_OFFSET(hal),
+				   tp_addr >> HAL_ADDR_MSB_REG_SHIFT);
+	}
+
+	/* Initialize head and tail pointers to indicate ring is empty */
+	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R2];
+	ath12k_hif_write32(ab, reg_base, 0);
+	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_TP_OFFSET, 0);
+	*srng->u.src_ring.tp_addr = 0;
+
+	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R0];
+	val = 0;
+	if (srng->flags & HAL_SRNG_FLAGS_DATA_TLV_SWAP)
+		val |= HAL_TCL1_RING_MISC_DATA_TLV_SWAP;
+	if (srng->flags & HAL_SRNG_FLAGS_RING_PTR_SWAP)
+		val |= HAL_TCL1_RING_MISC_HOST_FW_SWAP;
+	if (srng->flags & HAL_SRNG_FLAGS_MSI_SWAP)
+		val |= HAL_TCL1_RING_MISC_MSI_SWAP;
+
+	/* Loop count is not used for SRC rings */
+	val |= HAL_TCL1_RING_MISC_MSI_LOOPCNT_DISABLE;
+
+	val |= HAL_TCL1_RING_MISC_SRNG_ENABLE;
+
+	if (srng->ring_id == HAL_SRNG_RING_ID_WBM_IDLE_LINK)
+		val |= HAL_TCL1_RING_MISC_MSI_RING_ID_DISABLE;
+
+	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_MISC_OFFSET(hal), val);
+}
+
+void ath12k_wifi7_hal_set_umac_srng_ptr_addr(struct ath12k_base *ab,
+					     struct hal_srng *srng)
+{
+	u32 reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R2];
+
+	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
+		if (!ab->hw_params->supports_shadow_regs) {
+			srng->u.src_ring.hp_addr =
+				(u32 *)((unsigned long)ab->mem + reg_base);
+		} else {
+			ath12k_dbg(ab, ATH12K_DBG_HAL,
+				   "hal reg_base 0x%x shadow 0x%lx\n",
+				   reg_base,
+				   (unsigned long)srng->u.src_ring.hp_addr -
+				   (unsigned long)ab->mem);
+		}
+	} else  {
+		if (!ab->hw_params->supports_shadow_regs) {
+			srng->u.dst_ring.tp_addr =
+				(u32 *)((unsigned long)ab->mem + reg_base +
+						(HAL_REO1_RING_TP - HAL_REO1_RING_HP));
+		} else {
+			ath12k_dbg(ab, ATH12K_DBG_HAL,
+				   "target_reg 0x%x shadow 0x%lx\n",
+				   reg_base + HAL_REO1_RING_TP - HAL_REO1_RING_HP,
+				   (unsigned long)srng->u.dst_ring.tp_addr -
+				   (unsigned long)ab->mem);
+		}
+	}
+}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.h b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
index 1a8a720c4923..044ed1dce323 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
@@ -8,4 +8,12 @@
 #define ATH12K_HAL_WIFI7_H
 
 int ath12k_wifi7_hal_init(struct ath12k_base *ab);
+void ath12k_wifi7_hal_ce_dst_setup(struct ath12k_base *ab,
+				   struct hal_srng *srng, int ring_num);
+void ath12k_wifi7_hal_srng_dst_hw_init(struct ath12k_base *ab,
+				       struct hal_srng *srng);
+void ath12k_wifi7_hal_srng_src_hw_init(struct ath12k_base *ab,
+				       struct hal_srng *srng);
+void ath12k_wifi7_hal_set_umac_srng_ptr_addr(struct ath12k_base *ab,
+					     struct hal_srng *srng);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index 592007f1cad6..070e28a38a70 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -1000,5 +1000,9 @@ const struct hal_ops hal_qcn9274_ops = {
 	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274,
 	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcn9274,
 	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_qcn9274,
+	.ce_dst_setup = ath12k_wifi7_hal_ce_dst_setup,
+	.srng_src_hw_init = ath12k_wifi7_hal_srng_src_hw_init,
+	.srng_dst_hw_init = ath12k_wifi7_hal_srng_dst_hw_init,
+	.set_umac_srng_ptr_addr = ath12k_wifi7_hal_set_umac_srng_ptr_addr,
 };
 EXPORT_SYMBOL(hal_qcn9274_ops);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 8949b6fc833a..9d1f94db60bd 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -815,5 +815,9 @@ const struct hal_ops hal_wcn7850_ops = {
 	.rx_desc_get_mpdu_start_tag = ath12k_hal_rx_desc_get_mpdu_start_tag_wcn7850,
 	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_wcn7850,
 	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_wcn7850,
+	.ce_dst_setup = ath12k_wifi7_hal_ce_dst_setup,
+	.srng_src_hw_init = ath12k_wifi7_hal_srng_src_hw_init,
+	.srng_dst_hw_init = ath12k_wifi7_hal_srng_dst_hw_init,
+	.set_umac_srng_ptr_addr = ath12k_wifi7_hal_set_umac_srng_ptr_addr,
 };
 EXPORT_SYMBOL(hal_wcn7850_ops);
-- 
2.34.1


