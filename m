Return-Path: <linux-wireless+bounces-21528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2762A892C6
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 06:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7893168BAA
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 04:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6103E18C91F;
	Tue, 15 Apr 2025 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fFnXNbBd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436A18A6A9
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 04:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744690877; cv=none; b=b6d9AT+DtVIRsG/rimnWDaePN482NNCEJCr09FlCy0u1HShKmctNqHwu4t/Py1qCOlrGGjEYcJhQ3kPC3Z6uKsmDdMBa9XdfPyFCRPBsIBmWAY79y1a9n3VaUpWcje+aMpK+bbpDMO68Q5rBvbEMQWR0gbneJ5rJJjkmjHt3Meg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744690877; c=relaxed/simple;
	bh=fyMeRdxQtQNq0ipXqp6ESGCYvtCZHK0xs2SAE7JlSK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMtswUr/BRC/b/YkN1nLdvauQAIcKRJXoJlm1rXJ5yraFZ+YOM4w5hFS4Y8mkzIwd2JKs008IjUzKSFSmfRXPtRVbvYl7SjUKYvb6SoClesvdrBvrG4xE42blPF/jBocjptlUT0X01bMMn8KNJBWfnEQynrgPZCd/zBYoi4c5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fFnXNbBd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F16OEZ016669;
	Tue, 15 Apr 2025 04:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UoW5VGt/Oe6fOmmw35BpolUBrmx75o2shD0sxMVJDMw=; b=fFnXNbBdWZJUSU2o
	WYRopN0lP1SrGqPC1IvRSYgYylgjt0SA0XKP8WA82EIiiaU7ErF7XWLL42Z1S0XC
	PMO5lGlEfgBpuOvsqZjb/kn4df4j0U3oyQN/0TtPaDvLAP7uhwcoYtizf0VuzS4Y
	ircBgTTgZ7GFxStaNhFRcKpvwFYdRayv5PH7Cs2/gLwkEVdsdJ9hFy8qROCIMr5e
	nVnC8C6xo9eGJeABcI2Clx+rjQzBJ9siQFf2j8Br53yogWZ756z6IW+QRViTsjel
	aVvs/8BPiji9tlzifLgsTok548lNik+gbmOJovV3qaFeFGmA2LaD3pqT136jkimx
	1ZP0DA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhfcxgy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:08 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53F4L7at020562
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:07 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Apr 2025 21:21:05 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v6 04/11] wifi: cfg80211: reorg sinfo structure elements for MLO
Date: Tue, 15 Apr 2025 09:50:23 +0530
Message-ID: <20250415042030.1246187-5-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=CfUI5Krl c=1 sm=1 tr=0 ts=67fddeb4 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=7UXX7Acwc9871hhD1wAA:9 a=4x-jt1a3ahjGyfQ2:21
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: f8n7fVR7rjXKBUl47ODdvrbUsuUNPdru
X-Proofpoint-ORIG-GUID: f8n7fVR7rjXKBUl47ODdvrbUsuUNPdru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150026

Current implementation of NL80211_GET_STATION does not work for
multi-link operation(MLO) since in case of MLO only deflink (or one
of the links) is considered and not all links.

Therefore to support for MLO, start reorganizing sinfo structure
related data elements and add link_sinfo structure for link-level
statistics and keep station related data at sinfo structure.
Currently, changes are done at the deflink(or one of the links) level.
Actual link-level changes will be added in subsequent changes.

Also currently, mac80211 ops .sta_statistics() is mapped to fill sinfo
structure. But to add support for station statistics at link level,
change the ops to .link_sta_statistics() to fill link_sinfo structure.

Additionally, move connected_time before assoc_at in station_info
structure to get minimal holes.
pahole summary before this change:
 - size: 232, cachelines: 4, members: 23
 - sum members: 223, holes: 3, sum holes: 9
 - forced alignments: 1
 - last cacheline: 40 bytes

pahole summary after this change:
 - size: 224, cachelines: 4, members: 23
 - sum members: 223, holes: 1, sum holes: 1
 - forced alignments: 1
 - last cacheline: 32 bytes

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
NOTE:
 - Included driver changes for fixing compilation issue.
---
 drivers/net/wireless/ath/ath10k/mac.c         |   8 +-
 drivers/net/wireless/ath/ath11k/mac.c         |   6 +-
 drivers/net/wireless/ath/ath12k/mac.c         |  10 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  56 +++---
 drivers/net/wireless/ath/wcn36xx/main.c       |   5 +-
 drivers/net/wireless/ath/wcn36xx/smd.c        |   2 +-
 drivers/net/wireless/ath/wcn36xx/smd.h        |   2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  36 ++--
 drivers/net/wireless/ath/wil6210/debugfs.c    |  13 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  84 +++++----
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   2 +-
 .../net/wireless/intel/iwlwifi/mld/stats.c    |  10 +-
 .../net/wireless/intel/iwlwifi/mld/stats.h    |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   4 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 drivers/net/wireless/marvell/libertas/cfg.c   |  22 ++-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  69 +++----
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   2 +-
 .../net/wireless/mediatek/mt76/mt792x_core.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |   4 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  38 ++--
 .../net/wireless/quantenna/qtnfmac/commands.c |  60 ++++---
 drivers/net/wireless/realtek/rtl8xxxu/core.c  |   4 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |   4 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   4 +-
 drivers/net/wireless/ti/wlcore/main.c         |   4 +-
 drivers/net/wireless/virtual/virt_wifi.c      |  14 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  37 ++--
 include/net/cfg80211.h                        | 170 +++++++++++-------
 include/net/mac80211.h                        |  18 +-
 net/batman-adv/bat_v_elp.c                    |  11 +-
 net/mac80211/driver-ops.h                     |  14 +-
 net/mac80211/ethtool.c                        |  31 ++--
 net/mac80211/sta_info.c                       |  11 +-
 net/mac80211/trace.h                          |   2 +-
 net/wireless/nl80211.c                        |   9 +-
 net/wireless/trace.h                          |  33 ++--
 net/wireless/util.c                           |   6 +-
 net/wireless/wext-compat.c                    |  22 +--
 43 files changed, 478 insertions(+), 365 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index c61b95a928da..944a04c8d2af 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "mac.h"
