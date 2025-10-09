Return-Path: <linux-wireless+bounces-27905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DA6BC8B56
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B3F44E7C28
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0272DF3F9;
	Thu,  9 Oct 2025 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XiIxnA6t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54712E0914
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008276; cv=none; b=ENOomuDes4/p32qNyBS3SnalRTJHNe71W32i1Mi6giwfJVvzrkgV6/OgvIJMHGQNjD37t3A8bB72mcWE7BunlWqMZbSK7rZNi6lk9s0Wa46wrygSMkX2+Gbhx3F/eNa7yc8P9zPJNF3XNEtgZMIgeWW9RtRBOzh/hJJPbOpJDEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008276; c=relaxed/simple;
	bh=44GHatLBNB9VJI4ZyfRQ39meBMRAVuMqVZpNmGmSpX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0RVg0/Nkeb25+ty4tpa2cep3qT+LR51oLUYZfNX1jSo4flxZw28Tsv9ZvlAJxrheqZUlN/gz6+tpTBroKXwtpwIsE4c9sa/zwaFe0owkdlOYp876cgEUxOILgstDivpgFHVUYWj7UmkDzVOVLQ80/6sXXFm/aB/NLcdM5qM8Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XiIxnA6t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EJCf023282;
	Thu, 9 Oct 2025 11:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TZctVVBK95jAmmoArA+gAP76cwgSmuul0A5t3yWQb9A=; b=XiIxnA6tbNaNyMh4
	eA/jt9+bqlYkYofhf+vSjNcR3+C0lNfNE6WgFuN63Z+n+i0HRP6dtipc7jfkH5zt
	fguZon/+B9WflhmnPmkVfCMmQyRxCkQVhoKON/kcj8TvPNExl1VFEUWVDKW/yHCQ
	ai5kRfS9A9Ex1YGlarqrxp23YBmtnXpQy9fclihc829vs0/zvoBB3TRZGrC0oqmo
	9xu7zEkB50+8Jg1tmnUc+tyEvE5PeajgUSmHCH0XbGPJtNhXAtbTZIMkZZvho/jN
	nBqTAZrXk24K87SJcVkKUBusrk8eFm/HJJnSlrBnQ1pkXJN56uFJPigv6Si63ATr
	Ay4LJQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4m2hrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BB9g0024572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:09 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:11:07 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 05/18] wifi: ath12k: Move hal_params and regs to hal from hw
Date: Thu, 9 Oct 2025 16:40:32 +0530
Message-ID: <20251009111045.1763001-6-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX+EBe0Z4oJhJP
 PtrVNLfxxhDtoTvqU4W0Jc2C+sZK+whCQaxcQqjZKyqGrfkw/CIgG8DR0Pd/0pM4Uwgf2r781/q
 hqaA32VHyg4vp7qjgsEQ4M0Xcv/TArFibNxRykNgd/pXP8tv2H9t8uxJPn9zOKEMDR9wppJgXjr
 8RlvO/0bRCLV6iKQ007+7naz3w9bXK90n2bbS7I08vG6G4kiRREnISF2YYQcwc72Lov7vYKA/m/
 IrwN9hJUwMCxj3xhppkghYxfxySr3Qi2xMER5I2LPneyB/7fFeXhlMA8UUH5f1cuLkkU0sHpG8U
 eveS3+rPZIGy7xfqS6PknXA+wqYvxIjJg7haDt4v7rHhi0eMbDYTNrC29IM8Q8Pb/ZcPE+TeyJq
 3KrlZejJZkeLNY0JkjDxEcBJAhJfCg==
X-Authority-Analysis: v=2.4 cv=B6G0EetM c=1 sm=1 tr=0 ts=68e7984d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=nVXscRQj6b5d_olxpLsA:9
 a=4_4FWhMwoNWkI50s:21 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: zeH4WdWAQrWyOLMWXg3hqouHivY1xBMU
X-Proofpoint-ORIG-GUID: zeH4WdWAQrWyOLMWXg3hqouHivY1xBMU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move hal_params and regs to hal structure from
the hw structure, since these parameters are used by hal layer
and make corresponding initializations in hal_init.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c          |   2 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c      |   4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c       |   2 +-
 drivers/net/wireless/ath/ath12k/hal.h         | 211 +++++++---
 drivers/net/wireless/ath/ath12k/hw.h          |  90 +---
 drivers/net/wireless/ath/ath12k/pci.h         |  10 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |   2 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal.c   |  10 +
 drivers/net/wireless/ath/ath12k/wifi7/hal.h   |   1 -
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   | 288 +++++++++++++
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.h   |   5 +
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  97 +++++
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.h   |   2 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c    | 393 ------------------
 14 files changed, 563 insertions(+), 554 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index b2a60b6c06ef..600fa7803c59 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1243,7 +1243,7 @@ void ath12k_dp_cc_config(struct ath12k_base *ab)
 	/* Enable Cookie conversion for WBM2SW Rings */
 	val = ath12k_hif_read32(ab, wbm_base + HAL_WBM_SW_COOKIE_CONVERT_CFG);
 	val |= u32_encode_bits(1, HAL_WBM_SW_COOKIE_CONV_CFG_GLOBAL_EN) |
