Return-Path: <linux-wireless+bounces-27917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E09BC8B7D
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8A53B6969
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596FB19E967;
	Thu,  9 Oct 2025 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G05eaA83"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B297C25A659
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008310; cv=none; b=QVupVUeDZVp5wgmYNFo1EJ8MCgOjTM+9UcUrEi//YVRuo+grCyZu6TRdjk5WBlR4Uu5S3FG5RArGo4kedI9ipAVrwuiwfQI0ooa8TtEZM0Z4mhvsOy6eLqqD6nuyi9LQQmhAzSZMRkbTSRf5U5U00KmRG4l7oIbJ+9aLxiKG1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008310; c=relaxed/simple;
	bh=CmJ9yBbKUetzD+x3eYz8Tk7u/qPv3voP1P9lvMegfpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1awmVPmjHbxyOXh4mGF8ciOoIx9yUUCewmnYCR/gf8hKG9/XaW0fklbbaUWdQ662Bzn91cyHkWVfHnu5WygjPPBKC9ii83W1O5HVp3NoeYgwZdY3mQiCx77C9ND5SauI7/BET6wwaMK12FwJh0Gkgx/Zrp3ZfOx25eC1icCMpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G05eaA83; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EPBO029764;
	Thu, 9 Oct 2025 11:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uTUebhpiV3a4eE7MsFR51uv9RZs6d6KeCcVle6wQ7kE=; b=G05eaA83bThgzqFR
	Pmm4Qk6XEcPdsFRzKePI2XJ/lxVSC6jClPXNiOV+9Ozv44VIzwXJeNYV0bdo+qUo
	SUxdU+lH/zjnaS3RURI7Ii8Ldx4bN+R56S1uLTxXLolEmLLtofS75dW7Z84rNHpd
	zsy+MuQ6c7Wv0VaEmhAtwLU4xZfg0SanCfZxwTdYqYXZbRYExSo9DakMpGE8VU/+
	qrQDWzzsyuaZTVGes3nzEQZHi1fKwEhRCaFztyPxC+P1OcHIRUVBL34ECjAHYvNL
	GYDPK+rPpYWX10WR6aD1WkQVpiC5lAzr4LBSBgzxL3OOblxrE+GDqRHPBZc7beXf
	Mb/eAg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nah46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BBSCw009102
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:28 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:11:26 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 18/18] wifi: ath12k: Drop hal_ prefix from hardware register names
Date: Thu, 9 Oct 2025 16:40:45 +0530
Message-ID: <20251009111045.1763001-19-quic_rdeuri@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=ZJzaWH7b c=1 sm=1 tr=0 ts=68e79860 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=1cZl-D-JA15i60oHfWkA:9
 a=TJCq-gOzEa1vjmNJ:21 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: fL8CIV9KgV271fcLNJUS6Bs_p6RHxadX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX024mjd3HWgMe
 s2tEs+ARsIqDyaM00jjsZNxyf5wcEmMTQjCs/KWwI8Xp153sBy9yNghOzO1eAFHRI/5yfPT1nLG
 8APpeYYRaGjVGxIlNRDdVHyZL3zh69isSIGvOOTdsFgXNwRBH1UM1oOslLxxtVK7V/DKUUANsuA
 4x5AZQWNZcF6ty10h7bD9E+/a0Az2MIXqs8S12xhZX58WHJyN8rNjHnFn6OZltyZk/NWu0zFJIK
 wuaTkLKKX2izkSTgvNL6my8/5pdG/4txXRJBb9HdTfX229Ae51WNcpbySRhyHG9fHDaPeu1dYqI
 iRX0eQrPnwJD9UWz6z8uFW+pN+DTv8JKVXDR1S5uG3LlIAsGpoKCgPiX86Dop2jPAfInu+uZko8
 VMsEGJSJovPjAz/X88Self26cVzlEg==
