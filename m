Return-Path: <linux-wireless+bounces-27902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B33DBC8B4D
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D0F3ABF14
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DC92DD5EB;
	Thu,  9 Oct 2025 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F0lNSWrk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0306C2DF152
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008272; cv=none; b=cXMhACWy8bN9jVC/MFdsD17Xcd+oF9F9B7ydxlSJzfgi4JIhw+BiXnVxzg/c8UE0sFABnxo53tb0hWoebXI/KPF75DS2YSlTsaV9YO5vktyLZ0jbh4uVH5xDX5jm1eOEzCWG5tS8hhj5w/l84ruPKKiApIJOgYtrwK+w8Iv07GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008272; c=relaxed/simple;
	bh=XscduHzKctDv5mfg6YToPlU5XYezLrf2fLL3N8c4vMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOouTbFwLm7Y9pyE7EwKJ1eNVGcDTrhUeobSk4Q0+C5lgR41vSoXJyh3DbGfkqowtTmzxIsgy1Euti2U+OBRiHEg4qCDalBWIDD52eEBtN9xlwGnDY8CN4CuB9FOSscgLyYtg96oU1OKIgAXX7u83an62O/vSVHyE6Qo5iB9T0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F0lNSWrk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EQMq004530;
	Thu, 9 Oct 2025 11:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8Go60odIG/YbKQH1rdeV6O0xFd/DgXkVmsI73K5fJrA=; b=F0lNSWrkHAh8meO8
	ZhlY1qjGbRwq3mEnwP8bEc3XV6NLqIEzYswVRhwJ0KvdoBMGwQ1zDgH0YIa9wNzM
	iD1vCF5AkNUlxzV3r1a+RsBJl+Xq15CGP6BPIzuLNz85G6PQQgiWfWLzSd5QM19L
	Z1z8hSWPlyKMUop8B0LFyBCEEM7bUVCz96BQQlrvKrdkze99Tn1wNm2C5u8luFG7
	FtiJqJV5AzeLjH6RkOl3vtKf9ie85BcQ7H97Q9OVbbvE/sAIt+YlCkH8cn3ylsff
	7/pH1jzuBxvN0i1gX8Y6DPAnaJpgVJAfhM1kaxa5sFDAEs8kZXWBs98n0JVq3Lm/
	m/qXCQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4j2h31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BB7wa008356
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:07 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:11:06 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 04/18] wifi: ath12k: Move wbm_rbm_map to hw specific hal files
Date: Thu, 9 Oct 2025 16:40:31 +0530
Message-ID: <20251009111045.1763001-5-quic_rdeuri@quicinc.com>
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
X-Proofpoint-GUID: KDMdIqRHRQIaXAI2raw-Wt_IKwyHYWIy
X-Proofpoint-ORIG-GUID: KDMdIqRHRQIaXAI2raw-Wt_IKwyHYWIy
X-Authority-Analysis: v=2.4 cv=f91FxeyM c=1 sm=1 tr=0 ts=68e7984c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=BLzwJ-yQ3cE5kN1FFlAA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX8uUy4Q1PCJvs
 cvMDG2MXbo7UH+hBJN+VIJAeoExsraMpZeR+fFSFUajyZY3jKRKkDXHaBPWQBZWpvRJ34qPm48p
 Qw0obyVH01pLnLRGMaXyk53sq7kB/29pkTBxR+gYsT6qj5saDYGqwweCh03B5+4xp2Vroi5+6pB
 Yvu9Zn9jw3MOw8t3m6raA5tSOirxxJJtFvfHpAgArmmNTejMH+wISWYmNLr62+Byj/ZHrdK0gZ1
 H66vOcSvitJZrn/oZQQBa5wGYslUENULb0ItUo+9gjf9LfId6QcT700GGa1xJf/VSEUTBf4zoM1
 k8XnseZJIZljpacVac+Is/h1C6O4D7a7AXLQ89O2D0aA9Vysf5/182tmbRTofDrFeLxImrsahm2
 SbS6SlmeJdsum5tA/k4UPxKyKmErxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move wbm_rbm_map from common hal file to
