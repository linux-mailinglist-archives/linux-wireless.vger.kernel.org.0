Return-Path: <linux-wireless+bounces-27913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BDABC8B71
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCE02352D6B
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED20E2E0419;
	Thu,  9 Oct 2025 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LfEcbZ0q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A8B2E266A
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008287; cv=none; b=n8L/azdTiU5qyRrSe8hF6K4BoQzdcDW3iRHkxu4FXSLa+ey9QcnYCmheFwrsDUqAXheuYBF8rAoPmaqa4EEsgqC5wjnvuxJ0QzXgZYXDqVtjV/fY749vFJnyFA+immBInQtjYDzxPEYI0lRCyTg+G1VNp3u0zLB34nrG3brbVJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008287; c=relaxed/simple;
	bh=NPRmn6k3/8+Cu1wOnkJG+5QqgyxtLvLAMRd1dgCbjR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EA3ScDnwwncEJm9fVHZYfL1qGSxrE074MqkBU7wAXjClV7yOF4rlCWw9DoSAVxCaFsOEY24brXiDDp0lc+VRbhqINH3wZ58Xw63p9BIfpjH63jYiDWf0aD2VHqYdhys5SdKzVccGt4rHdDuvOVGZZoQ0x5ENIcWXmwRXPVeaaNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LfEcbZ0q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EOjY029749;
	Thu, 9 Oct 2025 11:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vjz3lyetlEMQt7IUGMIq84+X1u1V9tuigBe1HItqC+c=; b=LfEcbZ0qg6OsS6iZ
	A/m5omvlL2rpLYsmxcPK66N74v849aK3L3sMaNfU3R1HeX8KSy2pvhzJfhtNxJ/1
	CDTvnDZTSvyaLBYyFkl7Dj++PkjPXf3A1nLlalWfevhO73v0Ug5L1KrgaLnc+aTP
	hzgrR5+wBsWYDvHcF1kMZmBC9xyrdUSAfW2sZAX/HufKysexRnJBwstCFDEle6ZM
	FzrndZBxU6V6FwEHWlSJwFxf8VuiNsJT0NYjpHcn2+eDxX3qluoH/vh5YZpdd0s2
	zflbL53Dv3XAnEYOwm8DOyTQJ7KhLwbAK8smCdWS8OdATSW2d9GILn1C+Ou8BJut
	lsBoTQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nah3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BBM8n022001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:22 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:11:21 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 14/18] wifi: ath12k: Move HAL Cookie Conversion and RBM related APIs to wifi7 directory
Date: Thu, 9 Oct 2025 16:40:41 +0530
Message-ID: <20251009111045.1763001-15-quic_rdeuri@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=ZJzaWH7b c=1 sm=1 tr=0 ts=68e7985b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=nloMc1UKMNAEPNwcCPgA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: OKMMhjsuDjmOnhDeoWa1eNai3BHTf_uj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX+hsdO2yPqWMJ
 /6wwiXpnZivtnpXocLg06slKf70t2wETXq/f0xjkFl18T5XOqW9wnRXAN8mmn9uwdo8B7lKW/Fa
 EBQZbmyTDvzvQdxVzfZVcpbSqdT8sZ6CEoVIbsTlmublFlsxhQCwqr5SpTcaX/TSCu6ymi1Gkx+
 FLYUxJIFunEZe3WKo3Mo2Tm1NvEAFhbmzmYVwIEAUWCgF33FntG6BUpo0FzXFJMcEYSgHY3ul4q
 aNKNHaUZjjQRGm/cFg2jqL8m9deBt+k+XlIewTraXLez0Mu2AlmGWSpZGglVXB5HTfrfIZRwWg6
 c6HWoCruC1eJ/QeFCaytuSxf3AfXtfNv4BdysP6al9MzDVkPFrKFiI9PkiMhytnpvc4JFZgw8gH
 Wv9C4yB+a4rGMKrj9bOe7Uj8mOmdUQ==
X-Proofpoint-GUID: OKMMhjsuDjmOnhDeoWa1eNai3BHTf_uj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move the hardware specific HAL APIs to hal.c file
inside wifi7 directory. These APIs will be called
through the hal_ops mechanism, which are registered
separately by qcn and wcn

