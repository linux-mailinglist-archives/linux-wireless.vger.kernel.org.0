Return-Path: <linux-wireless+bounces-1471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068A7823B0F
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 04:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82902288265
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 03:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631555227;
	Thu,  4 Jan 2024 03:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AK6XPRcl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA5523B
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jan 2024 03:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4043Jear021987;
	Thu, 4 Jan 2024 03:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=/IvIJuk
	+18lkpjx48w2439+D+LLfhVfgosB1dJOuDYc=; b=AK6XPRclJW00E1HlFSq51yL
	148oePAqZuJgju2sRwWntb6CzctjmpjQ71W+hmBughCtIgPT/T1kiRML+ew0/ziu
	VoEmZVsZzsBbp2tcP3psoV5+WkGx6GnY3fIX2Xp/8BteZTxAy7ZAoLAMRnbcz3dd
	zFxceQl7AQnOdqVUTpfVkUYD4vSgz+Cj0xyli4Wgwu6nYTc5Uwe0Nh2wMBpA98fj
	RhpvpmJ2Ni3LUkg8QUy7ZSKOSuD93e1hlxNr4JU8gs9nW+nSY/gz2gm0wPoYWUSi
	jMlENr8P5dczhBxqMlh9ePQwMfBgTXphL5+US1C5zKhAWmqPp7mu5x0V9uUaAaQ=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd8dpskua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 03:22:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4043MEhH009415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jan 2024 03:22:14 GMT
Received: from lingbok-Latitude-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 3 Jan 2024 19:22:13 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: ath12k: add display tx and rx bitrate for 11be
Date: Wed, 3 Jan 2024 22:22:02 -0500
Message-ID: <20240104032202.19472-1-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: 1hcptYkmuTR4BLK87rvp2dOVNc1UGpYQ
X-Proofpoint-ORIG-GUID: 1hcptYkmuTR4BLK87rvp2dOVNc1UGpYQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 mlxlogscore=830 adultscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401040020

When AP is in 11be state, STA's tx/rx bitrate display error value using iw
dev wlan command.

In ath12k_dp_tx_update_txcompl() function, not handle the case when
pkt_type is equal to HAL_TX_RATE_STATS_PKT_TYPE_11BE, so add a else if
statement to handle this situation.

In ath12k_dp_rx_h_rate function, not handle the case when pkt_type is equal
to RX_MSDU_START_PKT_TYPE_11BE, so add a case statement to handle this
situation.

After that, "iw dev xxx station dump" show the correct tx bitrate such as:
tx bitrate: 1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
rx bitrate: 1441.1 MBit/s 80MHz EHT-MCS 9 EHT-NSS 3 EHT-GI 0

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
depends on patch:
Lingbo Kong(1)
public review:[PATCH v3] wifi: ath12k: report tx bitrate for iw dev
xxx station dump

 drivers/net/wireless/ath/ath12k/core.h    |  3 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c   | 20 +++++-
 drivers/net/wireless/ath/ath12k/dp_tx.c   | 15 +++-
 drivers/net/wireless/ath/ath12k/mac.c     | 84 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h     |  4 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h |  4 +-
 6 files changed, 123 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index d3f912704c8b..4fdca047a3c1 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_CORE_H
@@ -71,6 +71,7 @@ enum wme_ac {
 #define ATH12K_HT_MCS_MAX	7
 #define ATH12K_VHT_MCS_MAX	9
 #define ATH12K_HE_MCS_MAX	11
+#define ATH12K_EHT_MCS_MAX	13
 
 enum ath12k_crypt_mode {
 	/* Only use hardware crypto engine */
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 60e10a4893cc..16da9209d3f4 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/ieee80211.h>
@@ -2331,6 +2331,21 @@ static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct hal_rx_desc *rx_desc,
 		rx_status->he_gi = ath12k_mac_he_gi_to_nl80211_he_gi(sgi);
 		rx_status->bw = ath12k_mac_bw_to_mac80211_bw(bw);
 		break;
+	case RX_MSDU_START_PKT_TYPE_11BE:
+		rx_status->rate_idx = rate_mcs;
+		if (rate_mcs > ATH12K_EHT_MCS_MAX) {
+			ath12k_warn(ar->ab,
+				    "Received with invalid mcs in EHT mode %d\n",
+				    rate_mcs);
+			break;
+		}
+		rx_status->encoding = RX_ENC_EHT;
+		rx_status->nss = nss;
+		rx_status->eht.gi = ath12k_mac_eht_gi_to_nl80211_eht_gi(sgi);
+		rx_status->bw = ath12k_mac_bw_to_mac80211_bw(bw);
+		break;
+	default:
+		break;
 	}
 }
 