X-Proofpoint-GUID: fL8CIV9KgV271fcLNJUS6Bs_p6RHxadX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Remove the hal_ prefix from hardware register names in ath12k_hw_regs
as the registers have been moved from ab->regs to hal->regs.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.h         | 142 +++----
 drivers/net/wireless/ath/ath12k/wifi7/hal.h   | 122 +++---
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   | 360 +++++++++---------
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   | 122 +++---
 4 files changed, 373 insertions(+), 373 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 68c873a1f454..dbf07c15481b 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1032,81 +1032,81 @@ struct ath12k_hw_hal_params {
 };
 
 struct ath12k_hw_regs {
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
+	u32 tcl1_ring_id;
+	u32 tcl1_ring_misc;
+	u32 tcl1_ring_tp_addr_lsb;
+	u32 tcl1_ring_tp_addr_msb;
+	u32 tcl1_ring_consumer_int_setup_ix0;
+	u32 tcl1_ring_consumer_int_setup_ix1;
+	u32 tcl1_ring_msi1_base_lsb;
+	u32 tcl1_ring_msi1_base_msb;
+	u32 tcl1_ring_msi1_data;
+	u32 tcl_ring_base_lsb;
+	u32 tcl1_ring_base_lsb;
+	u32 tcl1_ring_base_msb;
+	u32 tcl2_ring_base_lsb;
+
+	u32 tcl_status_ring_base_lsb;
+
+	u32 reo1_qdesc_addr;
+	u32 reo1_qdesc_max_peerid;
+
+	u32 wbm_idle_ring_base_lsb;
+	u32 wbm_idle_ring_misc_addr;
+	u32 wbm_r0_idle_list_cntl_addr;
+	u32 wbm_r0_idle_list_size_addr;
+	u32 wbm_scattered_ring_base_lsb;
+	u32 wbm_scattered_ring_base_msb;
+	u32 wbm_scattered_desc_head_info_ix0;
+	u32 wbm_scattered_desc_head_info_ix1;
+	u32 wbm_scattered_desc_tail_info_ix0;
+	u32 wbm_scattered_desc_tail_info_ix1;
+	u32 wbm_scattered_desc_ptr_hp_addr;
+
+	u32 wbm_sw_release_ring_base_lsb;
+	u32 wbm_sw1_release_ring_base_lsb;
+	u32 wbm0_release_ring_base_lsb;
+	u32 wbm1_release_ring_base_lsb;
 
 	u32 pcie_qserdes_sysclk_en_sel;
 	u32 pcie_pcs_osc_dtct_config_base;
 
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
+	u32 umac_ce0_src_reg_base;
+	u32 umac_ce0_dest_reg_base;
+	u32 umac_ce1_src_reg_base;
+	u32 umac_ce1_dest_reg_base;
+
+	u32 ppe_rel_ring_base;
+
+	u32 reo2_ring_base;
+	u32 reo1_misc_ctrl_addr;
+	u32 reo1_sw_cookie_cfg0;
+	u32 reo1_sw_cookie_cfg1;
+	u32 reo1_qdesc_lut_base0;
+	u32 reo1_qdesc_lut_base1;
+	u32 reo1_ring_base_lsb;
+	u32 reo1_ring_base_msb;
+	u32 reo1_ring_id;
+	u32 reo1_ring_misc;
+	u32 reo1_ring_hp_addr_lsb;
+	u32 reo1_ring_hp_addr_msb;
+	u32 reo1_ring_producer_int_setup;
+	u32 reo1_ring_msi1_base_lsb;
+	u32 reo1_ring_msi1_base_msb;
+	u32 reo1_ring_msi1_data;
+	u32 reo1_aging_thres_ix0;
+	u32 reo1_aging_thres_ix1;
+	u32 reo1_aging_thres_ix2;
+	u32 reo1_aging_thres_ix3;
+
+	u32 reo2_sw0_ring_base;
+
+	u32 sw2reo_ring_base;
+	u32 sw2reo1_ring_base;
+
+	u32 reo_cmd_ring_base;
+
+	u32 reo_status_ring_base;
 
 	u32 gcc_gcc_pcie_hot_rst;
 };
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.h b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
index 8a40b9176406..0a39862d07c4 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
@@ -29,13 +29,13 @@
 #define HAL_SEQ_WCSS_UMAC_REO_REG		0x00a38000
 #define HAL_SEQ_WCSS_UMAC_TCL_REG		0x00a44000
 #define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(hal) \
-	((hal)->regs->hal_umac_ce0_src_reg_base)
+	((hal)->regs->umac_ce0_src_reg_base)
 #define HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal) \
-	((hal)->regs->hal_umac_ce0_dest_reg_base)
+	((hal)->regs->umac_ce0_dest_reg_base)
 #define HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(hal) \
-	((hal)->regs->hal_umac_ce1_src_reg_base)
+	((hal)->regs->umac_ce1_src_reg_base)
 #define HAL_SEQ_WCSS_UMAC_CE1_DST_REG(hal) \
-	((hal)->regs->hal_umac_ce1_dest_reg_base)
+	((hal)->regs->umac_ce1_dest_reg_base)
 #define HAL_SEQ_WCSS_UMAC_WBM_REG		0x00a34000
 
 #define HAL_CE_WFSS_CE_REG_BASE			0x01b80000
@@ -47,30 +47,30 @@
 #define HAL_TCL1_RING_DSCP_TID_MAP		0x00000240
 
 #define HAL_TCL1_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_tcl1_ring_base_lsb)
+	((hal)->regs->tcl1_ring_base_lsb)
 #define HAL_TCL1_RING_BASE_MSB(hal) \
-	((hal)->regs->hal_tcl1_ring_base_msb)
-#define HAL_TCL1_RING_ID(hal)		((hal)->regs->hal_tcl1_ring_id)
+	((hal)->regs->tcl1_ring_base_msb)
+#define HAL_TCL1_RING_ID(hal)		((hal)->regs->tcl1_ring_id)
 #define HAL_TCL1_RING_MISC(hal) \
-	((hal)->regs->hal_tcl1_ring_misc)
+	((hal)->regs->tcl1_ring_misc)
 #define HAL_TCL1_RING_TP_ADDR_LSB(hal) \
-	((hal)->regs->hal_tcl1_ring_tp_addr_lsb)
+	((hal)->regs->tcl1_ring_tp_addr_lsb)
 #define HAL_TCL1_RING_TP_ADDR_MSB(hal) \
-	((hal)->regs->hal_tcl1_ring_tp_addr_msb)
+	((hal)->regs->tcl1_ring_tp_addr_msb)
 #define HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0(hal) \
-	((hal)->regs->hal_tcl1_ring_consumer_int_setup_ix0)
+	((hal)->regs->tcl1_ring_consumer_int_setup_ix0)
 #define HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1(hal) \
-	((hal)->regs->hal_tcl1_ring_consumer_int_setup_ix1)
+	((hal)->regs->tcl1_ring_consumer_int_setup_ix1)
 #define HAL_TCL1_RING_MSI1_BASE_LSB(hal) \
-	((hal)->regs->hal_tcl1_ring_msi1_base_lsb)
+	((hal)->regs->tcl1_ring_msi1_base_lsb)
 #define HAL_TCL1_RING_MSI1_BASE_MSB(hal) \
-	((hal)->regs->hal_tcl1_ring_msi1_base_msb)
+	((hal)->regs->tcl1_ring_msi1_base_msb)
 #define HAL_TCL1_RING_MSI1_DATA(hal) \
-	((hal)->regs->hal_tcl1_ring_msi1_data)
+	((hal)->regs->tcl1_ring_msi1_data)
 #define HAL_TCL2_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_tcl2_ring_base_lsb)
