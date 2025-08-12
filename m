Return-Path: <linux-wireless+bounces-26333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D84B22EC4
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 19:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66E73BF45C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 17:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814E62FDC2E;
	Tue, 12 Aug 2025 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vjocpch/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECEB2FDC34
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018769; cv=none; b=QY2waVsJCyjuo10oMrzY9Vka2kFwTd+JjZpVdUv0v0AMWmtR6ybt0/xtrvyEBfIQOjReR2EPI4msMRMVLYqKBIxNs5l1sVr77gAYYoccZxMsZOsVfYdrJFw9pIK8oy6dbJA6FdAHT969y6nIbmYFET3bqDu1NuMnqCnQvr6HdUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018769; c=relaxed/simple;
	bh=WmfJjCoHcC132FW2ZBvKXNlWDsqiL/TDCu3mvWLbkkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=E6MD7UmPfJG/SK04+IUHDUXlwWkPu8jt1/8eoZMB5RQpHgY8ZHJlGPba2TiCeS6PO/F1EKUAI0xb/lM4ZlR531QGHSV08WPIFZzhenAFQ2cnj1QBwiXH3q2EwvhM9CUb7EQDW8n1lzdUGvAiKWu/o1kXS8fTBVGW94Cu5/BmNO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vjocpch/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvnJP021278;
	Tue, 12 Aug 2025 17:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZpE+wlUOn4rOTV0dR15pByTbFBmtuZPAky292hk6nDE=; b=Vjocpch/e7DBnXma
	3NlvaQDK8rzZVb/6RdI5nRrMIj62YKRv/EftscvgbzIkRTd0QhmoFMoBjVmpLP6F
	rSatIwvA5ihowd1qsH0cTmYnDWKHcAkmBZCR9TdsjbIE0zBu0YRiHqy6No71lBi2
	srkZqIkZP+hTEtuEn0/wwDp/I0v+Qc7OULD9/NJPyn5TUksEiQ+CIQFa9LrnIyO0
	Ewxfqr5tbknUH8PUtPH/a6QnL8f0JTykhMLMbaiHwD4elILy8icTi8uWXb1y75uT
	5aDNSrbdQk2lpZKZ1pB4K/VSqUOua7htqQWfDkkDw3Jty1cCGgmYRcMQ4swOH4qO
	OgBurw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6mtv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:39 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57CHCcOR010521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:38 GMT
Received: from hu-kiranv-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 10:12:37 -0700
From: Kiran Venkatappa <quic_kiranv@quicinc.com>
Date: Tue, 12 Aug 2025 22:39:29 +0530
Subject: [PATCH ath12k-ng 03/13] wifi: ath12k: Move Wi-Fi 7 WMI
 configuration to dedicated file
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250812-ath12k-mod-v1-3-8c9b0eb9335d@quicinc.com>
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
In-Reply-To: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfX8rK1slxhs+ht
 57lWc9e3EaMn+PaSp2ijhJyjAtNjv2PbV55/h0JG5zyEDN/+GYKT56z2ShKP9VxEEQCtXOiMKGv
 7lmuhVk+OXSfzCc5+BHApS9iQ6SSnXFKMiCa5159IX4XW08fxOBzOQl42qaHjc219t7KehjHmkO
 v6XN8FHVvEQ4twFIlwHfSC5k/YMK2rvoAFGiR2WlQZA4dcgHQ11qWfUgY0iDHtpUermS7WG+c/j
 5DlQJI+6m+PY+yt8sdubLW39pcB6y7xi0KF3NWL6s870vW95JjWxfYabOkirX6Tt4+yTBSmzDn2
 XPCHfhrf1fxIgxFpKTqdCGlTpEUobpMwmgEKWX6B6ehmk9PcNi2uVOXtal2zNHqwJWS2lbHig7M
 JSXoeA+U
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689b7607 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=X7Ah-KukCkl87x9OXY0A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: aU74KmLOVTr3_lufXtjeCWlzfpjagLcW
X-Proofpoint-ORIG-GUID: aU74KmLOVTr3_lufXtjeCWlzfpjagLcW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

Relocate Wi-Fi 7 specific WMI configuration from shared codebase to a new
target-specific file. Isolate WMI settings per target to improve
modularity and maintainability.

