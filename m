Return-Path: <linux-wireless+bounces-20393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D0EA6141F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 15:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12434617E0
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 14:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C551FF7BB;
	Fri, 14 Mar 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VY6M2mLl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205992010F5
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963880; cv=none; b=HewXq9s2XATuWucd1M6Ji5OKqim8ktdvdP3WKOIiz+AP8lTAz3Tc0uix29o/2GqXKEaMKP1WXn7NqJhgeW8AaTI9WowTS2dovK88ZOOL26xc8JMdD+yJyi1MD+5qJ4IgXkZUESKib5tTFvL5x3uKkzRigg/9cUtI1sb3QMLdHrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963880; c=relaxed/simple;
	bh=IGkUbh2iYcolsjhM7fJh3L9HFfalzqsg19oeJAnSCuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCPBu1mA0wxiBcOf8a4P7+Z5vANRwxVw6SWUPE10yDbMeUTt3IDEelZepijm/pDJYf4Z7V4hbLAMebjKlj+arCOmgmEJ82wieIRTYGNR0ltN/VoTdGdpoOj8olpzn/n/bqvT65G+vDgCBQSgJWpYzxmICOmPwXOtKw90j2y+sK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VY6M2mLl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EC2VQR028132;
	Fri, 14 Mar 2025 14:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	efUM7FAcUWb/PBzFvXQogLfOnNDftTgcFtjVHDqWI/U=; b=VY6M2mLlSr4NPvdM
	E+E9be2N5ZLCXJkg0Wsi8aS/Q9uUUzOkiRAJsmT8jzrBB80egJEWr5ulemqgaD3C
	uO4swU2QzTus27uHMz91f9NEb31kl739OVQYIQvH6VX/9aXZ2rDStNN69aPOPRqg
	pK2KyDhEM1uua/NAer3nIVZ8dHCRs879CGnqoCaMjDUR4UWu/5OtUDcE6BqsNRAv
	yaK+qI194BTcCma18hZvr2O+IlP/VvZj1YEgx06Djmawwj194kOgz8per8ZceytI
	6xKY7jhkynFxSLHyBv7Ob4lAvKhOnAO/YHeyTj39hwLguqsk0YvZ9y4GY9yvs+IB
	FmQ07Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2q1j0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 14:51:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52EEpG18021742
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 14:51:16 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 14 Mar 2025 07:51:14 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH v10 9/9] wifi: ath12k: add monitor interface support on QCN9274
Date: Fri, 14 Mar 2025 20:20:37 +0530
Message-ID: <20250314145037.3678649-10-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314145037.3678649-1-quic_periyasa@quicinc.com>
References: <20250314145037.3678649-1-quic_periyasa@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=P506hjAu c=1 sm=1 tr=0 ts=67d44265 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=P6OxkFoJwAWwjOy9P0MA:9 a=RVmHIydaz68A:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: I-tQVTqdSjO-cq3okzYYQmwoLaIseZpx
X-Proofpoint-ORIG-GUID: I-tQVTqdSjO-cq3okzYYQmwoLaIseZpx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_05,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140117

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
 drivers/net/wireless/ath/ath12k/core.c  |   4 +
 drivers/net/wireless/ath/ath12k/core.h  |   1 -
 drivers/net/wireless/ath/ath12k/dp_tx.c |   6 +
 drivers/net/wireless/ath/ath12k/hw.c    |   4 +-
 drivers/net/wireless/ath/ath12k/mac.c   | 149 +++++-------------------
 5 files changed, 44 insertions(+), 120 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 0b2dec081c6e..bc0bb11df2d2 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1306,6 +1306,10 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 				     ath12k_mac_tx_mgmt_pending_free, ar);
 			idr_destroy(&ar->txmgmt_idr);
 			wake_up(&ar->txmgmt_empty_waitq);
+
+			ar->monitor_vdev_id = -1;
+			ar->monitor_vdev_created = false;
+			ar->monitor_started = false;
 		}
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 2ee83517eadc..b6de7029a4e6 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -738,7 +738,6 @@ struct ath12k {
 #endif
 
 	bool dfs_block_radar_events;
-	bool monitor_conf_enabled;
 	bool monitor_vdev_created;
 	bool monitor_started;
 	int monitor_vdev_id;
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
index 302db61710bf..3c61ef591da8 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1245,61 +1245,6 @@ static int ath12k_mac_monitor_vdev_stop(struct ath12k *ar)
 	return ret;
 }
 