@@ -9267,7 +9267,7 @@ static void ath10k_mac_parse_bitrate(struct ath10k *ar, u32 rate_code,
 
 static void ath10k_mac_sta_get_peer_stats_info(struct ath10k *ar,
 					       struct ieee80211_sta *sta,
-					       struct station_info *sinfo)
+					       struct link_station_info *sinfo)
 {
 	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
 	struct ath10k_peer *peer;
@@ -9326,7 +9326,7 @@ static void ath10k_mac_sta_get_peer_stats_info(struct ath10k *ar,
 static void ath10k_sta_statistics(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta,
-				  struct station_info *sinfo)
+				  struct link_station_info *sinfo)
 {
 	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
 	struct ath10k *ar = arsta->arvif->ar;
@@ -9478,7 +9478,7 @@ static const struct ieee80211_ops ath10k_ops = {
 	.unassign_vif_chanctx		= ath10k_mac_op_unassign_vif_chanctx,
 	.switch_vif_chanctx		= ath10k_mac_op_switch_vif_chanctx,
 	.sta_pre_rcu_remove		= ath10k_mac_op_sta_pre_rcu_remove,
-	.sta_statistics			= ath10k_sta_statistics,
+	.link_sta_statistics		= ath10k_sta_statistics,
 	.set_tid_config			= ath10k_mac_op_set_tid_config,
 	.reset_tid_config		= ath10k_mac_op_reset_tid_config,
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 97816916abac..1809662bc482 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8962,7 +8962,7 @@ static int ath11k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	return ret;
 }
 
-static void ath11k_mac_put_chain_rssi(struct station_info *sinfo,
+static void ath11k_mac_put_chain_rssi(struct link_station_info *sinfo,
 				      struct ath11k_sta *arsta,
 				      char *pre,
 				      bool clear)
@@ -8994,7 +8994,7 @@ static void ath11k_mac_put_chain_rssi(struct station_info *sinfo,
 static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
 					 struct ieee80211_sta *sta,
-					 struct station_info *sinfo)
+					 struct link_station_info *sinfo)
 {
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k *ar = arsta->arvif->ar;
@@ -9778,7 +9778,7 @@ static const struct ieee80211_ops ath11k_ops = {
 	.set_bitrate_mask		= ath11k_mac_op_set_bitrate_mask,
 	.get_survey			= ath11k_mac_op_get_survey,
 	.flush				= ath11k_mac_op_flush,
-	.sta_statistics			= ath11k_mac_op_sta_statistics,
+	.link_sta_statistics		= ath11k_mac_op_sta_statistics,
 	CFG80211_TESTMODE_CMD(ath11k_tm_cmd)
 
 #ifdef CONFIG_PM
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index dfa05f0ee6c9..d310feb1fdf2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10301,10 +10301,10 @@ static int ath12k_mac_get_fw_stats(struct ath12k *ar, u32 pdev_id,
 	return ret;
 }
 
-static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
-					 struct ieee80211_vif *vif,
-					 struct ieee80211_sta *sta,
-					 struct station_info *sinfo)
+static void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
+					      struct ieee80211_vif *vif,
+					      struct ieee80211_sta *sta,
+					      struct link_station_info *sinfo)
 {
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
 	struct ath12k_link_sta *arsta;
@@ -10600,7 +10600,7 @@ static const struct ieee80211_ops ath12k_ops = {
 	.set_bitrate_mask		= ath12k_mac_op_set_bitrate_mask,
 	.get_survey			= ath12k_mac_op_get_survey,
 	.flush				= ath12k_mac_op_flush,
-	.sta_statistics			= ath12k_mac_op_sta_statistics,
+	.link_sta_statistics		= ath12k_mac_op_link_sta_statistics,
 	.remain_on_channel              = ath12k_mac_op_remain_on_channel,
 	.cancel_remain_on_channel       = ath12k_mac_op_cancel_remain_on_channel,
 	.change_sta_links               = ath12k_mac_op_change_sta_links,
diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 8c2e8081112e..e99dc173c6e5 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1810,47 +1810,51 @@ static int ath6kl_get_station(struct wiphy *wiphy, struct net_device *dev,
 	else if (left < 0)
 		return left;
 
+	sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
+	if (!sinfo->links[0])
+		return -ENOMEM;
+
 	if (vif->target_stats.rx_byte) {
-		sinfo->rx_bytes = vif->target_stats.rx_byte;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
-		sinfo->rx_packets = vif->target_stats.rx_pkt;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
+		sinfo->links[0]->rx_bytes = vif->target_stats.rx_byte;
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
+		sinfo->links[0]->rx_packets = vif->target_stats.rx_pkt;
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
 	}
 
 	if (vif->target_stats.tx_byte) {
-		sinfo->tx_bytes = vif->target_stats.tx_byte;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
-		sinfo->tx_packets = vif->target_stats.tx_pkt;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
+		sinfo->links[0]->tx_bytes = vif->target_stats.tx_byte;
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
+		sinfo->links[0]->tx_packets = vif->target_stats.tx_pkt;
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
 	}
 
-	sinfo->signal = vif->target_stats.cs_rssi;
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+	sinfo->links[0]->signal = vif->target_stats.cs_rssi;
+	sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
 
 	rate = vif->target_stats.tx_ucast_rate;
 
 	if (is_rate_legacy(rate)) {
-		sinfo->txrate.legacy = rate / 100;
+		sinfo->links[0]->txrate.legacy = rate / 100;
 	} else if (is_rate_ht20(rate, &mcs, &sgi)) {
 		if (sgi) {
-			sinfo->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
-			sinfo->txrate.mcs = mcs - 1;
+			sinfo->links[0]->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+			sinfo->links[0]->txrate.mcs = mcs - 1;
 		} else {
-			sinfo->txrate.mcs = mcs;
+			sinfo->links[0]->txrate.mcs = mcs;
 		}
 
-		sinfo->txrate.flags |= RATE_INFO_FLAGS_MCS;
-		sinfo->txrate.bw = RATE_INFO_BW_20;
+		sinfo->links[0]->txrate.flags |= RATE_INFO_FLAGS_MCS;
+		sinfo->links[0]->txrate.bw = RATE_INFO_BW_20;
 	} else if (is_rate_ht40(rate, &mcs, &sgi)) {
 		if (sgi) {
-			sinfo->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
-			sinfo->txrate.mcs = mcs - 1;
+			sinfo->links[0]->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+			sinfo->links[0]->txrate.mcs = mcs - 1;
 		} else {
-			sinfo->txrate.mcs = mcs;
+			sinfo->links[0]->txrate.mcs = mcs;
 		}
 
-		sinfo->txrate.bw = RATE_INFO_BW_40;
-		sinfo->txrate.flags |= RATE_INFO_FLAGS_MCS;
+		sinfo->links[0]->txrate.bw = RATE_INFO_BW_40;
+		sinfo->links[0]->txrate.flags |= RATE_INFO_FLAGS_MCS;
 	} else {
 		ath6kl_dbg(ATH6KL_DBG_WLAN_CFG,
 			   "invalid rate from stats: %d\n", rate);
@@ -1858,15 +1862,15 @@ static int ath6kl_get_station(struct wiphy *wiphy, struct net_device *dev,
 		return 0;
 	}
 
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+	sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 
 	if (test_bit(CONNECTED, &vif->flags) &&
 	    test_bit(DTIM_PERIOD_AVAIL, &vif->flags) &&
 	    vif->nw_type == INFRA_NETWORK) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BSS_PARAM);
-		sinfo->bss_param.flags = 0;
-		sinfo->bss_param.dtim_period = vif->assoc_bss_dtim_period;
-		sinfo->bss_param.beacon_interval = vif->assoc_bss_beacon_int;
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_BSS_PARAM);
+		sinfo->links[0]->bss_param.flags = 0;
+		sinfo->links[0]->bss_param.dtim_period = vif->assoc_bss_dtim_period;
+		sinfo->links[0]->bss_param.beacon_interval = vif->assoc_bss_beacon_int;
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 94d08d6ae1a3..7bdf09613df6 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1332,7 +1332,8 @@ static int wcn36xx_get_survey(struct ieee80211_hw *hw, int idx,
 }
 
 static void wcn36xx_sta_statistics(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-				   struct ieee80211_sta *sta, struct station_info *sinfo)
+				   struct ieee80211_sta *sta,
+				   struct link_station_info *sinfo)
 {
 	struct wcn36xx *wcn;
 	u8 sta_index;
@@ -1374,7 +1375,7 @@ static const struct ieee80211_ops wcn36xx_ops = {
 	.set_rts_threshold	= wcn36xx_set_rts_threshold,
 	.sta_add		= wcn36xx_sta_add,
 	.sta_remove		= wcn36xx_sta_remove,
-	.sta_statistics		= wcn36xx_sta_statistics,
+	.link_sta_statistics	= wcn36xx_sta_statistics,
 	.ampdu_action		= wcn36xx_ampdu_action,
 #if IS_ENABLED(CONFIG_IPV6)
 	.ipv6_addr_change	= wcn36xx_ipv6_addr_change,
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 2cf86fc3f8fe..e494fb34c4fc 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2590,7 +2590,7 @@ int wcn36xx_smd_del_ba(struct wcn36xx *wcn, u16 tid, u8 direction, u8 sta_index)
 }
 
 int wcn36xx_smd_get_stats(struct wcn36xx *wcn, u8 sta_index, u32 stats_mask,
-			  struct station_info *sinfo)
+			  struct link_station_info *sinfo)
 {
 	struct wcn36xx_hal_stats_req_msg msg_body;
 	struct wcn36xx_hal_stats_rsp_msg *rsp;
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index 2c1ed9e570bf..f6a7944aa464 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -136,7 +136,7 @@ int wcn36xx_smd_add_ba(struct wcn36xx *wcn, u8 session_id);
 int wcn36xx_smd_del_ba(struct wcn36xx *wcn, u16 tid, u8 direction, u8 sta_index);
 int wcn36xx_smd_trigger_ba(struct wcn36xx *wcn, u8 sta_index, u16 tid, u16 *ssn);
 int wcn36xx_smd_get_stats(struct wcn36xx *wcn, u8 sta_index, u32 stats_mask,
-			  struct station_info *sinfo);
+			  struct link_station_info *sinfo);
 
 int wcn36xx_smd_update_cfg(struct wcn36xx *wcn, u32 cfg_id, u32 value);
 
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 5473c01cbe66..df0fad50f7ad 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -474,9 +474,13 @@ int wil_cid_fill_sinfo(struct wil6210_vif *vif, int cid,
 		    le16_to_cpu(reply.evt.other_tx_sector),
 		    reply.evt.tx_mode);
 
+	sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
+	if (!sinfo->links[0])
+		return -ENOMEM;
+
 	sinfo->generation = wil->sinfo_gen;
 
-	sinfo->filled = BIT_ULL(NL80211_STA_INFO_RX_BYTES) |
+	sinfo->links[0]->filled = BIT_ULL(NL80211_STA_INFO_RX_BYTES) |
 			BIT_ULL(NL80211_STA_INFO_TX_BYTES) |
 			BIT_ULL(NL80211_STA_INFO_RX_PACKETS) |
 			BIT_ULL(NL80211_STA_INFO_TX_PACKETS) |
@@ -504,29 +508,29 @@ int wil_cid_fill_sinfo(struct wil6210_vif *vif, int cid,
 		rx_mcs = WIL_BASE_MCS_FOR_EXTENDED_26;
 	}
 
-	sinfo->txrate.flags = tx_rate_flag;
-	sinfo->rxrate.flags = rx_rate_flag;
-	sinfo->txrate.mcs = tx_mcs;
-	sinfo->rxrate.mcs = rx_mcs;
+	sinfo->links[0]->txrate.flags = tx_rate_flag;
+	sinfo->links[0]->rxrate.flags = rx_rate_flag;
+	sinfo->links[0]->txrate.mcs = tx_mcs;
+	sinfo->links[0]->rxrate.mcs = rx_mcs;
 
-	sinfo->txrate.n_bonded_ch =
+	sinfo->links[0]->txrate.n_bonded_ch =
 				  wil_tx_cb_mode_to_n_bonded(reply.evt.tx_mode);
-	sinfo->rxrate.n_bonded_ch =
+	sinfo->links[0]->rxrate.n_bonded_ch =
 			     wil_rx_cb_mode_to_n_bonded(stats->last_cb_mode_rx);
-	sinfo->rx_bytes = stats->rx_bytes;
-	sinfo->rx_packets = stats->rx_packets;
-	sinfo->rx_dropped_misc = stats->rx_dropped;
-	sinfo->tx_bytes = stats->tx_bytes;
-	sinfo->tx_packets = stats->tx_packets;
-	sinfo->tx_failed = stats->tx_errors;
+	sinfo->links[0]->rx_bytes = stats->rx_bytes;
+	sinfo->links[0]->rx_packets = stats->rx_packets;
+	sinfo->links[0]->rx_dropped_misc = stats->rx_dropped;
+	sinfo->links[0]->tx_bytes = stats->tx_bytes;
+	sinfo->links[0]->tx_packets = stats->tx_packets;
+	sinfo->links[0]->tx_failed = stats->tx_errors;
 
 	if (test_bit(wil_vif_fwconnected, vif->status)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
 		if (test_bit(WMI_FW_CAPABILITY_RSSI_REPORTING,
 			     wil->fw_capabilities))
-			sinfo->signal = reply.evt.rssi;
+			sinfo->links[0]->signal = reply.evt.rssi;
 		else
-			sinfo->signal = reply.evt.sqi;
+			sinfo->links[0]->signal = reply.evt.sqi;
 	}
 
 	return rc;
diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index c021ebcddee7..e2c5fb90da5c 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -1396,6 +1396,12 @@ static int link_show(struct seq_file *s, void *data)
 	if (!sinfo)
 		return -ENOMEM;
 
+	sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
+	if (!sinfo->links[0]) {
+		kfree(sinfo);
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < wil->max_assoc_sta; i++) {
 		struct wil_sta_info *p = &wil->sta[i];
 		char *status = "unknown";
@@ -1427,16 +1433,17 @@ static int link_show(struct seq_file *s, void *data)
 				goto out;
 
 			seq_printf(s, "  Tx_mcs = %s\n",
-				   WIL_EXTENDED_MCS_CHECK(sinfo->txrate.mcs));
+				   WIL_EXTENDED_MCS_CHECK(sinfo->links[0]->txrate.mcs));
 			seq_printf(s, "  Rx_mcs = %s\n",
-				   WIL_EXTENDED_MCS_CHECK(sinfo->rxrate.mcs));
-			seq_printf(s, "  SQ     = %d\n", sinfo->signal);
+				   WIL_EXTENDED_MCS_CHECK(sinfo->links[0]->rxrate.mcs));
+			seq_printf(s, "  SQ     = %d\n", sinfo->links[0]->signal);
 		} else {
 			seq_puts(s, "  INVALID MID\n");
 		}
 	}
 
 out:
+	kfree(sinfo->links[0]);
 	kfree(sinfo);
 	return rc;
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 4b70845e1a26..642fc753ce21 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3028,7 +3028,7 @@ static void brcmf_convert_sta_flags(u32 fw_sta_flags, struct station_info *si)
 		sfu->set |= BIT(NL80211_STA_FLAG_AUTHORIZED);
 }
 
