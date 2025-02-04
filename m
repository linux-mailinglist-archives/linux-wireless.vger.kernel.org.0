Return-Path: <linux-wireless+bounces-18409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE81A26EAD
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 10:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E651A163349
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76C6207DE8;
	Tue,  4 Feb 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n+uwDaev"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AA6207DE5
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738661964; cv=none; b=Vih4o3Qt190g2s1e/oXSWFUBAO1YUEvuKcPJduufdURUjD1vcG2BkO++L7luBoJ1px4t0nJPIYcLCJTkIYC7iIOn+pzkJfIW/HkHw0/uvM7wjgzTHGOl5leoAwxEvlaxgVwTCsj6mV+YYlp9u05cbzL9/bW/kS4PKV0jiDT/6WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738661964; c=relaxed/simple;
	bh=Wf5GrJKqyGS/u6LMCRSl32XdnTZpkacaUFe1YPRUcNY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7DL6pleo0irpjEO9PEXpPYSx96x3udVFNRYuHf05d/n8+Jv2Mg+mD8vV3u2CEAAQgzvEbDhLKyrj0MzVBAejFiAUNOES/jUWYrhLoLiOfzUnx3ez9zOInSS0Ta0i0khb83FLVsFq3ZNWBV+40zUbCJEeVaZ/zUQoPfV9nLo/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n+uwDaev; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5141asEU004323;
	Tue, 4 Feb 2025 09:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xtDYCwV5/GYPWQKJMC1aMstBcbC2Tz26b6/OW5kqMKk=; b=n+uwDaevAqkuVgWf
	3YzxOpWxqkO11dyvd496PSviN0C0jTnlyKzbd+CgPhn4BtCcMOclyJ4eZpv9Jgu3
	CspvHxIytxGmJn5garGudH4ROOnA/bi1eIwE2G2RwxVih//gBCHicxLqUG3trO/o
	mxkPCsSLPqjgTNiNGkjXXFnLeMV9S7jsXNzc/Sah8g2GPU66f2CvJ1/fOurXFOPe
	Z1C3osoU+EMv4SUgsCyXjvbEn7lf+dQ/wRNFl5Sc4pSiHb3FFzEpSglrwt6rq3Uw
	K3fqcBlmjxA7xDPOqcKGEdIcFu05VwncswLNUKnMBEDcvrmuocrIPY6NRg9AB/xK
	7fCUTQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k9cn0xg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 09:39:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5149dJFJ013842
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 09:39:19 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Feb 2025 01:39:16 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Nicolas Escande
	<nico.escande@gmail.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH v4 7/7] wifi: ath12k: add monitor interface support on QCN9274
Date: Tue, 4 Feb 2025 15:06:56 +0530
Message-ID: <20250204093656.3682278-8-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204093656.3682278-1-quic_periyasa@quicinc.com>
References: <20250204093656.3682278-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ySYWp8UPEMF0PCAxM1qfwfG6E9nrHMu1
X-Proofpoint-ORIG-GUID: ySYWp8UPEMF0PCAxM1qfwfG6E9nrHMu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040077

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
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c  |  5 +++++
 drivers/net/wireless/ath/ath12k/dp_tx.c |  8 +++++++-
 drivers/net/wireless/ath/ath12k/hw.c    |  4 ++--
 drivers/net/wireless/ath/ath12k/mac.c   | 22 +++++++++++++++++++++-
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 323bd5082a7d..e2fe69db0c47 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1274,6 +1274,11 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
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
index 94310bcc620c..d21d895f4bbd 100644
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
index 2a4213447a14..1022cf992b7b 100644
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
@@ -7266,6 +7272,11 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
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
@@ -8127,6 +8138,9 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	}
 
 err_vdev_del:
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR)
+		ar->monitor_vdev_id = -1;
+
 	ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
 	ar->num_created_vdevs--;
 	arvif->is_created = false;
@@ -11056,6 +11070,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	ieee80211_hw_set(hw, QUEUE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(hw, REPORTS_LOW_ACK);
+	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
 
 	if ((ht_cap & WMI_HT_CAP_ENABLED) || is_6ghz) {
 		ieee80211_hw_set(hw, AMPDU_AGGREGATION);
@@ -11253,6 +11268,11 @@ static void ath12k_mac_setup(struct ath12k *ar)
 
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