Handling following APIs:
ath12k_wifi7_hal_cc_config
ath12k_wifi7_hal_get_idle_link_rbm

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c        |  2 +-
 drivers/net/wireless/ath/ath12k/dp.c          | 75 +------------------
 drivers/net/wireless/ath/ath12k/dp.h          |  1 -
 drivers/net/wireless/ath/ath12k/hal.c         | 11 +++
 drivers/net/wireless/ath/ath12k/hal.h         |  6 ++
 drivers/net/wireless/ath/ath12k/wifi7/hal.c   | 73 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/hal.h   |  3 +
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  2 +
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  2 +
 9 files changed, 100 insertions(+), 75 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 7b51261b1170..1adbdd571a0f 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -922,7 +922,7 @@ static int ath12k_core_start(struct ath12k_base *ab)
 		goto err_hif_stop;
 	}
 
-	ath12k_dp_cc_config(ab);
+	ath12k_hal_cc_config(ab);
 
 	ret = ath12k_dp_rx_pdev_reo_setup(ab);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index faba234a6671..0f02924ecdeb 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1192,60 +1192,6 @@ static void ath12k_dp_cleanup(struct ath12k_base *ab)
 	/* Deinit any SOC level resource */
 }
 
-void ath12k_dp_cc_config(struct ath12k_base *ab)
-{
-	u32 cmem_base = ab->qmi.dev_mem[ATH12K_QMI_DEVMEM_CMEM_INDEX].start;
-	u32 reo_base = HAL_SEQ_WCSS_UMAC_REO_REG;
-	u32 wbm_base = HAL_SEQ_WCSS_UMAC_WBM_REG;
-	u32 val = 0;
-	struct ath12k_hal *hal = &ab->hal;
-
-	if (ath12k_ftm_mode)
-		return;
-
-	ath12k_hif_write32(ab, reo_base + HAL_REO1_SW_COOKIE_CFG0(hal), cmem_base);
-
-	val |= u32_encode_bits(ATH12K_CMEM_ADDR_MSB,
-			       HAL_REO1_SW_COOKIE_CFG_CMEM_BASE_ADDR_MSB) |
-		u32_encode_bits(ATH12K_CC_PPT_MSB,
-				HAL_REO1_SW_COOKIE_CFG_COOKIE_PPT_MSB) |
-		u32_encode_bits(ATH12K_CC_SPT_MSB,
-				HAL_REO1_SW_COOKIE_CFG_COOKIE_SPT_MSB) |
-		u32_encode_bits(1, HAL_REO1_SW_COOKIE_CFG_ALIGN) |
-		u32_encode_bits(1, HAL_REO1_SW_COOKIE_CFG_ENABLE) |
-		u32_encode_bits(1, HAL_REO1_SW_COOKIE_CFG_GLOBAL_ENABLE);
-
-	ath12k_hif_write32(ab, reo_base + HAL_REO1_SW_COOKIE_CFG1(hal), val);
-
-	/* Enable HW CC for WBM */
-	ath12k_hif_write32(ab, wbm_base + HAL_WBM_SW_COOKIE_CFG0, cmem_base);
-
-	val = u32_encode_bits(ATH12K_CMEM_ADDR_MSB,
-			      HAL_WBM_SW_COOKIE_CFG_CMEM_BASE_ADDR_MSB) |
-		u32_encode_bits(ATH12K_CC_PPT_MSB,
-				HAL_WBM_SW_COOKIE_CFG_COOKIE_PPT_MSB) |
-		u32_encode_bits(ATH12K_CC_SPT_MSB,
-				HAL_WBM_SW_COOKIE_CFG_COOKIE_SPT_MSB) |
-		u32_encode_bits(1, HAL_WBM_SW_COOKIE_CFG_ALIGN);
-
-	ath12k_hif_write32(ab, wbm_base + HAL_WBM_SW_COOKIE_CFG1, val);
-
-	/* Enable conversion complete indication */
-	val = ath12k_hif_read32(ab, wbm_base + HAL_WBM_SW_COOKIE_CFG2);
-	val |= u32_encode_bits(1, HAL_WBM_SW_COOKIE_CFG_RELEASE_PATH_EN) |
-		u32_encode_bits(1, HAL_WBM_SW_COOKIE_CFG_ERR_PATH_EN) |
-		u32_encode_bits(1, HAL_WBM_SW_COOKIE_CFG_CONV_IND_EN);
-
-	ath12k_hif_write32(ab, wbm_base + HAL_WBM_SW_COOKIE_CFG2, val);
-
-	/* Enable Cookie conversion for WBM2SW Rings */
-	val = ath12k_hif_read32(ab, wbm_base + HAL_WBM_SW_COOKIE_CONVERT_CFG);
-	val |= u32_encode_bits(1, HAL_WBM_SW_COOKIE_CONV_CFG_GLOBAL_EN) |
-	       hal->hal_params->wbm2sw_cc_enable;
-
-	ath12k_hif_write32(ab, wbm_base + HAL_WBM_SW_COOKIE_CONVERT_CFG, val);
-}
-
 static u32 ath12k_dp_cc_cookie_gen(u16 ppt_idx, u16 spt_idx)
 {
 	return (u32)ppt_idx << ATH12K_CC_PPT_SHIFT | spt_idx;
@@ -1570,24 +1516,6 @@ static int ath12k_dp_reoq_lut_setup(struct ath12k_base *ab)
 	return 0;
 }
 
