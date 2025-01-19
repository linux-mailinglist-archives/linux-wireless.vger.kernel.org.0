Return-Path: <linux-wireless+bounces-17710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAC2A162AD
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 16:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3BC18849C0
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCAE1DFD85;
	Sun, 19 Jan 2025 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DFTtrYPs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEFA1DF996
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737300593; cv=none; b=IP/KSQMiTaUZrOPb34Ut7nNjZ3KL/TiZMIECY+o3E87BrJ8wPT2f4mdoeLX7P9uskRf4XEFnCNQL8ptHMrM8Ed8Xuz2Jn7rkUC8+39tAn7W+KWpcxtgZDBgtEVPOUqSBT1GLxZ/89dpSM6R7IfwFvst42uIjXtNYwYDYxNQQc/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737300593; c=relaxed/simple;
	bh=bZiV/xZSLovOz+x0QQpbHy+zuxmnOaoEuB6uylmZkyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hV2rdyp0+GqBYgM3w+FmT9XcmKCLMMRPmNYB+rdBCmBDVk5iy7CjbDI+x5RiNz1PYnd+NQAL+BCkapQ8qLyYA8zTFoaMtJ5nSicODlHMRsRgfPrP+kylLZ6lUCpbYiskvsoFKeTG6gpWHZwPv0nPEoY6vzAF4ojispmPMf+myWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DFTtrYPs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50JBoPr1003625;
	Sun, 19 Jan 2025 15:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I3r4jG1OnOSH//uEP3kq86xfP+X/FvVf2upURgJX4gc=; b=DFTtrYPs7qHDMJg3
	OjTZy3zzILz8ovQrCVVATyU3mVsGqImI1ZYqsVHX0+zna5ikoKQul/5nhKUItqEX
	OUj0ePndbWl9tj5SJ5dIP+8/wR4k/pmYXpLuhy07ZqtGt6drh3le0O7aL23RCVPx
	SyksC3XoCcJjUFfZL/eBg2/YDK2H1xNTkG+zkCYOIchir71dgfJWOhPw4GCMwG7O
	cUmb8dzbSccOLtvir+fO2yOzkvpTsvf2braNRBdbqnwpA7FuGo5G2hOichy6R800
	x7/LgWMNpwHeQ3NEAMu5IEqMdZYWmmUzID6fImctF7Q0xkF2MgbMSPcdA3BOgeZK
	02lqag==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4485k7t4kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jan 2025 15:29:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50JFTnl5006917
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jan 2025 15:29:49 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 19 Jan 2025 07:29:47 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH v2 7/7] wifi: ath12k: add monitor interface support on QCN9274
Date: Sun, 19 Jan 2025 20:59:17 +0530
Message-ID: <20250119152917.2316514-8-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250119152917.2316514-1-quic_periyasa@quicinc.com>
References: <20250119152917.2316514-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 8iyUkqFTy6MB9B3LObAv4dh8V4Sgwf8N
X-Proofpoint-GUID: 8iyUkqFTy6MB9B3LObAv4dh8V4Sgwf8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-19_02,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501190120

From: P Praneesh <quic_ppranees@quicinc.com>

Currently, the monitor interface is not supported. To support the monitor
interface, configure the monitor vdev state identifier, configure the HTT
filter setup, subscribe the mac80211 WANT_MONITOR_VIF feature and prevent
monitor interface to transmit packet. Therefore, add these procedures to
add monitor interface support and enable the monitor interface support on
the QCN9274 platform through the hardware parameter.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c  |  5 +++++
 drivers/net/wireless/ath/ath12k/dp_tx.c |  8 +++++++-
 drivers/net/wireless/ath/ath12k/hw.c    |  4 ++--
 drivers/net/wireless/ath/ath12k/mac.c   | 22 +++++++++++++++++++++-
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 0606116d6b9c..7c4e925b6297 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1263,6 +1263,11 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 				     ath12k_mac_tx_mgmt_pending_free, ar);
 			idr_destroy(&ar->txmgmt_idr);
 			wake_up(&ar->txmgmt_empty_waitq);