hw specific hal files, since these implementations are
specific and configurable for each hardware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c         |  4 +--
 drivers/net/wireless/ath/ath12k/dp.c          |  4 +--
 drivers/net/wireless/ath/ath12k/hal.c         | 36 -------------------
 drivers/net/wireless/ath/ath12k/hal.h         |  4 ++-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  2 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal.c   |  5 +++
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   | 21 ++++++++++-
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.h   |  2 +-
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   | 17 ++++++++-
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.h   |  2 +-
 10 files changed, 50 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 2c991580571c..91ee962ebc24 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -558,12 +558,10 @@ static int ath12k_ahb_config_ext_irq(struct ath12k_base *ab)
 {
 	const struct ath12k_hw_ring_mask *ring_mask;
 	struct ath12k_ext_irq_grp *irq_grp;
-	const struct hal_ops *hal_ops;
 	int i, j, irq, irq_idx, ret;
 	u32 num_irq;
 
 	ring_mask = ab->hw_params->ring_mask;
-	hal_ops = ab->hal.hal_ops;
 	for (i = 0; i < ATH12K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		irq_grp = &ab->ext_irq_grp[i];
 		num_irq = 0;
@@ -583,7 +581,7 @@ static int ath12k_ahb_config_ext_irq(struct ath12k_base *ab)
 			 * tcl_to_wbm_rbm_map point to the same ring number.
 			 */
 			if (ring_mask->tx[i] &
-			    BIT(hal_ops->tcl_to_wbm_rbm_map[j].wbm_ring_num)) {
+			    BIT(ab->hal.tcl_to_wbm_rbm_map[j].wbm_ring_num)) {
 				irq_grp->irqs[num_irq++] =
 					wbm2host_tx_completions_ring1 - j;
 			}
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 167878e9964c..b2a60b6c06ef 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -142,7 +142,7 @@ static int ath12k_dp_srng_calculate_msi_group(struct ath12k_base *ab,
 			grp_mask = &ab->hw_params->ring_mask->rx_wbm_rel[0];
 			ring_num = 0;
 		} else {
-			map = ab->hal.hal_ops->tcl_to_wbm_rbm_map;
+			map = ab->hal.tcl_to_wbm_rbm_map;
 			for (i = 0; i < ab->hw_params->max_tx_ring; i++) {
 				if (ring_num == map[i].wbm_ring_num) {
 					ring_num = i;
@@ -508,7 +508,7 @@ static int ath12k_dp_srng_common_setup(struct ath12k_base *ab)
 	}
 
 	for (i = 0; i < ab->hw_params->max_tx_ring; i++) {
-		map = ab->hal.hal_ops->tcl_to_wbm_rbm_map;
+		map = ab->hal.tcl_to_wbm_rbm_map;
 		tx_comp_ring_num = map[i].wbm_ring_num;
 
 		ret = ath12k_dp_srng_setup(ab, &dp->tx_ring[i].tcl_data_ring,
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 338a4e5244dd..d1dfbe2f9a65 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -12,42 +12,6 @@
 #include "wifi7/hal_qcn9274.h"
 #include "wifi7/hal_wcn7850.h"
 
-const struct ath12k_hal_tcl_to_wbm_rbm_map
-ath12k_hal_qcn9274_tcl_to_wbm_rbm_map[DP_TCL_NUM_RING_MAX] = {
-	{
-		.wbm_ring_num = 0,
-		.rbm_id = HAL_RX_BUF_RBM_SW0_BM,
-	},
-	{
-		.wbm_ring_num = 1,
-		.rbm_id = HAL_RX_BUF_RBM_SW1_BM,
-	},
-	{
-		.wbm_ring_num = 2,
-		.rbm_id = HAL_RX_BUF_RBM_SW2_BM,
-	},
-	{
-		.wbm_ring_num = 4,
-		.rbm_id = HAL_RX_BUF_RBM_SW4_BM,
-	}
-};
-
-const struct ath12k_hal_tcl_to_wbm_rbm_map
-ath12k_hal_wcn7850_tcl_to_wbm_rbm_map[DP_TCL_NUM_RING_MAX] = {
-	{
-		.wbm_ring_num = 0,
-		.rbm_id = HAL_RX_BUF_RBM_SW0_BM,
-	},
-	{
-		.wbm_ring_num = 2,
-		.rbm_id = HAL_RX_BUF_RBM_SW2_BM,
-	},
-	{
-		.wbm_ring_num = 4,
-		.rbm_id = HAL_RX_BUF_RBM_SW4_BM,
-	},
-};
-
 static unsigned int ath12k_hal_reo1_ring_id_offset(struct ath12k_base *ab)
 {
 	return HAL_REO1_RING_ID(ab) - HAL_REO1_RING_BASE_LSB(ab);
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 4874bebc11f7..5763a18ac046 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1473,6 +1473,8 @@ struct ath12k_hal {
 	int num_shadow_reg_configured;
 
 	u32 hal_desc_sz;
+
+	const struct ath12k_hal_tcl_to_wbm_rbm_map *tcl_to_wbm_rbm_map;
 };
 
 /* Maps WBM ring number and Return Buffer Manager Id per TCL ring */
@@ -1582,11 +1584,11 @@ enum nl80211_he_ru_alloc ath12k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
 struct ath12k_hw_version_map {
 	const struct hal_ops *hal_ops;
 	u32 hal_desc_sz;
+	const struct ath12k_hal_tcl_to_wbm_rbm_map *tcl_to_wbm_rbm_map;
 };
 
 struct hal_ops {
 	int (*create_srng_config)(struct ath12k_base *ab);
-	const struct ath12k_hal_tcl_to_wbm_rbm_map *tcl_to_wbm_rbm_map;
 	void (*rx_desc_set_msdu_len)(struct hal_rx_desc *desc, u16 len);
 	void (*rx_desc_get_dot11_hdr)(struct hal_rx_desc *desc,
 				      struct ieee80211_hdr *hdr);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index 036bacd704e9..b3c0f8a6a5ce 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -107,7 +107,7 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 	ti.ring_id = ring_selector % ab->hw_params->max_tx_ring;
 
 	ring_map |= BIT(ti.ring_id);
-	ti.rbm_id = ab->hal.hal_ops->tcl_to_wbm_rbm_map[ti.ring_id].rbm_id;
+	ti.rbm_id = ab->hal.tcl_to_wbm_rbm_map[ti.ring_id].rbm_id;
 
 	tx_ring = &dp->tx_ring[ti.ring_id];
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index 0e3930c8575a..53ea3792ef51 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -14,18 +14,22 @@ static const struct ath12k_hw_version_map ath12k_wifi7_hw_ver_map[] = {
 	[ATH12K_HW_QCN9274_HW10] = {
 		.hal_ops = &hal_qcn9274_ops,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
+		.tcl_to_wbm_rbm_map = ath12k_hal_tcl_to_wbm_rbm_map_qcn9274,
 	},
 	[ATH12K_HW_QCN9274_HW20] = {
 		.hal_ops = &hal_qcn9274_ops,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
+		.tcl_to_wbm_rbm_map = ath12k_hal_tcl_to_wbm_rbm_map_qcn9274,
 	},
 	[ATH12K_HW_WCN7850_HW20] = {
 		.hal_ops = &hal_wcn7850_ops,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn7850),
+		.tcl_to_wbm_rbm_map = ath12k_hal_tcl_to_wbm_rbm_map_wcn7850,
 	},
 	[ATH12K_HW_IPQ5332_HW10] = {
 		.hal_ops = &hal_qcn9274_ops,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
+		.tcl_to_wbm_rbm_map = ath12k_hal_tcl_to_wbm_rbm_map_qcn9274,
 	},
 };
 
@@ -37,6 +41,7 @@ int ath12k_wifi7_hal_init(struct ath12k_base *ab)
 
 	hal->hal_ops = ath12k_wifi7_hw_ver_map[ab->hw_rev].hal_ops;
 	hal->hal_desc_sz = ath12k_wifi7_hw_ver_map[ab->hw_rev].hal_desc_sz;
+	hal->tcl_to_wbm_rbm_map = ath12k_wifi7_hw_ver_map[ab->hw_rev].tcl_to_wbm_rbm_map;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index 6a1c13565700..fefa151efaef 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -681,9 +681,28 @@ static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
 	return 0;
 }
 
+const struct ath12k_hal_tcl_to_wbm_rbm_map
+ath12k_hal_tcl_to_wbm_rbm_map_qcn9274[DP_TCL_NUM_RING_MAX] = {
+	{
+		.wbm_ring_num = 0,
+		.rbm_id = HAL_RX_BUF_RBM_SW0_BM,
+	},
+	{
+		.wbm_ring_num = 1,
+		.rbm_id = HAL_RX_BUF_RBM_SW1_BM,
+	},
+	{
+		.wbm_ring_num = 2,
+		.rbm_id = HAL_RX_BUF_RBM_SW2_BM,
+	},
+	{
+		.wbm_ring_num = 4,
+		.rbm_id = HAL_RX_BUF_RBM_SW4_BM,
+	},
+};
+
 const struct hal_ops hal_qcn9274_ops = {
 	.create_srng_config = ath12k_hal_srng_create_config_qcn9274,
-	.tcl_to_wbm_rbm_map = ath12k_hal_qcn9274_tcl_to_wbm_rbm_map,
 	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_qcn9274,
 	.rx_desc_get_dot11_hdr = ath12k_hal_rx_desc_get_dot11_hdr_qcn9274,
 	.rx_desc_get_crypto_header = ath12k_hal_rx_desc_get_crypto_hdr_qcn9274,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
index 4d08292d8a7f..1b431d5b6417 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
@@ -14,7 +14,7 @@
 
 extern const struct hal_ops hal_qcn9274_ops;
 extern const struct ath12k_hal_tcl_to_wbm_rbm_map
-ath12k_hal_qcn9274_tcl_to_wbm_rbm_map[DP_TCL_NUM_RING_MAX];
+ath12k_hal_tcl_to_wbm_rbm_map_qcn9274[DP_TCL_NUM_RING_MAX];
 
 u8 ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274(struct hal_rx_desc *desc);
 void ath12k_hal_rx_desc_copy_end_tlv_qcn9274(struct hal_rx_desc *fdesc,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 275de9c1a359..3e88a1e68b87 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -690,9 +690,24 @@ static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
 	return 0;
 }
 
+const struct ath12k_hal_tcl_to_wbm_rbm_map
+ath12k_hal_tcl_to_wbm_rbm_map_wcn7850[DP_TCL_NUM_RING_MAX] = {
+	{
+		.wbm_ring_num = 0,
+		.rbm_id = HAL_RX_BUF_RBM_SW0_BM,
+	},
+	{
+		.wbm_ring_num = 2,
+		.rbm_id = HAL_RX_BUF_RBM_SW2_BM,
+	},
+	{
+		.wbm_ring_num = 4,
+		.rbm_id = HAL_RX_BUF_RBM_SW4_BM,
+	},
+};
+
 const struct hal_ops hal_wcn7850_ops = {
 	.create_srng_config = ath12k_hal_srng_create_config_wcn7850,
-	.tcl_to_wbm_rbm_map = ath12k_hal_wcn7850_tcl_to_wbm_rbm_map,
 	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_wcn7850,
 	.rx_desc_get_dot11_hdr = ath12k_hal_rx_desc_get_dot11_hdr_wcn7850,
 	.rx_desc_get_crypto_header = ath12k_hal_rx_desc_get_crypto_hdr_wcn7850,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
index 8207e73602b3..2df4976f59aa 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
@@ -12,7 +12,7 @@
 
 extern const struct hal_ops hal_wcn7850_ops;
 extern const struct ath12k_hal_tcl_to_wbm_rbm_map
-ath12k_hal_wcn7850_tcl_to_wbm_rbm_map[DP_TCL_NUM_RING_MAX];
+ath12k_hal_tcl_to_wbm_rbm_map_wcn7850[DP_TCL_NUM_RING_MAX];
 
 u8 ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850(struct hal_rx_desc *desc);
 void ath12k_hal_rx_desc_copy_end_tlv_wcn7850(struct hal_rx_desc *fdesc,
-- 
2.34.1