-static enum hal_rx_buf_return_buf_manager
-ath12k_dp_get_idle_link_rbm(struct ath12k_base *ab)
-{
-	switch (ab->device_id) {
-	case 0:
-		return HAL_RX_BUF_RBM_WBM_DEV0_IDLE_DESC_LIST;
-	case 1:
-		return HAL_RX_BUF_RBM_WBM_DEV1_IDLE_DESC_LIST;
-	case 2:
-		return HAL_RX_BUF_RBM_WBM_DEV2_IDLE_DESC_LIST;
-	default:
-		ath12k_warn(ab, "invalid %d device id, so choose default rbm\n",
-			    ab->device_id);
-		WARN_ON(1);
-		return HAL_RX_BUF_RBM_WBM_DEV0_IDLE_DESC_LIST;
-	}
-}
-
 static int ath12k_dp_setup(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp;
@@ -1605,7 +1533,8 @@ static int ath12k_dp_setup(struct ath12k_base *ab)
 	spin_lock_init(&dp->reo_cmd_lock);
 
 	dp->reo_cmd_cache_flush_count = 0;
-	dp->idle_link_rbm = ath12k_dp_get_idle_link_rbm(ab);
+	dp->idle_link_rbm =
+			ath12k_hal_get_idle_link_rbm(&ab->hal, ab->device_id);
 
 	ret = ath12k_wbm_idle_ring_setup(ab, &n_link_desc);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 9690e3472ab7..2655b4d96f43 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -505,7 +505,6 @@ ath12k_dp_to_pdev_dp(struct ath12k_dp *dp, u8 pdev_idx)
 }
 
 void ath12k_dp_vdev_tx_attach(struct ath12k *ar, struct ath12k_link_vif *arvif);
-void ath12k_dp_cc_config(struct ath12k_base *ab);
 void ath12k_dp_partner_cc_init(struct ath12k_base *ab);
 int ath12k_dp_pdev_alloc(struct ath12k_base *ab);
 void ath12k_dp_pdev_pre_alloc(struct ath12k *ar);
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 00cd6dcb5bad..528138a1dc18 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -121,6 +121,17 @@ void ath12k_hal_rx_buf_addr_info_get(struct ath12k_hal *hal,
 	hal->hal_ops->rx_buf_addr_info_get(binfo, paddr, msdu_cookies, rbm);
 }
 