-	       ab->hw_params->hal_params->wbm2sw_cc_enable;
+	       ab->hal.hal_params->wbm2sw_cc_enable;
 
 	ath12k_hif_write32(ab, wbm_base + HAL_WBM_SW_COOKIE_CONVERT_CFG, val);
 }
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 89ba9ad41417..60c4447c7489 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2685,7 +2685,7 @@ int ath12k_dp_mon_status_bufs_replenish(struct ath12k_base *ab,
 					int req_entries)
 {
 	enum hal_rx_buf_return_buf_manager mgr =
-		ab->hw_params->hal_params->rx_buf_rbm;
+		ab->hal.hal_params->rx_buf_rbm;
 	int num_free, num_remain, buf_id;
 	struct ath12k_buffer_addr *desc;
 	struct hal_srng *srng;
@@ -4042,7 +4042,7 @@ static int ath12k_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
 move_next:
 		skb = ath12k_dp_rx_alloc_mon_status_buf(ab, rx_ring,
 							&buf_id);
-		hal_params = ab->hw_params->hal_params;
+		hal_params = ab->hal.hal_params;
 
 		if (!skb) {
 			ath12k_warn(ab, "failed to alloc buffer for status ring\n");
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index a81859b25bd2..5f70bc5e3b99 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -78,7 +78,7 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 	dma_addr_t paddr;
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_rx_desc_info *rx_desc;
-	enum hal_rx_buf_return_buf_manager mgr = ab->hw_params->hal_params->rx_buf_rbm;
+	enum hal_rx_buf_return_buf_manager mgr = ab->hal.hal_params->rx_buf_rbm;
 
 	req_entries = min(req_entries, rx_ring->bufs_max);
 
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 5763a18ac046..fb36367b538e 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -73,13 +73,13 @@ struct ath12k_base;
 #define HAL_SEQ_WCSS_UMAC_REO_REG		0x00a38000
 #define HAL_SEQ_WCSS_UMAC_TCL_REG		0x00a44000
 #define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) \
-	((ab)->hw_params->regs->hal_umac_ce0_src_reg_base)
+	((ab)->hal.regs->hal_umac_ce0_src_reg_base)
 #define HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) \
-	((ab)->hw_params->regs->hal_umac_ce0_dest_reg_base)
+	((ab)->hal.regs->hal_umac_ce0_dest_reg_base)
 #define HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) \
-	((ab)->hw_params->regs->hal_umac_ce1_src_reg_base)
+	((ab)->hal.regs->hal_umac_ce1_src_reg_base)
 #define HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) \
-	((ab)->hw_params->regs->hal_umac_ce1_dest_reg_base)
+	((ab)->hal.regs->hal_umac_ce1_dest_reg_base)
 #define HAL_SEQ_WCSS_UMAC_WBM_REG		0x00a34000
 
 #define HAL_CE_WFSS_CE_REG_BASE			0x01b80000
@@ -90,30 +90,30 @@ struct ath12k_base;
 #define HAL_TCL1_RING_CMN_CTRL_REG		0x00000020
 #define HAL_TCL1_RING_DSCP_TID_MAP		0x00000240
 #define HAL_TCL1_RING_BASE_LSB(ab) \
-	((ab)->hw_params->regs->hal_tcl1_ring_base_lsb)
+	((ab)->hal.regs->hal_tcl1_ring_base_lsb)
 #define HAL_TCL1_RING_BASE_MSB(ab) \
-	((ab)->hw_params->regs->hal_tcl1_ring_base_msb)
-#define HAL_TCL1_RING_ID(ab)			((ab)->hw_params->regs->hal_tcl1_ring_id)
+	((ab)->hal.regs->hal_tcl1_ring_base_msb)
+#define HAL_TCL1_RING_ID(ab)		((ab)->hal.regs->hal_tcl1_ring_id)
 #define HAL_TCL1_RING_MISC(ab) \
-	((ab)->hw_params->regs->hal_tcl1_ring_misc)
+	((ab)->hal.regs->hal_tcl1_ring_misc)
 #define HAL_TCL1_RING_TP_ADDR_LSB(ab) \
-	((ab)->hw_params->regs->hal_tcl1_ring_tp_addr_lsb)
+	((ab)->hal.regs->hal_tcl1_ring_tp_addr_lsb)
 #define HAL_TCL1_RING_TP_ADDR_MSB(ab) \
-	((ab)->hw_params->regs->hal_tcl1_ring_tp_addr_msb)
+	((ab)->hal.regs->hal_tcl1_ring_tp_addr_msb)
 #define HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0(ab) \
-	((ab)->hw_params->regs->hal_tcl1_ring_consumer_int_setup_ix0)
+	((ab)->hal.regs->hal_tcl1_ring_consumer_int_setup_ix0)
 #define HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1(ab) \
-	((ab)->hw_params->regs->hal_tcl1_ring_consumer_int_setup_ix1)
+	((ab)->hal.regs->hal_tcl1_ring_consumer_int_setup_ix1)
 #define HAL_TCL1_RING_MSI1_BASE_LSB(ab) \
-	((ab)->hw_params->regs->hal_tcl1_ring_msi1_base_lsb)
+	((ab)->hal.regs->hal_tcl1_ring_msi1_base_lsb)
 #define HAL_TCL1_RING_MSI1_BASE_MSB(ab) \
-	((ab)->hw_params->regs->hal_tcl1_ring_msi1_base_msb)
+	((ab)->hal.regs->hal_tcl1_ring_msi1_base_msb)
 #define HAL_TCL1_RING_MSI1_DATA(ab) \
-	((ab)->hw_params->regs->hal_tcl1_ring_msi1_data)
+	((ab)->hal.regs->hal_tcl1_ring_msi1_data)
 #define HAL_TCL2_RING_BASE_LSB(ab) \
-	((ab)->hw_params->regs->hal_tcl2_ring_base_lsb)
+	((ab)->hal.regs->hal_tcl2_ring_base_lsb)
 #define HAL_TCL_RING_BASE_LSB(ab) \
-	((ab)->hw_params->regs->hal_tcl_ring_base_lsb)
+	((ab)->hal.regs->hal_tcl_ring_base_lsb)
 
 #define HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
 	(HAL_TCL1_RING_MSI1_BASE_LSB(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
@@ -147,7 +147,7 @@ struct ath12k_base;
 
 /* TCL STATUS ring address */
 #define HAL_TCL_STATUS_RING_BASE_LSB(ab) \
-	((ab)->hw_params->regs->hal_tcl_status_ring_base_lsb)
+	((ab)->hal.regs->hal_tcl_status_ring_base_lsb)
 #define HAL_TCL_STATUS_RING_HP			0x00002048
 
 /* PPE2TCL1 Ring address */
@@ -156,41 +156,41 @@ struct ath12k_base;
 
 /* WBM PPE Release Ring address */
 #define HAL_WBM_PPE_RELEASE_RING_BASE_LSB(ab) \
-	((ab)->hw_params->regs->hal_ppe_rel_ring_base)
+	((ab)->hal.regs->hal_ppe_rel_ring_base)
 #define HAL_WBM_PPE_RELEASE_RING_HP		0x00003020
 
 /* REO2SW(x) R0 ring configuration address */
 #define HAL_REO1_GEN_ENABLE			0x00000000
 #define HAL_REO1_MISC_CTRL_ADDR(ab) \
-	((ab)->hw_params->regs->hal_reo1_misc_ctrl_addr)
+	((ab)->hal.regs->hal_reo1_misc_ctrl_addr)
 #define HAL_REO1_DEST_RING_CTRL_IX_0		0x00000004
 #define HAL_REO1_DEST_RING_CTRL_IX_1		0x00000008
 #define HAL_REO1_DEST_RING_CTRL_IX_2		0x0000000c
 #define HAL_REO1_DEST_RING_CTRL_IX_3		0x00000010
-#define HAL_REO1_QDESC_ADDR(ab)		((ab)->hw_params->regs->hal_reo1_qdesc_addr)
-#define HAL_REO1_QDESC_MAX_PEERID(ab)	((ab)->hw_params->regs->hal_reo1_qdesc_max_peerid)
-#define HAL_REO1_SW_COOKIE_CFG0(ab)	((ab)->hw_params->regs->hal_reo1_sw_cookie_cfg0)
-#define HAL_REO1_SW_COOKIE_CFG1(ab)	((ab)->hw_params->regs->hal_reo1_sw_cookie_cfg1)
-#define HAL_REO1_QDESC_LUT_BASE0(ab)	((ab)->hw_params->regs->hal_reo1_qdesc_lut_base0)
-#define HAL_REO1_QDESC_LUT_BASE1(ab)	((ab)->hw_params->regs->hal_reo1_qdesc_lut_base1)
-#define HAL_REO1_RING_BASE_LSB(ab)	((ab)->hw_params->regs->hal_reo1_ring_base_lsb)
-#define HAL_REO1_RING_BASE_MSB(ab)	((ab)->hw_params->regs->hal_reo1_ring_base_msb)
-#define HAL_REO1_RING_ID(ab)		((ab)->hw_params->regs->hal_reo1_ring_id)
-#define HAL_REO1_RING_MISC(ab)		((ab)->hw_params->regs->hal_reo1_ring_misc)
-#define HAL_REO1_RING_HP_ADDR_LSB(ab)	((ab)->hw_params->regs->hal_reo1_ring_hp_addr_lsb)
-#define HAL_REO1_RING_HP_ADDR_MSB(ab)	((ab)->hw_params->regs->hal_reo1_ring_hp_addr_msb)
+#define HAL_REO1_QDESC_ADDR(ab)		((ab)->hal.regs->hal_reo1_qdesc_addr)
+#define HAL_REO1_QDESC_MAX_PEERID(ab)	((ab)->hal.regs->hal_reo1_qdesc_max_peerid)
+#define HAL_REO1_SW_COOKIE_CFG0(ab)	((ab)->hal.regs->hal_reo1_sw_cookie_cfg0)
+#define HAL_REO1_SW_COOKIE_CFG1(ab)	((ab)->hal.regs->hal_reo1_sw_cookie_cfg1)
+#define HAL_REO1_QDESC_LUT_BASE0(ab)	((ab)->hal.regs->hal_reo1_qdesc_lut_base0)
+#define HAL_REO1_QDESC_LUT_BASE1(ab)	((ab)->hal.regs->hal_reo1_qdesc_lut_base1)
+#define HAL_REO1_RING_BASE_LSB(ab)	((ab)->hal.regs->hal_reo1_ring_base_lsb)
+#define HAL_REO1_RING_BASE_MSB(ab)	((ab)->hal.regs->hal_reo1_ring_base_msb)
+#define HAL_REO1_RING_ID(ab)		((ab)->hal.regs->hal_reo1_ring_id)
+#define HAL_REO1_RING_MISC(ab)		((ab)->hal.regs->hal_reo1_ring_misc)
+#define HAL_REO1_RING_HP_ADDR_LSB(ab)	((ab)->hal.regs->hal_reo1_ring_hp_addr_lsb)
+#define HAL_REO1_RING_HP_ADDR_MSB(ab)	((ab)->hal.regs->hal_reo1_ring_hp_addr_msb)
 #define HAL_REO1_RING_PRODUCER_INT_SETUP(ab) \
-	((ab)->hw_params->regs->hal_reo1_ring_producer_int_setup)
+	((ab)->hal.regs->hal_reo1_ring_producer_int_setup)
 #define HAL_REO1_RING_MSI1_BASE_LSB(ab)	\
-	((ab)->hw_params->regs->hal_reo1_ring_msi1_base_lsb)
+	((ab)->hal.regs->hal_reo1_ring_msi1_base_lsb)
 #define HAL_REO1_RING_MSI1_BASE_MSB(ab)	\
-	((ab)->hw_params->regs->hal_reo1_ring_msi1_base_msb)
-#define HAL_REO1_RING_MSI1_DATA(ab)	((ab)->hw_params->regs->hal_reo1_ring_msi1_data)
-#define HAL_REO2_RING_BASE_LSB(ab)	((ab)->hw_params->regs->hal_reo2_ring_base)
-#define HAL_REO1_AGING_THRESH_IX_0(ab)	((ab)->hw_params->regs->hal_reo1_aging_thres_ix0)
-#define HAL_REO1_AGING_THRESH_IX_1(ab)	((ab)->hw_params->regs->hal_reo1_aging_thres_ix1)
-#define HAL_REO1_AGING_THRESH_IX_2(ab)	((ab)->hw_params->regs->hal_reo1_aging_thres_ix2)
-#define HAL_REO1_AGING_THRESH_IX_3(ab)	((ab)->hw_params->regs->hal_reo1_aging_thres_ix3)
+	((ab)->hal.regs->hal_reo1_ring_msi1_base_msb)
+#define HAL_REO1_RING_MSI1_DATA(ab)	((ab)->hal.regs->hal_reo1_ring_msi1_data)
+#define HAL_REO2_RING_BASE_LSB(ab)	((ab)->hal.regs->hal_reo2_ring_base)
+#define HAL_REO1_AGING_THRESH_IX_0(ab)	((ab)->hal.regs->hal_reo1_aging_thres_ix0)
+#define HAL_REO1_AGING_THRESH_IX_1(ab)	((ab)->hal.regs->hal_reo1_aging_thres_ix1)
+#define HAL_REO1_AGING_THRESH_IX_2(ab)	((ab)->hal.regs->hal_reo1_aging_thres_ix2)
+#define HAL_REO1_AGING_THRESH_IX_3(ab)	((ab)->hal.regs->hal_reo1_aging_thres_ix3)
 
 /* REO2SW(x) R2 ring pointers (head/tail) address */
 #define HAL_REO1_RING_HP			0x00003048
@@ -201,23 +201,23 @@ struct ath12k_base;
 
 /* REO2SW0 ring configuration address */
 #define HAL_REO_SW0_RING_BASE_LSB(ab) \
-	((ab)->hw_params->regs->hal_reo2_sw0_ring_base)
+	((ab)->hal.regs->hal_reo2_sw0_ring_base)
 
 /* REO2SW0 R2 ring pointer (head/tail) address */
 #define HAL_REO_SW0_RING_HP			0x00003088
 
 /* REO CMD R0 address */
 #define HAL_REO_CMD_RING_BASE_LSB(ab) \
-	((ab)->hw_params->regs->hal_reo_cmd_ring_base)
+	((ab)->hal.regs->hal_reo_cmd_ring_base)
 
 /* REO CMD R2 address */
 #define HAL_REO_CMD_HP				0x00003020
 
 /* SW2REO R0 address */
 #define	HAL_SW2REO_RING_BASE_LSB(ab) \
-	((ab)->hw_params->regs->hal_sw2reo_ring_base)
+	((ab)->hal.regs->hal_sw2reo_ring_base)
 #define HAL_SW2REO1_RING_BASE_LSB(ab) \
-	((ab)->hw_params->regs->hal_sw2reo1_ring_base)
+	((ab)->hal.regs->hal_sw2reo1_ring_base)
 
 /* SW2REO R2 address */
 #define HAL_SW2REO_RING_HP			0x00003028
@@ -235,41 +235,41 @@ struct ath12k_base;
 
 /* REO status address */
 #define HAL_REO_STATUS_RING_BASE_LSB(ab) \
-	((ab)->hw_params->regs->hal_reo_status_ring_base)
+	((ab)->hal.regs->hal_reo_status_ring_base)
 #define HAL_REO_STATUS_HP			0x000030a8
 
 /* WBM Idle R0 address */
 #define HAL_WBM_IDLE_LINK_RING_BASE_LSB(ab) \
-	((ab)->hw_params->regs->hal_wbm_idle_ring_base_lsb)
+	((ab)->hal.regs->hal_wbm_idle_ring_base_lsb)
 #define HAL_WBM_IDLE_LINK_RING_MISC_ADDR(ab) \
-	((ab)->hw_params->regs->hal_wbm_idle_ring_misc_addr)
+	((ab)->hal.regs->hal_wbm_idle_ring_misc_addr)
 #define HAL_WBM_R0_IDLE_LIST_CONTROL_ADDR(ab) \
-	((ab)->hw_params->regs->hal_wbm_r0_idle_list_cntl_addr)
+	((ab)->hal.regs->hal_wbm_r0_idle_list_cntl_addr)
 #define HAL_WBM_R0_IDLE_LIST_SIZE_ADDR(ab) \
-	((ab)->hw_params->regs->hal_wbm_r0_idle_list_size_addr)
+	((ab)->hal.regs->hal_wbm_r0_idle_list_size_addr)
 #define HAL_WBM_SCATTERED_RING_BASE_LSB(ab) \
-	((ab)->hw_params->regs->hal_wbm_scattered_ring_base_lsb)
+	((ab)->hal.regs->hal_wbm_scattered_ring_base_lsb)
 #define HAL_WBM_SCATTERED_RING_BASE_MSB(ab) \
-	((ab)->hw_params->regs->hal_wbm_scattered_ring_base_msb)
+	((ab)->hal.regs->hal_wbm_scattered_ring_base_msb)
 #define HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX0(ab) \
-	((ab)->hw_params->regs->hal_wbm_scattered_desc_head_info_ix0)
+	((ab)->hal.regs->hal_wbm_scattered_desc_head_info_ix0)
 #define HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX1(ab) \
-	((ab)->hw_params->regs->hal_wbm_scattered_desc_head_info_ix1)
+	((ab)->hal.regs->hal_wbm_scattered_desc_head_info_ix1)
 #define HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX0(ab) \
-	((ab)->hw_params->regs->hal_wbm_scattered_desc_tail_info_ix0)
+	((ab)->hal.regs->hal_wbm_scattered_desc_tail_info_ix0)
 #define HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX1(ab) \
-	((ab)->hw_params->regs->hal_wbm_scattered_desc_tail_info_ix1)
+	((ab)->hal.regs->hal_wbm_scattered_desc_tail_info_ix1)
 #define HAL_WBM_SCATTERED_DESC_PTR_HP_ADDR(ab) \
-	((ab)->hw_params->regs->hal_wbm_scattered_desc_ptr_hp_addr)
+	((ab)->hal.regs->hal_wbm_scattered_desc_ptr_hp_addr)
 
 /* WBM Idle R2 address */
 #define HAL_WBM_IDLE_LINK_RING_HP		0x000030b8
 
 /* SW2WBM R0 release address */
 #define HAL_WBM_SW_RELEASE_RING_BASE_LSB(ab) \
-	((ab)->hw_params->regs->hal_wbm_sw_release_ring_base_lsb)
+	((ab)->hal.regs->hal_wbm_sw_release_ring_base_lsb)
 #define HAL_WBM_SW1_RELEASE_RING_BASE_LSB(ab) \
-	((ab)->hw_params->regs->hal_wbm_sw1_release_ring_base_lsb)
+	((ab)->hal.regs->hal_wbm_sw1_release_ring_base_lsb)
 
 /* SW2WBM R2 release address */
 #define HAL_WBM_SW_RELEASE_RING_HP		0x00003010
@@ -277,10 +277,10 @@ struct ath12k_base;
 
 /* WBM2SW R0 release address */
 #define HAL_WBM0_RELEASE_RING_BASE_LSB(ab) \
-	((ab)->hw_params->regs->hal_wbm0_release_ring_base_lsb)
+	((ab)->hal.regs->hal_wbm0_release_ring_base_lsb)
 
 #define HAL_WBM1_RELEASE_RING_BASE_LSB(ab) \
-	((ab)->hw_params->regs->hal_wbm1_release_ring_base_lsb)
+	((ab)->hal.regs->hal_wbm1_release_ring_base_lsb)
 
 /* WBM2SW R2 release address */
 #define HAL_WBM0_RELEASE_RING_HP		0x000030c8
@@ -1439,6 +1439,91 @@ struct hal_reo_status {
 	} u;
 };
 
+struct ath12k_hw_hal_params {
+	enum hal_rx_buf_return_buf_manager rx_buf_rbm;
+	u32 wbm2sw_cc_enable;
+};
+
+struct ath12k_hw_regs {
+	u32 hal_tcl1_ring_id;
+	u32 hal_tcl1_ring_misc;
+	u32 hal_tcl1_ring_tp_addr_lsb;
+	u32 hal_tcl1_ring_tp_addr_msb;
+	u32 hal_tcl1_ring_consumer_int_setup_ix0;
+	u32 hal_tcl1_ring_consumer_int_setup_ix1;
+	u32 hal_tcl1_ring_msi1_base_lsb;
+	u32 hal_tcl1_ring_msi1_base_msb;
+	u32 hal_tcl1_ring_msi1_data;
+	u32 hal_tcl_ring_base_lsb;
+	u32 hal_tcl1_ring_base_lsb;
+	u32 hal_tcl1_ring_base_msb;
+	u32 hal_tcl2_ring_base_lsb;
+
+	u32 hal_tcl_status_ring_base_lsb;
+
+	u32 hal_reo1_qdesc_addr;
+	u32 hal_reo1_qdesc_max_peerid;
+
+	u32 hal_wbm_idle_ring_base_lsb;
+	u32 hal_wbm_idle_ring_misc_addr;
+	u32 hal_wbm_r0_idle_list_cntl_addr;
+	u32 hal_wbm_r0_idle_list_size_addr;
+	u32 hal_wbm_scattered_ring_base_lsb;
+	u32 hal_wbm_scattered_ring_base_msb;
+	u32 hal_wbm_scattered_desc_head_info_ix0;
+	u32 hal_wbm_scattered_desc_head_info_ix1;
+	u32 hal_wbm_scattered_desc_tail_info_ix0;
+	u32 hal_wbm_scattered_desc_tail_info_ix1;
+	u32 hal_wbm_scattered_desc_ptr_hp_addr;
+
+	u32 hal_wbm_sw_release_ring_base_lsb;
+	u32 hal_wbm_sw1_release_ring_base_lsb;
+	u32 hal_wbm0_release_ring_base_lsb;
+	u32 hal_wbm1_release_ring_base_lsb;
+
+	u32 pcie_qserdes_sysclk_en_sel;
+	u32 pcie_pcs_osc_dtct_config_base;
+
+	u32 hal_umac_ce0_src_reg_base;
+	u32 hal_umac_ce0_dest_reg_base;
+	u32 hal_umac_ce1_src_reg_base;
+	u32 hal_umac_ce1_dest_reg_base;
+
+	u32 hal_ppe_rel_ring_base;
+
+	u32 hal_reo2_ring_base;
+	u32 hal_reo1_misc_ctrl_addr;
+	u32 hal_reo1_sw_cookie_cfg0;
+	u32 hal_reo1_sw_cookie_cfg1;
+	u32 hal_reo1_qdesc_lut_base0;
+	u32 hal_reo1_qdesc_lut_base1;
+	u32 hal_reo1_ring_base_lsb;
+	u32 hal_reo1_ring_base_msb;
+	u32 hal_reo1_ring_id;
+	u32 hal_reo1_ring_misc;
+	u32 hal_reo1_ring_hp_addr_lsb;
+	u32 hal_reo1_ring_hp_addr_msb;
+	u32 hal_reo1_ring_producer_int_setup;
+	u32 hal_reo1_ring_msi1_base_lsb;
+	u32 hal_reo1_ring_msi1_base_msb;
+	u32 hal_reo1_ring_msi1_data;
+	u32 hal_reo1_aging_thres_ix0;
+	u32 hal_reo1_aging_thres_ix1;
+	u32 hal_reo1_aging_thres_ix2;
+	u32 hal_reo1_aging_thres_ix3;
+
+	u32 hal_reo2_sw0_ring_base;
+
+	u32 hal_sw2reo_ring_base;
+	u32 hal_sw2reo1_ring_base;
+
+	u32 hal_reo_cmd_ring_base;
+
+	u32 hal_reo_status_ring_base;
+
+	u32 gcc_gcc_pcie_hot_rst;
+};
+
 /* HAL context to be used to access SRNG APIs (currently used by data path
  * and transport (CE) modules)
  */
@@ -1463,6 +1548,8 @@ struct ath12k_hal {
 	} wrp;
 
 	const struct hal_ops *hal_ops;
+	const struct ath12k_hw_regs *regs;
+	const struct ath12k_hw_hal_params *hal_params;
 	/* Available REO blocking resources bitmap */
 	u8 avail_blk_resource;
 
@@ -1585,6 +1672,8 @@ struct ath12k_hw_version_map {
 	const struct hal_ops *hal_ops;
 	u32 hal_desc_sz;
 	const struct ath12k_hal_tcl_to_wbm_rbm_map *tcl_to_wbm_rbm_map;
+	const struct ath12k_hw_hal_params *hal_params;
+	const struct ath12k_hw_regs *hw_regs;
 };
 
 struct hal_ops {
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 7e8f1f7ef584..655753d0413a 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_HW_H
@@ -128,11 +128,6 @@ struct ath12k_hw_ring_mask {
 	u8 tx_mon_dest[ATH12K_EXT_IRQ_GRP_NUM_MAX];
 };
 
-struct ath12k_hw_hal_params {
-	enum hal_rx_buf_return_buf_manager rx_buf_rbm;
-	u32	  wbm2sw_cc_enable;
-};
-
 enum ath12k_m3_fw_loaders {
 	ath12k_m3_fw_loader_driver,
 	ath12k_m3_fw_loader_remoteproc,
@@ -156,7 +151,6 @@ struct ath12k_hw_params {
 
 	const struct ath12k_hw_ops *hw_ops;
 	const struct ath12k_hw_ring_mask *ring_mask;
-	const struct ath12k_hw_regs *regs;
 
 	const struct ce_attr *host_ce_config;
 	u32 ce_count;
@@ -165,8 +159,6 @@ struct ath12k_hw_params {
 	const struct service_to_pipe *svc_to_ce_map;
 	u32 svc_to_ce_map_len;
 
-	const struct ath12k_hw_hal_params *hal_params;
-
 	bool rxdma1_enable:1;
 	int num_rxdma_per_pdev;
 	int num_rxdma_dst_ring;
@@ -283,86 +275,6 @@ enum ath12k_bd_ie_type {
 	ATH12K_BD_IE_REGDB = 1,
 };
 
-struct ath12k_hw_regs {
-	u32 hal_tcl1_ring_id;
-	u32 hal_tcl1_ring_misc;
-	u32 hal_tcl1_ring_tp_addr_lsb;
-	u32 hal_tcl1_ring_tp_addr_msb;
-	u32 hal_tcl1_ring_consumer_int_setup_ix0;
-	u32 hal_tcl1_ring_consumer_int_setup_ix1;
-	u32 hal_tcl1_ring_msi1_base_lsb;
-	u32 hal_tcl1_ring_msi1_base_msb;
-	u32 hal_tcl1_ring_msi1_data;
-	u32 hal_tcl_ring_base_lsb;
-	u32 hal_tcl1_ring_base_lsb;
-	u32 hal_tcl1_ring_base_msb;
-	u32 hal_tcl2_ring_base_lsb;
-
-	u32 hal_tcl_status_ring_base_lsb;
-
-	u32 hal_reo1_qdesc_addr;
-	u32 hal_reo1_qdesc_max_peerid;
-
-	u32 hal_wbm_idle_ring_base_lsb;
-	u32 hal_wbm_idle_ring_misc_addr;
-	u32 hal_wbm_r0_idle_list_cntl_addr;
-	u32 hal_wbm_r0_idle_list_size_addr;
-	u32 hal_wbm_scattered_ring_base_lsb;
-	u32 hal_wbm_scattered_ring_base_msb;
-	u32 hal_wbm_scattered_desc_head_info_ix0;
-	u32 hal_wbm_scattered_desc_head_info_ix1;
-	u32 hal_wbm_scattered_desc_tail_info_ix0;
-	u32 hal_wbm_scattered_desc_tail_info_ix1;
-	u32 hal_wbm_scattered_desc_ptr_hp_addr;
-
-	u32 hal_wbm_sw_release_ring_base_lsb;
-	u32 hal_wbm_sw1_release_ring_base_lsb;
-	u32 hal_wbm0_release_ring_base_lsb;
-	u32 hal_wbm1_release_ring_base_lsb;
-
-	u32 pcie_qserdes_sysclk_en_sel;
-	u32 pcie_pcs_osc_dtct_config_base;
-
-	u32 hal_umac_ce0_src_reg_base;
-	u32 hal_umac_ce0_dest_reg_base;
-	u32 hal_umac_ce1_src_reg_base;
-	u32 hal_umac_ce1_dest_reg_base;
-
-	u32 hal_ppe_rel_ring_base;
-
-	u32 hal_reo2_ring_base;
-	u32 hal_reo1_misc_ctrl_addr;
-	u32 hal_reo1_sw_cookie_cfg0;
-	u32 hal_reo1_sw_cookie_cfg1;
-	u32 hal_reo1_qdesc_lut_base0;
-	u32 hal_reo1_qdesc_lut_base1;
-	u32 hal_reo1_ring_base_lsb;
-	u32 hal_reo1_ring_base_msb;
-	u32 hal_reo1_ring_id;
-	u32 hal_reo1_ring_misc;
-	u32 hal_reo1_ring_hp_addr_lsb;
-	u32 hal_reo1_ring_hp_addr_msb;
-	u32 hal_reo1_ring_producer_int_setup;
-	u32 hal_reo1_ring_msi1_base_lsb;
-	u32 hal_reo1_ring_msi1_base_msb;
-	u32 hal_reo1_ring_msi1_data;
-	u32 hal_reo1_aging_thres_ix0;
-	u32 hal_reo1_aging_thres_ix1;
-	u32 hal_reo1_aging_thres_ix2;
-	u32 hal_reo1_aging_thres_ix3;
-
-	u32 hal_reo2_sw0_ring_base;
-
-	u32 hal_sw2reo_ring_base;
-	u32 hal_sw2reo1_ring_base;
-
-	u32 hal_reo_cmd_ring_base;
-
-	u32 hal_reo_status_ring_base;
-
-	u32 gcc_gcc_pcie_hot_rst;
-};
-
 static inline const char *ath12k_bd_ie_type_str(enum ath12k_bd_ie_type type)
 {
 	switch (type) {
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index 2c19bb42f0f7..1cc4f0e050f9 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -30,7 +30,7 @@
 #define PARM_LTSSM_VALUE			0x111
 
 #define GCC_GCC_PCIE_HOT_RST(ab) \
-	((ab)->hw_params->regs->gcc_gcc_pcie_hot_rst)
+	((ab)->hal.regs->gcc_gcc_pcie_hot_rst)
 
 #define GCC_GCC_PCIE_HOT_RST_VAL		0x10
 
@@ -39,17 +39,17 @@
 #define PCIE_INT_CLEAR_ALL			0xffffffff
 
 #define PCIE_QSERDES_COM_SYSCLK_EN_SEL_REG(ab) \
-	((ab)->hw_params->regs->pcie_qserdes_sysclk_en_sel)
+	((ab)->hal.regs->pcie_qserdes_sysclk_en_sel)
 #define PCIE_QSERDES_COM_SYSCLK_EN_SEL_VAL	0x10
 #define PCIE_QSERDES_COM_SYSCLK_EN_SEL_MSK	0xffffffff
 #define PCIE_PCS_OSC_DTCT_CONFIG1_REG(ab) \
-	((ab)->hw_params->regs->pcie_pcs_osc_dtct_config_base)
+	((ab)->hal.regs->pcie_pcs_osc_dtct_config_base)
 #define PCIE_PCS_OSC_DTCT_CONFIG1_VAL		0x02
 #define PCIE_PCS_OSC_DTCT_CONFIG2_REG(ab) \
-	((ab)->hw_params->regs->pcie_pcs_osc_dtct_config_base + 0x4)
+	((ab)->hal.regs->pcie_pcs_osc_dtct_config_base + 0x4)
 #define PCIE_PCS_OSC_DTCT_CONFIG2_VAL		0x52
 #define PCIE_PCS_OSC_DTCT_CONFIG4_REG(ab) \
-	((ab)->hw_params->regs->pcie_pcs_osc_dtct_config_base + 0xc)
+	((ab)->hal.regs->pcie_pcs_osc_dtct_config_base + 0xc)
 #define PCIE_PCS_OSC_DTCT_CONFIG4_VAL		0xff
 #define PCIE_PCS_OSC_DTCT_CONFIG_MSK		0x000000ff
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index d6ce6b9bb4d7..eef8d2558494 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -1383,7 +1383,7 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 						       msdu_cookies, &rbm);
 		if (rbm != partner_dp->idle_link_rbm &&
 		    rbm != HAL_RX_BUF_RBM_SW3_BM &&
-		    rbm != partner_ab->hw_params->hal_params->rx_buf_rbm) {
+		    rbm != partner_ab->hal.hal_params->rx_buf_rbm) {
 			act = HAL_WBM_REL_BM_ACT_REL_MSDU;
 			ab->device_stats.invalid_rbm++;
 			ath12k_warn(ab, "invalid return buffer manager %d\n", rbm);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index 53ea3792ef51..25963ac18cb9 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -15,21 +15,29 @@ static const struct ath12k_hw_version_map ath12k_wifi7_hw_ver_map[] = {
 		.hal_ops = &hal_qcn9274_ops,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
 		.tcl_to_wbm_rbm_map = ath12k_hal_tcl_to_wbm_rbm_map_qcn9274,
+		.hal_params = &ath12k_hw_hal_params_qcn9274,
+		.hw_regs = &qcn9274_v1_regs,
 	},
 	[ATH12K_HW_QCN9274_HW20] = {
 		.hal_ops = &hal_qcn9274_ops,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
 		.tcl_to_wbm_rbm_map = ath12k_hal_tcl_to_wbm_rbm_map_qcn9274,
+		.hal_params = &ath12k_hw_hal_params_qcn9274,
+		.hw_regs = &qcn9274_v2_regs,
 	},
 	[ATH12K_HW_WCN7850_HW20] = {
 		.hal_ops = &hal_wcn7850_ops,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn7850),
 		.tcl_to_wbm_rbm_map = ath12k_hal_tcl_to_wbm_rbm_map_wcn7850,
+		.hal_params = &ath12k_hw_hal_params_wcn7850,
+		.hw_regs = &wcn7850_regs,
 	},
 	[ATH12K_HW_IPQ5332_HW10] = {
 		.hal_ops = &hal_qcn9274_ops,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
 		.tcl_to_wbm_rbm_map = ath12k_hal_tcl_to_wbm_rbm_map_qcn9274,
+		.hal_params = &ath12k_hw_hal_params_ipq5332,
+		.hw_regs = &ipq5332_regs,
 	},
 };
 
@@ -42,6 +50,8 @@ int ath12k_wifi7_hal_init(struct ath12k_base *ab)
 	hal->hal_ops = ath12k_wifi7_hw_ver_map[ab->hw_rev].hal_ops;
 	hal->hal_desc_sz = ath12k_wifi7_hw_ver_map[ab->hw_rev].hal_desc_sz;
 	hal->tcl_to_wbm_rbm_map = ath12k_wifi7_hw_ver_map[ab->hw_rev].tcl_to_wbm_rbm_map;
+	hal->regs = ath12k_wifi7_hw_ver_map[ab->hw_rev].hw_regs;
+	hal->hal_params = ath12k_wifi7_hw_ver_map[ab->hw_rev].hal_params;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.h b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
index 0dc5eaec5fb0..1a8a720c4923 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
@@ -8,5 +8,4 @@
 #define ATH12K_HAL_WIFI7_H
 
 int ath12k_wifi7_hal_init(struct ath12k_base *ab);
-
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index fefa151efaef..265e9f368858 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -5,6 +5,8 @@
  */
 #include "hal_desc.h"
 #include "hal_qcn9274.h"
+#include "hw.h"
+#include "hal.h"
 
 static const struct hal_srng_config hw_srng_config_template[] = {
 	/* TODO: max_rings can populated by querying HW capabilities */
@@ -209,6 +211,274 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 	}
 };
 
+const struct ath12k_hw_regs qcn9274_v1_regs = {
+	/* SW2TCL(x) R0 ring configuration address */
+	.hal_tcl1_ring_id = 0x00000908,
+	.hal_tcl1_ring_misc = 0x00000910,
+	.hal_tcl1_ring_tp_addr_lsb = 0x0000091c,
+	.hal_tcl1_ring_tp_addr_msb = 0x00000920,
+	.hal_tcl1_ring_consumer_int_setup_ix0 = 0x00000930,
+	.hal_tcl1_ring_consumer_int_setup_ix1 = 0x00000934,
+	.hal_tcl1_ring_msi1_base_lsb = 0x00000948,
+	.hal_tcl1_ring_msi1_base_msb = 0x0000094c,
+	.hal_tcl1_ring_msi1_data = 0x00000950,
+	.hal_tcl_ring_base_lsb = 0x00000b58,
+	.hal_tcl1_ring_base_lsb = 0x00000900,
+	.hal_tcl1_ring_base_msb = 0x00000904,
+	.hal_tcl2_ring_base_lsb = 0x00000978,
+
+	/* TCL STATUS ring address */
+	.hal_tcl_status_ring_base_lsb = 0x00000d38,
+
+	.hal_wbm_idle_ring_base_lsb = 0x00000d0c,
+	.hal_wbm_idle_ring_misc_addr = 0x00000d1c,
+	.hal_wbm_r0_idle_list_cntl_addr = 0x00000210,
+	.hal_wbm_r0_idle_list_size_addr = 0x00000214,
+	.hal_wbm_scattered_ring_base_lsb = 0x00000220,
+	.hal_wbm_scattered_ring_base_msb = 0x00000224,
+	.hal_wbm_scattered_desc_head_info_ix0 = 0x00000230,
+	.hal_wbm_scattered_desc_head_info_ix1 = 0x00000234,
+	.hal_wbm_scattered_desc_tail_info_ix0 = 0x00000240,
+	.hal_wbm_scattered_desc_tail_info_ix1 = 0x00000244,
+	.hal_wbm_scattered_desc_ptr_hp_addr = 0x0000024c,
+
+	.hal_wbm_sw_release_ring_base_lsb = 0x0000034c,
+	.hal_wbm_sw1_release_ring_base_lsb = 0x000003c4,
+	.hal_wbm0_release_ring_base_lsb = 0x00000dd8,
+	.hal_wbm1_release_ring_base_lsb = 0x00000e50,
+
+	/* PCIe base address */
+	.pcie_qserdes_sysclk_en_sel = 0x01e0c0a8,
+	.pcie_pcs_osc_dtct_config_base = 0x01e0d45c,
+
+	/* PPE release ring address */
+	.hal_ppe_rel_ring_base = 0x0000043c,
+
+	/* REO DEST ring address */
+	.hal_reo2_ring_base = 0x0000055c,
+	.hal_reo1_misc_ctrl_addr = 0x00000b7c,
+	.hal_reo1_sw_cookie_cfg0 = 0x00000050,
+	.hal_reo1_sw_cookie_cfg1 = 0x00000054,
+	.hal_reo1_qdesc_lut_base0 = 0x00000058,
+	.hal_reo1_qdesc_lut_base1 = 0x0000005c,
+	.hal_reo1_ring_base_lsb = 0x000004e4,
+	.hal_reo1_ring_base_msb = 0x000004e8,
+	.hal_reo1_ring_id = 0x000004ec,
+	.hal_reo1_ring_misc = 0x000004f4,
+	.hal_reo1_ring_hp_addr_lsb = 0x000004f8,
+	.hal_reo1_ring_hp_addr_msb = 0x000004fc,
+	.hal_reo1_ring_producer_int_setup = 0x00000508,
+	.hal_reo1_ring_msi1_base_lsb = 0x0000052C,
+	.hal_reo1_ring_msi1_base_msb = 0x00000530,
+	.hal_reo1_ring_msi1_data = 0x00000534,
+	.hal_reo1_aging_thres_ix0 = 0x00000b08,
+	.hal_reo1_aging_thres_ix1 = 0x00000b0c,
+	.hal_reo1_aging_thres_ix2 = 0x00000b10,
+	.hal_reo1_aging_thres_ix3 = 0x00000b14,
+
+	/* REO Exception ring address */
+	.hal_reo2_sw0_ring_base = 0x000008a4,
+
+	/* REO Reinject ring address */
+	.hal_sw2reo_ring_base = 0x00000304,
+	.hal_sw2reo1_ring_base = 0x0000037c,
+
+	/* REO cmd ring address */
+	.hal_reo_cmd_ring_base = 0x0000028c,
+
+	/* REO status ring address */
+	.hal_reo_status_ring_base = 0x00000a84,
+
+	/* CE base address */
+	.hal_umac_ce0_src_reg_base = 0x01b80000,
+	.hal_umac_ce0_dest_reg_base = 0x01b81000,
+	.hal_umac_ce1_src_reg_base = 0x01b82000,
+	.hal_umac_ce1_dest_reg_base = 0x01b83000,
+
+	.gcc_gcc_pcie_hot_rst = 0x1e38338,
+};
+
+const struct ath12k_hw_regs qcn9274_v2_regs = {
+	/* SW2TCL(x) R0 ring configuration address */
+	.hal_tcl1_ring_id = 0x00000908,
+	.hal_tcl1_ring_misc = 0x00000910,
+	.hal_tcl1_ring_tp_addr_lsb = 0x0000091c,
+	.hal_tcl1_ring_tp_addr_msb = 0x00000920,
+	.hal_tcl1_ring_consumer_int_setup_ix0 = 0x00000930,
+	.hal_tcl1_ring_consumer_int_setup_ix1 = 0x00000934,
+	.hal_tcl1_ring_msi1_base_lsb = 0x00000948,
+	.hal_tcl1_ring_msi1_base_msb = 0x0000094c,
+	.hal_tcl1_ring_msi1_data = 0x00000950,
+	.hal_tcl_ring_base_lsb = 0x00000b58,
+	.hal_tcl1_ring_base_lsb = 0x00000900,
+	.hal_tcl1_ring_base_msb = 0x00000904,
+	.hal_tcl2_ring_base_lsb = 0x00000978,
+
+	/* TCL STATUS ring address */
+	.hal_tcl_status_ring_base_lsb = 0x00000d38,
+
+	/* WBM idle link ring address */
+	.hal_wbm_idle_ring_base_lsb = 0x00000d3c,
+	.hal_wbm_idle_ring_misc_addr = 0x00000d4c,
+	.hal_wbm_r0_idle_list_cntl_addr = 0x00000240,
+	.hal_wbm_r0_idle_list_size_addr = 0x00000244,
+	.hal_wbm_scattered_ring_base_lsb = 0x00000250,
+	.hal_wbm_scattered_ring_base_msb = 0x00000254,
+	.hal_wbm_scattered_desc_head_info_ix0 = 0x00000260,
+	.hal_wbm_scattered_desc_head_info_ix1 = 0x00000264,
+	.hal_wbm_scattered_desc_tail_info_ix0 = 0x00000270,
+	.hal_wbm_scattered_desc_tail_info_ix1 = 0x00000274,
+	.hal_wbm_scattered_desc_ptr_hp_addr = 0x0000027c,
+
+	/* SW2WBM release ring address */
+	.hal_wbm_sw_release_ring_base_lsb = 0x0000037c,
+	.hal_wbm_sw1_release_ring_base_lsb = 0x000003f4,
+
+	/* WBM2SW release ring address */
+	.hal_wbm0_release_ring_base_lsb = 0x00000e08,
+	.hal_wbm1_release_ring_base_lsb = 0x00000e80,
+
+	/* PCIe base address */
+	.pcie_qserdes_sysclk_en_sel = 0x01e0c0a8,
+	.pcie_pcs_osc_dtct_config_base = 0x01e0d45c,
+
+	/* PPE release ring address */
+	.hal_ppe_rel_ring_base = 0x0000046c,
+
+	/* REO DEST ring address */
+	.hal_reo2_ring_base = 0x00000578,
+	.hal_reo1_misc_ctrl_addr = 0x00000b9c,
+	.hal_reo1_sw_cookie_cfg0 = 0x0000006c,
+	.hal_reo1_sw_cookie_cfg1 = 0x00000070,
+	.hal_reo1_qdesc_lut_base0 = 0x00000074,
+	.hal_reo1_qdesc_lut_base1 = 0x00000078,
+	.hal_reo1_qdesc_addr = 0x0000007c,
+	.hal_reo1_qdesc_max_peerid = 0x00000088,
+	.hal_reo1_ring_base_lsb = 0x00000500,
+	.hal_reo1_ring_base_msb = 0x00000504,
+	.hal_reo1_ring_id = 0x00000508,
+	.hal_reo1_ring_misc = 0x00000510,
+	.hal_reo1_ring_hp_addr_lsb = 0x00000514,
+	.hal_reo1_ring_hp_addr_msb = 0x00000518,
+	.hal_reo1_ring_producer_int_setup = 0x00000524,
+	.hal_reo1_ring_msi1_base_lsb = 0x00000548,
+	.hal_reo1_ring_msi1_base_msb = 0x0000054C,
+	.hal_reo1_ring_msi1_data = 0x00000550,
+	.hal_reo1_aging_thres_ix0 = 0x00000B28,
+	.hal_reo1_aging_thres_ix1 = 0x00000B2C,
+	.hal_reo1_aging_thres_ix2 = 0x00000B30,
+	.hal_reo1_aging_thres_ix3 = 0x00000B34,
+
+	/* REO Exception ring address */
+	.hal_reo2_sw0_ring_base = 0x000008c0,
+
+	/* REO Reinject ring address */
+	.hal_sw2reo_ring_base = 0x00000320,
+	.hal_sw2reo1_ring_base = 0x00000398,
+
+	/* REO cmd ring address */
+	.hal_reo_cmd_ring_base = 0x000002A8,
+
+	/* REO status ring address */
+	.hal_reo_status_ring_base = 0x00000aa0,
+
+	/* CE base address */
+	.hal_umac_ce0_src_reg_base = 0x01b80000,
+	.hal_umac_ce0_dest_reg_base = 0x01b81000,
+	.hal_umac_ce1_src_reg_base = 0x01b82000,
+	.hal_umac_ce1_dest_reg_base = 0x01b83000,
+
+	.gcc_gcc_pcie_hot_rst = 0x1e38338,
+};
+
+const struct ath12k_hw_regs ipq5332_regs = {
+	/* SW2TCL(x) R0 ring configuration address */
+	.hal_tcl1_ring_id = 0x00000918,
+	.hal_tcl1_ring_misc = 0x00000920,
+	.hal_tcl1_ring_tp_addr_lsb = 0x0000092c,
+	.hal_tcl1_ring_tp_addr_msb = 0x00000930,
+	.hal_tcl1_ring_consumer_int_setup_ix0 = 0x00000940,
+	.hal_tcl1_ring_consumer_int_setup_ix1 = 0x00000944,
+	.hal_tcl1_ring_msi1_base_lsb = 0x00000958,
+	.hal_tcl1_ring_msi1_base_msb = 0x0000095c,
+	.hal_tcl1_ring_base_lsb = 0x00000910,
+	.hal_tcl1_ring_base_msb = 0x00000914,
+	.hal_tcl1_ring_msi1_data = 0x00000960,
+	.hal_tcl2_ring_base_lsb = 0x00000988,
+	.hal_tcl_ring_base_lsb = 0x00000b68,
+
+	/* TCL STATUS ring address */
+	.hal_tcl_status_ring_base_lsb = 0x00000d48,
+
+	/* REO DEST ring address */
+	.hal_reo2_ring_base = 0x00000578,
+	.hal_reo1_misc_ctrl_addr = 0x00000b9c,
+	.hal_reo1_sw_cookie_cfg0 = 0x0000006c,
+	.hal_reo1_sw_cookie_cfg1 = 0x00000070,
+	.hal_reo1_qdesc_lut_base0 = 0x00000074,
+	.hal_reo1_qdesc_lut_base1 = 0x00000078,
+	.hal_reo1_ring_base_lsb = 0x00000500,
+	.hal_reo1_ring_base_msb = 0x00000504,
+	.hal_reo1_ring_id = 0x00000508,
+	.hal_reo1_ring_misc = 0x00000510,
+	.hal_reo1_ring_hp_addr_lsb = 0x00000514,
+	.hal_reo1_ring_hp_addr_msb = 0x00000518,
+	.hal_reo1_ring_producer_int_setup = 0x00000524,
+	.hal_reo1_ring_msi1_base_lsb = 0x00000548,
+	.hal_reo1_ring_msi1_base_msb = 0x0000054C,
+	.hal_reo1_ring_msi1_data = 0x00000550,
+	.hal_reo1_aging_thres_ix0 = 0x00000B28,
+	.hal_reo1_aging_thres_ix1 = 0x00000B2C,
+	.hal_reo1_aging_thres_ix2 = 0x00000B30,
+	.hal_reo1_aging_thres_ix3 = 0x00000B34,
+
+	/* REO Exception ring address */
+	.hal_reo2_sw0_ring_base = 0x000008c0,
+
+	/* REO Reinject ring address */
+	.hal_sw2reo_ring_base = 0x00000320,
+	.hal_sw2reo1_ring_base = 0x00000398,
+
+	/* REO cmd ring address */
+	.hal_reo_cmd_ring_base = 0x000002A8,
+
+	/* REO status ring address */
+	.hal_reo_status_ring_base = 0x00000aa0,
+
+	/* WBM idle link ring address */
+	.hal_wbm_idle_ring_base_lsb = 0x00000d3c,
+	.hal_wbm_idle_ring_misc_addr = 0x00000d4c,
+	.hal_wbm_r0_idle_list_cntl_addr = 0x00000240,
+	.hal_wbm_r0_idle_list_size_addr = 0x00000244,
+	.hal_wbm_scattered_ring_base_lsb = 0x00000250,
+	.hal_wbm_scattered_ring_base_msb = 0x00000254,
+	.hal_wbm_scattered_desc_head_info_ix0 = 0x00000260,
+	.hal_wbm_scattered_desc_head_info_ix1   = 0x00000264,
+	.hal_wbm_scattered_desc_tail_info_ix0 = 0x00000270,
+	.hal_wbm_scattered_desc_tail_info_ix1 = 0x00000274,
+	.hal_wbm_scattered_desc_ptr_hp_addr = 0x0000027c,
+
+	/* SW2WBM release ring address */
+	.hal_wbm_sw_release_ring_base_lsb = 0x0000037c,
+
+	/* WBM2SW release ring address */
+	.hal_wbm0_release_ring_base_lsb = 0x00000e08,
+	.hal_wbm1_release_ring_base_lsb = 0x00000e80,
+
+	/* PPE release ring address */
+	.hal_ppe_rel_ring_base = 0x0000046c,
+
+	/* CE address */
+	.hal_umac_ce0_src_reg_base = 0x00740000 -
+		HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.hal_umac_ce0_dest_reg_base = 0x00741000 -
+		HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.hal_umac_ce1_src_reg_base = 0x00742000 -
+		HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.hal_umac_ce1_dest_reg_base = 0x00743000 -
+		HAL_IPQ5332_CE_WFSS_REG_BASE,
+};
+
 static inline
 bool ath12k_hal_rx_desc_get_first_msdu_qcn9274(struct hal_rx_desc *desc)
 {
@@ -571,6 +841,24 @@ void ath12k_hal_extract_rx_desc_data_qcn9274(struct hal_rx_desc_data *rx_desc_da
 	rx_desc_data->err_bitmap = ath12k_hal_rx_h_mpdu_err_qcn9274(rx_desc);
 }
 
+const struct ath12k_hw_hal_params ath12k_hw_hal_params_qcn9274 = {
+	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
+	.wbm2sw_cc_enable = HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW0_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW1_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW2_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW3_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN,
+};
+
+const struct ath12k_hw_hal_params ath12k_hw_hal_params_ipq5332 = {
+	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
+	.wbm2sw_cc_enable = HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW0_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW1_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW2_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW3_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN,
+};
+
 static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
 {
 	struct ath12k_hal *hal = &ab->hal;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
index 1b431d5b6417..c48dd029f52e 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
@@ -13,8 +13,13 @@
 #include "hal_rx.h"
 
 extern const struct hal_ops hal_qcn9274_ops;
+extern const struct ath12k_hw_regs qcn9274_v1_regs;
+extern const struct ath12k_hw_regs qcn9274_v2_regs;
+extern const struct ath12k_hw_regs ipq5332_regs;
 extern const struct ath12k_hal_tcl_to_wbm_rbm_map
 ath12k_hal_tcl_to_wbm_rbm_map_qcn9274[DP_TCL_NUM_RING_MAX];
+extern const struct ath12k_hw_hal_params ath12k_hw_hal_params_qcn9274;
+extern const struct ath12k_hw_hal_params ath12k_hw_hal_params_ipq5332;
 
 u8 ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274(struct hal_rx_desc *desc);
 void ath12k_hal_rx_desc_copy_end_tlv_qcn9274(struct hal_rx_desc *fdesc,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 3e88a1e68b87..b3ed7c8d738d 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -6,6 +6,8 @@
 
 #include "hal_desc.h"
 #include "hal_wcn7850.h"
+#include "hw.h"
+#include "hal.h"
 
 static const struct hal_srng_config hw_srng_config_template[] = {
 	/* TODO: max_rings can populated by querying HW capabilities */
@@ -210,6 +212,93 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 	}
 };
 
+const struct ath12k_hw_regs wcn7850_regs = {
+	/* SW2TCL(x) R0 ring configuration address */
+	.hal_tcl1_ring_id = 0x00000908,
+	.hal_tcl1_ring_misc = 0x00000910,
+	.hal_tcl1_ring_tp_addr_lsb = 0x0000091c,
+	.hal_tcl1_ring_tp_addr_msb = 0x00000920,
+	.hal_tcl1_ring_consumer_int_setup_ix0 = 0x00000930,
+	.hal_tcl1_ring_consumer_int_setup_ix1 = 0x00000934,
+	.hal_tcl1_ring_msi1_base_lsb = 0x00000948,
+	.hal_tcl1_ring_msi1_base_msb = 0x0000094c,
+	.hal_tcl1_ring_msi1_data = 0x00000950,
+	.hal_tcl_ring_base_lsb = 0x00000b58,
+	.hal_tcl1_ring_base_lsb = 0x00000900,
+	.hal_tcl1_ring_base_msb = 0x00000904,
+	.hal_tcl2_ring_base_lsb = 0x00000978,
+
+	/* TCL STATUS ring address */
+	.hal_tcl_status_ring_base_lsb = 0x00000d38,
+
+	.hal_wbm_idle_ring_base_lsb = 0x00000d3c,
+	.hal_wbm_idle_ring_misc_addr = 0x00000d4c,
+	.hal_wbm_r0_idle_list_cntl_addr = 0x00000240,
+	.hal_wbm_r0_idle_list_size_addr = 0x00000244,
+	.hal_wbm_scattered_ring_base_lsb = 0x00000250,
+	.hal_wbm_scattered_ring_base_msb = 0x00000254,
+	.hal_wbm_scattered_desc_head_info_ix0 = 0x00000260,
+	.hal_wbm_scattered_desc_head_info_ix1 = 0x00000264,
+	.hal_wbm_scattered_desc_tail_info_ix0 = 0x00000270,
+	.hal_wbm_scattered_desc_tail_info_ix1 = 0x00000274,
+	.hal_wbm_scattered_desc_ptr_hp_addr = 0x00000027c,
+
+	.hal_wbm_sw_release_ring_base_lsb = 0x0000037c,
+	.hal_wbm_sw1_release_ring_base_lsb = 0x00000284,
+	.hal_wbm0_release_ring_base_lsb = 0x00000e08,
+	.hal_wbm1_release_ring_base_lsb = 0x00000e80,
+
+	/* PCIe base address */
+	.pcie_qserdes_sysclk_en_sel = 0x01e0e0a8,
+	.pcie_pcs_osc_dtct_config_base = 0x01e0f45c,
+
+	/* PPE release ring address */
+	.hal_ppe_rel_ring_base = 0x0000043c,
+
+	/* REO DEST ring address */
+	.hal_reo2_ring_base = 0x0000055c,
+	.hal_reo1_misc_ctrl_addr = 0x00000b7c,
+	.hal_reo1_sw_cookie_cfg0 = 0x00000050,
+	.hal_reo1_sw_cookie_cfg1 = 0x00000054,
+	.hal_reo1_qdesc_lut_base0 = 0x00000058,
+	.hal_reo1_qdesc_lut_base1 = 0x0000005c,
+	.hal_reo1_ring_base_lsb = 0x000004e4,
+	.hal_reo1_ring_base_msb = 0x000004e8,
+	.hal_reo1_ring_id = 0x000004ec,
+	.hal_reo1_ring_misc = 0x000004f4,
+	.hal_reo1_ring_hp_addr_lsb = 0x000004f8,
+	.hal_reo1_ring_hp_addr_msb = 0x000004fc,
+	.hal_reo1_ring_producer_int_setup = 0x00000508,
+	.hal_reo1_ring_msi1_base_lsb = 0x0000052C,
+	.hal_reo1_ring_msi1_base_msb = 0x00000530,
+	.hal_reo1_ring_msi1_data = 0x00000534,
+	.hal_reo1_aging_thres_ix0 = 0x00000b08,
+	.hal_reo1_aging_thres_ix1 = 0x00000b0c,
+	.hal_reo1_aging_thres_ix2 = 0x00000b10,
+	.hal_reo1_aging_thres_ix3 = 0x00000b14,
+
+	/* REO Exception ring address */
+	.hal_reo2_sw0_ring_base = 0x000008a4,
+
+	/* REO Reinject ring address */
+	.hal_sw2reo_ring_base = 0x00000304,
+	.hal_sw2reo1_ring_base = 0x0000037c,
+
+	/* REO cmd ring address */
+	.hal_reo_cmd_ring_base = 0x0000028c,
+
+	/* REO status ring address */
+	.hal_reo_status_ring_base = 0x00000a84,
+
+	/* CE base address */
+	.hal_umac_ce0_src_reg_base = 0x01b80000,
+	.hal_umac_ce0_dest_reg_base = 0x01b81000,
+	.hal_umac_ce1_src_reg_base = 0x01b82000,
+	.hal_umac_ce1_dest_reg_base = 0x01b83000,
+
+	.gcc_gcc_pcie_hot_rst = 0x1e40304,
+};
+
 static inline
 bool ath12k_hal_rx_desc_get_first_msdu_wcn7850(struct hal_rx_desc *desc)
 {
@@ -706,6 +795,14 @@ ath12k_hal_tcl_to_wbm_rbm_map_wcn7850[DP_TCL_NUM_RING_MAX] = {
 	},
 };
 
+const struct ath12k_hw_hal_params ath12k_hw_hal_params_wcn7850 = {
+	.rx_buf_rbm = HAL_RX_BUF_RBM_SW1_BM,
+	.wbm2sw_cc_enable = HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW0_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW2_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW3_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN,
+};
+
 const struct hal_ops hal_wcn7850_ops = {
 	.create_srng_config = ath12k_hal_srng_create_config_wcn7850,
 	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_wcn7850,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
index 2df4976f59aa..7d0b0c985446 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
@@ -11,8 +11,10 @@
 #include "hal_rx.h"
 
 extern const struct hal_ops hal_wcn7850_ops;
+extern const struct ath12k_hw_regs wcn7850_regs;
 extern const struct ath12k_hal_tcl_to_wbm_rbm_map
 ath12k_hal_tcl_to_wbm_rbm_map_wcn7850[DP_TCL_NUM_RING_MAX];
+extern const struct ath12k_hw_hal_params ath12k_hw_hal_params_wcn7850;
 
 u8 ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850(struct hal_rx_desc *desc);
 void ath12k_hal_rx_desc_copy_end_tlv_wcn7850(struct hal_rx_desc *fdesc,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index f469a829ae9a..01c859f35a93 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -310,387 +310,6 @@ static const struct ath12k_hw_ring_mask ath12k_wifi7_hw_ring_mask_wcn7850 = {
 	},
 };
 
-static const struct ath12k_hw_regs qcn9274_v1_regs = {
-	/* SW2TCL(x) R0 ring configuration address */
-	.hal_tcl1_ring_id = 0x00000908,
-	.hal_tcl1_ring_misc = 0x00000910,
-	.hal_tcl1_ring_tp_addr_lsb = 0x0000091c,
-	.hal_tcl1_ring_tp_addr_msb = 0x00000920,
-	.hal_tcl1_ring_consumer_int_setup_ix0 = 0x00000930,
-	.hal_tcl1_ring_consumer_int_setup_ix1 = 0x00000934,
-	.hal_tcl1_ring_msi1_base_lsb = 0x00000948,
-	.hal_tcl1_ring_msi1_base_msb = 0x0000094c,
-	.hal_tcl1_ring_msi1_data = 0x00000950,
-	.hal_tcl_ring_base_lsb = 0x00000b58,
-	.hal_tcl1_ring_base_lsb = 0x00000900,
-	.hal_tcl1_ring_base_msb = 0x00000904,
-	.hal_tcl2_ring_base_lsb = 0x00000978,
-
-	/* TCL STATUS ring address */
-	.hal_tcl_status_ring_base_lsb = 0x00000d38,
-
-	.hal_wbm_idle_ring_base_lsb = 0x00000d0c,
-	.hal_wbm_idle_ring_misc_addr = 0x00000d1c,
-	.hal_wbm_r0_idle_list_cntl_addr = 0x00000210,
-	.hal_wbm_r0_idle_list_size_addr = 0x00000214,
-	.hal_wbm_scattered_ring_base_lsb = 0x00000220,
-	.hal_wbm_scattered_ring_base_msb = 0x00000224,
-	.hal_wbm_scattered_desc_head_info_ix0 = 0x00000230,
-	.hal_wbm_scattered_desc_head_info_ix1 = 0x00000234,
-	.hal_wbm_scattered_desc_tail_info_ix0 = 0x00000240,
-	.hal_wbm_scattered_desc_tail_info_ix1 = 0x00000244,
-	.hal_wbm_scattered_desc_ptr_hp_addr = 0x0000024c,
-
-	.hal_wbm_sw_release_ring_base_lsb = 0x0000034c,
-	.hal_wbm_sw1_release_ring_base_lsb = 0x000003c4,
-	.hal_wbm0_release_ring_base_lsb = 0x00000dd8,
-	.hal_wbm1_release_ring_base_lsb = 0x00000e50,
-
-	/* PCIe base address */
-	.pcie_qserdes_sysclk_en_sel = 0x01e0c0a8,
-	.pcie_pcs_osc_dtct_config_base = 0x01e0d45c,
-
-	/* PPE release ring address */
-	.hal_ppe_rel_ring_base = 0x0000043c,
-
-	/* REO DEST ring address */
-	.hal_reo2_ring_base = 0x0000055c,
-	.hal_reo1_misc_ctrl_addr = 0x00000b7c,
-	.hal_reo1_sw_cookie_cfg0 = 0x00000050,
-	.hal_reo1_sw_cookie_cfg1 = 0x00000054,
-	.hal_reo1_qdesc_lut_base0 = 0x00000058,
-	.hal_reo1_qdesc_lut_base1 = 0x0000005c,
-	.hal_reo1_ring_base_lsb = 0x000004e4,
-	.hal_reo1_ring_base_msb = 0x000004e8,
-	.hal_reo1_ring_id = 0x000004ec,
-	.hal_reo1_ring_misc = 0x000004f4,
-	.hal_reo1_ring_hp_addr_lsb = 0x000004f8,
-	.hal_reo1_ring_hp_addr_msb = 0x000004fc,
-	.hal_reo1_ring_producer_int_setup = 0x00000508,
-	.hal_reo1_ring_msi1_base_lsb = 0x0000052C,
-	.hal_reo1_ring_msi1_base_msb = 0x00000530,
-	.hal_reo1_ring_msi1_data = 0x00000534,
-	.hal_reo1_aging_thres_ix0 = 0x00000b08,
-	.hal_reo1_aging_thres_ix1 = 0x00000b0c,
-	.hal_reo1_aging_thres_ix2 = 0x00000b10,
-	.hal_reo1_aging_thres_ix3 = 0x00000b14,
-
-	/* REO Exception ring address */
-	.hal_reo2_sw0_ring_base = 0x000008a4,
-
-	/* REO Reinject ring address */
-	.hal_sw2reo_ring_base = 0x00000304,
-	.hal_sw2reo1_ring_base = 0x0000037c,
-
-	/* REO cmd ring address */
-	.hal_reo_cmd_ring_base = 0x0000028c,
-
-	/* REO status ring address */
-	.hal_reo_status_ring_base = 0x00000a84,
-
-	/* CE base address */
-	.hal_umac_ce0_src_reg_base = 0x01b80000,
-	.hal_umac_ce0_dest_reg_base = 0x01b81000,
-	.hal_umac_ce1_src_reg_base = 0x01b82000,
-	.hal_umac_ce1_dest_reg_base = 0x01b83000,
-
-	.gcc_gcc_pcie_hot_rst = 0x1e38338,
-};
-
-static const struct ath12k_hw_regs qcn9274_v2_regs = {
-	/* SW2TCL(x) R0 ring configuration address */
-	.hal_tcl1_ring_id = 0x00000908,
-	.hal_tcl1_ring_misc = 0x00000910,
-	.hal_tcl1_ring_tp_addr_lsb = 0x0000091c,
-	.hal_tcl1_ring_tp_addr_msb = 0x00000920,
-	.hal_tcl1_ring_consumer_int_setup_ix0 = 0x00000930,
-	.hal_tcl1_ring_consumer_int_setup_ix1 = 0x00000934,
-	.hal_tcl1_ring_msi1_base_lsb = 0x00000948,
-	.hal_tcl1_ring_msi1_base_msb = 0x0000094c,
-	.hal_tcl1_ring_msi1_data = 0x00000950,
-	.hal_tcl_ring_base_lsb = 0x00000b58,
-	.hal_tcl1_ring_base_lsb = 0x00000900,
-	.hal_tcl1_ring_base_msb = 0x00000904,
-	.hal_tcl2_ring_base_lsb = 0x00000978,
-
-	/* TCL STATUS ring address */
-	.hal_tcl_status_ring_base_lsb = 0x00000d38,
-
-	/* WBM idle link ring address */
-	.hal_wbm_idle_ring_base_lsb = 0x00000d3c,
-	.hal_wbm_idle_ring_misc_addr = 0x00000d4c,
-	.hal_wbm_r0_idle_list_cntl_addr = 0x00000240,
-	.hal_wbm_r0_idle_list_size_addr = 0x00000244,
-	.hal_wbm_scattered_ring_base_lsb = 0x00000250,
-	.hal_wbm_scattered_ring_base_msb = 0x00000254,
-	.hal_wbm_scattered_desc_head_info_ix0 = 0x00000260,
-	.hal_wbm_scattered_desc_head_info_ix1 = 0x00000264,
-	.hal_wbm_scattered_desc_tail_info_ix0 = 0x00000270,
-	.hal_wbm_scattered_desc_tail_info_ix1 = 0x00000274,
-	.hal_wbm_scattered_desc_ptr_hp_addr = 0x0000027c,
-
-	/* SW2WBM release ring address */
-	.hal_wbm_sw_release_ring_base_lsb = 0x0000037c,
-	.hal_wbm_sw1_release_ring_base_lsb = 0x000003f4,
-
-	/* WBM2SW release ring address */
-	.hal_wbm0_release_ring_base_lsb = 0x00000e08,
-	.hal_wbm1_release_ring_base_lsb = 0x00000e80,
-
-	/* PCIe base address */
-	.pcie_qserdes_sysclk_en_sel = 0x01e0c0a8,
-	.pcie_pcs_osc_dtct_config_base = 0x01e0d45c,
-
-	/* PPE release ring address */
-	.hal_ppe_rel_ring_base = 0x0000046c,
-
-	/* REO DEST ring address */
-	.hal_reo2_ring_base = 0x00000578,
-	.hal_reo1_misc_ctrl_addr = 0x00000b9c,
-	.hal_reo1_sw_cookie_cfg0 = 0x0000006c,
-	.hal_reo1_sw_cookie_cfg1 = 0x00000070,
-	.hal_reo1_qdesc_lut_base0 = 0x00000074,
-	.hal_reo1_qdesc_lut_base1 = 0x00000078,
-	.hal_reo1_qdesc_addr = 0x0000007c,
-	.hal_reo1_qdesc_max_peerid = 0x00000088,
-	.hal_reo1_ring_base_lsb = 0x00000500,
-	.hal_reo1_ring_base_msb = 0x00000504,
-	.hal_reo1_ring_id = 0x00000508,
-	.hal_reo1_ring_misc = 0x00000510,
-	.hal_reo1_ring_hp_addr_lsb = 0x00000514,
-	.hal_reo1_ring_hp_addr_msb = 0x00000518,
-	.hal_reo1_ring_producer_int_setup = 0x00000524,
-	.hal_reo1_ring_msi1_base_lsb = 0x00000548,
-	.hal_reo1_ring_msi1_base_msb = 0x0000054C,
-	.hal_reo1_ring_msi1_data = 0x00000550,
-	.hal_reo1_aging_thres_ix0 = 0x00000B28,
-	.hal_reo1_aging_thres_ix1 = 0x00000B2C,
-	.hal_reo1_aging_thres_ix2 = 0x00000B30,
-	.hal_reo1_aging_thres_ix3 = 0x00000B34,
-
-	/* REO Exception ring address */
-	.hal_reo2_sw0_ring_base = 0x000008c0,
-
-	/* REO Reinject ring address */
-	.hal_sw2reo_ring_base = 0x00000320,
-	.hal_sw2reo1_ring_base = 0x00000398,
-
-	/* REO cmd ring address */
-	.hal_reo_cmd_ring_base = 0x000002A8,
-
-	/* REO status ring address */
-	.hal_reo_status_ring_base = 0x00000aa0,
-
-	/* CE base address */
-	.hal_umac_ce0_src_reg_base = 0x01b80000,
-	.hal_umac_ce0_dest_reg_base = 0x01b81000,
-	.hal_umac_ce1_src_reg_base = 0x01b82000,
-	.hal_umac_ce1_dest_reg_base = 0x01b83000,
-
-	.gcc_gcc_pcie_hot_rst = 0x1e38338,
-};
-
-static const struct ath12k_hw_regs ipq5332_regs = {
-	/* SW2TCL(x) R0 ring configuration address */
-	.hal_tcl1_ring_id = 0x00000918,
-	.hal_tcl1_ring_misc = 0x00000920,
-	.hal_tcl1_ring_tp_addr_lsb = 0x0000092c,
-	.hal_tcl1_ring_tp_addr_msb = 0x00000930,
-	.hal_tcl1_ring_consumer_int_setup_ix0 = 0x00000940,
-	.hal_tcl1_ring_consumer_int_setup_ix1 = 0x00000944,
-	.hal_tcl1_ring_msi1_base_lsb = 0x00000958,
-	.hal_tcl1_ring_msi1_base_msb = 0x0000095c,
-	.hal_tcl1_ring_base_lsb = 0x00000910,
-	.hal_tcl1_ring_base_msb = 0x00000914,
-	.hal_tcl1_ring_msi1_data = 0x00000960,
-	.hal_tcl2_ring_base_lsb = 0x00000988,
-	.hal_tcl_ring_base_lsb = 0x00000b68,
-
-	/* TCL STATUS ring address */
-	.hal_tcl_status_ring_base_lsb = 0x00000d48,
-
-	/* REO DEST ring address */
-	.hal_reo2_ring_base = 0x00000578,
-	.hal_reo1_misc_ctrl_addr = 0x00000b9c,
-	.hal_reo1_sw_cookie_cfg0 = 0x0000006c,
-	.hal_reo1_sw_cookie_cfg1 = 0x00000070,
-	.hal_reo1_qdesc_lut_base0 = 0x00000074,
-	.hal_reo1_qdesc_lut_base1 = 0x00000078,
-	.hal_reo1_ring_base_lsb = 0x00000500,
-	.hal_reo1_ring_base_msb = 0x00000504,
-	.hal_reo1_ring_id = 0x00000508,
-	.hal_reo1_ring_misc = 0x00000510,
-	.hal_reo1_ring_hp_addr_lsb = 0x00000514,
-	.hal_reo1_ring_hp_addr_msb = 0x00000518,
-	.hal_reo1_ring_producer_int_setup = 0x00000524,
-	.hal_reo1_ring_msi1_base_lsb = 0x00000548,
-	.hal_reo1_ring_msi1_base_msb = 0x0000054C,
-	.hal_reo1_ring_msi1_data = 0x00000550,
-	.hal_reo1_aging_thres_ix0 = 0x00000B28,
-	.hal_reo1_aging_thres_ix1 = 0x00000B2C,
-	.hal_reo1_aging_thres_ix2 = 0x00000B30,
-	.hal_reo1_aging_thres_ix3 = 0x00000B34,
-
-	/* REO Exception ring address */
-	.hal_reo2_sw0_ring_base = 0x000008c0,
-
-	/* REO Reinject ring address */
-	.hal_sw2reo_ring_base = 0x00000320,
-	.hal_sw2reo1_ring_base = 0x00000398,
-
-	/* REO cmd ring address */
-	.hal_reo_cmd_ring_base = 0x000002A8,
-
-	/* REO status ring address */
-	.hal_reo_status_ring_base = 0x00000aa0,
-
-	/* WBM idle link ring address */
-	.hal_wbm_idle_ring_base_lsb = 0x00000d3c,
-	.hal_wbm_idle_ring_misc_addr = 0x00000d4c,
-	.hal_wbm_r0_idle_list_cntl_addr = 0x00000240,
-	.hal_wbm_r0_idle_list_size_addr = 0x00000244,
-	.hal_wbm_scattered_ring_base_lsb = 0x00000250,
-	.hal_wbm_scattered_ring_base_msb = 0x00000254,
-	.hal_wbm_scattered_desc_head_info_ix0 = 0x00000260,
-	.hal_wbm_scattered_desc_head_info_ix1   = 0x00000264,
-	.hal_wbm_scattered_desc_tail_info_ix0 = 0x00000270,
-	.hal_wbm_scattered_desc_tail_info_ix1 = 0x00000274,
-	.hal_wbm_scattered_desc_ptr_hp_addr = 0x0000027c,
-
-	/* SW2WBM release ring address */
-	.hal_wbm_sw_release_ring_base_lsb = 0x0000037c,
-
-	/* WBM2SW release ring address */
-	.hal_wbm0_release_ring_base_lsb = 0x00000e08,
-	.hal_wbm1_release_ring_base_lsb = 0x00000e80,
-
-	/* PPE release ring address */
-	.hal_ppe_rel_ring_base = 0x0000046c,
-
-	/* CE address */
-	.hal_umac_ce0_src_reg_base = 0x00740000 -
-		HAL_IPQ5332_CE_WFSS_REG_BASE,
-	.hal_umac_ce0_dest_reg_base = 0x00741000 -
-		HAL_IPQ5332_CE_WFSS_REG_BASE,
-	.hal_umac_ce1_src_reg_base = 0x00742000 -
-		HAL_IPQ5332_CE_WFSS_REG_BASE,
-	.hal_umac_ce1_dest_reg_base = 0x00743000 -
-		HAL_IPQ5332_CE_WFSS_REG_BASE,
-};
-
-static const struct ath12k_hw_regs wcn7850_regs = {
-	/* SW2TCL(x) R0 ring configuration address */
-	.hal_tcl1_ring_id = 0x00000908,
-	.hal_tcl1_ring_misc = 0x00000910,
-	.hal_tcl1_ring_tp_addr_lsb = 0x0000091c,
-	.hal_tcl1_ring_tp_addr_msb = 0x00000920,
-	.hal_tcl1_ring_consumer_int_setup_ix0 = 0x00000930,
-	.hal_tcl1_ring_consumer_int_setup_ix1 = 0x00000934,
-	.hal_tcl1_ring_msi1_base_lsb = 0x00000948,
-	.hal_tcl1_ring_msi1_base_msb = 0x0000094c,
-	.hal_tcl1_ring_msi1_data = 0x00000950,
-	.hal_tcl_ring_base_lsb = 0x00000b58,
-	.hal_tcl1_ring_base_lsb = 0x00000900,
-	.hal_tcl1_ring_base_msb = 0x00000904,
-	.hal_tcl2_ring_base_lsb = 0x00000978,
-
-	/* TCL STATUS ring address */
-	.hal_tcl_status_ring_base_lsb = 0x00000d38,
-
-	.hal_wbm_idle_ring_base_lsb = 0x00000d3c,
-	.hal_wbm_idle_ring_misc_addr = 0x00000d4c,
-	.hal_wbm_r0_idle_list_cntl_addr = 0x00000240,
-	.hal_wbm_r0_idle_list_size_addr = 0x00000244,
-	.hal_wbm_scattered_ring_base_lsb = 0x00000250,
-	.hal_wbm_scattered_ring_base_msb = 0x00000254,
-	.hal_wbm_scattered_desc_head_info_ix0 = 0x00000260,
-	.hal_wbm_scattered_desc_head_info_ix1 = 0x00000264,
-	.hal_wbm_scattered_desc_tail_info_ix0 = 0x00000270,
-	.hal_wbm_scattered_desc_tail_info_ix1 = 0x00000274,
-	.hal_wbm_scattered_desc_ptr_hp_addr = 0x00000027c,
-
-	.hal_wbm_sw_release_ring_base_lsb = 0x0000037c,
-	.hal_wbm_sw1_release_ring_base_lsb = 0x00000284,
-	.hal_wbm0_release_ring_base_lsb = 0x00000e08,
-	.hal_wbm1_release_ring_base_lsb = 0x00000e80,
-
-	/* PCIe base address */
-	.pcie_qserdes_sysclk_en_sel = 0x01e0e0a8,
-	.pcie_pcs_osc_dtct_config_base = 0x01e0f45c,
-
-	/* PPE release ring address */
-	.hal_ppe_rel_ring_base = 0x0000043c,
-
-	/* REO DEST ring address */
-	.hal_reo2_ring_base = 0x0000055c,
-	.hal_reo1_misc_ctrl_addr = 0x00000b7c,
-	.hal_reo1_sw_cookie_cfg0 = 0x00000050,
-	.hal_reo1_sw_cookie_cfg1 = 0x00000054,
-	.hal_reo1_qdesc_lut_base0 = 0x00000058,
-	.hal_reo1_qdesc_lut_base1 = 0x0000005c,
-	.hal_reo1_ring_base_lsb = 0x000004e4,
-	.hal_reo1_ring_base_msb = 0x000004e8,
-	.hal_reo1_ring_id = 0x000004ec,
-	.hal_reo1_ring_misc = 0x000004f4,
-	.hal_reo1_ring_hp_addr_lsb = 0x000004f8,
-	.hal_reo1_ring_hp_addr_msb = 0x000004fc,
-	.hal_reo1_ring_producer_int_setup = 0x00000508,
-	.hal_reo1_ring_msi1_base_lsb = 0x0000052C,
-	.hal_reo1_ring_msi1_base_msb = 0x00000530,
-	.hal_reo1_ring_msi1_data = 0x00000534,
-	.hal_reo1_aging_thres_ix0 = 0x00000b08,
-	.hal_reo1_aging_thres_ix1 = 0x00000b0c,
-	.hal_reo1_aging_thres_ix2 = 0x00000b10,
-	.hal_reo1_aging_thres_ix3 = 0x00000b14,
-
-	/* REO Exception ring address */
-	.hal_reo2_sw0_ring_base = 0x000008a4,
-
-	/* REO Reinject ring address */
-	.hal_sw2reo_ring_base = 0x00000304,
-	.hal_sw2reo1_ring_base = 0x0000037c,
-
-	/* REO cmd ring address */
-	.hal_reo_cmd_ring_base = 0x0000028c,
-
-	/* REO status ring address */
-	.hal_reo_status_ring_base = 0x00000a84,
-
-	/* CE base address */
-	.hal_umac_ce0_src_reg_base = 0x01b80000,
-	.hal_umac_ce0_dest_reg_base = 0x01b81000,
-	.hal_umac_ce1_src_reg_base = 0x01b82000,
-	.hal_umac_ce1_dest_reg_base = 0x01b83000,
-
-	.gcc_gcc_pcie_hot_rst = 0x1e40304,
-};
-
-static const struct ath12k_hw_hal_params ath12k_wifi7_hw_hal_params_qcn9274 = {
-	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
-	.wbm2sw_cc_enable = HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW0_EN |
-			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW1_EN |
-			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW2_EN |
-			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW3_EN |
-			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN,
-};
-
-static const struct ath12k_hw_hal_params ath12k_wifi7_hw_hal_params_wcn7850 = {
-	.rx_buf_rbm = HAL_RX_BUF_RBM_SW1_BM,
-	.wbm2sw_cc_enable = HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW0_EN |
-			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW2_EN |
-			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW3_EN |
-			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN,
-};
-
-static const struct ath12k_hw_hal_params ath12k_wifi7_hw_hal_params_ipq5332 = {
-	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
-	.wbm2sw_cc_enable = HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW0_EN |
-			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW1_EN |
-			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW2_EN |
-			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW3_EN |
-			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN,
-};
-
 static const struct ce_ie_addr ath12k_wifi7_ce_ie_addr_ipq5332 = {
 	.ie1_reg_addr = CE_HOST_IE_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
 	.ie2_reg_addr = CE_HOST_IE_2_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
@@ -720,7 +339,6 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 
 		.hw_ops = &qcn9274_ops,
 		.ring_mask = &ath12k_wifi7_hw_ring_mask_qcn9274,
-		.regs = &qcn9274_v1_regs,
 
 		.host_ce_config = ath12k_wifi7_host_ce_config_qcn9274,
 		.ce_count = 16,
@@ -730,8 +348,6 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			ath12k_wifi7_target_service_to_ce_map_wlan_qcn9274,
 		.svc_to_ce_map_len = 18,
 
-		.hal_params = &ath12k_wifi7_hw_hal_params_qcn9274,
-
 		.rxdma1_enable = false,
 		.num_rxdma_per_pdev = 1,
 		.num_rxdma_dst_ring = 0,
@@ -806,7 +422,6 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 
 		.hw_ops = &wcn7850_ops,
 		.ring_mask = &ath12k_wifi7_hw_ring_mask_wcn7850,
-		.regs = &wcn7850_regs,
 
 		.host_ce_config = ath12k_wifi7_host_ce_config_wcn7850,
 		.ce_count = 9,
@@ -816,8 +431,6 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			ath12k_wifi7_target_service_to_ce_map_wlan_wcn7850,
 		.svc_to_ce_map_len = 14,
 
-		.hal_params = &ath12k_wifi7_hw_hal_params_wcn7850,
-
 		.rxdma1_enable = false,
 		.num_rxdma_per_pdev = 2,
 		.num_rxdma_dst_ring = 1,
@@ -892,7 +505,6 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 
 		.hw_ops = &qcn9274_ops,
 		.ring_mask = &ath12k_wifi7_hw_ring_mask_qcn9274,
-		.regs = &qcn9274_v2_regs,
 
 		.host_ce_config = ath12k_wifi7_host_ce_config_qcn9274,
 		.ce_count = 16,
@@ -902,8 +514,6 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			ath12k_wifi7_target_service_to_ce_map_wlan_qcn9274,
 		.svc_to_ce_map_len = 18,
 
-		.hal_params = &ath12k_wifi7_hw_hal_params_qcn9274,
-
 		.rxdma1_enable = true,
 		.num_rxdma_per_pdev = 1,
 		.num_rxdma_dst_ring = 0,
@@ -975,7 +585,6 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 		.internal_sleep_clock = false,
 
 		.hw_ops = &qcn9274_ops,
-		.regs = &ipq5332_regs,
 		.ring_mask = &ath12k_wifi7_hw_ring_mask_ipq5332,
 
 		.host_ce_config = ath12k_wifi7_host_ce_config_ipq5332,
@@ -986,8 +595,6 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			ath12k_wifi7_target_service_to_ce_map_wlan_ipq5332,
 		.svc_to_ce_map_len = 18,
 
-		.hal_params = &ath12k_wifi7_hw_hal_params_ipq5332,
-
 		.rxdma1_enable = false,
 		.num_rxdma_per_pdev = 1,
 		.num_rxdma_dst_ring = 0,
-- 
2.34.1