@@ -2417,7 +2432,7 @@ static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *nap
 	spin_unlock_bh(&ab->base_lock);
 
 	ath12k_dbg(ab, ATH12K_DBG_DATA,
-		   "rx skb %pK len %u peer %pM %d %s sn %u %s%s%s%s%s%s%s%s%s rate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
+		   "rx skb %pK len %u peer %pM %d %s sn %u %s%s%s%s%s%s%s%s%s%s rate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
 		   msdu,
 		   msdu->len,
 		   peer ? peer->addr : NULL,
@@ -2428,6 +2443,7 @@ static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *nap
 		   (status->encoding == RX_ENC_HT) ? "ht" : "",
 		   (status->encoding == RX_ENC_VHT) ? "vht" : "",
 		   (status->encoding == RX_ENC_HE) ? "he" : "",
+		   (status->encoding == RX_ENC_EHT) ? "eht" : "",
 		   (status->bw == RATE_INFO_BW_40) ? "40" : "",
 		   (status->bw == RATE_INFO_BW_80) ? "80" : "",
 		   (status->bw == RATE_INFO_BW_160) ? "160" : "",
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 2cef90377696..de1e7032eb0d 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
@@ -510,6 +510,13 @@ static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status
 		arsta->txrate.mcs = ts->mcs;
 		arsta->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
 		arsta->txrate.he_gi = ath12k_mac_he_gi_to_nl80211_he_gi(ts->sgi);
+	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11BE) {
+		if (ts->mcs > ATH12K_EHT_MCS_MAX)
+			goto err_out;
+
+		arsta->txrate.mcs = ts->mcs;
+		arsta->txrate.flags = RATE_INFO_FLAGS_EHT_MCS;
+		arsta->txrate.eht_gi = ath12k_mac_eht_gi_to_nl80211_eht_gi(ts->sgi);
 	}
 
 	arsta->txrate.bw = ath12k_mac_bw_to_mac80211_bw(ts->bw);
@@ -519,6 +526,12 @@ static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status
 			ath12k_mac_he_ru_tones_to_nl80211_he_ru_alloc(ts->ru_tones);
 	}
 
+	if (ts->ofdma && ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11BE) {
+		arsta->txrate.bw = RATE_INFO_BW_EHT_RU;
+		arsta->txrate.eht_ru_alloc =
+			ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(ts->ru_tones);
+	}
+
 err_out:
 	spin_unlock_bh(&ab->base_lock);
 }
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 40aa00002885..87d79a0cfb3a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <net/mac80211.h>
@@ -7697,6 +7697,88 @@ void ath12k_mac_destroy(struct ath12k_base *ab)
 	}
 }
 
+enum nl80211_eht_gi ath12k_mac_eht_gi_to_nl80211_eht_gi(u8 sgi)
+{
+	enum nl80211_eht_gi ret;
+
+	switch (sgi) {
+	case RX_MSDU_START_SGI_0_8_US:
+		ret = NL80211_RATE_INFO_EHT_GI_0_8;
+		break;
+	case RX_MSDU_START_SGI_1_6_US:
+		ret = NL80211_RATE_INFO_EHT_GI_1_6;
+		break;
+	case RX_MSDU_START_SGI_3_2_US:
+		ret = NL80211_RATE_INFO_EHT_GI_3_2;
+		break;
+	default:
+		ret = NL80211_RATE_INFO_EHT_GI_0_8;
+		break;
+	}
+
+	return ret;
+}
+
+enum nl80211_eht_ru_alloc ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(u16 ru_tones)
+{
+	enum nl80211_eht_ru_alloc ret;
+
+	switch (ru_tones) {
+	case 26:
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_26;
+		break;
+	case 52:
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_52;
+		break;
+	case (52 + 26):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_52P26;
+		break;
+	case 106:
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_106;
+		break;
+	case (106 + 26):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_106P26;
+		break;
+	case 242:
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_242;
+		break;
+	case 484:
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_484;
+		break;
+	case (484 + 242):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_484P242;
+		break;
+	case 996:
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_996;
+		break;
+	case (996 + 484):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_996P484;
+		break;
+	case (996 + 484 + 242):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_996P484P242;
+		break;
+	case (2 * 996):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_2x996;
+		break;
+	case (2 * 996 + 484):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_2x996P484;
+		break;
+	case (3 * 996):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_3x996;
+		break;
+	case (3 * 996 + 484):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_3x996P484;
+		break;
+	case (4 * 996):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_4x996;
+		break;
+	default:
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_26;
+	}
+
+	return ret;
+}
+
 enum nl80211_he_ru_alloc ath12k_mac_phy_he_ru_to_nl80211_he_ru_alloc(u16 ru_phy)
 {
 	enum nl80211_he_ru_alloc ret;
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 274aa219b53c..e0da3b3886e8 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_MAC_H
@@ -79,4 +79,6 @@ int ath12k_mac_rfkill_config(struct ath12k *ar);
 enum nl80211_he_gi ath12k_mac_he_gi_to_nl80211_he_gi(u8 sgi);
 enum nl80211_he_ru_alloc ath12k_mac_phy_he_ru_to_nl80211_he_ru_alloc(u16 ru_phy);
 enum nl80211_he_ru_alloc ath12k_mac_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones);
+enum nl80211_eht_ru_alloc ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(u16 ru_tones);
+enum nl80211_eht_gi ath12k_mac_eht_gi_to_nl80211_eht_gi(u8 sgi);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/rx_desc.h b/drivers/net/wireless/ath/ath12k/rx_desc.h
index 55f20c446ca9..cad358d153d6 100644
--- a/drivers/net/wireless/ath/ath12k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath12k/rx_desc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #ifndef ATH12K_RX_DESC_H
 #define ATH12K_RX_DESC_H
@@ -582,6 +582,8 @@ enum rx_msdu_start_pkt_type {
 	RX_MSDU_START_PKT_TYPE_11N,
 	RX_MSDU_START_PKT_TYPE_11AC,
 	RX_MSDU_START_PKT_TYPE_11AX,
+	RX_MSDU_START_PKT_TYPE_11BA,
+	RX_MSDU_START_PKT_TYPE_11BE,
 };
 
 enum rx_msdu_start_sgi {

base-commit: 2cd4e3f91f264926a6b11df948417b74d52ca9b9
prerequisite-patch-id: 912672aa0506b1efccd896bc5efbe2349a1e15a3
-- 
2.34.1