+
+			ar->monitor_vdev_id = -1;
+			ar->monitor_conf_enabled = false;
+			ar->monitor_vdev_created = false;
+			ar->monitor_started = false;
 		}
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index b8f0df6f7a05..fb6273e2ae25 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -1,12 +1,13 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
 #include "dp_tx.h"
 #include "debug.h"
+#include "debugfs.h"
 #include "hw.h"
 
 static enum hal_tcl_encap_type
@@ -1277,6 +1278,11 @@ int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
 					HTT_RX_MON_MO_CTRL_FILTER_FLASG3 |
 					HTT_RX_MON_FP_DATA_FILTER_FLASG3 |
 					HTT_RX_MON_MO_DATA_FILTER_FLASG3;
+	} else {
+		tlv_filter = ath12k_mac_mon_status_filter_default;
+
+		if (ath12k_debugfs_is_extd_rx_stats_enabled(ar))
+			tlv_filter.rx_filter = ath12k_debugfs_rx_filter(ar);
 	}
 
 	if (ab->hw_params->rxdma1_enable) {
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index a106ebed7870..021a4b565e8b 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/types.h>
@@ -1049,7 +1049,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 					BIT(NL80211_IFTYPE_AP) |
 					BIT(NL80211_IFTYPE_MESH_POINT) |
 					BIT(NL80211_IFTYPE_AP_VLAN),
-		.supports_monitor = false,
+		.supports_monitor = true,
 
 		.idle_ps = false,
 		.download_calib = true,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d17fb097efc7..2ffba2e2fd6b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1276,9 +1276,15 @@ static int ath12k_mac_monitor_start(struct ath12k *ar)
 		return ret;
 	}
 
+	ret = ath12k_dp_tx_htt_monitor_mode_ring_config(ar, false);
+	if (ret) {
+		ath12k_warn(ar->ab, "fail to set monitor filter: %d\n", ret);
+		return ret;
+	}
+
 	ar->monitor_started = true;
 	ar->num_started_vdevs++;
-	ret = ath12k_dp_tx_htt_monitor_mode_ring_config(ar, false);
+
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac monitor started ret %d\n", ret);
 
 	return ret;
@@ -7188,6 +7194,11 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 	u8 link_id;
 	int ret;
 
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
+		ieee80211_free_txskb(hw, skb);
+		return;
+	}
+
 	link_id = u32_get_bits(info->control.flags, IEEE80211_TX_CTRL_MLO_LINK);
 	memset(skb_cb, 0, sizeof(*skb_cb));
 	skb_cb->vif = vif;
@@ -8043,6 +8054,9 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	}
 
 err_vdev_del:
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR)
+		ar->monitor_vdev_id = -1;
+
 	ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
 	ar->num_created_vdevs--;
 	arvif->is_created = false;
@@ -10918,6 +10932,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	ieee80211_hw_set(hw, QUEUE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(hw, REPORTS_LOW_ACK);
+	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
 
 	if ((ht_cap & WMI_HT_CAP_ENABLED) || is_6ghz) {
 		ieee80211_hw_set(hw, AMPDU_AGGREGATION);
@@ -11113,6 +11128,11 @@ static void ath12k_mac_setup(struct ath12k *ar)
 
 	wiphy_work_init(&ar->wmi_mgmt_tx_work, ath12k_mgmt_over_wmi_tx_work);
 	skb_queue_head_init(&ar->wmi_mgmt_tx_queue);
+
+	ar->monitor_vdev_id = -1;
+	ar->monitor_conf_enabled = false;
+	ar->monitor_vdev_created = false;
+	ar->monitor_started = false;
 }
 
 static int __ath12k_mac_mlo_setup(struct ath12k *ar)
-- 
2.34.1