This change is part of a broader effort to separate hardware-dependent
logic into standalone modules, paving the way for cleaner support of
multiple hardware families

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kiran Venkatappa <quic_kiranv@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile    |   1 +
 drivers/net/wireless/ath/ath12k/hw.c        |   1 +
 drivers/net/wireless/ath/ath12k/wmi.c       |  97 -------------------------
 drivers/net/wireless/ath/ath12k/wmi.h       |   4 --
 drivers/net/wireless/ath/ath12k/wmi_wifi7.c | 105 ++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi_wifi7.h |  15 ++++
 6 files changed, 122 insertions(+), 101 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index e4776887c939ab0d11307e8f616f3728ed39ce71..ee075ee68bb834e3f3605b13a5fee6afff0ba763 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -5,6 +5,7 @@ ath12k-y += core.o \
 	    hal_tx.o \
 	    hal_rx.o \
 	    wmi.o \
+	    wmi_wifi7.o \
 	    mac.o \
 	    reg.o \
 	    htc.o \
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index dd60e27cc499648e4c6ec95d0a56ec06f4c7c6ae..df1b4439adc798dc0dfb7d8604874a4fcb77663b 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -16,6 +16,7 @@
 #include "mhi.h"
 #include "dp_rx.h"
 #include "peer.h"
+#include "wmi_wifi7.h"
 
 static const guid_t wcn7850_uuid = GUID_INIT(0xf634f534, 0x6147, 0x11ec,
 					     0x90, 0xd6, 0x02, 0x42,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index da85c28ec35568ca5c81a49e565c19cff195bac7..9869c935aee7edb5591595f0bdbf1fbe7e54b00f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -198,103 +198,6 @@ static __le32 ath12k_wmi_tlv_cmd_hdr(u32 cmd, u32 len)
 	return ath12k_wmi_tlv_hdr(cmd, len - TLV_HDR_SIZE);
 }
 