-static int ath12k_mac_monitor_vdev_create(struct ath12k *ar)
-{
-	struct ath12k_pdev *pdev = ar->pdev;
-	struct ath12k_wmi_vdev_create_arg arg = {};
-	int bit, ret;
-	u8 tmp_addr[6];
-
-	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
-
-	if (ar->monitor_vdev_created)
-		return 0;
-
-	if (ar->ab->free_vdev_map == 0) {
-		ath12k_warn(ar->ab, "failed to find free vdev id for monitor vdev\n");
-		return -ENOMEM;
-	}
-
-	bit = __ffs64(ar->ab->free_vdev_map);
-
-	ar->monitor_vdev_id = bit;
-
-	arg.if_id = ar->monitor_vdev_id;
-	arg.type = WMI_VDEV_TYPE_MONITOR;
-	arg.subtype = WMI_VDEV_SUBTYPE_NONE;
-	arg.pdev_id = pdev->pdev_id;
-	arg.if_stats_id = ATH12K_INVAL_VDEV_STATS_ID;
-
-	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
-		arg.chains[NL80211_BAND_2GHZ].tx = ar->num_tx_chains;
-		arg.chains[NL80211_BAND_2GHZ].rx = ar->num_rx_chains;
-	}
-
-	if (pdev->cap.supported_bands & WMI_HOST_WLAN_5GHZ_CAP) {
-		arg.chains[NL80211_BAND_5GHZ].tx = ar->num_tx_chains;
-		arg.chains[NL80211_BAND_5GHZ].rx = ar->num_rx_chains;
-	}
-
-	ret = ath12k_wmi_vdev_create(ar, tmp_addr, &arg);
-	if (ret) {
-		ath12k_warn(ar->ab, "failed to request monitor vdev %i creation: %d\n",
-			    ar->monitor_vdev_id, ret);
-		ar->monitor_vdev_id = -1;
-		return ret;
-	}
-
-	ar->allocated_vdev_map |= 1LL << ar->monitor_vdev_id;
-	ar->ab->free_vdev_map &= ~(1LL << ar->monitor_vdev_id);
-	ar->num_created_vdevs++;
-	ar->monitor_vdev_created = true;
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac monitor vdev %d created\n",
-		   ar->monitor_vdev_id);
-
-	return 0;
-}
-
 static int ath12k_mac_monitor_vdev_delete(struct ath12k *ar)
 {
 	int ret;
@@ -1362,9 +1307,15 @@ static int ath12k_mac_monitor_start(struct ath12k *ar)
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
@@ -1433,58 +1384,9 @@ int ath12k_mac_vdev_stop(struct ath12k_link_vif *arvif)
 	return ret;
 }
 
-static int ath12k_mac_config(struct ath12k *ar, u32 changed)
-{
-	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
-	struct ieee80211_conf *conf = &hw->conf;
-	int ret = 0;
-
-	lockdep_assert_wiphy(hw->wiphy);
-
-	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
-		ar->monitor_conf_enabled = conf->flags & IEEE80211_CONF_MONITOR;
-		if (ar->monitor_conf_enabled) {
-			if (ar->monitor_vdev_created)
-				return ret;
-			ret = ath12k_mac_monitor_vdev_create(ar);
-			if (ret)
-				return ret;
-			ret = ath12k_mac_monitor_start(ar);
-			if (ret)
-				goto err_mon_del;
-		} else {
-			if (!ar->monitor_vdev_created)
-				return ret;
-			ret = ath12k_mac_monitor_stop(ar);
-			if (ret)
-				return ret;
-			ath12k_mac_monitor_vdev_delete(ar);
-		}
-	}
-
-	return ret;
-
-err_mon_del:
-	ath12k_mac_monitor_vdev_delete(ar);
-	return ret;
-}
-
 static int ath12k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k *ar;
-	int ret;
-
-	lockdep_assert_wiphy(hw->wiphy);
-
-	ar = ath12k_ah_to_ar(ah, 0);
-
-	ret = ath12k_mac_config(ar, changed);
-	if (ret)
-		ath12k_warn(ar->ab, "failed to update config pdev idx %d: %d\n",
-			    ar->pdev_idx, ret);
-
-	return ret;
+	return 0;
 }
 
 static int ath12k_mac_setup_bcn_p2p_ie(struct ath12k_link_vif *arvif,
@@ -7336,6 +7238,11 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
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
@@ -8082,6 +7989,12 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 
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
@@ -8237,6 +8150,9 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 			goto err_peer_del;
 		}
 		break;
+	case WMI_VDEV_TYPE_MONITOR:
+		ar->monitor_vdev_created = true;
+		break;
 	default:
 		break;
 	}
@@ -8256,8 +8172,6 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	}
 
 	ath12k_dp_vdev_tx_attach(ar, arvif);
-	if (vif->type != NL80211_IFTYPE_MONITOR && ar->monitor_conf_enabled)
-		ath12k_mac_monitor_vdev_create(ar);
 
 	return ret;
 
@@ -8282,6 +8196,11 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
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
@@ -8559,8 +8478,6 @@ static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ath12k_link_vif *arv
 	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		ar->monitor_vdev_id = -1;
 		ar->monitor_vdev_created = false;
-	} else if (ar->monitor_vdev_created && !ar->monitor_started) {
-		ret = ath12k_mac_monitor_vdev_delete(ar);
 	}
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "vdev %pM deleted, vdev_id %d\n",
@@ -9500,9 +9417,6 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		goto out;
 	}
 
-	if (ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR && ar->monitor_vdev_created)
-		ath12k_mac_monitor_start(ar);
-
 	arvif->is_started = true;
 
 	/* TODO: Setup ps and cts/rts protection */
@@ -9564,10 +9478,6 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 				    arvif->vdev_id, ret);
 	}
 	arvif->is_started = false;
-
-	if (ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
-	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
-		ath12k_mac_monitor_stop(ar);
 }
 
 static int
@@ -11212,6 +11122,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	ieee80211_hw_set(hw, QUEUE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(hw, REPORTS_LOW_ACK);
+	ieee80211_hw_set(hw, NO_VIRTUAL_MONITOR);
 
 	if ((ht_cap & WMI_HT_CAP_ENABLED) || is_6ghz) {
 		ieee80211_hw_set(hw, AMPDU_AGGREGATION);
@@ -11411,6 +11322,10 @@ static void ath12k_mac_setup(struct ath12k *ar)
 
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