+	((hal)->regs->tcl2_ring_base_lsb)
 #define HAL_TCL_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_tcl_ring_base_lsb)
+	((hal)->regs->tcl_ring_base_lsb)
 
 #define HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
 	(HAL_TCL1_RING_MSI1_BASE_LSB(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
@@ -104,7 +104,7 @@
 
 /* TCL STATUS ring address */
 #define HAL_TCL_STATUS_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_tcl_status_ring_base_lsb)
+	((hal)->regs->tcl_status_ring_base_lsb)
 #define HAL_TCL_STATUS_RING_HP			0x00002048
 
 /* PPE2TCL1 Ring address */
@@ -113,41 +113,41 @@
 
 /* WBM PPE Release Ring address */
 #define HAL_WBM_PPE_RELEASE_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_ppe_rel_ring_base)
+	((hal)->regs->ppe_rel_ring_base)
 #define HAL_WBM_PPE_RELEASE_RING_HP		0x00003020
 
 /* REO2SW(x) R0 ring configuration address */
 #define HAL_REO1_GEN_ENABLE			0x00000000
 #define HAL_REO1_MISC_CTRL_ADDR(hal) \
-	((hal)->regs->hal_reo1_misc_ctrl_addr)
+	((hal)->regs->reo1_misc_ctrl_addr)
 #define HAL_REO1_DEST_RING_CTRL_IX_0		0x00000004
 #define HAL_REO1_DEST_RING_CTRL_IX_1		0x00000008
 #define HAL_REO1_DEST_RING_CTRL_IX_2		0x0000000c
 #define HAL_REO1_DEST_RING_CTRL_IX_3		0x00000010
-#define HAL_REO1_QDESC_ADDR(hal)		((hal)->regs->hal_reo1_qdesc_addr)
-#define HAL_REO1_QDESC_MAX_PEERID(hal)	((hal)->regs->hal_reo1_qdesc_max_peerid)
-#define HAL_REO1_SW_COOKIE_CFG0(hal)	((hal)->regs->hal_reo1_sw_cookie_cfg0)
-#define HAL_REO1_SW_COOKIE_CFG1(hal)	((hal)->regs->hal_reo1_sw_cookie_cfg1)
-#define HAL_REO1_QDESC_LUT_BASE0(hal)	((hal)->regs->hal_reo1_qdesc_lut_base0)
-#define HAL_REO1_QDESC_LUT_BASE1(hal)	((hal)->regs->hal_reo1_qdesc_lut_base1)
-#define HAL_REO1_RING_BASE_LSB(hal)	((hal)->regs->hal_reo1_ring_base_lsb)
-#define HAL_REO1_RING_BASE_MSB(hal)	((hal)->regs->hal_reo1_ring_base_msb)
-#define HAL_REO1_RING_ID(hal)		((hal)->regs->hal_reo1_ring_id)
-#define HAL_REO1_RING_MISC(hal)		((hal)->regs->hal_reo1_ring_misc)
-#define HAL_REO1_RING_HP_ADDR_LSB(hal)	((hal)->regs->hal_reo1_ring_hp_addr_lsb)
-#define HAL_REO1_RING_HP_ADDR_MSB(hal)	((hal)->regs->hal_reo1_ring_hp_addr_msb)
+#define HAL_REO1_QDESC_ADDR(hal)		((hal)->regs->reo1_qdesc_addr)
+#define HAL_REO1_QDESC_MAX_PEERID(hal)	((hal)->regs->reo1_qdesc_max_peerid)
+#define HAL_REO1_SW_COOKIE_CFG0(hal)	((hal)->regs->reo1_sw_cookie_cfg0)
+#define HAL_REO1_SW_COOKIE_CFG1(hal)	((hal)->regs->reo1_sw_cookie_cfg1)
+#define HAL_REO1_QDESC_LUT_BASE0(hal)	((hal)->regs->reo1_qdesc_lut_base0)
+#define HAL_REO1_QDESC_LUT_BASE1(hal)	((hal)->regs->reo1_qdesc_lut_base1)
+#define HAL_REO1_RING_BASE_LSB(hal)	((hal)->regs->reo1_ring_base_lsb)
+#define HAL_REO1_RING_BASE_MSB(hal)	((hal)->regs->reo1_ring_base_msb)
+#define HAL_REO1_RING_ID(hal)		((hal)->regs->reo1_ring_id)
+#define HAL_REO1_RING_MISC(hal)		((hal)->regs->reo1_ring_misc)
+#define HAL_REO1_RING_HP_ADDR_LSB(hal)	((hal)->regs->reo1_ring_hp_addr_lsb)
+#define HAL_REO1_RING_HP_ADDR_MSB(hal)	((hal)->regs->reo1_ring_hp_addr_msb)
 #define HAL_REO1_RING_PRODUCER_INT_SETUP(hal) \
-	((hal)->regs->hal_reo1_ring_producer_int_setup)
+	((hal)->regs->reo1_ring_producer_int_setup)
 #define HAL_REO1_RING_MSI1_BASE_LSB(hal)	\
-	((hal)->regs->hal_reo1_ring_msi1_base_lsb)
+	((hal)->regs->reo1_ring_msi1_base_lsb)
 #define HAL_REO1_RING_MSI1_BASE_MSB(hal)	\
-	((hal)->regs->hal_reo1_ring_msi1_base_msb)
-#define HAL_REO1_RING_MSI1_DATA(hal)	((hal)->regs->hal_reo1_ring_msi1_data)
-#define HAL_REO2_RING_BASE_LSB(hal)	((hal)->regs->hal_reo2_ring_base)
-#define HAL_REO1_AGING_THRESH_IX_0(hal)	((hal)->regs->hal_reo1_aging_thres_ix0)
-#define HAL_REO1_AGING_THRESH_IX_1(hal)	((hal)->regs->hal_reo1_aging_thres_ix1)
-#define HAL_REO1_AGING_THRESH_IX_2(hal)	((hal)->regs->hal_reo1_aging_thres_ix2)
-#define HAL_REO1_AGING_THRESH_IX_3(hal)	((hal)->regs->hal_reo1_aging_thres_ix3)
+	((hal)->regs->reo1_ring_msi1_base_msb)
+#define HAL_REO1_RING_MSI1_DATA(hal)	((hal)->regs->reo1_ring_msi1_data)
+#define HAL_REO2_RING_BASE_LSB(hal)	((hal)->regs->reo2_ring_base)
+#define HAL_REO1_AGING_THRESH_IX_0(hal)	((hal)->regs->reo1_aging_thres_ix0)
+#define HAL_REO1_AGING_THRESH_IX_1(hal)	((hal)->regs->reo1_aging_thres_ix1)
+#define HAL_REO1_AGING_THRESH_IX_2(hal)	((hal)->regs->reo1_aging_thres_ix2)
+#define HAL_REO1_AGING_THRESH_IX_3(hal)	((hal)->regs->reo1_aging_thres_ix3)
 
 /* REO2SW(x) R2 ring pointers (head/tail) address */
 #define HAL_REO1_RING_HP			0x00003048
@@ -158,23 +158,23 @@
 
 /* REO2SW0 ring configuration address */
 #define HAL_REO_SW0_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_reo2_sw0_ring_base)
+	((hal)->regs->reo2_sw0_ring_base)
 
 /* REO2SW0 R2 ring pointer (head/tail) address */
 #define HAL_REO_SW0_RING_HP			0x00003088
 
 /* REO CMD R0 address */
 #define HAL_REO_CMD_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_reo_cmd_ring_base)
+	((hal)->regs->reo_cmd_ring_base)
 
 /* REO CMD R2 address */
 #define HAL_REO_CMD_HP				0x00003020
 
 /* SW2REO R0 address */
 #define	HAL_SW2REO_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_sw2reo_ring_base)
+	((hal)->regs->sw2reo_ring_base)
 #define HAL_SW2REO1_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_sw2reo1_ring_base)
+	((hal)->regs->sw2reo1_ring_base)
 
 /* SW2REO R2 address */
 #define HAL_SW2REO_RING_HP			0x00003028
@@ -192,41 +192,41 @@
 
 /* REO status address */
 #define HAL_REO_STATUS_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_reo_status_ring_base)
+	((hal)->regs->reo_status_ring_base)
 #define HAL_REO_STATUS_HP			0x000030a8
 
 /* WBM Idle R0 address */
 #define HAL_WBM_IDLE_LINK_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_wbm_idle_ring_base_lsb)
+	((hal)->regs->wbm_idle_ring_base_lsb)
 #define HAL_WBM_IDLE_LINK_RING_MISC_ADDR(hal) \
-	((hal)->regs->hal_wbm_idle_ring_misc_addr)
+	((hal)->regs->wbm_idle_ring_misc_addr)
 #define HAL_WBM_R0_IDLE_LIST_CONTROL_ADDR(hal) \
-	((hal)->regs->hal_wbm_r0_idle_list_cntl_addr)
+	((hal)->regs->wbm_r0_idle_list_cntl_addr)
 #define HAL_WBM_R0_IDLE_LIST_SIZE_ADDR(hal) \
-	((hal)->regs->hal_wbm_r0_idle_list_size_addr)
+	((hal)->regs->wbm_r0_idle_list_size_addr)
 #define HAL_WBM_SCATTERED_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_wbm_scattered_ring_base_lsb)
+	((hal)->regs->wbm_scattered_ring_base_lsb)
 #define HAL_WBM_SCATTERED_RING_BASE_MSB(hal) \
-	((hal)->regs->hal_wbm_scattered_ring_base_msb)
+	((hal)->regs->wbm_scattered_ring_base_msb)
 #define HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX0(hal) \
-	((hal)->regs->hal_wbm_scattered_desc_head_info_ix0)
+	((hal)->regs->wbm_scattered_desc_head_info_ix0)
 #define HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX1(hal) \
-	((hal)->regs->hal_wbm_scattered_desc_head_info_ix1)
+	((hal)->regs->wbm_scattered_desc_head_info_ix1)
 #define HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX0(hal) \
-	((hal)->regs->hal_wbm_scattered_desc_tail_info_ix0)
+	((hal)->regs->wbm_scattered_desc_tail_info_ix0)
 #define HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX1(hal) \
-	((hal)->regs->hal_wbm_scattered_desc_tail_info_ix1)
+	((hal)->regs->wbm_scattered_desc_tail_info_ix1)
 #define HAL_WBM_SCATTERED_DESC_PTR_HP_ADDR(hal) \
-	((hal)->regs->hal_wbm_scattered_desc_ptr_hp_addr)
+	((hal)->regs->wbm_scattered_desc_ptr_hp_addr)
 
 /* WBM Idle R2 address */
 #define HAL_WBM_IDLE_LINK_RING_HP		0x000030b8
 
 /* SW2WBM R0 release address */
 #define HAL_WBM_SW_RELEASE_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_wbm_sw_release_ring_base_lsb)
+	((hal)->regs->wbm_sw_release_ring_base_lsb)
 #define HAL_WBM_SW1_RELEASE_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_wbm_sw1_release_ring_base_lsb)
+	((hal)->regs->wbm_sw1_release_ring_base_lsb)
 
 /* SW2WBM R2 release address */
 #define HAL_WBM_SW_RELEASE_RING_HP		0x00003010
@@ -234,10 +234,10 @@
 
 /* WBM2SW R0 release address */
 #define HAL_WBM0_RELEASE_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_wbm0_release_ring_base_lsb)
+	((hal)->regs->wbm0_release_ring_base_lsb)
 
 #define HAL_WBM1_RELEASE_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_wbm1_release_ring_base_lsb)
+	((hal)->regs->wbm1_release_ring_base_lsb)
 
 /* WBM2SW R2 release address */
 #define HAL_WBM0_RELEASE_RING_HP		0x000030c8
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index 2dc4f1539d68..3ccd689bbf1c 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -214,269 +214,269 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 
 const struct ath12k_hw_regs qcn9274_v1_regs = {
 	/* SW2TCL(x) R0 ring configuration address */
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
+	.tcl1_ring_id = 0x00000908,
+	.tcl1_ring_misc = 0x00000910,
+	.tcl1_ring_tp_addr_lsb = 0x0000091c,
+	.tcl1_ring_tp_addr_msb = 0x00000920,
+	.tcl1_ring_consumer_int_setup_ix0 = 0x00000930,
+	.tcl1_ring_consumer_int_setup_ix1 = 0x00000934,
+	.tcl1_ring_msi1_base_lsb = 0x00000948,
+	.tcl1_ring_msi1_base_msb = 0x0000094c,
+	.tcl1_ring_msi1_data = 0x00000950,
+	.tcl_ring_base_lsb = 0x00000b58,
+	.tcl1_ring_base_lsb = 0x00000900,
+	.tcl1_ring_base_msb = 0x00000904,
+	.tcl2_ring_base_lsb = 0x00000978,
 
 	/* TCL STATUS ring address */
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
+	.tcl_status_ring_base_lsb = 0x00000d38,
+
+	.wbm_idle_ring_base_lsb = 0x00000d0c,
+	.wbm_idle_ring_misc_addr = 0x00000d1c,
+	.wbm_r0_idle_list_cntl_addr = 0x00000210,
+	.wbm_r0_idle_list_size_addr = 0x00000214,
+	.wbm_scattered_ring_base_lsb = 0x00000220,
+	.wbm_scattered_ring_base_msb = 0x00000224,
+	.wbm_scattered_desc_head_info_ix0 = 0x00000230,
+	.wbm_scattered_desc_head_info_ix1 = 0x00000234,
+	.wbm_scattered_desc_tail_info_ix0 = 0x00000240,
+	.wbm_scattered_desc_tail_info_ix1 = 0x00000244,
+	.wbm_scattered_desc_ptr_hp_addr = 0x0000024c,
+
+	.wbm_sw_release_ring_base_lsb = 0x0000034c,
+	.wbm_sw1_release_ring_base_lsb = 0x000003c4,
+	.wbm0_release_ring_base_lsb = 0x00000dd8,
+	.wbm1_release_ring_base_lsb = 0x00000e50,
 
 	/* PCIe base address */
 	.pcie_qserdes_sysclk_en_sel = 0x01e0c0a8,
 	.pcie_pcs_osc_dtct_config_base = 0x01e0d45c,
 
 	/* PPE release ring address */
-	.hal_ppe_rel_ring_base = 0x0000043c,
+	.ppe_rel_ring_base = 0x0000043c,
 
 	/* REO DEST ring address */
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
+	.reo2_ring_base = 0x0000055c,
+	.reo1_misc_ctrl_addr = 0x00000b7c,
+	.reo1_sw_cookie_cfg0 = 0x00000050,
+	.reo1_sw_cookie_cfg1 = 0x00000054,
+	.reo1_qdesc_lut_base0 = 0x00000058,
+	.reo1_qdesc_lut_base1 = 0x0000005c,
+	.reo1_ring_base_lsb = 0x000004e4,
+	.reo1_ring_base_msb = 0x000004e8,
+	.reo1_ring_id = 0x000004ec,
+	.reo1_ring_misc = 0x000004f4,
+	.reo1_ring_hp_addr_lsb = 0x000004f8,
+	.reo1_ring_hp_addr_msb = 0x000004fc,
+	.reo1_ring_producer_int_setup = 0x00000508,
+	.reo1_ring_msi1_base_lsb = 0x0000052C,
+	.reo1_ring_msi1_base_msb = 0x00000530,
+	.reo1_ring_msi1_data = 0x00000534,
+	.reo1_aging_thres_ix0 = 0x00000b08,
+	.reo1_aging_thres_ix1 = 0x00000b0c,
+	.reo1_aging_thres_ix2 = 0x00000b10,
+	.reo1_aging_thres_ix3 = 0x00000b14,
 
 	/* REO Exception ring address */
-	.hal_reo2_sw0_ring_base = 0x000008a4,
+	.reo2_sw0_ring_base = 0x000008a4,
 
 	/* REO Reinject ring address */
-	.hal_sw2reo_ring_base = 0x00000304,
-	.hal_sw2reo1_ring_base = 0x0000037c,
+	.sw2reo_ring_base = 0x00000304,
+	.sw2reo1_ring_base = 0x0000037c,
 
 	/* REO cmd ring address */
-	.hal_reo_cmd_ring_base = 0x0000028c,
+	.reo_cmd_ring_base = 0x0000028c,
 
 	/* REO status ring address */
-	.hal_reo_status_ring_base = 0x00000a84,
+	.reo_status_ring_base = 0x00000a84,
 
 	/* CE base address */
-	.hal_umac_ce0_src_reg_base = 0x01b80000,
-	.hal_umac_ce0_dest_reg_base = 0x01b81000,
-	.hal_umac_ce1_src_reg_base = 0x01b82000,
-	.hal_umac_ce1_dest_reg_base = 0x01b83000,
+	.umac_ce0_src_reg_base = 0x01b80000,
+	.umac_ce0_dest_reg_base = 0x01b81000,
+	.umac_ce1_src_reg_base = 0x01b82000,
+	.umac_ce1_dest_reg_base = 0x01b83000,
 
 	.gcc_gcc_pcie_hot_rst = 0x1e38338,
 };
 
 const struct ath12k_hw_regs qcn9274_v2_regs = {
 	/* SW2TCL(x) R0 ring configuration address */
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
+	.tcl1_ring_id = 0x00000908,
+	.tcl1_ring_misc = 0x00000910,
+	.tcl1_ring_tp_addr_lsb = 0x0000091c,
+	.tcl1_ring_tp_addr_msb = 0x00000920,
+	.tcl1_ring_consumer_int_setup_ix0 = 0x00000930,
+	.tcl1_ring_consumer_int_setup_ix1 = 0x00000934,
+	.tcl1_ring_msi1_base_lsb = 0x00000948,
+	.tcl1_ring_msi1_base_msb = 0x0000094c,
+	.tcl1_ring_msi1_data = 0x00000950,
+	.tcl_ring_base_lsb = 0x00000b58,
+	.tcl1_ring_base_lsb = 0x00000900,
+	.tcl1_ring_base_msb = 0x00000904,
+	.tcl2_ring_base_lsb = 0x00000978,
 
 	/* TCL STATUS ring address */
-	.hal_tcl_status_ring_base_lsb = 0x00000d38,
+	.tcl_status_ring_base_lsb = 0x00000d38,
 
 	/* WBM idle link ring address */
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
+	.wbm_idle_ring_base_lsb = 0x00000d3c,
+	.wbm_idle_ring_misc_addr = 0x00000d4c,
+	.wbm_r0_idle_list_cntl_addr = 0x00000240,
+	.wbm_r0_idle_list_size_addr = 0x00000244,
+	.wbm_scattered_ring_base_lsb = 0x00000250,
+	.wbm_scattered_ring_base_msb = 0x00000254,
+	.wbm_scattered_desc_head_info_ix0 = 0x00000260,
+	.wbm_scattered_desc_head_info_ix1 = 0x00000264,
+	.wbm_scattered_desc_tail_info_ix0 = 0x00000270,
+	.wbm_scattered_desc_tail_info_ix1 = 0x00000274,
+	.wbm_scattered_desc_ptr_hp_addr = 0x0000027c,
 
 	/* SW2WBM release ring address */
-	.hal_wbm_sw_release_ring_base_lsb = 0x0000037c,
-	.hal_wbm_sw1_release_ring_base_lsb = 0x000003f4,
+	.wbm_sw_release_ring_base_lsb = 0x0000037c,
+	.wbm_sw1_release_ring_base_lsb = 0x000003f4,
 
 	/* WBM2SW release ring address */
-	.hal_wbm0_release_ring_base_lsb = 0x00000e08,
-	.hal_wbm1_release_ring_base_lsb = 0x00000e80,
+	.wbm0_release_ring_base_lsb = 0x00000e08,
+	.wbm1_release_ring_base_lsb = 0x00000e80,
 
 	/* PCIe base address */
 	.pcie_qserdes_sysclk_en_sel = 0x01e0c0a8,
 	.pcie_pcs_osc_dtct_config_base = 0x01e0d45c,
 
 	/* PPE release ring address */
-	.hal_ppe_rel_ring_base = 0x0000046c,
+	.ppe_rel_ring_base = 0x0000046c,
 
 	/* REO DEST ring address */
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
+	.reo2_ring_base = 0x00000578,
+	.reo1_misc_ctrl_addr = 0x00000b9c,
+	.reo1_sw_cookie_cfg0 = 0x0000006c,
+	.reo1_sw_cookie_cfg1 = 0x00000070,
+	.reo1_qdesc_lut_base0 = 0x00000074,
+	.reo1_qdesc_lut_base1 = 0x00000078,
+	.reo1_qdesc_addr = 0x0000007c,
+	.reo1_qdesc_max_peerid = 0x00000088,
+	.reo1_ring_base_lsb = 0x00000500,
+	.reo1_ring_base_msb = 0x00000504,
+	.reo1_ring_id = 0x00000508,
+	.reo1_ring_misc = 0x00000510,
+	.reo1_ring_hp_addr_lsb = 0x00000514,
+	.reo1_ring_hp_addr_msb = 0x00000518,
+	.reo1_ring_producer_int_setup = 0x00000524,
+	.reo1_ring_msi1_base_lsb = 0x00000548,
+	.reo1_ring_msi1_base_msb = 0x0000054C,
+	.reo1_ring_msi1_data = 0x00000550,
+	.reo1_aging_thres_ix0 = 0x00000B28,
+	.reo1_aging_thres_ix1 = 0x00000B2C,
+	.reo1_aging_thres_ix2 = 0x00000B30,
+	.reo1_aging_thres_ix3 = 0x00000B34,
 
 	/* REO Exception ring address */
-	.hal_reo2_sw0_ring_base = 0x000008c0,
+	.reo2_sw0_ring_base = 0x000008c0,
 
 	/* REO Reinject ring address */
-	.hal_sw2reo_ring_base = 0x00000320,
-	.hal_sw2reo1_ring_base = 0x00000398,
+	.sw2reo_ring_base = 0x00000320,
+	.sw2reo1_ring_base = 0x00000398,
 
 	/* REO cmd ring address */
-	.hal_reo_cmd_ring_base = 0x000002A8,
+	.reo_cmd_ring_base = 0x000002A8,
 
 	/* REO status ring address */
-	.hal_reo_status_ring_base = 0x00000aa0,
+	.reo_status_ring_base = 0x00000aa0,
 
 	/* CE base address */
-	.hal_umac_ce0_src_reg_base = 0x01b80000,
-	.hal_umac_ce0_dest_reg_base = 0x01b81000,
-	.hal_umac_ce1_src_reg_base = 0x01b82000,
-	.hal_umac_ce1_dest_reg_base = 0x01b83000,
+	.umac_ce0_src_reg_base = 0x01b80000,
+	.umac_ce0_dest_reg_base = 0x01b81000,
+	.umac_ce1_src_reg_base = 0x01b82000,
+	.umac_ce1_dest_reg_base = 0x01b83000,
 
 	.gcc_gcc_pcie_hot_rst = 0x1e38338,
 };
 
 const struct ath12k_hw_regs ipq5332_regs = {
 	/* SW2TCL(x) R0 ring configuration address */
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
+	.tcl1_ring_id = 0x00000918,
+	.tcl1_ring_misc = 0x00000920,
+	.tcl1_ring_tp_addr_lsb = 0x0000092c,
+	.tcl1_ring_tp_addr_msb = 0x00000930,
+	.tcl1_ring_consumer_int_setup_ix0 = 0x00000940,
+	.tcl1_ring_consumer_int_setup_ix1 = 0x00000944,
+	.tcl1_ring_msi1_base_lsb = 0x00000958,
+	.tcl1_ring_msi1_base_msb = 0x0000095c,
+	.tcl1_ring_base_lsb = 0x00000910,
+	.tcl1_ring_base_msb = 0x00000914,
+	.tcl1_ring_msi1_data = 0x00000960,
+	.tcl2_ring_base_lsb = 0x00000988,
+	.tcl_ring_base_lsb = 0x00000b68,
 
 	/* TCL STATUS ring address */
-	.hal_tcl_status_ring_base_lsb = 0x00000d48,
+	.tcl_status_ring_base_lsb = 0x00000d48,
 
 	/* REO DEST ring address */
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
+	.reo2_ring_base = 0x00000578,
+	.reo1_misc_ctrl_addr = 0x00000b9c,
+	.reo1_sw_cookie_cfg0 = 0x0000006c,
+	.reo1_sw_cookie_cfg1 = 0x00000070,
+	.reo1_qdesc_lut_base0 = 0x00000074,
+	.reo1_qdesc_lut_base1 = 0x00000078,
+	.reo1_ring_base_lsb = 0x00000500,
+	.reo1_ring_base_msb = 0x00000504,
+	.reo1_ring_id = 0x00000508,
+	.reo1_ring_misc = 0x00000510,
+	.reo1_ring_hp_addr_lsb = 0x00000514,
+	.reo1_ring_hp_addr_msb = 0x00000518,
+	.reo1_ring_producer_int_setup = 0x00000524,
+	.reo1_ring_msi1_base_lsb = 0x00000548,
+	.reo1_ring_msi1_base_msb = 0x0000054C,
+	.reo1_ring_msi1_data = 0x00000550,
+	.reo1_aging_thres_ix0 = 0x00000B28,
+	.reo1_aging_thres_ix1 = 0x00000B2C,
+	.reo1_aging_thres_ix2 = 0x00000B30,
+	.reo1_aging_thres_ix3 = 0x00000B34,
 
 	/* REO Exception ring address */
-	.hal_reo2_sw0_ring_base = 0x000008c0,
+	.reo2_sw0_ring_base = 0x000008c0,
 
 	/* REO Reinject ring address */
-	.hal_sw2reo_ring_base = 0x00000320,
-	.hal_sw2reo1_ring_base = 0x00000398,
+	.sw2reo_ring_base = 0x00000320,
+	.sw2reo1_ring_base = 0x00000398,
 
 	/* REO cmd ring address */
-	.hal_reo_cmd_ring_base = 0x000002A8,
+	.reo_cmd_ring_base = 0x000002A8,
 
 	/* REO status ring address */
-	.hal_reo_status_ring_base = 0x00000aa0,
+	.reo_status_ring_base = 0x00000aa0,
 
 	/* WBM idle link ring address */
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
+	.wbm_idle_ring_base_lsb = 0x00000d3c,
+	.wbm_idle_ring_misc_addr = 0x00000d4c,
+	.wbm_r0_idle_list_cntl_addr = 0x00000240,
+	.wbm_r0_idle_list_size_addr = 0x00000244,
+	.wbm_scattered_ring_base_lsb = 0x00000250,
+	.wbm_scattered_ring_base_msb = 0x00000254,
+	.wbm_scattered_desc_head_info_ix0 = 0x00000260,
+	.wbm_scattered_desc_head_info_ix1   = 0x00000264,
+	.wbm_scattered_desc_tail_info_ix0 = 0x00000270,
+	.wbm_scattered_desc_tail_info_ix1 = 0x00000274,
+	.wbm_scattered_desc_ptr_hp_addr = 0x0000027c,
 
 	/* SW2WBM release ring address */
-	.hal_wbm_sw_release_ring_base_lsb = 0x0000037c,
+	.wbm_sw_release_ring_base_lsb = 0x0000037c,
 
 	/* WBM2SW release ring address */
-	.hal_wbm0_release_ring_base_lsb = 0x00000e08,
-	.hal_wbm1_release_ring_base_lsb = 0x00000e80,
+	.wbm0_release_ring_base_lsb = 0x00000e08,
+	.wbm1_release_ring_base_lsb = 0x00000e80,
 
 	/* PPE release ring address */
-	.hal_ppe_rel_ring_base = 0x0000046c,
+	.ppe_rel_ring_base = 0x0000046c,
 
 	/* CE address */
-	.hal_umac_ce0_src_reg_base = 0x00740000 -
+	.umac_ce0_src_reg_base = 0x00740000 -
 		HAL_IPQ5332_CE_WFSS_REG_BASE,
-	.hal_umac_ce0_dest_reg_base = 0x00741000 -
+	.umac_ce0_dest_reg_base = 0x00741000 -
 		HAL_IPQ5332_CE_WFSS_REG_BASE,
-	.hal_umac_ce1_src_reg_base = 0x00742000 -
+	.umac_ce1_src_reg_base = 0x00742000 -
 		HAL_IPQ5332_CE_WFSS_REG_BASE,
-	.hal_umac_ce1_dest_reg_base = 0x00743000 -
+	.umac_ce1_dest_reg_base = 0x00743000 -
 		HAL_IPQ5332_CE_WFSS_REG_BASE,
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 8151c216a5e1..8966de3d64a4 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -173,87 +173,87 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 
 const struct ath12k_hw_regs wcn7850_regs = {
 	/* SW2TCL(x) R0 ring configuration address */
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
+	.tcl1_ring_id = 0x00000908,
+	.tcl1_ring_misc = 0x00000910,
+	.tcl1_ring_tp_addr_lsb = 0x0000091c,
+	.tcl1_ring_tp_addr_msb = 0x00000920,
+	.tcl1_ring_consumer_int_setup_ix0 = 0x00000930,
+	.tcl1_ring_consumer_int_setup_ix1 = 0x00000934,
+	.tcl1_ring_msi1_base_lsb = 0x00000948,
+	.tcl1_ring_msi1_base_msb = 0x0000094c,
+	.tcl1_ring_msi1_data = 0x00000950,
+	.tcl_ring_base_lsb = 0x00000b58,
+	.tcl1_ring_base_lsb = 0x00000900,
+	.tcl1_ring_base_msb = 0x00000904,
+	.tcl2_ring_base_lsb = 0x00000978,
 
 	/* TCL STATUS ring address */
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
+	.tcl_status_ring_base_lsb = 0x00000d38,
+
+	.wbm_idle_ring_base_lsb = 0x00000d3c,
+	.wbm_idle_ring_misc_addr = 0x00000d4c,
+	.wbm_r0_idle_list_cntl_addr = 0x00000240,
+	.wbm_r0_idle_list_size_addr = 0x00000244,
+	.wbm_scattered_ring_base_lsb = 0x00000250,
+	.wbm_scattered_ring_base_msb = 0x00000254,
+	.wbm_scattered_desc_head_info_ix0 = 0x00000260,
+	.wbm_scattered_desc_head_info_ix1 = 0x00000264,
+	.wbm_scattered_desc_tail_info_ix0 = 0x00000270,
+	.wbm_scattered_desc_tail_info_ix1 = 0x00000274,
+	.wbm_scattered_desc_ptr_hp_addr = 0x00000027c,
+
+	.wbm_sw_release_ring_base_lsb = 0x0000037c,
+	.wbm_sw1_release_ring_base_lsb = 0x00000284,
+	.wbm0_release_ring_base_lsb = 0x00000e08,
+	.wbm1_release_ring_base_lsb = 0x00000e80,
 
 	/* PCIe base address */
 	.pcie_qserdes_sysclk_en_sel = 0x01e0e0a8,
 	.pcie_pcs_osc_dtct_config_base = 0x01e0f45c,
 
 	/* PPE release ring address */
-	.hal_ppe_rel_ring_base = 0x0000043c,
+	.ppe_rel_ring_base = 0x0000043c,
 
 	/* REO DEST ring address */
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
+	.reo2_ring_base = 0x0000055c,
+	.reo1_misc_ctrl_addr = 0x00000b7c,
+	.reo1_sw_cookie_cfg0 = 0x00000050,
+	.reo1_sw_cookie_cfg1 = 0x00000054,
+	.reo1_qdesc_lut_base0 = 0x00000058,
+	.reo1_qdesc_lut_base1 = 0x0000005c,
+	.reo1_ring_base_lsb = 0x000004e4,
+	.reo1_ring_base_msb = 0x000004e8,
+	.reo1_ring_id = 0x000004ec,
+	.reo1_ring_misc = 0x000004f4,
+	.reo1_ring_hp_addr_lsb = 0x000004f8,
+	.reo1_ring_hp_addr_msb = 0x000004fc,
+	.reo1_ring_producer_int_setup = 0x00000508,
+	.reo1_ring_msi1_base_lsb = 0x0000052C,
+	.reo1_ring_msi1_base_msb = 0x00000530,
+	.reo1_ring_msi1_data = 0x00000534,
+	.reo1_aging_thres_ix0 = 0x00000b08,
+	.reo1_aging_thres_ix1 = 0x00000b0c,
+	.reo1_aging_thres_ix2 = 0x00000b10,
+	.reo1_aging_thres_ix3 = 0x00000b14,
 
 	/* REO Exception ring address */
-	.hal_reo2_sw0_ring_base = 0x000008a4,
+	.reo2_sw0_ring_base = 0x000008a4,
 
 	/* REO Reinject ring address */
-	.hal_sw2reo_ring_base = 0x00000304,
-	.hal_sw2reo1_ring_base = 0x0000037c,
+	.sw2reo_ring_base = 0x00000304,
+	.sw2reo1_ring_base = 0x0000037c,
 
 	/* REO cmd ring address */
-	.hal_reo_cmd_ring_base = 0x0000028c,
+	.reo_cmd_ring_base = 0x0000028c,
 
 	/* REO status ring address */
-	.hal_reo_status_ring_base = 0x00000a84,
+	.reo_status_ring_base = 0x00000a84,
 
 	/* CE base address */
-	.hal_umac_ce0_src_reg_base = 0x01b80000,
-	.hal_umac_ce0_dest_reg_base = 0x01b81000,
-	.hal_umac_ce1_src_reg_base = 0x01b82000,
-	.hal_umac_ce1_dest_reg_base = 0x01b83000,
+	.umac_ce0_src_reg_base = 0x01b80000,
+	.umac_ce0_dest_reg_base = 0x01b81000,
+	.umac_ce1_src_reg_base = 0x01b82000,
+	.umac_ce1_dest_reg_base = 0x01b83000,
 
 	.gcc_gcc_pcie_hot_rst = 0x1e40304,
 };
-- 
2.34.1


