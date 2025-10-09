Return-Path: <linux-wireless+bounces-27900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E38EBC8B47
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 657964E129D
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2794A2DF3C6;
	Thu,  9 Oct 2025 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VyScMj9e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415DC241CB7
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008270; cv=none; b=ihCL33IA442P/0W3BMIAdXqfsGZqX9flPBGzCp+S+TCnR6w3tcubt187HhID2GJXRZ8Y1PQAPY5BJ9tB8mRoP295jGp15Yq6/aoWf4eY1HCHypWLl1qrKjNWaou6+1Dr7TAODLttkAAC0ZjPyZ8N7SEUpRik722z+nGsU0abqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008270; c=relaxed/simple;
	bh=r60bcbSXPWc/jv1SJ5XhhSC+ygHUA6CT4zM6wuQbwf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CG2CBG2iasigTNt4gbofgZUrFtju5XujZTdbRhy0okUokkcuXi/SwjkJXA8mMe2P1ujoB5ocvvWiO4de+wKMXKD9xuvvtbh1xxxjIcsNVjZNkDUrsdw7Y7HtmRDOQWVwETTj2SYwpQvR6Xehj9GUBbzq9kKU6s3mAuCEHBkyHQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VyScMj9e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EHPS029042;
	Thu, 9 Oct 2025 11:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A9sNNP+JwhIaxTkSFTFKaCtJHaBqaCFXYt2lKx35gT0=; b=VyScMj9eCDJE6jBb
	TkynfhAoPlr518cyhi+fij03Xkz1FVi2PunkX5ghv53MgVE9rw//q5JdxKU7RSup
	ILffWSM8wVaIoXEQ0dI3fm1CMvsopXVn+2/guDFTu4+1yrGsgTiqibFEA5R4Zx3i
	WCwFy4x3Pck8an9S8lOwjVmXwBzyLXH9ahkxoJaNlrU4q4Qv7EyOypHlI5YRpAoI
	r3iCQeLdz4Jh8VLsgq0nQGCOwX/gNbuF5+goqhgdCVBNTjtrRma+w7woWOXYEXZB
	iopEV15iz06eLZUfHSMPfW/yhv+sZCmdfFYOdzVAUvsbpFqU66nwESozOPYEZkmR
	XeC/zQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kthas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BB4vg021522
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:04 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:11:03 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 02/18] wifi: ath12k: Initialize desc_size through hal_init
Date: Thu, 9 Oct 2025 16:40:29 +0530
Message-ID: <20251009111045.1763001-3-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX9d5vWUyGdZBp
 HTcoQYRpolmq5wUjykBpLSz3Z+xBEvrAptafT6yP5FFvoGKKOeNE0/JRbF1nlOfByfaPZ+c5qcD
 YP1ION+u8dcvmPEB+1+e2iC+jXbjVh5AQYXCu6Z6X7x917rDhCvEHuBfNR28H000Y7SYlVfUf2W
 xpM2ipJIbdUDmqiCLA+fVOGRcfAf6rix0wDL9p1j6zMQmjxS6zk280Rp4Nf5gyMH7+ZnS85Dto+
 kyigNGl19JW4wCQqe+sP3KDlMbyPlw2BEu8FVq7zoGWiDKLl0+ivdHKcVnhiYueg5jSPF7Vc887
 RScx+MkIb1LooXL9l/QC1OtE4DoRiN2SAF1kl6fqKSuMC4Z5glzjGBP+sXOPf4DjO31D0XNRSe9
 Q53ZGvn7Fpyv9HsKaJSuSq5QhoyZxw==
X-Authority-Analysis: v=2.4 cv=CbcFJbrl c=1 sm=1 tr=0 ts=68e79849 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=6l8oHQuSN4U-z53-8pUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: KRDtEZyjqgiFmGNxiYTZvYMGWiAO9Bkg
X-Proofpoint-ORIG-GUID: KRDtEZyjqgiFmGNxiYTZvYMGWiAO9Bkg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Currently desc_size uses a dedicated hal_ops API for initialization.
Combine it with other hal_params to be initialized in a
single API "hal_init" during probe time using a static array.

hal_init will be used as the common API to initialize
all hal parameters during the probe.

Add hal.c file to add hal definitions that are wifi7 specific
but common between qca and wcn chipsets.
Add hal.h header to add wifi7 specific prototypes/Macros etc

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile      |  1 +
 drivers/net/wireless/ath/ath12k/core.c        |  2 --
 drivers/net/wireless/ath/ath12k/dp.c          |  5 ---
 drivers/net/wireless/ath/ath12k/dp.h          |  1 -
 drivers/net/wireless/ath/ath12k/hal.c         |  3 --
 drivers/net/wireless/ath/ath12k/hal.h         |  5 ++-
 drivers/net/wireless/ath/ath12k/wifi7/hal.c   | 36 +++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/hal.h   | 12 +++++++
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  1 -
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  1 -
 drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  3 ++
 11 files changed, 56 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal.h

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index e14844402163..32a0f30faf92 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -28,6 +28,7 @@ ath12k-y += wifi7/hal_tx.o \
 	    wifi7/dp_rx.o \
 	    wifi7/dp_tx.o \
 	    wifi7/dp.o \
+	    wifi7/hal.o \
 	    wifi7/hal_qcn9274.o \
 	    wifi7/hal_wcn7850.o
 
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 84ac706fed20..7b51261b1170 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -930,8 +930,6 @@ static int ath12k_core_start(struct ath12k_base *ab)
 		goto err_hif_stop;
 	}
 
