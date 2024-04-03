Return-Path: <linux-wireless+bounces-5783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FB2896358
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 06:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D91EB2375D
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 04:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628315235;
	Wed,  3 Apr 2024 04:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RdQ+yQUK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEAC405FD
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 04:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712117075; cv=none; b=dtaIbeij9FgHR1Z+HMfdqVNzdUDzu9rAtSSf82UZ39UfwLB0UWvKjirQn/M09cchK3NqcyXgiEd2kbZBs9MBnB4P0uxUD4NBPOJEGqQ28C4LctRpuenp3a/V0b0Ra54XL+c30ypLfl/q8YjdDOxXXQRQNwBUiTqG1oQToBsAlRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712117075; c=relaxed/simple;
	bh=vTCBO+W13WUObRb8e7v//56txDcVx70OF+qNwDgrpGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XL+Fz2hCv/NYZw7AZ5LUIgf4hCytEIhy0iOjzNrnjVlm90Z+YIay7CZzSC12AiAtFYn0s/O7pDF9yyJgVykmF3VQQGOLlA6oZyq98qL5hXiStunsYT4HpUXdBjSb/+D2DvzFkaQJPdNNHEBIb65OHJxjrgdKGNWvR6ytLDhdaIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RdQ+yQUK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433431uo006277;
	Wed, 3 Apr 2024 04:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=KSDN7PSFnVioU36mdlBgJJqbLhC+bo85EPGDeDejIYg=; b=Rd
	Q+yQUKU4xRWiltIsBgOqXnAoT2L89z8YBucLbTz8griKvwQIFnaj60VUmmXB2J88
	avqx65nbli+TMmkJNRhgdUVFGEa563n3BDTKtFjLE74P/nLeNXT1kvJvmRCYuew1
	RSm9JOhcrBQU0T+gPYzylunY/nSZO4d9+/KNHXKI4pbl0L2aa+mRvDrpU2yqL17Y
	xL6JN01HpMr6rZyX7tveR+6zxpe38pEDEHDmxzsPoggohM9ivCPzx53Ghh/+//5X
	h0D3ojHtOEWFBNl2XJZectBRRfvlUdf9wRj41U75bq3/3syLpprfatRleMrRuPbF
	6x+4xQLHpM2t/HBau+jA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8ex7tn3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 04:04:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43344TsK014147
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 04:04:29 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 21:04:27 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 1/2] wifi: ath12k: extend the link capable flag
Date: Wed, 3 Apr 2024 09:34:11 +0530
Message-ID: <20240403040412.1488095-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403040412.1488095-1-quic_periyasa@quicinc.com>
References: <20240403040412.1488095-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: hjqN0sYbx2ngXGxOes6mhkqBjILgqHUj
X-Proofpoint-ORIG-GUID: hjqN0sYbx2ngXGxOes6mhkqBjILgqHUj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_03,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=928 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030025

Link capability categorized as Single Link Operation (SLO) and Multi Link
Operation (MLO).

 - Intra-device SLO/MLO refers to links present within a device
 - Inter-device SLO/MLO refers to links present across multiple devices

Currently, driver uses a boolean variable to represent intra-device SLO/MLO
capability. To accommodate inter-device SLO/MLO capabilities within the
same variable, modify the existing variable name and type. Define a new
enumeration for the link capabilities to accommodate both intra-device
and inter-device scenarios. Populate the enum based on the supported
capabilities.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  2 +-
 drivers/net/wireless/ath/ath12k/core.h | 23 ++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/mhi.c  |  2 +-
 drivers/net/wireless/ath/ath12k/qmi.c  |  2 +-
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 391b6fb2bd42..942a4274fda1 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1227,7 +1227,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	ab->dev = dev;
 	ab->hif.bus = bus;
 	ab->qmi.num_radios = U8_MAX;
-	ab->slo_capable = true;
+	ab->mlo_capable_flags = ATH12k_INTRA_DEVICE_MLO_SUPPORT;
 
 	return ab;
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 97e5a0ccd233..e4eabd0f6e0e 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -688,6 +688,21 @@ struct ath12k_soc_dp_stats {
 	struct ath12k_soc_dp_tx_err_stats tx_err;
 };
 
+/**
+ * enum ath12k_link_capable_flags - link capable flags
+ *
+ * Single/Multi link capability information
+ *
+ * @ATH12k_INTRA_DEVICE_MLO_SUPPORT: SLO/MLO form between the radio, where all
+ *	the links (radios) present within a device.
+ * @ATH12k_INTER_DEVICE_MLO_SUPPORT: SLO/MLO form between the radio, where all
+ *	the links (radios) present across the devices.
+ */
+enum ath12k_link_capable_flags {
+	ATH12k_INTRA_DEVICE_MLO_SUPPORT	= BIT(0),
+	ATH12k_INTER_DEVICE_MLO_SUPPORT	= BIT(1),
+};
+
 /* Master structure to hold the hw data which may be used in core module */
 struct ath12k_base {
 	enum ath12k_hw_rev hw_rev;
@@ -843,10 +858,12 @@ struct ath12k_base {
 
 	const struct hal_rx_ops *hal_rx_ops;
 
-	/* slo_capable denotes if the single/multi link operation
-	 * is supported within the same chip (SoC).
+	/* mlo_capable_flags denotes the single/multi link operation
+	 * capabilities of the Device.
+	 *
+	 * See enum ath12k_link_capable_flags
 	 */
-	bool slo_capable;
+	u8 mlo_capable_flags;
 
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index adb8c3ec1950..fd519c87ae24 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -385,7 +385,7 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 				   "failed to read board id\n");
 		} else if (board_id & OTP_VALID_DUALMAC_BOARD_ID_MASK) {
 			dualmac = true;
-			ab->slo_capable = false;
+			ab->mlo_capable_flags = 0;
 			ath12k_dbg(ab, ATH12K_DBG_BOOT,
 				   "dualmac fw selected for board id: %x\n", board_id);
 		}
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 92845ffff44a..3f0d2b99127a 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2124,7 +2124,7 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 	struct qmi_txn txn;
 	int ret;
 
-	if (!ab->slo_capable)
+	if (!ab->mlo_capable_flags)
 		goto out;
 
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
-- 
2.34.1