-void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
-			     struct ath12k_wmi_resource_config_arg *config)
-{
-	config->num_vdevs = ab->num_radios * TARGET_NUM_VDEVS(ab);
-	config->num_peers = ab->num_radios *
-		ath12k_core_get_max_peers_per_radio(ab);
-	config->num_offload_peers = TARGET_NUM_OFFLD_PEERS;
-	config->num_offload_reorder_buffs = TARGET_NUM_OFFLD_REORDER_BUFFS;
-	config->num_peer_keys = TARGET_NUM_PEER_KEYS;
-	config->ast_skid_limit = TARGET_AST_SKID_LIMIT;
-	config->tx_chain_mask = (1 << ab->target_caps.num_rf_chains) - 1;
-	config->rx_chain_mask = (1 << ab->target_caps.num_rf_chains) - 1;
-	config->rx_timeout_pri[0] = TARGET_RX_TIMEOUT_LO_PRI;
-	config->rx_timeout_pri[1] = TARGET_RX_TIMEOUT_LO_PRI;
-	config->rx_timeout_pri[2] = TARGET_RX_TIMEOUT_LO_PRI;
-	config->rx_timeout_pri[3] = TARGET_RX_TIMEOUT_HI_PRI;
-
-	if (test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags))
-		config->rx_decap_mode = TARGET_DECAP_MODE_RAW;
-	else
-		config->rx_decap_mode = TARGET_DECAP_MODE_NATIVE_WIFI;
-
-	config->scan_max_pending_req = TARGET_SCAN_MAX_PENDING_REQS;
-	config->bmiss_offload_max_vdev = TARGET_BMISS_OFFLOAD_MAX_VDEV;
-	config->roam_offload_max_vdev = TARGET_ROAM_OFFLOAD_MAX_VDEV;
-	config->roam_offload_max_ap_profiles = TARGET_ROAM_OFFLOAD_MAX_AP_PROFILES;
-	config->num_mcast_groups = TARGET_NUM_MCAST_GROUPS;
-	config->num_mcast_table_elems = TARGET_NUM_MCAST_TABLE_ELEMS;
-	config->mcast2ucast_mode = TARGET_MCAST2UCAST_MODE;
-	config->tx_dbg_log_size = TARGET_TX_DBG_LOG_SIZE;
-	config->num_wds_entries = TARGET_NUM_WDS_ENTRIES;
-	config->dma_burst_size = TARGET_DMA_BURST_SIZE;
-	config->rx_skip_defrag_timeout_dup_detection_check =
-		TARGET_RX_SKIP_DEFRAG_TIMEOUT_DUP_DETECTION_CHECK;
-	config->vow_config = TARGET_VOW_CONFIG;
-	config->gtk_offload_max_vdev = TARGET_GTK_OFFLOAD_MAX_VDEV;
-	config->num_msdu_desc = TARGET_NUM_MSDU_DESC;
-	config->beacon_tx_offload_max_vdev = ab->num_radios * TARGET_MAX_BCN_OFFLD;
-	config->rx_batchmode = TARGET_RX_BATCHMODE;
-	/* Indicates host supports peer map v3 and unmap v2 support */
-	config->peer_map_unmap_version = 0x32;
-	config->twt_ap_pdev_count = ab->num_radios;
-	config->twt_ap_sta_count = 1000;
-	config->ema_max_vap_cnt = ab->num_radios;
-	config->ema_max_profile_period = TARGET_EMA_MAX_PROFILE_PERIOD;
-	config->beacon_tx_offload_max_vdev += config->ema_max_vap_cnt;
-
-	if (test_bit(WMI_TLV_SERVICE_PEER_METADATA_V1A_V1B_SUPPORT, ab->wmi_ab.svc_map))
-		config->peer_metadata_ver = ATH12K_PEER_METADATA_V1B;
-}
-
-void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
-			     struct ath12k_wmi_resource_config_arg *config)
-{
-	config->num_vdevs = 4;
-	config->num_peers = 16;
-	config->num_tids = 32;
-
-	config->num_offload_peers = 3;
-	config->num_offload_reorder_buffs = 3;
-	config->num_peer_keys = TARGET_NUM_PEER_KEYS;
-	config->ast_skid_limit = TARGET_AST_SKID_LIMIT;
-	config->tx_chain_mask = (1 << ab->target_caps.num_rf_chains) - 1;
-	config->rx_chain_mask = (1 << ab->target_caps.num_rf_chains) - 1;
-	config->rx_timeout_pri[0] = TARGET_RX_TIMEOUT_LO_PRI;
-	config->rx_timeout_pri[1] = TARGET_RX_TIMEOUT_LO_PRI;
-	config->rx_timeout_pri[2] = TARGET_RX_TIMEOUT_LO_PRI;
-	config->rx_timeout_pri[3] = TARGET_RX_TIMEOUT_HI_PRI;
-	config->rx_decap_mode = TARGET_DECAP_MODE_NATIVE_WIFI;
-	config->scan_max_pending_req = TARGET_SCAN_MAX_PENDING_REQS;
-	config->bmiss_offload_max_vdev = TARGET_BMISS_OFFLOAD_MAX_VDEV;
-	config->roam_offload_max_vdev = TARGET_ROAM_OFFLOAD_MAX_VDEV;
-	config->roam_offload_max_ap_profiles = TARGET_ROAM_OFFLOAD_MAX_AP_PROFILES;
-	config->num_mcast_groups = 0;
-	config->num_mcast_table_elems = 0;
-	config->mcast2ucast_mode = 0;
-	config->tx_dbg_log_size = TARGET_TX_DBG_LOG_SIZE;
-	config->num_wds_entries = 0;
-	config->dma_burst_size = 0;
-	config->rx_skip_defrag_timeout_dup_detection_check = 0;
-	config->vow_config = TARGET_VOW_CONFIG;
-	config->gtk_offload_max_vdev = 2;
-	config->num_msdu_desc = 0x400;
-	config->beacon_tx_offload_max_vdev = 2;
-	config->rx_batchmode = TARGET_RX_BATCHMODE;
-
-	config->peer_map_unmap_version = 0x1;
-	config->use_pdev_id = 1;
-	config->max_frag_entries = 0xa;
-	config->num_tdls_vdevs = 0x1;
-	config->num_tdls_conn_table_entries = 8;
-	config->beacon_tx_offload_max_vdev = 0x2;
-	config->num_multicast_filter_entries = 0x20;
-	config->num_wow_filters = 0x16;
-	config->num_keep_alive_pattern = 0;
-}
-
 #define PRIMAP(_hw_mode_) \
 	[_hw_mode_] = _hw_mode_##_PRI
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index f3b0a6f57ec2b0d9f9a1b1831b04639088ded27d..833f42e6b826e59a8f54e32359b905d8752e6e42 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -6283,10 +6283,6 @@ struct ath12k_wmi_rssi_dbm_conv_info_arg {
 	s8 min_nf_dbm;
 };
 