-static void brcmf_fill_bss_param(struct brcmf_if *ifp, struct station_info *si)
+static void brcmf_fill_bss_param(struct brcmf_if *ifp, struct link_station_info *si)
 {
 	struct brcmf_pub *drvr = ifp->drvr;
 	struct {
@@ -3066,7 +3066,7 @@ static void brcmf_fill_bss_param(struct brcmf_if *ifp, struct station_info *si)
 
 static s32
 brcmf_cfg80211_get_station_ibss(struct brcmf_if *ifp,
-				struct station_info *sinfo)
+				struct link_station_info *sinfo)
 {
 	struct brcmf_pub *drvr = ifp->drvr;
 	struct brcmf_scb_val_le scbval;
@@ -3135,8 +3135,17 @@ brcmf_cfg80211_get_station(struct wiphy *wiphy, struct net_device *ndev,
 	if (!check_vif_up(ifp->vif))
 		return -EIO;
 
-	if (brcmf_is_ibssmode(ifp->vif))
-		return brcmf_cfg80211_get_station_ibss(ifp, sinfo);
+	sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
+	if (!sinfo->links[0])
+		return -ENOMEM;
+
+	if (brcmf_is_ibssmode(ifp->vif)) {
+		err = brcmf_cfg80211_get_station_ibss(ifp, sinfo->links[0]);
+		if (err) {
+			kfree(sinfo->links[0]);
+			return err;
+		}
+	}
 
 	memset(&sta_info_le, 0, sizeof(sta_info_le));
 	memcpy(&sta_info_le, mac, ETH_ALEN);
@@ -3150,12 +3159,13 @@ brcmf_cfg80211_get_station(struct wiphy *wiphy, struct net_device *ndev,
 					       sizeof(sta_info_le));
 		if (err < 0) {
 			bphy_err(drvr, "GET STA INFO failed, %d\n", err);
+			kfree(sinfo->links[0]);
 			goto done;
 		}
 	}
 	brcmf_dbg(TRACE, "version %d\n", le16_to_cpu(sta_info_le.ver));
-	sinfo->filled = BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME);
-	sinfo->inactive_time = le32_to_cpu(sta_info_le.idle) * 1000;
+	sinfo->links[0]->filled = BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME);
+	sinfo->links[0]->inactive_time = le32_to_cpu(sta_info_le.idle) * 1000;
 	sta_flags = le32_to_cpu(sta_info_le.flags);
 	brcmf_convert_sta_flags(sta_flags, sinfo);
 	sinfo->sta_flags.mask |= BIT(NL80211_STA_FLAG_TDLS_PEER);
@@ -3166,54 +3176,54 @@ brcmf_cfg80211_get_station(struct wiphy *wiphy, struct net_device *ndev,
 	if (sta_flags & BRCMF_STA_ASSOC) {
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CONNECTED_TIME);
 		sinfo->connected_time = le32_to_cpu(sta_info_le.in);
-		brcmf_fill_bss_param(ifp, sinfo);
+		brcmf_fill_bss_param(ifp, sinfo->links[0]);
 	}
 	if (sta_flags & BRCMF_STA_SCBSTATS) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
-		sinfo->tx_failed = le32_to_cpu(sta_info_le.tx_failures);
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
-		sinfo->tx_packets = le32_to_cpu(sta_info_le.tx_pkts);
-		sinfo->tx_packets += le32_to_cpu(sta_info_le.tx_mcast_pkts);
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
-		sinfo->rx_packets = le32_to_cpu(sta_info_le.rx_ucast_pkts);
-		sinfo->rx_packets += le32_to_cpu(sta_info_le.rx_mcast_pkts);
-		if (sinfo->tx_packets) {
-			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
-			sinfo->txrate.legacy =
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+		sinfo->links[0]->tx_failed = le32_to_cpu(sta_info_le.tx_failures);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
+		sinfo->links[0]->tx_packets = le32_to_cpu(sta_info_le.tx_pkts);
+		sinfo->links[0]->tx_packets += le32_to_cpu(sta_info_le.tx_mcast_pkts);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
+		sinfo->links[0]->rx_packets = le32_to_cpu(sta_info_le.rx_ucast_pkts);
+		sinfo->links[0]->rx_packets += le32_to_cpu(sta_info_le.rx_mcast_pkts);
+		if (sinfo->links[0]->tx_packets) {
+			sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+			sinfo->links[0]->txrate.legacy =
 				le32_to_cpu(sta_info_le.tx_rate) / 100;
 		}
-		if (sinfo->rx_packets) {
-			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
-			sinfo->rxrate.legacy =
+		if (sinfo->links[0]->rx_packets) {
+			sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
+			sinfo->links[0]->rxrate.legacy =
 				le32_to_cpu(sta_info_le.rx_rate) / 100;
 		}
 		if (le16_to_cpu(sta_info_le.ver) >= 4) {
-			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES);
-			sinfo->tx_bytes = le64_to_cpu(sta_info_le.tx_tot_bytes);
-			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES);
-			sinfo->rx_bytes = le64_to_cpu(sta_info_le.rx_tot_bytes);
+			sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES);
+			sinfo->links[0]->tx_bytes = le64_to_cpu(sta_info_le.tx_tot_bytes);
+			sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES);
+			sinfo->links[0]->rx_bytes = le64_to_cpu(sta_info_le.rx_tot_bytes);
 		}
 		for (i = 0; i < BRCMF_ANT_MAX; i++) {
 			if (sta_info_le.rssi[i] == 0 ||
 			    sta_info_le.rx_lastpkt_rssi[i] == 0)
 				continue;
-			sinfo->chains |= BIT(count_rssi);
-			sinfo->chain_signal[count_rssi] =
+			sinfo->links[0]->chains |= BIT(count_rssi);
+			sinfo->links[0]->chain_signal[count_rssi] =
 				sta_info_le.rx_lastpkt_rssi[i];
-			sinfo->chain_signal_avg[count_rssi] =
+			sinfo->links[0]->chain_signal_avg[count_rssi] =
 				sta_info_le.rssi[i];
 			total_rssi += sta_info_le.rx_lastpkt_rssi[i];
 			total_rssi_avg += sta_info_le.rssi[i];
 			count_rssi++;
 		}
 		if (count_rssi) {
-			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
-			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
-			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
-			sinfo->filled |=
+			sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+			sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+			sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
+			sinfo->links[0]->filled |=
 				BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
-			sinfo->signal = total_rssi / count_rssi;
-			sinfo->signal_avg = total_rssi_avg / count_rssi;
+			sinfo->links[0]->signal = total_rssi / count_rssi;
+			sinfo->links[0]->signal_avg = total_rssi_avg / count_rssi;
 		} else if (test_bit(BRCMF_VIF_STATUS_CONNECTED,
 			&ifp->vif->sme_state)) {
 			memset(&scb_val, 0, sizeof(scb_val));
@@ -3222,11 +3232,13 @@ brcmf_cfg80211_get_station(struct wiphy *wiphy, struct net_device *ndev,
 			if (err) {
 				bphy_err(drvr, "Could not get rssi (%d)\n",
 					 err);
+				kfree(sinfo->links[0]);
 				goto done;
 			} else {
 				rssi = le32_to_cpu(scb_val.val);
-				sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
-				sinfo->signal = rssi;
+				sinfo->links[0]->filled |=
+					BIT_ULL(NL80211_STA_INFO_SIGNAL);
+				sinfo->links[0]->signal = rssi;
 				brcmf_dbg(CONN, "RSSI %d dBm\n", rssi);
 			}
 		}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 6851064b82da..3e41c5002b49 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2626,7 +2626,7 @@ const struct ieee80211_ops iwl_mld_hw_ops = {
 	.mgd_prepare_tx = iwl_mld_mac80211_mgd_prepare_tx,
 	.mgd_complete_tx = iwl_mld_mac_mgd_complete_tx,
 	.sta_state = iwl_mld_mac80211_sta_state,
-	.sta_statistics = iwl_mld_mac80211_sta_statistics,
+	.link_sta_statistics = iwl_mld_mac80211_sta_statistics,
 	.flush = iwl_mld_mac80211_flush,
 	.flush_sta = iwl_mld_mac80211_flush_sta,
 	.ampdu_action = iwl_mld_mac80211_ampdu_action,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
index 0715bbc31031..f6ab72f64af8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -38,7 +38,7 @@ int iwl_mld_clear_stats_in_fw(struct iwl_mld *mld)
 static void
 iwl_mld_fill_stats_from_oper_notif(struct iwl_mld *mld,
 				   struct iwl_rx_packet *pkt,
-				   u8 fw_sta_id, struct station_info *sinfo)
+				   u8 fw_sta_id, struct link_station_info *sinfo)
 {
 	const struct iwl_system_statistics_notif_oper *notif =
 		(void *)&pkt->data;
@@ -73,7 +73,7 @@ iwl_mld_fill_stats_from_oper_notif(struct iwl_mld *mld,
 
 struct iwl_mld_stats_data {
 	u8 fw_sta_id;
-	struct station_info *sinfo;
+	struct link_station_info *sinfo;
 	struct iwl_mld *mld;
 };
 
@@ -100,7 +100,7 @@ static bool iwl_mld_wait_stats_handler(struct iwl_notif_wait_data *notif_data,
 
 static int
 iwl_mld_fw_stats_to_mac80211(struct iwl_mld *mld, struct iwl_mld_sta *mld_sta,
-			     struct station_info *sinfo)
+			     struct link_station_info *sinfo)
 {
 	u32 cfg_mask = IWL_STATS_CFG_FLG_ON_DEMAND_NTFY_MSK |
 		       IWL_STATS_CFG_FLG_RESET_MSK;
@@ -164,7 +164,7 @@ int iwl_mld_request_periodic_fw_stats(struct iwl_mld *mld, bool enable)
 }
 
 static void iwl_mld_sta_stats_fill_txrate(struct iwl_mld_sta *mld_sta,
-					  struct station_info *sinfo)
+					  struct link_station_info *sinfo)
 {
 	struct rate_info *rinfo = &sinfo->txrate;
 	u32 rate_n_flags = mld_sta->deflink.last_rate_n_flags;
@@ -305,7 +305,7 @@ static void iwl_mld_sta_stats_fill_txrate(struct iwl_mld_sta *mld_sta,
 void iwl_mld_mac80211_sta_statistics(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_sta *sta,
-				     struct station_info *sinfo)
+				     struct link_station_info *sinfo)
 {
 	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.h b/drivers/net/wireless/intel/iwlwifi/mld/stats.h
index de434e66d555..d6c6f609b3a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.h
@@ -10,7 +10,7 @@ int iwl_mld_request_periodic_fw_stats(struct iwl_mld *mld, bool enable);
 void iwl_mld_mac80211_sta_statistics(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_sta *sta,
-				     struct station_info *sinfo);
+				     struct link_station_info *sinfo);
 
 void iwl_mld_handle_stats_oper_notif(struct iwl_mld *mld,
 				     struct iwl_rx_packet *pkt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 1e916a0ce082..b19b9ffe1e25 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6255,7 +6255,7 @@ static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta,
-				struct station_info *sinfo)
+				struct link_station_info *sinfo)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -6663,7 +6663,7 @@ const struct ieee80211_ops iwl_mvm_hw_ops = {
 	.set_default_unicast_key = iwl_mvm_set_default_unicast_key,
 #endif
 	.get_survey = iwl_mvm_mac_get_survey,
-	.sta_statistics = iwl_mvm_mac_sta_statistics,
+	.link_sta_statistics = iwl_mvm_mac_sta_statistics,
 	.get_ftm_responder_stats = iwl_mvm_mac_get_ftm_responder_stats,
 	.start_pmsr = iwl_mvm_start_pmsr,
 	.abort_pmsr = iwl_mvm_abort_pmsr,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 78d7153a0cfc..5ead5dc6837a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1417,7 +1417,7 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.set_default_unicast_key = iwl_mvm_set_default_unicast_key,
 #endif
 	.get_survey = iwl_mvm_mac_get_survey,
-	.sta_statistics = iwl_mvm_mac_sta_statistics,
+	.link_sta_statistics = iwl_mvm_mac_sta_statistics,
 	.get_ftm_responder_stats = iwl_mvm_mac_get_ftm_responder_stats,
 	.start_pmsr = iwl_mvm_start_pmsr,
 	.abort_pmsr = iwl_mvm_abort_pmsr,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f6391c7a3e29..2c840f0f6c74 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2964,7 +2964,7 @@ int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
 void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta,
-				struct station_info *sinfo);
+				struct link_station_info *sinfo);
 int
 iwl_mvm_mac_get_ftm_responder_stats(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 2e2c193716d9..1e687aa26837 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -1612,27 +1612,31 @@ static int lbs_cfg_get_station(struct wiphy *wiphy, struct net_device *dev,
 	int ret;
 	size_t i;
 
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES) |
+	sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
+	if (!sinfo->links[0])
+		return -ENOMEM;
+
+	sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES) |
 			 BIT_ULL(NL80211_STA_INFO_TX_PACKETS) |
 			 BIT_ULL(NL80211_STA_INFO_RX_BYTES) |
 			 BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
-	sinfo->tx_bytes = priv->dev->stats.tx_bytes;
-	sinfo->tx_packets = priv->dev->stats.tx_packets;
-	sinfo->rx_bytes = priv->dev->stats.rx_bytes;
-	sinfo->rx_packets = priv->dev->stats.rx_packets;
+	sinfo->links[0]->tx_bytes = priv->dev->stats.tx_bytes;
+	sinfo->links[0]->tx_packets = priv->dev->stats.tx_packets;
+	sinfo->links[0]->rx_bytes = priv->dev->stats.rx_bytes;
+	sinfo->links[0]->rx_packets = priv->dev->stats.rx_packets;
 
 	/* Get current RSSI */
 	ret = lbs_get_rssi(priv, &signal, &noise);
 	if (ret == 0) {
-		sinfo->signal = signal;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+		sinfo->links[0]->signal = signal;
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
 	}
 
 	/* Convert priv->cur_rate from hw_value to NL80211 value */
 	for (i = 0; i < ARRAY_SIZE(lbs_rates); i++) {
 		if (priv->cur_rate == lbs_rates[i].hw_value) {
-			sinfo->txrate.legacy = lbs_rates[i].bitrate;
-			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+			sinfo->links[0]->txrate.legacy = lbs_rates[i].bitrate;
+			sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 			break;
 		}
 	}
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index a099fdaafa45..749c6e2397d9 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1461,32 +1461,39 @@ mwifiex_dump_station_info(struct mwifiex_private *priv,
 {
 	u32 rate;
 
-	sinfo->filled = BIT_ULL(NL80211_STA_INFO_RX_BYTES) | BIT_ULL(NL80211_STA_INFO_TX_BYTES) |
+	sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
+	if (!sinfo->links[0])
+		return -ENOMEM;
+
+	sinfo->links[0]->filled = BIT_ULL(NL80211_STA_INFO_RX_BYTES) |
+			BIT_ULL(NL80211_STA_INFO_TX_BYTES) |
 			BIT_ULL(NL80211_STA_INFO_RX_PACKETS) | BIT_ULL(NL80211_STA_INFO_TX_PACKETS) |
 			BIT_ULL(NL80211_STA_INFO_TX_BITRATE) |
 			BIT_ULL(NL80211_STA_INFO_SIGNAL) | BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
 
 	if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP) {
-		if (!node)
+		if (!node) {
+			kfree(sinfo->links[0]);
 			return -ENOENT;
+		}
 
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME) |
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME) |
 				BIT_ULL(NL80211_STA_INFO_TX_FAILED);
-		sinfo->inactive_time =
+		sinfo->links[0]->inactive_time =
 			jiffies_to_msecs(jiffies - node->stats.last_rx);
 
-		sinfo->signal = node->stats.rssi;
-		sinfo->signal_avg = node->stats.rssi;
-		sinfo->rx_bytes = node->stats.rx_bytes;
-		sinfo->tx_bytes = node->stats.tx_bytes;
-		sinfo->rx_packets = node->stats.rx_packets;
-		sinfo->tx_packets = node->stats.tx_packets;
-		sinfo->tx_failed = node->stats.tx_failed;
+		sinfo->links[0]->signal = node->stats.rssi;
+		sinfo->links[0]->signal_avg = node->stats.rssi;
+		sinfo->links[0]->rx_bytes = node->stats.rx_bytes;
+		sinfo->links[0]->tx_bytes = node->stats.tx_bytes;
+		sinfo->links[0]->rx_packets = node->stats.rx_packets;
+		sinfo->links[0]->tx_packets = node->stats.tx_packets;
+		sinfo->links[0]->tx_failed = node->stats.tx_failed;
 
 		mwifiex_parse_htinfo(priv, priv->tx_rate,
 				     node->stats.last_tx_htinfo,
-				     &sinfo->txrate);
-		sinfo->txrate.legacy = node->stats.last_tx_rate * 5;
+				     &sinfo->links[0]->txrate);
+		sinfo->links[0]->txrate.legacy = node->stats.last_tx_rate * 5;
 
 		return 0;
 	}
