Return-Path: <linux-wireless+bounces-18020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC420A1D583
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 12:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D44F1670BE
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 11:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6FC1FECCD;
	Mon, 27 Jan 2025 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nyanHMMs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BA11FF1AD
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737978069; cv=none; b=Q2CJO9E0YJBDHyUUFfBeHYAW9jDEPkMcYVijavrekhhz4B4ENbFelcmx9qecG7A5iAu6G1Sp0uGwles3kdD2KzDOTSFcLfngQ+jWVQThe6Zc7v1Aiv/qxd1wz2YSks+G+JgHPFOdNUElXi9tZ7ICj3y1rHaZRzHagUqyWV5UbUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737978069; c=relaxed/simple;
	bh=r7ks9N+ieTenM0pRjedFBxfvAJDEJ5pjf6n5sOkSru4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XS1muam43klOIPNN8lKgKJyZwapuCh8peruGDM2t0J653hqFHLfU1X9HfksYRUDKFYEHH/QrRKLSV6tbl03ZJqe188Pff+ubBU/psjdGQ6p6LGIYIfO7eJQJm6W8ZLlfqtp9B0J2cOHWaG49nvb2kpIkKmdClWxDF7asZb82uGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nyanHMMs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RB6ktp011282;
	Mon, 27 Jan 2025 11:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VkHAiyQ9T6RqajqWzMR01UZ4dYKCpQG5LeyyMVJb4R4=; b=nyanHMMsZZuPWk+1
	G/DG4btSHmPediGjWQ2nrYSLdq4u3wfMgIqhmlWjeAIhj6mZT7zC1ukpudz/IlZn
	KOLhvB0gSUnvuSAgTLGtPmIenz8a5l4aOi1ZlGPlQ65enozVdUD6tgIJERAgGEnz
	zv/1KJbJqW+A0b3R7lFloOKc1rbg1dz0l8P1jYCUh89nb1nrgwtOwvra9NskTmVq
	bGP0yK0Qw38GaRHiwasIBU2MGoXrNbHfSMlMo9UNum6/p6oEw0vCiaY3odUN00pR
	RTR21bVQnhXC+H5PAQWjPbTYKEW1ugT8tIvgqi5HTXBFxgWT+Yzh0zBEy/V0uRNv
	V0RtAg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44e90105j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 11:41:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50RBf3X9012358
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 11:41:03 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 27 Jan 2025 03:41:01 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Nicolas Escande
	<nico.escande@gmail.com>
Subject: [PATCH v3 7/7] wifi: ath12k: add monitor interface support on QCN9274
Date: Mon, 27 Jan 2025 17:10:30 +0530
Message-ID: <20250127114030.43479-8-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127114030.43479-1-quic_periyasa@quicinc.com>
References: <20250127114030.43479-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: soHkoud7W2qKUV0z2XA_DPt2e8kfuJMZ
X-Proofpoint-ORIG-GUID: soHkoud7W2qKUV0z2XA_DPt2e8kfuJMZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_05,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270093

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
Tested-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath12k/core.c  |  5 +++++
 drivers/net/wireless/ath/ath12k/dp_tx.c |  8 +++++++-
 drivers/net/wireless/ath/ath12k/hw.c    |  4 ++--
 drivers/net/wireless/ath/ath12k/mac.c   | 22 +++++++++++++++++++++-
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 2dd0666959cd..ec2c2b23bc1c 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1272,6 +1272,11 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
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
index aa8058dd2da6..63b048626128 100644
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
 #include "peer.h"
 #include "mac.h"
@@ -1409,6 +1410,11 @@ int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
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
index a00dc02adb5d..59cb22a8e8d1 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1356,9 +1356,15 @@ static int ath12k_mac_monitor_start(struct ath12k *ar)
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
@@ -7269,6 +7275,11 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
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
@@ -8130,6 +8141,9 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	}
 
 err_vdev_del:
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR)
+		ar->monitor_vdev_id = -1;
+
 	ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
 	ar->num_created_vdevs--;
 	arvif->is_created = false;
@@ -11060,6 +11074,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	ieee80211_hw_set(hw, QUEUE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(hw, REPORTS_LOW_ACK);
+	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
 
 	if ((ht_cap & WMI_HT_CAP_ENABLED) || is_6ghz) {
 		ieee80211_hw_set(hw, AMPDU_AGGREGATION);
@@ -11257,6 +11272,11 @@ static void ath12k_mac_setup(struct ath12k *ar)
 
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