-	ath12k_dp_hal_rx_desc_init(ab);
-
 	ret = ath12k_wmi_cmd_init(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to send wmi init cmd: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 1dcf421240e5..5b255e7c0deb 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -913,11 +913,6 @@ void ath12k_dp_pdev_pre_alloc(struct ath12k *ar)
 	/* TODO: Add any RXDMA setup required per pdev */
 }
 
-void ath12k_dp_hal_rx_desc_init(struct ath12k_base *ab)
-{
-	ab->hal.hal_desc_sz = ab->hw_params->hal_ops->rx_desc_get_desc_size();
-}
-
 int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 1bb46a1b2d63..284e89f7c4b8 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -526,5 +526,4 @@ struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_base *ab,
 						  u32 cookie);
 struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_base *ab,
 						  u32 desc_id);
-void ath12k_dp_hal_rx_desc_init(struct ath12k_base *ab);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 4ff906854970..87abacc8ae8e 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -1103,11 +1103,8 @@ static void ath12k_hal_unregister_srng_lock_keys(struct ath12k_base *ab)
 
 int ath12k_hal_srng_init(struct ath12k_base *ab)
 {
-	struct ath12k_hal *hal = &ab->hal;
 	int ret;
 
-	memset(hal, 0, sizeof(*hal));
-
 	ret = ab->hw_params->hal_ops->create_srng_config(ab);
 	if (ret)
 		goto err_hal;
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index e3e1fe1809fe..4c3a5ec6ae83 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1578,6 +1578,10 @@ enum nl80211_he_ru_alloc ath12k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
 	return ret;
 }
 
+struct ath12k_hw_version_map {
+	u32 hal_desc_sz;
+};
+
 struct hal_ops {
 	int (*create_srng_config)(struct ath12k_base *ab);
 	const struct ath12k_hal_tcl_to_wbm_rbm_map *tcl_to_wbm_rbm_map;
@@ -1593,7 +1597,6 @@ struct hal_ops {
 	void (*extract_rx_desc_data)(struct hal_rx_desc_data *rx_desc_data,
 				     struct hal_rx_desc *rx_desc,
 				     struct hal_rx_desc *ldesc);
-	u32 (*rx_desc_get_desc_size)(void);
 	u32 (*rx_desc_get_mpdu_start_tag)(struct hal_rx_desc *desc);
 	u32 (*rx_desc_get_mpdu_ppdu_id)(struct hal_rx_desc *desc);
 	u8 (*rx_desc_get_l3_pad_bytes)(struct hal_rx_desc *desc);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
new file mode 100644
index 000000000000..4ad3ef3ba5e0
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include "hw.h"
+#include "hal_desc.h"
+#include "../hal.h"
+#include "hal.h"
+
+static const struct ath12k_hw_version_map ath12k_wifi7_hw_ver_map[] = {
+	[ATH12K_HW_QCN9274_HW10] = {
+		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
+	},
+	[ATH12K_HW_QCN9274_HW20] = {
+		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
+	},
+	[ATH12K_HW_WCN7850_HW20] = {
+		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn7850),
+	},
+	[ATH12K_HW_IPQ5332_HW10] = {
+		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
+	},
+};
+
+int ath12k_wifi7_hal_init(struct ath12k_base *ab)
+{
+	struct ath12k_hal *hal = &ab->hal;
+
+	memset(hal, 0, sizeof(*hal));
+
+	hal->hal_desc_sz = ath12k_wifi7_hw_ver_map[ab->hw_rev].hal_desc_sz;
+
+	return 0;
+}
+EXPORT_SYMBOL(ath12k_wifi7_hal_init);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.h b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
new file mode 100644
index 000000000000..0dc5eaec5fb0
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef ATH12K_HAL_WIFI7_H
+#define ATH12K_HAL_WIFI7_H
+
+int ath12k_wifi7_hal_init(struct ath12k_base *ab);
+
+#endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index c98ffc991ad8..6a1c13565700 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -690,7 +690,6 @@ const struct hal_ops hal_qcn9274_ops = {
 	.rx_desc_copy_end_tlv = ath12k_hal_rx_desc_copy_end_tlv_qcn9274,
 	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_qcn9274,
 	.extract_rx_desc_data = ath12k_hal_extract_rx_desc_data_qcn9274,
-	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_qcn9274,
 	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274,
 	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcn9274,
 	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_qcn9274,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 2e88ac0ae797..275de9c1a359 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -699,7 +699,6 @@ const struct hal_ops hal_wcn7850_ops = {
 	.rx_desc_copy_end_tlv = ath12k_hal_rx_desc_copy_end_tlv_wcn7850,
 	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_wcn7850,
 	.extract_rx_desc_data = ath12k_hal_extract_rx_desc_data_wcn7850,
-	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_wcn7850,
 	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850,
 	.rx_desc_get_mpdu_start_tag = ath12k_hal_rx_desc_get_mpdu_start_tag_wcn7850,
 	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_wcn7850,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index 1acf6ffaea08..621022064962 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -23,6 +23,7 @@
 #include "../debugfs.h"
 #include "../debugfs_sta.h"
 #include "../testmode.h"
+#include "hal.h"
 
 static const guid_t wcn7850_uuid = GUID_INIT(0xf634f534, 0x6147, 0x11ec,
 					     0x90, 0xd6, 0x02, 0x42,
@@ -1124,6 +1125,8 @@ int ath12k_wifi7_hw_init(struct ath12k_base *ab)
 	ab->hw_params = hw_params;
 	ab->ath12k_ops = &ath12k_ops_wifi7;
 
+	ath12k_wifi7_hal_init(ab);
+
 	ath12k_info(ab, "Wi-Fi 7 Hardware name: %s\n", ab->hw_params->name);
 
 	return 0;
-- 
2.34.1