@@ -1496,12 +1503,14 @@ mwifiex_dump_station_info(struct mwifiex_private *priv,
 			     HostCmd_ACT_GEN_GET, 0, NULL, true)) {
 		mwifiex_dbg(priv->adapter, ERROR,
 			    "failed to get signal information\n");
+		kfree(sinfo->links[0]);
 		return -EFAULT;
 	}
 
 	if (mwifiex_drv_get_data_rate(priv, &rate)) {
 		mwifiex_dbg(priv->adapter, ERROR,
 			    "getting data rate error\n");
+		kfree(sinfo->links[0]);
 		return -EFAULT;
 	}
 
@@ -1511,34 +1520,34 @@ mwifiex_dump_station_info(struct mwifiex_private *priv,
 			 &priv->dtim_period, true);
 
 	mwifiex_parse_htinfo(priv, priv->tx_rate, priv->tx_htinfo,
-			     &sinfo->txrate);
-
-	sinfo->signal_avg = priv->bcn_rssi_avg;
-	sinfo->rx_bytes = priv->stats.rx_bytes;
-	sinfo->tx_bytes = priv->stats.tx_bytes;
-	sinfo->rx_packets = priv->stats.rx_packets;
-	sinfo->tx_packets = priv->stats.tx_packets;
-	sinfo->signal = priv->bcn_rssi_avg;
+			     &sinfo->links[0]->txrate);
+
+	sinfo->links[0]->signal_avg = priv->bcn_rssi_avg;
+	sinfo->links[0]->rx_bytes = priv->stats.rx_bytes;
+	sinfo->links[0]->tx_bytes = priv->stats.tx_bytes;
+	sinfo->links[0]->rx_packets = priv->stats.rx_packets;
+	sinfo->links[0]->tx_packets = priv->stats.tx_packets;
+	sinfo->links[0]->signal = priv->bcn_rssi_avg;
 	/* bit rate is in 500 kb/s units. Convert it to 100kb/s units */
-	sinfo->txrate.legacy = rate * 5;
+	sinfo->links[0]->txrate.legacy = rate * 5;
 
-	sinfo->filled |= BIT(NL80211_STA_INFO_RX_BITRATE);
+	sinfo->links[0]->filled |= BIT(NL80211_STA_INFO_RX_BITRATE);
 	mwifiex_parse_htinfo(priv, priv->rxpd_rate, priv->rxpd_htinfo,
-			     &sinfo->rxrate);
+			     &sinfo->links[0]->rxrate);
 
 	if (priv->bss_mode == NL80211_IFTYPE_STATION) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BSS_PARAM);
-		sinfo->bss_param.flags = 0;
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_BSS_PARAM);
+		sinfo->links[0]->bss_param.flags = 0;
 		if (priv->curr_bss_params.bss_descriptor.cap_info_bitmap &
 						WLAN_CAPABILITY_SHORT_PREAMBLE)
-			sinfo->bss_param.flags |=
+			sinfo->links[0]->bss_param.flags |=
 					BSS_PARAM_FLAGS_SHORT_PREAMBLE;
 		if (priv->curr_bss_params.bss_descriptor.cap_info_bitmap &
 						WLAN_CAPABILITY_SHORT_SLOT_TIME)
-			sinfo->bss_param.flags |=
+			sinfo->links[0]->bss_param.flags |=
 					BSS_PARAM_FLAGS_SHORT_SLOT_TIME;
-		sinfo->bss_param.dtim_period = priv->dtim_period;
-		sinfo->bss_param.beacon_interval =
+		sinfo->links[0]->bss_param.dtim_period = priv->dtim_period;
+		sinfo->links[0]->bss_param.beacon_interval =
 			priv->curr_bss_params.bss_descriptor.beacon_period;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3aa31c5cefa6..a2becae6a84a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1148,7 +1148,7 @@ mt7915_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta,
