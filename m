Return-Path: <linux-wireless+bounces-2637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BFF83FEBA
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 07:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE711F23693
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D484EB47;
	Mon, 29 Jan 2024 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SoUPFErq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018BD4D5BC
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706511478; cv=none; b=LBCJaaj0KXJl7wNz1xyDUAJDDXmA4kZ5aqHvJYGhAXWLA96oT3EKU9M7TfqNjkb8fEykS7r/j0SNFYLY1H/uXiJ+1A6K8Xg/yHupsDwcve9qhPPWtG+fCBg+w2tkS4AT9qn7zbh3QFB1vyKgrnZf2WG23bqvzJWo9j3VsaI6MSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706511478; c=relaxed/simple;
	bh=WEOdGRuHxgek6WS7HCZhpV9eWluletCCj1dELAe0UsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udC8cECTi8IetfZstqnbrdBKWa6oB+k/OlDqw3kSLQ4K5/XWcs6K50Chq3FllsE9pR3vbDEtpZnNgcc+nO/DN3D/T8uptpW7lE7f83Hacsa7xAH46YDbREQs1YJku0dRzslEfawDD2va0UrEC7CGW0u79sE8tAegHayIK/I6qQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SoUPFErq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T4UKhu017194;
	Mon, 29 Jan 2024 06:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=a4a2dwt+kF7W6aCnTQ8kGcmczbsbeGjOA6TcoUHZxpA=; b=So
	UPFErqHK+tL6hYu4ghEkGAOgmx+eZTtVMrzVFJsXCfMyCESdlE4rUiPZgqfDIYwj
	pD52l8+3UoUHySR1W4hKnzzJSDIJ8CfEPocrKXMnMdLX9tzo52of4OZaoubgCmaI
	P82f/+UQksa/RV2xQC9MzVF5DXTyEKlpmPqQSH1WsbBmh4VIjxXpKT+KisHAH2EG
	kD82FBTGEdZIBR7v+g85DtZuPBZ/5ecR9hsPqu16nGL2RqEe6DE8LrWMV7vZdEDs
	QZDh6uTwux1MLAXb/wVIzXX/6+ZzCCiC8xnfNr4J+n584SkWKc0YqLZlmxrzOOVG
	fhMZf6zPAe5yHXIiP7Bg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx3t2gb60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:57:53 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T6vrF6025084
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:57:53 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 22:57:51 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Harshitha Prem <quic_hprem@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v3 03/13] wifi: ath12k: add support for peer meta data version
Date: Mon, 29 Jan 2024 12:27:14 +0530
Message-ID: <20240129065724.2310207-4-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7aGaOv0qQSPzzzZ_mgCzFU_iyAtbyOsc
X-Proofpoint-GUID: 7aGaOv0qQSPzzzZ_mgCzFU_iyAtbyOsc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_03,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290048

From: Harshitha Prem <quic_hprem@quicinc.com>

Add support to process WMI_TLV_SERVICE_PEER_METADATA_V1A_V1B_SUPPORT
service bit. If this service bit is set by firmware, then it expects
host to set rx_peer_meta_data_ver in wmi_resource_config's flags2
with value 3 for QCN9274 to indicate as V1B meta version. If this is
not set firmware crash is seen during peer addition.

Hence, if WMI_TLV_SERVICE_PEER_METADATA_V1A_V1B_SUPPORT service bit
is set by firmware, set correct peer metadata version to avoid
firmware crash.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.h  | 4 +++-
 drivers/net/wireless/ath/ath12k/wmi.c | 6 ++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 0c3b416ae150..44ba3a50e075 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_HW_H
@@ -66,6 +66,8 @@
 #define TARGET_NUM_WDS_ENTRIES		32
 #define TARGET_DMA_BURST_SIZE		1
 #define TARGET_RX_BATCHMODE		1
+#define TARGET_RX_PEER_METADATA_VER_V1A	2
+#define TARGET_RX_PEER_METADATA_VER_V1B	3
 
 #define ATH12K_HW_MAX_QUEUES		4
 #define ATH12K_QUEUE_LEN		4096
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 487ca82bd17d..276351d68efb 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -228,6 +228,9 @@ void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 	config->peer_map_unmap_version = 0x32;
 	config->twt_ap_pdev_count = ab->num_radios;
 	config->twt_ap_sta_count = 1000;
+
+	if (test_bit(WMI_TLV_SERVICE_PEER_METADATA_V1A_V1B_SUPPORT, ab->wmi_ab.svc_map))
+		config->dp_peer_meta_data_ver = TARGET_RX_PEER_METADATA_VER_V1B;
 }
 
 void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
@@ -3266,6 +3269,9 @@ ath12k_wmi_copy_resource_config(struct ath12k_wmi_resource_config_params *wmi_cf
 	wmi_cfg->sched_params = cpu_to_le32(tg_cfg->sched_params);
 	wmi_cfg->twt_ap_pdev_count = cpu_to_le32(tg_cfg->twt_ap_pdev_count);
 	wmi_cfg->twt_ap_sta_count = cpu_to_le32(tg_cfg->twt_ap_sta_count);
+	wmi_cfg->flags2 = le32_encode_bits(tg_cfg->dp_peer_meta_data_ver,
+					   WMI_RSRC_CFG_FLAGS2_RX_PEER_METADATA_VERSION);
+
 	wmi_cfg->host_service_flags = cpu_to_le32(tg_cfg->is_reg_cc_ext_event_supported <<
 				WMI_RSRC_CFG_HOST_SVC_FLAG_REG_CC_EXT_SUPPORT_BIT);
 }
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 06b931222321..7443831d62d8 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2163,6 +2163,8 @@ enum wmi_tlv_service {
 
 	WMI_TLV_SERVICE_11BE = 289,
 
+	WMI_TLV_SERVICE_PEER_METADATA_V1A_V1B_SUPPORT = 365,
+
 	WMI_MAX_EXT2_SERVICE,
 };
 
@@ -2350,6 +2352,7 @@ struct ath12k_wmi_resource_config_arg {
 	u32 twt_ap_pdev_count;
 	u32 twt_ap_sta_count;
 	bool is_reg_cc_ext_event_supported;
+	u8  dp_peer_meta_data_ver;
 };
 
 struct ath12k_wmi_init_cmd_arg {
@@ -2402,6 +2405,7 @@ struct wmi_init_cmd {
 } __packed;
 
 #define WMI_RSRC_CFG_HOST_SVC_FLAG_REG_CC_EXT_SUPPORT_BIT 4
+#define WMI_RSRC_CFG_FLAGS2_RX_PEER_METADATA_VERSION		GENMASK(5, 4)
 
 struct ath12k_wmi_resource_config_params {
 	__le32 tlv_header;
-- 
2.34.1


