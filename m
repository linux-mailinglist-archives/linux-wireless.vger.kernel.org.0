Return-Path: <linux-wireless+bounces-20732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48748A6D442
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 07:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA02E16DFA5
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 06:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1C319E826;
	Mon, 24 Mar 2025 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HZ2BYQU1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B4519D88F
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797560; cv=none; b=NvxCUdO0N/e4K0CFtZOQHMn/d518h5OfAjN4eWka6bCn44zNe6UbUU6WvTNtOWIZmED//AUY8IEaEPv4Hw32ZB/65lsVarNs9qwnqXb3D8AVsqTDBtujcQTvpfT9hzZdVVjYRj0rejeb3C+04gvrvqlIEQHCii3hpUAcNeirtyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797560; c=relaxed/simple;
	bh=TIITcL4g05vZKTESu44VK5xU3SGuD3wqSPc1YGzYAVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJdHqFRAHIpGBRgNr0ku/mv/O0Q7x9JNaKiZlwQ6TBnGcXt71eoW84yrjhwuta5rmxR0/AMADXTT82wBLhCkUE0v09MhnmA7q5UAKi8xwceAvehg4Tb9SpQ4QhlCDU7IHTTNOHtJQoMFv0E942zvRMgM9vQmIUJCH+5yqZ0ZuMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HZ2BYQU1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O6FjpY011473;
	Mon, 24 Mar 2025 06:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xONq8cYdLI3RXJ+wfjsE1o092spcf/QW3VcxaQ/utWY=; b=HZ2BYQU1ti0VXLqz
	4WfofBzlM37vvhR/gbFTM5vyndlMmYo3HwoxuWhnE/vsoWug8OP6YKJ8+OHC55bz
	b2XjFtQnfgutBhdIfqmp/2bW4OpzXlH3LrGpVl7QrFbL2hVtJIEGQBpborn4OYNe
	CDkgTN6ZhgCA288xhHVsqVGIV/CV2M3gX46u1rM6zkVtAv4TViVQZdtDX9WmV2g2
	eCTwg+pdxMv+3RD3HBKlrCopPlhi6XP7SZFaRhd1DZnGWU665x6AMfOUALPd4nSo
	jwaD5bP/mBpGJD3WuZBeC7TWt6aNQt1iLuYcBMNm4M4U1mvmOEaNNHGW4Kk8OY1k
	4WmaDQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hjwhkexp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 06:25:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52O6PtKP005485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 06:25:55 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Mar 2025 23:25:53 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH v11 10/10] wifi: ath12k: add monitor interface support on QCN9274
Date: Mon, 24 Mar 2025 11:55:18 +0530
Message-ID: <20250324062518.2752822-11-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324062518.2752822-1-quic_periyasa@quicinc.com>
References: <20250324062518.2752822-1-quic_periyasa@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=H+jbw/Yi c=1 sm=1 tr=0 ts=67e0faf4 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=wErSCELDaHQ-P4d28LYA:9 a=RVmHIydaz68A:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: PVl-qpxl0LKrJy_UrLTbypJJwi1ec5Bv
X-Proofpoint-ORIG-GUID: PVl-qpxl0LKrJy_UrLTbypJJwi1ec5Bv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240046

From: P Praneesh <quic_ppranees@quicinc.com>

Currently, the monitor interface is not supported. To support the monitor
interface, configure the monitor vdev state identifier, configure the HTT
filter setup, subscribe the mac80211 NO_VIRTUAL_MONITOR feature, remove
the VIRTUAL_MONITOR handler procedures since align to NO_VIRTUAL_MONITOR
feature and prevent monitor interface to transmit packet. Therefore, add
these procedures to add monitor interface support and enable the monitor
interface support on the QCN9274 platform through the hardware parameter.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c  |  4 +++
 drivers/net/wireless/ath/ath12k/dp_tx.c |  6 +++++
 drivers/net/wireless/ath/ath12k/hw.c    |  4 +--
 drivers/net/wireless/ath/ath12k/mac.c   | 36 ++++++++++++++++++++++---
 4 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 301dea381841..137474fb9e9c 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1359,6 +1359,10 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 				     ath12k_mac_tx_mgmt_pending_free, ar);
 			idr_destroy(&ar->txmgmt_idr);
 			wake_up(&ar->txmgmt_empty_waitq);
+
+			ar->monitor_vdev_id = -1;
+			ar->monitor_vdev_created = false;
+			ar->monitor_started = false;
 		}
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index ced232bf4aed..29e2715024ce 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -7,6 +7,7 @@
 #include "core.h"
 #include "dp_tx.h"
 #include "debug.h"
+#include "debugfs.h"
 #include "hw.h"
 #include "peer.h"
 #include "mac.h"
@@ -1431,6 +1432,11 @@ int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
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
index d1bcf7fd6113..f59ccee60d6a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1306,12 +1306,18 @@ static int ath12k_mac_monitor_start(struct ath12k *ar)
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
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac monitor started ret %d\n", ret);
 
-	return ret;
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac monitor started\n");
+
+	return 0;
 }
 
 static int ath12k_mac_monitor_stop(struct ath12k *ar)
@@ -7370,6 +7376,11 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
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
@@ -8117,6 +8128,12 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	/* In NO_VIRTUAL_MONITOR, its necessary to restrict only one monitor
+	 * interface in each radio
+	 */
+	if (vif->type == NL80211_IFTYPE_MONITOR && ar->monitor_vdev_created)
+		return -EINVAL;
+
 	/* If no link is active and scan vdev is requested
 	 * use a default link conf for scan address purpose.
 	 */
@@ -8272,6 +8289,9 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 			goto err_peer_del;
 		}
 		break;
+	case WMI_VDEV_TYPE_MONITOR:
+		ar->monitor_vdev_created = true;
+		break;
 	default:
 		break;
 	}
@@ -8315,6 +8335,11 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	}
 
 err_vdev_del:
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
+		ar->monitor_vdev_id = -1;
+		ar->monitor_vdev_created = false;
+	}
+
 	ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
 	ar->num_created_vdevs--;
 	arvif->is_created = false;
@@ -11213,6 +11238,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	ieee80211_hw_set(hw, QUEUE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(hw, REPORTS_LOW_ACK);
+	ieee80211_hw_set(hw, NO_VIRTUAL_MONITOR);
 
 	if ((ht_cap & WMI_HT_CAP_ENABLED) || is_6ghz) {
 		ieee80211_hw_set(hw, AMPDU_AGGREGATION);
@@ -11411,6 +11437,10 @@ static void ath12k_mac_setup(struct ath12k *ar)
 
 	wiphy_work_init(&ar->wmi_mgmt_tx_work, ath12k_mgmt_over_wmi_tx_work);
 	skb_queue_head_init(&ar->wmi_mgmt_tx_queue);
+
+	ar->monitor_vdev_id = -1;
+	ar->monitor_vdev_created = false;
+	ar->monitor_started = false;
 }
 
 static int __ath12k_mac_mlo_setup(struct ath12k *ar)
-- 
2.34.1