-				  struct station_info *sinfo)
+				  struct link_station_info *sinfo)
 {
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
@@ -1794,7 +1794,7 @@ const struct ieee80211_ops mt7915_ops = {
 	.set_antenna = mt7915_set_antenna,
 	.set_bitrate_mask = mt7915_set_bitrate_mask,
 	.set_coverage_class = mt7915_set_coverage_class,
-	.sta_statistics = mt7915_sta_statistics,
+	.link_sta_statistics = mt7915_sta_statistics,
 	.sta_set_txpwr = mt7915_sta_set_txpwr,
 	.sta_set_4addr = mt7915_sta_set_4addr,
 	.sta_set_decap_offload = mt7915_sta_set_decap_offload,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 826c48a2ee69..b85291b26fd5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1545,7 +1545,7 @@ const struct ieee80211_ops mt7921_ops = {
 	.set_coverage_class = mt792x_set_coverage_class,
 	.hw_scan = mt7921_hw_scan,
 	.cancel_hw_scan = mt7921_cancel_hw_scan,
-	.sta_statistics = mt792x_sta_statistics,
+	.link_sta_statistics = mt792x_sta_statistics,
 	.sched_scan_start = mt7921_start_sched_scan,
 	.sched_scan_stop = mt7921_stop_sched_scan,
 	CFG80211_TESTMODE_CMD(mt7921_testmode_cmd)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 66f327781947..0bbc352fb02c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2231,7 +2231,7 @@ const struct ieee80211_ops mt7925_ops = {
 	.set_coverage_class = mt792x_set_coverage_class,
 	.hw_scan = mt7925_hw_scan,
 	.cancel_hw_scan = mt7925_cancel_hw_scan,
-	.sta_statistics = mt792x_sta_statistics,
+	.link_sta_statistics = mt792x_sta_statistics,
 	.sched_scan_start = mt7925_start_sched_scan,
 	.sched_scan_stop = mt7925_stop_sched_scan,
 #ifdef CONFIG_PM
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index e0359d431eca..6546ef4dbee8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -411,7 +411,7 @@ void mt792x_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 void mt792x_sta_statistics(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta,
-			   struct station_info *sinfo);
+			   struct link_station_info *sinfo);
 void mt792x_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class);
 void mt792x_dma_cleanup(struct mt792x_dev *dev);
 int mt792x_dma_enable(struct mt792x_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 38dd58f6e493..35de16374e1f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -544,7 +544,7 @@ EXPORT_SYMBOL_GPL(mt792x_get_et_stats);
 void mt792x_sta_statistics(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta,
-			   struct station_info *sinfo)
+			   struct link_station_info *sinfo)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct rate_info *txrate = &msta->deflink.wcid.rate;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 91c64e3a0860..5452fd989014 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1534,7 +1534,7 @@ mt7996_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 static void mt7996_sta_statistics(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta,
-				  struct station_info *sinfo)
+				  struct link_station_info *sinfo)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
@@ -2134,7 +2134,7 @@ const struct ieee80211_ops mt7996_ops = {
 	.set_antenna = mt7996_set_antenna,
 	.set_bitrate_mask = mt7996_set_bitrate_mask,
 	.set_coverage_class = mt7996_set_coverage_class,
-	.sta_statistics = mt7996_sta_statistics,
+	.link_sta_statistics = mt7996_sta_statistics,
 	.sta_set_4addr = mt7996_sta_set_4addr,
 	.sta_set_decap_offload = mt7996_sta_set_decap_offload,
 	.add_twt_setup = mt7996_mac_add_twt_setup,
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index e7aa0f991923..87512d5a304d 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -746,6 +746,10 @@ static int get_station(struct wiphy *wiphy, struct net_device *dev,
 	u32 associatedsta = ~0;
 	u32 inactive_time = 0;
 
+	sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
+	if (!sinfo->links[0])
+		return -ENOMEM;
+
 	if (vif->iftype == WILC_AP_MODE || vif->iftype == WILC_GO_MODE) {
 		for (i = 0; i < NUM_STA_ASSOCIATED; i++) {
 			if (!(memcmp(mac,
@@ -758,32 +762,35 @@ static int get_station(struct wiphy *wiphy, struct net_device *dev,
 
 		if (associatedsta == ~0) {
 			netdev_err(dev, "sta required is not associated\n");
+			kfree(sinfo->links[0]);
 			return -ENOENT;
 		}
 
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME);
 
 		wilc_get_inactive_time(vif, mac, &inactive_time);
-		sinfo->inactive_time = 1000 * inactive_time;
+		sinfo->links[0]->inactive_time = 1000 * inactive_time;
 	} else if (vif->iftype == WILC_STATION_MODE) {
 		struct rf_info stats;
 
-		if (!wilc->initialized)
+		if (!wilc->initialized) {
+			kfree(sinfo->links[0]);
 			return -EBUSY;
+		}
 
 		wilc_get_statistics(vif, &stats);
 
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL) |
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL) |
 				 BIT_ULL(NL80211_STA_INFO_RX_PACKETS) |
 				 BIT_ULL(NL80211_STA_INFO_TX_PACKETS) |
 				 BIT_ULL(NL80211_STA_INFO_TX_FAILED) |
 				 BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 
-		sinfo->signal = stats.rssi;
-		sinfo->rx_packets = stats.rx_cnt;
-		sinfo->tx_packets = stats.tx_cnt + stats.tx_fail_cnt;
-		sinfo->tx_failed = stats.tx_fail_cnt;
-		sinfo->txrate.legacy = stats.link_speed * 10;
+		sinfo->links[0]->signal = stats.rssi;
+		sinfo->links[0]->rx_packets = stats.rx_cnt;
+		sinfo->links[0]->tx_packets = stats.tx_cnt + stats.tx_fail_cnt;
+		sinfo->links[0]->tx_failed = stats.tx_fail_cnt;
+		sinfo->links[0]->txrate.legacy = stats.link_speed * 10;
 
 		if (stats.link_speed > TCP_ACK_FILTER_LINK_SPEED_THRESH &&
 		    stats.link_speed != DEFAULT_LINK_SPEED)
@@ -1330,11 +1337,16 @@ static int dump_station(struct wiphy *wiphy, struct net_device *dev,
 	if (idx != 0)
 		return -ENOENT;
 
-	ret = wilc_get_rssi(vif, &sinfo->signal);
-	if (ret)
-		return ret;
+	sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
+	if (!sinfo->links[0])
+		return -ENOMEM;
 
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+	ret = wilc_get_rssi(vif, &sinfo->links[0]->signal);
+	if (ret) {
+		kfree(sinfo->links[0]);
+		return ret;
+	}
+	sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
 	memcpy(mac, vif->priv.associated_bss, ETH_ALEN);
 	return 0;
 }
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/net/wireless/quantenna/qtnfmac/commands.c
index 956c5763662f..4ce1827b93e4 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -615,9 +615,13 @@ qtnf_cmd_sta_info_parse(struct station_info *sinfo, const u8 *data,
 	if (!map || !stats)
 		return;
 
+	sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
+	if (!sinfo->links[0])
+		return;
+
 	if (qtnf_sta_stat_avail(inactive_time, QLINK_STA_INFO_INACTIVE_TIME)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME);
-		sinfo->inactive_time = le32_to_cpu(stats->inactive_time);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME);
+		sinfo->links[0]->inactive_time = le32_to_cpu(stats->inactive_time);
 	}
 
 	if (qtnf_sta_stat_avail(connected_time,
@@ -627,23 +631,23 @@ qtnf_cmd_sta_info_parse(struct station_info *sinfo, const u8 *data,
 	}
 
 	if (qtnf_sta_stat_avail(signal, QLINK_STA_INFO_SIGNAL)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
-		sinfo->signal = stats->signal - QLINK_RSSI_OFFSET;
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+		sinfo->links[0]->signal = stats->signal - QLINK_RSSI_OFFSET;
 	}
 
 	if (qtnf_sta_stat_avail(signal_avg, QLINK_STA_INFO_SIGNAL_AVG)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
-		sinfo->signal_avg = stats->signal_avg - QLINK_RSSI_OFFSET;
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+		sinfo->links[0]->signal_avg = stats->signal_avg - QLINK_RSSI_OFFSET;
 	}
 
 	if (qtnf_sta_stat_avail(rxrate, QLINK_STA_INFO_RX_BITRATE)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
-		qtnf_sta_info_parse_rate(&sinfo->rxrate, &stats->rxrate);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
+		qtnf_sta_info_parse_rate(&sinfo->links[0]->rxrate, &stats->rxrate);
 	}
 
 	if (qtnf_sta_stat_avail(txrate, QLINK_STA_INFO_TX_BITRATE)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
-		qtnf_sta_info_parse_rate(&sinfo->txrate, &stats->txrate);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+		qtnf_sta_info_parse_rate(&sinfo->links[0]->txrate, &stats->txrate);
 	}
 
 	if (qtnf_sta_stat_avail(sta_flags, QLINK_STA_INFO_STA_FLAGS)) {
@@ -652,48 +656,48 @@ qtnf_cmd_sta_info_parse(struct station_info *sinfo, const u8 *data,
 	}
 
 	if (qtnf_sta_stat_avail(rx_bytes, QLINK_STA_INFO_RX_BYTES)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES);
-		sinfo->rx_bytes = le64_to_cpu(stats->rx_bytes);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES);
+		sinfo->links[0]->rx_bytes = le64_to_cpu(stats->rx_bytes);
 	}
 
 	if (qtnf_sta_stat_avail(tx_bytes, QLINK_STA_INFO_TX_BYTES)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES);
-		sinfo->tx_bytes = le64_to_cpu(stats->tx_bytes);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES);
+		sinfo->links[0]->tx_bytes = le64_to_cpu(stats->tx_bytes);
 	}
 
 	if (qtnf_sta_stat_avail(rx_bytes, QLINK_STA_INFO_RX_BYTES64)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
-		sinfo->rx_bytes = le64_to_cpu(stats->rx_bytes);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
+		sinfo->links[0]->rx_bytes = le64_to_cpu(stats->rx_bytes);
 	}
 
 	if (qtnf_sta_stat_avail(tx_bytes, QLINK_STA_INFO_TX_BYTES64)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
-		sinfo->tx_bytes = le64_to_cpu(stats->tx_bytes);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
+		sinfo->links[0]->tx_bytes = le64_to_cpu(stats->tx_bytes);
 	}
 
 	if (qtnf_sta_stat_avail(rx_packets, QLINK_STA_INFO_RX_PACKETS)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
-		sinfo->rx_packets = le32_to_cpu(stats->rx_packets);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
+		sinfo->links[0]->rx_packets = le32_to_cpu(stats->rx_packets);
 	}
 
 	if (qtnf_sta_stat_avail(tx_packets, QLINK_STA_INFO_TX_PACKETS)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
-		sinfo->tx_packets = le32_to_cpu(stats->tx_packets);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
+		sinfo->links[0]->tx_packets = le32_to_cpu(stats->tx_packets);
 	}
 
 	if (qtnf_sta_stat_avail(rx_beacon, QLINK_STA_INFO_BEACON_RX)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_RX);
-		sinfo->rx_beacon = le64_to_cpu(stats->rx_beacon);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_RX);
+		sinfo->links[0]->rx_beacon = le64_to_cpu(stats->rx_beacon);
 	}
 
 	if (qtnf_sta_stat_avail(rx_dropped_misc, QLINK_STA_INFO_RX_DROP_MISC)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC);
-		sinfo->rx_dropped_misc = le32_to_cpu(stats->rx_dropped_misc);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC);
+		sinfo->links[0]->rx_dropped_misc = le32_to_cpu(stats->rx_dropped_misc);
 	}
 
 	if (qtnf_sta_stat_avail(tx_failed, QLINK_STA_INFO_TX_FAILED)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
-		sinfo->tx_failed = le32_to_cpu(stats->tx_failed);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+		sinfo->links[0]->tx_failed = le32_to_cpu(stats->tx_failed);
 	}
 
 #undef qtnf_sta_stat_avail
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 569856ca677f..03a54bdb516b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -7138,7 +7138,7 @@ rtl8xxxu_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 static void
 rtl8xxxu_sta_statistics(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			struct ieee80211_sta *sta, struct station_info *sinfo)
+			struct ieee80211_sta *sta, struct link_station_info *sinfo)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
 
@@ -7636,7 +7636,7 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
 	.sw_scan_complete = rtl8xxxu_sw_scan_complete,
 	.set_key = rtl8xxxu_set_key,
 	.ampdu_action = rtl8xxxu_ampdu_action,