-void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
-			     struct ath12k_wmi_resource_config_arg *config);
-void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
-			     struct ath12k_wmi_resource_config_arg *config);
 int ath12k_wmi_cmd_send(struct ath12k_wmi_pdev *wmi, struct sk_buff *skb,
 			u32 cmd_id);
 struct sk_buff *ath12k_wmi_alloc_skb(struct ath12k_wmi_base *wmi_sc, u32 len);
diff --git a/drivers/net/wireless/ath/ath12k/wmi_wifi7.c b/drivers/net/wireless/ath/ath12k/wmi_wifi7.c
new file mode 100644
index 0000000000000000000000000000000000000000..f27fa56210e8332ca3c309eca9184f6cbe560c91
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wmi_wifi7.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "core.h"
+#include "wmi_wifi7.h"
+
+void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
+			     struct ath12k_wmi_resource_config_arg *config)
+{
+	config->num_vdevs = ab->num_radios * TARGET_NUM_VDEVS(ab);
+	config->num_peers = ab->num_radios *
+		ath12k_core_get_max_peers_per_radio(ab);
+	config->num_offload_peers = TARGET_NUM_OFFLD_PEERS;
+	config->num_offload_reorder_buffs = TARGET_NUM_OFFLD_REORDER_BUFFS;
+	config->num_peer_keys = TARGET_NUM_PEER_KEYS;
+	config->ast_skid_limit = TARGET_AST_SKID_LIMIT;
+	config->tx_chain_mask = (1 << ab->target_caps.num_rf_chains) - 1;
+	config->rx_chain_mask = (1 << ab->target_caps.num_rf_chains) - 1;
+	config->rx_timeout_pri[0] = TARGET_RX_TIMEOUT_LO_PRI;
+	config->rx_timeout_pri[1] = TARGET_RX_TIMEOUT_LO_PRI;
+	config->rx_timeout_pri[2] = TARGET_RX_TIMEOUT_LO_PRI;
+	config->rx_timeout_pri[3] = TARGET_RX_TIMEOUT_HI_PRI;
+
+	if (test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags))
+		config->rx_decap_mode = TARGET_DECAP_MODE_RAW;
+	else
+		config->rx_decap_mode = TARGET_DECAP_MODE_NATIVE_WIFI;
+
+	config->scan_max_pending_req = TARGET_SCAN_MAX_PENDING_REQS;
+	config->bmiss_offload_max_vdev = TARGET_BMISS_OFFLOAD_MAX_VDEV;
+	config->roam_offload_max_vdev = TARGET_ROAM_OFFLOAD_MAX_VDEV;
+	config->roam_offload_max_ap_profiles = TARGET_ROAM_OFFLOAD_MAX_AP_PROFILES;
+	config->num_mcast_groups = TARGET_NUM_MCAST_GROUPS;
+	config->num_mcast_table_elems = TARGET_NUM_MCAST_TABLE_ELEMS;
+	config->mcast2ucast_mode = TARGET_MCAST2UCAST_MODE;
+	config->tx_dbg_log_size = TARGET_TX_DBG_LOG_SIZE;
+	config->num_wds_entries = TARGET_NUM_WDS_ENTRIES;
+	config->dma_burst_size = TARGET_DMA_BURST_SIZE;
+	config->rx_skip_defrag_timeout_dup_detection_check =
+		TARGET_RX_SKIP_DEFRAG_TIMEOUT_DUP_DETECTION_CHECK;
+	config->vow_config = TARGET_VOW_CONFIG;
+	config->gtk_offload_max_vdev = TARGET_GTK_OFFLOAD_MAX_VDEV;
+	config->num_msdu_desc = TARGET_NUM_MSDU_DESC;
+	config->beacon_tx_offload_max_vdev = ab->num_radios * TARGET_MAX_BCN_OFFLD;
+	config->rx_batchmode = TARGET_RX_BATCHMODE;
+	/* Indicates host supports peer map v3 and unmap v2 support */
+	config->peer_map_unmap_version = 0x32;
+	config->twt_ap_pdev_count = ab->num_radios;
+	config->twt_ap_sta_count = 1000;
+	config->ema_max_vap_cnt = ab->num_radios;
+	config->ema_max_profile_period = TARGET_EMA_MAX_PROFILE_PERIOD;
+	config->beacon_tx_offload_max_vdev += config->ema_max_vap_cnt;
+
+	if (test_bit(WMI_TLV_SERVICE_PEER_METADATA_V1A_V1B_SUPPORT, ab->wmi_ab.svc_map))
+		config->peer_metadata_ver = ATH12K_PEER_METADATA_V1B;
+}
+
+void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
+			     struct ath12k_wmi_resource_config_arg *config)
+{
+	config->num_vdevs = 4;
+	config->num_peers = 16;
+	config->num_tids = 32;
+
+	config->num_offload_peers = 3;
+	config->num_offload_reorder_buffs = 3;
+	config->num_peer_keys = TARGET_NUM_PEER_KEYS;
+	config->ast_skid_limit = TARGET_AST_SKID_LIMIT;
+	config->tx_chain_mask = (1 << ab->target_caps.num_rf_chains) - 1;
+	config->rx_chain_mask = (1 << ab->target_caps.num_rf_chains) - 1;
+	config->rx_timeout_pri[0] = TARGET_RX_TIMEOUT_LO_PRI;
+	config->rx_timeout_pri[1] = TARGET_RX_TIMEOUT_LO_PRI;
+	config->rx_timeout_pri[2] = TARGET_RX_TIMEOUT_LO_PRI;
+	config->rx_timeout_pri[3] = TARGET_RX_TIMEOUT_HI_PRI;
+	config->rx_decap_mode = TARGET_DECAP_MODE_NATIVE_WIFI;
+	config->scan_max_pending_req = TARGET_SCAN_MAX_PENDING_REQS;
+	config->bmiss_offload_max_vdev = TARGET_BMISS_OFFLOAD_MAX_VDEV;
+	config->roam_offload_max_vdev = TARGET_ROAM_OFFLOAD_MAX_VDEV;
+	config->roam_offload_max_ap_profiles = TARGET_ROAM_OFFLOAD_MAX_AP_PROFILES;
+	config->num_mcast_groups = 0;
+	config->num_mcast_table_elems = 0;
+	config->mcast2ucast_mode = 0;
+	config->tx_dbg_log_size = TARGET_TX_DBG_LOG_SIZE;
+	config->num_wds_entries = 0;
+	config->dma_burst_size = 0;
+	config->rx_skip_defrag_timeout_dup_detection_check = 0;
+	config->vow_config = TARGET_VOW_CONFIG;
+	config->gtk_offload_max_vdev = 2;
+	config->num_msdu_desc = 0x400;
+	config->beacon_tx_offload_max_vdev = 2;
+	config->rx_batchmode = TARGET_RX_BATCHMODE;
+
+	config->peer_map_unmap_version = 0x1;
+	config->use_pdev_id = 1;
+	config->max_frag_entries = 0xa;
+	config->num_tdls_vdevs = 0x1;
+	config->num_tdls_conn_table_entries = 8;
+	config->beacon_tx_offload_max_vdev = 0x2;
+	config->num_multicast_filter_entries = 0x20;
+	config->num_wow_filters = 0x16;
+	config->num_keep_alive_pattern = 0;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wmi_wifi7.h b/drivers/net/wireless/ath/ath12k/wmi_wifi7.h
new file mode 100644
index 0000000000000000000000000000000000000000..1514e3e8d4cb65d3d95d95a1c1593a7b66abcf58
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wmi_wifi7.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef ATH12K_WMI_WIFI7_H
+#define ATH12K_WMI_WIFI7_H
+
+void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
+			     struct ath12k_wmi_resource_config_arg *config);
+void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
+			     struct ath12k_wmi_resource_config_arg *config);
+
+#endif

-- 
2.34.1