+void ath12k_hal_cc_config(struct ath12k_base *ab)
+{
+	ab->hal.hal_ops->cc_config(ab);
+}
+
+enum hal_rx_buf_return_buf_manager
+ath12k_hal_get_idle_link_rbm(struct ath12k_hal *hal, u8 device_id)
+{
+	return hal->hal_ops->get_idle_link_rbm(hal, device_id);
+}
+
 static int ath12k_hal_alloc_cont_rdp(struct ath12k_hal *hal)
 {
 	size_t size;
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 2e85299f3685..0de5e1aa6405 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1737,6 +1737,9 @@ struct hal_ops {
 	void (*rx_buf_addr_info_get)(struct ath12k_buffer_addr *binfo,
 				     dma_addr_t *paddr, u32 *msdu_cookies,
 				     u8 *rbm);
+	void (*cc_config)(struct ath12k_base *ab);
+	enum hal_rx_buf_return_buf_manager
+		(*get_idle_link_rbm)(struct ath12k_hal *hal, u8 device_id);
 };
 
 u32 ath12k_wifi7_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
@@ -1817,4 +1820,7 @@ void ath12k_hal_rx_buf_addr_info_get(struct ath12k_hal *hal,
 				     struct ath12k_buffer_addr *binfo,
 				     dma_addr_t *paddr, u32 *msdu_cookies,
 				     u8 *rbm);
+void ath12k_hal_cc_config(struct ath12k_base *ab);
+enum hal_rx_buf_return_buf_manager
+ath12k_hal_get_idle_link_rbm(struct ath12k_hal *hal, u8 device_id);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index 73d86dedadb1..4f9f1efbbfcf 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -630,3 +630,76 @@ void ath12k_wifi7_hal_write_ml_reoq_lut_addr(struct ath12k_base *ab,
 	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG +
 			   HAL_REO1_QDESC_LUT_BASE1(&ab->hal), paddr);
 }
+
+void ath12k_wifi7_hal_cc_config(struct ath12k_base *ab)
+{
+	u32 cmem_base = ab->qmi.dev_mem[ATH12K_QMI_DEVMEM_CMEM_INDEX].start;
+	u32 reo_base = HAL_SEQ_WCSS_UMAC_REO_REG;
+	u32 wbm_base = HAL_SEQ_WCSS_UMAC_WBM_REG;
+	u32 val = 0;
+	struct ath12k_hal *hal = &ab->hal;
+
+	if (ath12k_ftm_mode)
+		return;
+
+	ath12k_hif_write32(ab, reo_base + HAL_REO1_SW_COOKIE_CFG0(hal), cmem_base);
+
+	val |= u32_encode_bits(ATH12K_CMEM_ADDR_MSB,
+			       HAL_REO1_SW_COOKIE_CFG_CMEM_BASE_ADDR_MSB) |
+		u32_encode_bits(ATH12K_CC_PPT_MSB,
+				HAL_REO1_SW_COOKIE_CFG_COOKIE_PPT_MSB) |
+		u32_encode_bits(ATH12K_CC_SPT_MSB,
+				HAL_REO1_SW_COOKIE_CFG_COOKIE_SPT_MSB) |
+		u32_encode_bits(1, HAL_REO1_SW_COOKIE_CFG_ALIGN) |
+		u32_encode_bits(1, HAL_REO1_SW_COOKIE_CFG_ENABLE) |
+		u32_encode_bits(1, HAL_REO1_SW_COOKIE_CFG_GLOBAL_ENABLE);
+
+	ath12k_hif_write32(ab, reo_base + HAL_REO1_SW_COOKIE_CFG1(hal), val);
+
+	/* Enable HW CC for WBM */
+	ath12k_hif_write32(ab, wbm_base + HAL_WBM_SW_COOKIE_CFG0, cmem_base);
+
+	val = u32_encode_bits(ATH12K_CMEM_ADDR_MSB,
+			      HAL_WBM_SW_COOKIE_CFG_CMEM_BASE_ADDR_MSB) |
+		u32_encode_bits(ATH12K_CC_PPT_MSB,
+				HAL_WBM_SW_COOKIE_CFG_COOKIE_PPT_MSB) |
+		u32_encode_bits(ATH12K_CC_SPT_MSB,
+				HAL_WBM_SW_COOKIE_CFG_COOKIE_SPT_MSB) |
+		u32_encode_bits(1, HAL_WBM_SW_COOKIE_CFG_ALIGN);
+
+	ath12k_hif_write32(ab, wbm_base + HAL_WBM_SW_COOKIE_CFG1, val);
+
+	/* Enable conversion complete indication */
+	val = ath12k_hif_read32(ab, wbm_base + HAL_WBM_SW_COOKIE_CFG2);
+	val |= u32_encode_bits(1, HAL_WBM_SW_COOKIE_CFG_RELEASE_PATH_EN) |
+		u32_encode_bits(1, HAL_WBM_SW_COOKIE_CFG_ERR_PATH_EN) |
+		u32_encode_bits(1, HAL_WBM_SW_COOKIE_CFG_CONV_IND_EN);
+
+	ath12k_hif_write32(ab, wbm_base + HAL_WBM_SW_COOKIE_CFG2, val);
+
+	/* Enable Cookie conversion for WBM2SW Rings */
+	val = ath12k_hif_read32(ab, wbm_base + HAL_WBM_SW_COOKIE_CONVERT_CFG);
+	val |= u32_encode_bits(1, HAL_WBM_SW_COOKIE_CONV_CFG_GLOBAL_EN) |
+	       hal->hal_params->wbm2sw_cc_enable;
+
+	ath12k_hif_write32(ab, wbm_base + HAL_WBM_SW_COOKIE_CONVERT_CFG, val);
+}
+
+enum hal_rx_buf_return_buf_manager
+ath12k_wifi7_hal_get_idle_link_rbm(struct ath12k_hal *hal, u8 device_id)
+{
+	switch (device_id) {
+	case 0:
+		return HAL_RX_BUF_RBM_WBM_DEV0_IDLE_DESC_LIST;
+	case 1:
+		return HAL_RX_BUF_RBM_WBM_DEV1_IDLE_DESC_LIST;
+	case 2:
+		return HAL_RX_BUF_RBM_WBM_DEV2_IDLE_DESC_LIST;
+	default:
+		ath12k_warn(hal,
+			    "invalid %d device id, so choose default rbm\n",
+			    device_id);
+		WARN_ON(1);
+		return HAL_RX_BUF_RBM_WBM_DEV0_IDLE_DESC_LIST;
+	}
+}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.h b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
index 6e67f06ffa43..b600b2e3cb78 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
@@ -23,6 +23,9 @@ int ath12k_wifi7_hal_srng_get_ring_id(struct ath12k_hal *hal,
 				      enum hal_ring_type type,
 				      int ring_num, int mac_id);
 u32 ath12k_wifi7_hal_ce_get_desc_size(enum hal_ce_desc type);