-	.sta_statistics = rtl8xxxu_sta_statistics,
+	.link_sta_statistics = rtl8xxxu_sta_statistics,
 	.get_antenna = rtl8xxxu_get_antenna,
 	.set_tim = rtl8xxxu_set_tim,
 	.sta_add = rtl8xxxu_sta_add,
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 026fbf4ad9cc..a3318fa7b728 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -720,7 +720,7 @@ static int rtw_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 static void rtw_ops_sta_statistics(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
-				   struct station_info *sinfo)
+				   struct link_station_info *sinfo)
 {
 	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
 
@@ -967,7 +967,7 @@ const struct ieee80211_ops rtw_ops = {
 	.sw_scan_complete	= rtw_ops_sw_scan_complete,
 	.mgd_prepare_tx		= rtw_ops_mgd_prepare_tx,
 	.set_rts_threshold	= rtw_ops_set_rts_threshold,
-	.sta_statistics		= rtw_ops_sta_statistics,
+	.link_sta_statistics	= rtw_ops_sta_statistics,
 	.flush			= rtw_ops_flush,
 	.set_bitrate_mask	= rtw_ops_set_bitrate_mask,
 	.set_antenna		= rtw_ops_set_antenna,
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 4fded07d0bee..26d109f20c3c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1013,7 +1013,7 @@ static int rtw89_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 static void rtw89_ops_sta_statistics(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_sta *sta,
-				     struct station_info *sinfo)
+				     struct link_station_info *sinfo)
 {
 	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
 	struct rtw89_sta_link *rtwsta_link;
@@ -1772,7 +1772,7 @@ const struct ieee80211_ops rtw89_ops = {
 	.set_key		= rtw89_ops_set_key,
 	.ampdu_action		= rtw89_ops_ampdu_action,
 	.set_rts_threshold	= rtw89_ops_set_rts_threshold,
-	.sta_statistics		= rtw89_ops_sta_statistics,
+	.link_sta_statistics	= rtw89_ops_sta_statistics,
 	.flush			= rtw89_ops_flush,
 	.set_bitrate_mask	= rtw89_ops_set_bitrate_mask,
 	.set_antenna		= rtw89_ops_set_antenna,
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index ea9bc4717a85..e3fd1ddb026a 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -5810,7 +5810,7 @@ static void wlcore_op_sta_rc_update(struct ieee80211_hw *hw,
 static void wlcore_op_sta_statistics(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_sta *sta,
-				     struct station_info *sinfo)
+				     struct link_station_info *sinfo)
 {
 	struct wl1271 *wl = hw->priv;
 	struct wl12xx_vif *wlvif = wl12xx_vif_to_data(vif);
@@ -6054,7 +6054,7 @@ static const struct ieee80211_ops wl1271_ops = {
 	.unassign_vif_chanctx = wlcore_op_unassign_vif_chanctx,
 	.switch_vif_chanctx = wlcore_op_switch_vif_chanctx,
 	.link_sta_rc_update = wlcore_op_sta_rc_update,
-	.sta_statistics = wlcore_op_sta_statistics,
+	.link_sta_statistics = wlcore_op_sta_statistics,
 	.get_expected_throughput = wlcore_op_get_expected_throughput,
 	CFG80211_TESTMODE_CMD(wl1271_tm_cmd)
 };
diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 1fffeff2190c..3c421a04b0f9 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -328,15 +328,19 @@ static int virt_wifi_get_station(struct wiphy *wiphy, struct net_device *dev,
 	if (!priv->is_connected || !ether_addr_equal(mac, fake_router_bssid))
 		return -ENOENT;
 
-	sinfo->filled = BIT_ULL(NL80211_STA_INFO_TX_PACKETS) |
+	sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
+	if (!sinfo->links[0])
+		return -ENOMEM;
+
+	sinfo->links[0]->filled = BIT_ULL(NL80211_STA_INFO_TX_PACKETS) |
 		BIT_ULL(NL80211_STA_INFO_TX_FAILED) |
 		BIT_ULL(NL80211_STA_INFO_SIGNAL) |
 		BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
-	sinfo->tx_packets = priv->tx_packets;
-	sinfo->tx_failed = priv->tx_failed;
+	sinfo->links[0]->tx_packets = priv->tx_packets;
+	sinfo->links[0]->tx_failed = priv->tx_failed;
 	/* For CFG80211_SIGNAL_TYPE_MBM, value is expressed in _dBm_ */
-	sinfo->signal = -50;
-	sinfo->txrate = (struct rate_info) {
+	sinfo->links[0]->signal = -50;
+	sinfo->links[0]->txrate = (struct rate_info) {
 		.legacy = 10, /* units are 100kbit/s */
 	};
 	return 0;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 7fcc46a0bb48..4b889d022584 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -969,8 +969,6 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	sinfo->filled = 0;
-
 	if (!mac) {
 		ret = -ENOENT;
 		goto exit;
@@ -982,6 +980,12 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
 		goto exit;
 	}
 
+	sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
+	if (!sinfo->links[0])
+		return -ENOMEM;
+
+	sinfo->links[0]->filled = 0;
+
 	/* for infra./P2PClient mode */
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)
 		&& check_fwstate(pmlmepriv, _FW_LINKED)) {
@@ -989,21 +993,23 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
 
 		if (memcmp((u8 *)mac, cur_network->network.mac_address, ETH_ALEN)) {
 			ret = -ENOENT;
+			kfree(sinfo->links[0]);
 			goto exit;
 		}
 
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
-		sinfo->signal = translate_percentage_to_dbm(padapter->recvpriv.signal_strength);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+		sinfo->links[0]->signal =
+			translate_percentage_to_dbm(padapter->recvpriv.signal_strength);
 
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
-		sinfo->txrate.legacy = rtw_get_cur_max_rate(padapter);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+		sinfo->links[0]->txrate.legacy = rtw_get_cur_max_rate(padapter);
 
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
-		sinfo->rx_packets = sta_rx_data_pkts(psta);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
+		sinfo->links[0]->rx_packets = sta_rx_data_pkts(psta);
 
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
-		sinfo->tx_packets = psta->sta_stats.tx_pkts;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
+		sinfo->links[0]->tx_packets = psta->sta_stats.tx_pkts;
+		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 	}
 
 	/* for Ad-Hoc/AP mode */
@@ -2432,8 +2438,13 @@ static int	cfg80211_rtw_dump_station(struct wiphy *wiphy,
 		goto exit;
 	}
 	memcpy(mac, psta->hwaddr, ETH_ALEN);
-	sinfo->filled = BIT_ULL(NL80211_STA_INFO_SIGNAL);
-	sinfo->signal = psta->rssi;
+
+	sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
+	if (!sinfo->links[0])
+		return -ENOMEM;
+
+	sinfo->links[0]->filled = BIT_ULL(NL80211_STA_INFO_SIGNAL);
+	sinfo->links[0]->signal = psta->rssi;
 
 exit:
 	return ret;
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index efbd79c67be2..4275f0240631 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2048,17 +2048,18 @@ struct cfg80211_tid_stats {
 #define IEEE80211_MAX_CHAINS	4
 
 /**
- * struct station_info - station information
+ * struct link_station_info - link station information
  *
- * Station information filled by driver for get_station() and dump_station.
+ * Link station information filled by driver for get_station() and dump_station.
  *
+ * @link_id: Link ID uniquely identifying the link STA. This is -1 for non-ML
  * @filled: bitflag of flags using the bits of &enum nl80211_sta_info to
  *	indicate the relevant values in this struct for them
- * @connected_time: time(in secs) since a station is last connected
- * @inactive_time: time since last station activity (tx/rx) in milliseconds
- * @assoc_at: bootime (ns) of the last association
- * @rx_bytes: bytes (size of MPDUs) received from this station
- * @tx_bytes: bytes (size of MPDUs) transmitted to this station
+ * @connected_time: time(in secs) since a link station is last connected
+ * @inactive_time: time since last link station activity (tx/rx) in milliseconds
+ * @assoc_at: bootime (ns) of the last link station association
+ * @rx_bytes: bytes (size of MPDUs) received from this link station
+ * @tx_bytes: bytes (size of MPDUs) transmitted to this link station
  * @signal: The signal strength, type depends on the wiphy's signal_type.
  *	For CFG80211_SIGNAL_TYPE_MBM, value is expressed in _dBm_.
  * @signal_avg: Average signal strength, type depends on the wiphy's signal_type.
@@ -2066,19 +2067,95 @@ struct cfg80211_tid_stats {
  * @chains: bitmask for filled values in @chain_signal, @chain_signal_avg
  * @chain_signal: per-chain signal strength of last received packet in dBm
  * @chain_signal_avg: per-chain signal strength average in dBm
- * @txrate: current unicast bitrate from this station
- * @rxrate: current unicast bitrate to this station
- * @rx_packets: packets (MSDUs & MMPDUs) received from this station
- * @tx_packets: packets (MSDUs & MMPDUs) transmitted to this station
+ * @txrate: current unicast bitrate from this link station
+ * @rxrate: current unicast bitrate to this link station
+ * @rx_packets: packets (MSDUs & MMPDUs) received from this link station
+ * @tx_packets: packets (MSDUs & MMPDUs) transmitted to thislink station
  * @tx_retries: cumulative retry counts (MPDUs)
  * @tx_failed: number of failed transmissions (MPDUs) (retries exceeded, no ACK)
  * @rx_dropped_misc:  Dropped for un-specified reason.
  * @bss_param: current BSS parameters
+ * @beacon_loss_count: Number of times beacon loss event has triggered.
+ * @expected_throughput: expected throughput in kbps (including 802.11 headers)
+ *	towards this link station.
+ * @rx_beacon: number of beacons received from this peer
+ * @rx_beacon_signal_avg: signal strength average (in dBm) for beacons received
+ *	from this peer
+ * @rx_duration: aggregate PPDU duration(usecs) for all the frames from a peer
+ * @tx_duration: aggregate PPDU duration(usecs) for all the frames to a peer
+ * @airtime_weight: current airtime scheduling weight
+ * @pertid: per-TID statistics, see &struct cfg80211_tid_stats, using the last
+ *	(IEEE80211_NUM_TIDS) index for MSDUs not encapsulated in QoS-MPDUs.
+ *	Note that this doesn't use the @filled bit, but is used if non-NULL.
+ * @ack_signal: signal strength (in dBm) of the last ACK frame.
+ * @avg_ack_signal: average rssi value of ack packet for the no of msdu's has
+ *	been sent.
+ * @rx_mpdu_count: number of MPDUs received from this link station
+ * @fcs_err_count: number of packets (MPDUs) received from this link station with
+ *	an FCS error. This counter should be incremented only when TA of the
+ *	received packet with an FCS error matches the peer MAC address.
+ * @addr: For MLO STA connection, filled with address of the link station.
+ *	For non-MLO STA connection, filled with all zeros.
+ */
+struct link_station_info {
+	int link_id;
+	u64 filled;
+	u32 connected_time;
+	u32 inactive_time;
+	u64 assoc_at;
+	u64 rx_bytes;
+	u64 tx_bytes;
+	s8 signal;
+	s8 signal_avg;
+
+	u8 chains;
+	s8 chain_signal[IEEE80211_MAX_CHAINS];
+	s8 chain_signal_avg[IEEE80211_MAX_CHAINS];
+
+	struct rate_info txrate;
+	struct rate_info rxrate;
+	u32 rx_packets;
+	u32 tx_packets;
+	u32 tx_retries;
+	u32 tx_failed;
+	u32 rx_dropped_misc;
+	struct sta_bss_parameters bss_param;
+
+	u32 beacon_loss_count;
+
+	u32 expected_throughput;
+
+	u64 tx_duration;
+	u64 rx_duration;
+	u64 rx_beacon;
+	u8 rx_beacon_signal_avg;
+
+	u16 airtime_weight;
+
+	s8 ack_signal;
+	s8 avg_ack_signal;
+	struct cfg80211_tid_stats *pertid;
+
+	u32 rx_mpdu_count;
+	u32 fcs_err_count;
+
+	u8 addr[ETH_ALEN] __aligned(2);
+};
+
+/**
+ * struct station_info - station information
+ *
+ * Station information filled by driver for get_station() and dump_station.
+ *
+ * @filled: bitflag of flags using the bits of &enum nl80211_sta_info to
+ *	indicate the relevant values in this struct for them
+ * @connected_time: time(in secs) since a station is last connected
+ * @assoc_at: bootime (ns) of the last association
+ * @sta_flags: station flags mask & values
  * @generation: generation number for nl80211 dumps.
  *	This number should increase every time the list of stations
  *	changes, i.e. when a station is added or removed, so that
  *	userspace can tell whether it got a consistent snapshot.
- * @beacon_loss_count: Number of times beacon loss event has triggered.
  * @assoc_req_ies: IEs from (Re)Association Request.
  *	This is used only when in AP mode with drivers that do not use
  *	user space MLME/SME implementation. The information is provided for
@@ -2095,24 +2172,6 @@ struct cfg80211_tid_stats {
  * @local_pm: local mesh STA power save mode
  * @peer_pm: peer mesh STA power save mode
  * @nonpeer_pm: non-peer mesh STA power save mode
- * @expected_throughput: expected throughput in kbps (including 802.11 headers)
- *	towards this station.
- * @rx_beacon: number of beacons received from this peer
- * @rx_beacon_signal_avg: signal strength average (in dBm) for beacons received
- *	from this peer
- * @rx_duration: aggregate PPDU duration(usecs) for all the frames from a peer
- * @tx_duration: aggregate PPDU duration(usecs) for all the frames to a peer
- * @airtime_weight: current airtime scheduling weight
- * @pertid: per-TID statistics, see &struct cfg80211_tid_stats, using the last
- *	(IEEE80211_NUM_TIDS) index for MSDUs not encapsulated in QoS-MPDUs.
- *	Note that this doesn't use the @filled bit, but is used if non-NULL.
- * @ack_signal: signal strength (in dBm) of the last ACK frame.
- * @avg_ack_signal: average rssi value of ack packet for the no of msdu's has
- *	been sent.
- * @rx_mpdu_count: number of MPDUs received from this station
- * @fcs_err_count: number of packets (MPDUs) received from this station with
- *	an FCS error. This counter should be incremented only when TA of the
- *	received packet with an FCS error matches the peer MAC address.
  * @mlo_params_valid: Indicates @assoc_link_id and @mld_addr fields are filled
  *	by driver. Drivers use this only in cfg80211_new_sta() calls when AP
  *	MLD's MLME/SME is offload to driver. Drivers won't fill this
@@ -2131,35 +2190,19 @@ struct cfg80211_tid_stats {
  *	dump_station() callbacks. User space needs this information to determine
  *	the accepted and rejected affiliated links of the connected station.
  * @assoc_resp_ies_len: Length of @assoc_resp_ies buffer in octets.
+ * @links: reference to Link sta entries for MLO STA. For non-MLO STA
+ *	and case where the driver offload link decisions and do not provide
+ *	per-link statistics, all link specific information is accessed
+ *	through links[0].
  */
 struct station_info {
 	u64 filled;
-	u32 connected_time;
-	u32 inactive_time;
 	u64 assoc_at;
-	u64 rx_bytes;
-	u64 tx_bytes;
-	s8 signal;
-	s8 signal_avg;
-
-	u8 chains;
-	s8 chain_signal[IEEE80211_MAX_CHAINS];
-	s8 chain_signal_avg[IEEE80211_MAX_CHAINS];
-
-	struct rate_info txrate;
-	struct rate_info rxrate;
-	u32 rx_packets;
-	u32 tx_packets;
-	u32 tx_retries;
-	u32 tx_failed;
-	u32 rx_dropped_misc;
-	struct sta_bss_parameters bss_param;
+	u32 connected_time;
 	struct nl80211_sta_flag_update sta_flags;
 
 	int generation;
 
-	u32 beacon_loss_count;
-
 	const u8 *assoc_req_ies;
 	size_t assoc_req_ies_len;
 
@@ -2174,27 +2217,13 @@ struct station_info {
 	enum nl80211_mesh_power_mode peer_pm;
 	enum nl80211_mesh_power_mode nonpeer_pm;
 
-	u32 expected_throughput;
-
-	u16 airtime_weight;
-
-	s8 ack_signal;
-	s8 avg_ack_signal;
-	struct cfg80211_tid_stats *pertid;
-
-	u64 tx_duration;
-	u64 rx_duration;
-	u64 rx_beacon;
-	u8 rx_beacon_signal_avg;
-
-	u32 rx_mpdu_count;
-	u32 fcs_err_count;
-
 	bool mlo_params_valid;
 	u8 assoc_link_id;
 	u8 mld_addr[ETH_ALEN] __aligned(2);
 	const u8 *assoc_resp_ies;
 	size_t assoc_resp_ies_len;
+
+	struct link_station_info *links[IEEE80211_MLD_MAX_NUM_LINKS];
 };
 
 /**
@@ -8493,7 +8522,7 @@ void cfg80211_tx_mgmt_expired(struct wireless_dev *wdev, u64 cookie,
  *
  * Return: 0 on success. Non-zero on error.
  */
-int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp);
+int cfg80211_sinfo_alloc_tid_stats(struct link_station_info *sinfo, gfp_t gfp);
 
 /**
  * cfg80211_sinfo_release_content - release contents of station info
@@ -8505,7 +8534,10 @@ int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp);
  */
 static inline void cfg80211_sinfo_release_content(struct station_info *sinfo)
 {
-	kfree(sinfo->pertid);
+	if (sinfo->links[0]) {
+		kfree(sinfo->links[0]->pertid);
+		kfree(sinfo->links[0]);
+	}
 }
 
 /**
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index cbb154ce8551..2888dbdcf25c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4119,11 +4119,11 @@ struct ieee80211_prep_tx_info {
  *	is only used if the configured rate control algorithm actually uses
  *	the new rate table API, and is therefore optional. Must be atomic.
  *
- * @sta_statistics: Get statistics for this station. For example with beacon
- *	filtering, the statistics kept by mac80211 might not be accurate, so
- *	let the driver pre-fill the statistics. The driver can fill most of
- *	the values (indicating which by setting the filled bitmap), but not
- *	all of them make sense - see the source for which ones are possible.
+ * @link_sta_statistics: Get statistics for this link station. For example
+ *	with beacon filtering, the statistics kept by mac80211 might not be
+ *	accurate, so let the driver pre-fill the statistics. The driver can
+ *	fill most of the values (indicating which by setting the filled bitmap),
+ *	but not all of them make sense - see the source for which ones are possible.
  *	Statistics that the driver doesn't fill will be filled by mac80211.
  *	The callback can sleep.
  *
@@ -4606,10 +4606,10 @@ struct ieee80211_ops {
 	void (*sta_rate_tbl_update)(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_sta *sta);
-	void (*sta_statistics)(struct ieee80211_hw *hw,
-			       struct ieee80211_vif *vif,
-			       struct ieee80211_sta *sta,
-			       struct station_info *sinfo);
+	void (*link_sta_statistics)(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta,
+				    struct link_station_info *link_sinfo);
 	int (*conf_tx)(struct ieee80211_hw *hw,
 		       struct ieee80211_vif *vif,
 		       unsigned int link_id, u16 ac,
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 70d6778da0d7..ddf6abed4269 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -132,19 +132,20 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 			*pthroughput = 0;
 			return true;
 		}
-		if (ret)
+		if (ret || !sinfo.links[0])
 			goto default_throughput;
 
-		if (sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT)) {
-			*pthroughput = sinfo.expected_throughput / 100;
+		if (sinfo.links[0]->filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT)) {
+			*pthroughput = sinfo.links[0]->expected_throughput / 100;
 			return true;
 		}
 
 		/* try to estimate the expected throughput based on reported tx
 		 * rates
 		 */
-		if (sinfo.filled & BIT(NL80211_STA_INFO_TX_BITRATE)) {
-			*pthroughput = cfg80211_calculate_bitrate(&sinfo.txrate) / 3;
+		if (sinfo.links[0]->filled & BIT(NL80211_STA_INFO_TX_BITRATE)) {
+			*pthroughput =
+				cfg80211_calculate_bitrate(&sinfo.links[0]->txrate) / 3;
 			return true;
 		}
 
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 307587c8a003..a3c6cc56ca41 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -613,10 +613,10 @@ static inline void drv_sta_rate_tbl_update(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
-static inline void drv_sta_statistics(struct ieee80211_local *local,
-				      struct ieee80211_sub_if_data *sdata,
-				      struct ieee80211_sta *sta,
-				      struct station_info *sinfo)
+static inline void drv_link_sta_statistics(struct ieee80211_local *local,
+					   struct ieee80211_sub_if_data *sdata,
+					   struct ieee80211_sta *sta,
+					   struct link_station_info *link_sinfo)
 {
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -625,9 +625,9 @@ static inline void drv_sta_statistics(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return;
 
-	trace_drv_sta_statistics(local, sdata, sta);
-	if (local->ops->sta_statistics)
-		local->ops->sta_statistics(&local->hw, &sdata->vif, sta, sinfo);
+	trace_drv_link_sta_statistics(local, sdata, sta);
+	if (local->ops->link_sta_statistics)
+		local->ops->link_sta_statistics(&local->hw, &sdata->vif, sta, link_sinfo);
 	trace_drv_return_void(local);
 }
 
diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index 0397755a3bd1..7d73c00d824d 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -79,6 +79,7 @@ static void ieee80211_get_stats(struct net_device *dev,
 	struct sta_info *sta;
 	struct ieee80211_local *local = sdata->local;
 	struct station_info sinfo;
+	struct link_station_info *link_sinfo;
 	struct survey_info survey;
 	int i, q;
 #define STA_STATS_SURVEY_LEN 7
@@ -87,17 +88,16 @@ static void ieee80211_get_stats(struct net_device *dev,
 
 #define ADD_STA_STATS(sta)					\
 	do {							\
-		data[i++] += sinfo.rx_packets;			\
-		data[i++] += sinfo.rx_bytes;			\
+		data[i++] += link_sinfo->rx_packets;		\
+		data[i++] += link_sinfo->rx_bytes;		\
 		data[i++] += (sta)->rx_stats.num_duplicates;	\
 		data[i++] += (sta)->rx_stats.fragments;		\
-		data[i++] += sinfo.rx_dropped_misc;		\
-								\
-		data[i++] += sinfo.tx_packets;			\
-		data[i++] += sinfo.tx_bytes;			\
+		data[i++] += link_sinfo->rx_dropped_misc;	\
+		data[i++] += link_sinfo->tx_packets;		\
+		data[i++] += link_sinfo->tx_bytes;		\
 		data[i++] += (sta)->status_stats.filtered;	\
-		data[i++] += sinfo.tx_failed;			\
-		data[i++] += sinfo.tx_retries;			\
+		data[i++] += link_sinfo->tx_failed;		\
+		data[i++] += link_sinfo->tx_retries;		\
 	} while (0)
 
 	/* For Managed stations, find the single station based on BSSID
@@ -117,23 +117,23 @@ static void ieee80211_get_stats(struct net_device *dev,
 		memset(&sinfo, 0, sizeof(sinfo));
 		sta_set_sinfo(sta, &sinfo, false);
 
+		link_sinfo = sinfo.links[0];
 		i = 0;
 		ADD_STA_STATS(&sta->deflink);
 
 		data[i++] = sta->sta_state;
 
-
-		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE))
+		if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE))
 			data[i] = 100000ULL *
-				cfg80211_calculate_bitrate(&sinfo.txrate);
+				cfg80211_calculate_bitrate(&link_sinfo->txrate);
 		i++;
-		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE))
+		if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE))
 			data[i] = 100000ULL *
-				cfg80211_calculate_bitrate(&sinfo.rxrate);
+				cfg80211_calculate_bitrate(&link_sinfo->rxrate);
 		i++;
 
-		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG))
-			data[i] = (u8)sinfo.signal_avg;
+		if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG))
+			data[i] = (u8)link_sinfo->signal_avg;
 		i++;
 	} else {
 		list_for_each_entry(sta, &local->sta_list, list) {
@@ -143,6 +143,7 @@ static void ieee80211_get_stats(struct net_device *dev,
 
 			memset(&sinfo, 0, sizeof(sinfo));
 			sta_set_sinfo(sta, &sinfo, false);
+			link_sinfo = sinfo.links[0];
 			i = 0;
 			ADD_STA_STATS(&sta->deflink);
 		}
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 141fc2086062..0c3a38cde089 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2648,7 +2648,7 @@ static void sta_set_mesh_sinfo(struct sta_info *sta,
 }
 #endif
 
-static void sta_set_link_sinfo(struct sta_info *sta, struct station_info *sinfo,
+static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *sinfo,
 			       struct ieee80211_link_data *link_sdata, bool tidstats)
 {
 	struct link_sta_info *link_sta_info = &sta->deflink;
@@ -2667,7 +2667,7 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	if (sdata->vif.type == NL80211_IFTYPE_STATION)
 		sinfo->rx_beacon = link_sdata->u.mgd.count_beacon_signal;
 
-	drv_sta_statistics(local, sdata, &sta->sta, sinfo);
+	drv_link_sta_statistics(local, sdata, &sta->sta, sinfo);
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME) |
 			 BIT_ULL(NL80211_STA_INFO_BSS_PARAM) |
 			 BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC);
@@ -2863,6 +2863,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		   bool tidstats)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	struct link_station_info *link_sinfo = sinfo->links[0];
 	struct ieee80211_link_data *link_sdata = &sdata->deflink;
 
 	sinfo->generation = sdata->local->sta_generation;
@@ -2902,7 +2903,11 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER))
 		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_TDLS_PEER);
 
-	sta_set_link_sinfo(sta, sinfo, link_sdata, tidstats);
+	link_sinfo = kzalloc(sizeof(*link_sinfo), GFP_KERNEL);
+	if (!link_sinfo)
+		return;
+
+	sta_set_link_sinfo(sta, link_sinfo, link_sdata, tidstats);
 }
 
 u32 sta_get_expected_throughput(struct sta_info *sta)
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 72fad8ea8bb9..e936d519ee9f 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -995,7 +995,7 @@ DECLARE_EVENT_CLASS(sta_event,
 	)
 );
 
-DEFINE_EVENT(sta_event, drv_sta_statistics,
+DEFINE_EVENT(sta_event, drv_link_sta_statistics,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
 		 struct ieee80211_sta *sta),
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 415eca6a9f8f..9202f6ba2aaf 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6721,7 +6721,7 @@ static bool nl80211_put_signal(struct sk_buff *msg, u8 mask, s8 *signal,
 
 static int nl80211_fill_link_station(struct sk_buff *msg,
 				     struct cfg80211_registered_device *rdev,
-				     struct station_info *sinfo)
+				     struct link_station_info *sinfo)
 {
 	struct nlattr *bss_param;
 
@@ -6879,6 +6879,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 {
 	void *hdr;
 	struct nlattr *sinfoattr;
+	struct link_station_info *link_sinfo = sinfo->links[0];
 
 	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr) {
@@ -6915,7 +6916,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		    &sinfo->sta_flags))
 		goto nla_put_failure;
 
-	if (nl80211_fill_link_station(msg, rdev, sinfo))
+	if (link_sinfo && nl80211_fill_link_station(msg, rdev, link_sinfo))
 		goto nla_put_failure;
 
 	nla_nest_end(msg, sinfoattr);
@@ -13083,9 +13084,9 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 			return err;
 
 		cfg80211_sinfo_release_content(&sinfo);
-		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG))
+		if (sinfo.links[0]->filled & BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG))
 			cqm_config->last_rssi_event_value =
-				(s8) sinfo.rx_beacon_signal_avg;
+				(s8)sinfo.links[0]->rx_beacon_signal_avg;
 	}
 
 	last = cqm_config->last_rssi_event_value;
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 4ed9fada4ec0..145e725ef74c 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -200,22 +200,23 @@
 		    __field(u16, llid)		    \
 		    __field(u16, plid)		    \
 		    __field(u8, plink_state)
-#define SINFO_ASSIGN						       \
-	do {							       \
-		__entry->generation = sinfo->generation;	       \
-		__entry->connected_time = sinfo->connected_time;       \
-		__entry->inactive_time = sinfo->inactive_time;	       \
-		__entry->rx_bytes = sinfo->rx_bytes;		       \
-		__entry->tx_bytes = sinfo->tx_bytes;		       \
-		__entry->rx_packets = sinfo->rx_packets;	       \
-		__entry->tx_packets = sinfo->tx_packets;	       \
-		__entry->tx_retries = sinfo->tx_retries;	       \
-		__entry->tx_failed = sinfo->tx_failed;		       \
-		__entry->rx_dropped_misc = sinfo->rx_dropped_misc;     \
-		__entry->beacon_loss_count = sinfo->beacon_loss_count; \
-		__entry->llid = sinfo->llid;			       \
-		__entry->plid = sinfo->plid;			       \
-		__entry->plink_state = sinfo->plink_state;	       \
+#define SINFO_ASSIGN							\
+	struct link_station_info *link_sinfo = sinfo->links[0];		\
+	do {								\
+		__entry->generation = sinfo->generation;		\
+		__entry->connected_time = link_sinfo->connected_time;	\
+		__entry->inactive_time = link_sinfo->inactive_time;	\
+		__entry->rx_bytes = link_sinfo->rx_bytes;		\
+		__entry->tx_bytes = link_sinfo->tx_bytes;		\
+		__entry->rx_packets = link_sinfo->rx_packets;		\
+		__entry->tx_packets = link_sinfo->tx_packets;		\
+		__entry->tx_retries = link_sinfo->tx_retries;		\
+		__entry->tx_failed = link_sinfo->tx_failed;		\
+		__entry->rx_dropped_misc = link_sinfo->rx_dropped_misc;	\
+		__entry->beacon_loss_count = link_sinfo->beacon_loss_count; \
+		__entry->llid = sinfo->llid;				\
+		__entry->plid = sinfo->plid;				\
+		__entry->plink_state = sinfo->plink_state;		\
 	} while (0)
 
 #define BOOL_TO_STR(bo) (bo) ? "true" : "false"
diff --git a/net/wireless/util.c b/net/wireless/util.c
index ed868c0f7ca8..44926579d641 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2626,11 +2626,11 @@ bool cfg80211_does_bw_fit_range(const struct ieee80211_freq_range *freq_range,
 	return false;
 }
 
-int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp)
+int cfg80211_sinfo_alloc_tid_stats(struct link_station_info *sinfo, gfp_t gfp)
 {
 	sinfo->pertid = kcalloc(IEEE80211_NUM_TIDS + 1,
-				sizeof(*(sinfo->pertid)),
-				gfp);
+				     sizeof(*(sinfo->pertid)),
+				     gfp);
 	if (!sinfo->pertid)
 		return -ENOMEM;
 
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index a74b1afc594e..1da85440e6be 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -1267,12 +1267,12 @@ static int cfg80211_wext_giwrate(struct net_device *dev,
 	if (err)
 		return err;
 
-	if (!(sinfo.filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE))) {
+	if (!(sinfo.links[0]->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE))) {
 		err = -EOPNOTSUPP;
 		goto free;
 	}
 
-	rate->value = 100000 * cfg80211_calculate_bitrate(&sinfo.txrate);
+	rate->value = 100000 * cfg80211_calculate_bitrate(&sinfo.links[0]->txrate);
 
 free:
 	cfg80211_sinfo_release_content(&sinfo);
@@ -1316,8 +1316,8 @@ static struct iw_statistics *cfg80211_wireless_stats(struct net_device *dev)
 
 	switch (rdev->wiphy.signal_type) {
 	case CFG80211_SIGNAL_TYPE_MBM:
-		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_SIGNAL)) {
-			int sig = sinfo.signal;
+		if (sinfo.links[0]->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL)) {
+			int sig = sinfo.links[0]->signal;
 			wstats.qual.updated |= IW_QUAL_LEVEL_UPDATED;
 			wstats.qual.updated |= IW_QUAL_QUAL_UPDATED;
 			wstats.qual.updated |= IW_QUAL_DBM;
@@ -1331,11 +1331,11 @@ static struct iw_statistics *cfg80211_wireless_stats(struct net_device *dev)
 		}
 		fallthrough;
 	case CFG80211_SIGNAL_TYPE_UNSPEC:
-		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_SIGNAL)) {
+		if (sinfo.links[0]->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL)) {
 			wstats.qual.updated |= IW_QUAL_LEVEL_UPDATED;
 			wstats.qual.updated |= IW_QUAL_QUAL_UPDATED;
-			wstats.qual.level = sinfo.signal;
-			wstats.qual.qual = sinfo.signal;
+			wstats.qual.level = sinfo.links[0]->signal;
+			wstats.qual.qual = sinfo.links[0]->signal;
 			break;
 		}
 		fallthrough;
@@ -1345,10 +1345,10 @@ static struct iw_statistics *cfg80211_wireless_stats(struct net_device *dev)
 	}
 
 	wstats.qual.updated |= IW_QUAL_NOISE_INVALID;
-	if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC))
-		wstats.discard.misc = sinfo.rx_dropped_misc;
-	if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_TX_FAILED))
-		wstats.discard.retries = sinfo.tx_failed;
+	if (sinfo.links[0]->filled & BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC))
+		wstats.discard.misc = sinfo.links[0]->rx_dropped_misc;
+	if (sinfo.links[0]->filled & BIT_ULL(NL80211_STA_INFO_TX_FAILED))
+		wstats.discard.retries = sinfo.links[0]->tx_failed;
 
 	cfg80211_sinfo_release_content(&sinfo);
 
-- 
2.34.1