+void ath12k_wifi7_hal_cc_config(struct ath12k_base *ab);
+enum hal_rx_buf_return_buf_manager
+ath12k_wifi7_hal_get_idle_link_rbm(struct ath12k_hal *hal, u8 device_id);
 void ath12k_wifi7_hal_ce_src_set_desc(struct hal_ce_srng_src_desc *desc,
 				      dma_addr_t paddr,
 				      u32 len, u32 id, u8 byte_swap_data);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index fb723e971f5d..2dc4f1539d68 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -1024,5 +1024,7 @@ const struct hal_ops hal_qcn9274_ops = {
 	.reo_hw_setup = ath12k_wifi7_hal_reo_hw_setup,
 	.rx_buf_addr_info_set = ath12k_wifi7_hal_rx_buf_addr_info_set,
 	.rx_buf_addr_info_get = ath12k_wifi7_hal_rx_buf_addr_info_get,
+	.cc_config = ath12k_wifi7_hal_cc_config,
+	.get_idle_link_rbm = ath12k_wifi7_hal_get_idle_link_rbm,
 };
 EXPORT_SYMBOL(hal_qcn9274_ops);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 33f8ddcedd83..233350ccd06e 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -839,5 +839,7 @@ const struct hal_ops hal_wcn7850_ops = {
 	.reo_hw_setup = ath12k_wifi7_hal_reo_hw_setup,
 	.rx_buf_addr_info_set = ath12k_wifi7_hal_rx_buf_addr_info_set,
 	.rx_buf_addr_info_get = ath12k_wifi7_hal_rx_buf_addr_info_get,
+	.cc_config = ath12k_wifi7_hal_cc_config,
+	.get_idle_link_rbm = ath12k_wifi7_hal_get_idle_link_rbm,
 };
 EXPORT_SYMBOL(hal_wcn7850_ops);
-- 
2.34.1


