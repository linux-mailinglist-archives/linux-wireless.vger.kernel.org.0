Return-Path: <linux-wireless+bounces-2133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F05E8310B5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 02:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04827B251B4
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 01:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A008D46A8;
	Thu, 18 Jan 2024 01:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pcTgcUHT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D373FF1
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 01:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705539832; cv=none; b=iXGPF0XSwJwLKAYDcuZEiBp9WGDavHWeussHLGP8PHEXRFYlyMShCTGyGd91CFdK6rM7xesxw5AC/hs9bMPQLA39L5eyLVWxJtCfafUQe/pLSl4yTGNAI9Ud2cP7/7sYJUkvfKlvOyrKMkokF8IBEoPrjABoyGcxGMBBDC09O8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705539832; c=relaxed/simple;
	bh=60KRuYge4JlhzUjV0AA+FtalFraLE+A9HT4a0jSs7Ig=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=TxFxaR0rfgQuOLGZ6J1wAWHfyRiwDq6PBLTrd2kVQBBpSRR5VDZSdIsrnmOdBn5IBU5XySrIzDg5+Q7Es8adIfWK4nn+ed99zQCtXxrU0+fpBLlnf7XWo8Xi93n6FuAzAcXyISuZaRqxWwwJP0plRVj+OSjUkzNG1Yaeey7ctyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pcTgcUHT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HLkbC0014431;
	Thu, 18 Jan 2024 01:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=SStaT4SYf3613mgmmHV9/nESEu04QiPcYoDccWHGXQA=; b=pc
	TgcUHTC5hlNLZ1w4Dkr5VdqyDCo9eKOl0g/sDNn5/Yz7Ys0+Ok8EzmnvGpqLt/Xc
	1Yviz/O97CSnv0gOqqBQqWgKPMtoetloOHMs/nqcIEl5Jfn/sdrlOxR7AZn0Ofug
	LkJoB4xrRSEejN4o8l6+KfmtdqEdHw5JpfOg5cVAK46vS2SrmZdIYywsQ/wyOFei
	qM8rlE6DGmK5rsUZc3EVBbM1L5oGq213iqDkeyQkcUElWkdrjK1bZUvj3e0tY7mU
	6S2cjiCHSKWq/hExkqui1gNvn1EOLXJyKMO3zglCwFIE5b2DorLhZfrn5TAtd6n4
	om/nyAd+u8YSodHXjyLA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpm1frqkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 01:03:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40I13c1L003378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 01:03:38 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 17:03:37 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v4 1/2] wifi: ath12k: Refactor the mac80211 hw access from link/radio
Date: Thu, 18 Jan 2024 06:33:19 +0530
Message-ID: <20240118010320.3918136-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118010320.3918136-1-quic_periyasa@quicinc.com>
References: <20240118010320.3918136-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: jyY8HoQ8VvVjgEhiTlqYjWvX-tL4xmTc
X-Proofpoint-GUID: jyY8HoQ8VvVjgEhiTlqYjWvX-tL4xmTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_14,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401180004

Currently, mac80211 hardware accesses link/radio structure directly in
multiple locations. Introduce helper function to avoid this direct
access, as this change will facilitate refactoring for Multi-link
operation support.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c   | 10 +++--
 drivers/net/wireless/ath/ath12k/core.h   |  6 ++-
 drivers/net/wireless/ath/ath12k/dp_mon.c |  4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  |  6 +--
 drivers/net/wireless/ath/ath12k/dp_tx.c  |  6 +--
 drivers/net/wireless/ath/ath12k/mac.c    | 51 ++++++++++++++----------
 drivers/net/wireless/ath/ath12k/reg.c    |  6 +--
 drivers/net/wireless/ath/ath12k/wmi.c    | 17 ++++----
 8 files changed, 61 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 6cab747ff858..d21618ca70b9 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -879,6 +879,7 @@ static void ath12k_rfkill_work(struct work_struct *work)
 {
 	struct ath12k_base *ab = container_of(work, struct ath12k_base, rfkill_work);
 	struct ath12k *ar;
+	struct ieee80211_hw *hw;
 	bool rfkill_radio_on;
 	int i;
 
@@ -891,8 +892,9 @@ static void ath12k_rfkill_work(struct work_struct *work)
 		if (!ar)
 			continue;
 
+		hw = ath12k_ar_to_hw(ar);
 		ath12k_mac_rfkill_enable_radio(ar, rfkill_radio_on);
-		wiphy_rfkill_set_hw_state(ar->hw->wiphy, !rfkill_radio_on);
+		wiphy_rfkill_set_hw_state(hw->wiphy, !rfkill_radio_on);
 	}
 }
 
@@ -936,7 +938,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 		if (!ar || ar->state == ATH12K_STATE_OFF)
 			continue;
 
-		ieee80211_stop_queues(ar->hw);
+		ieee80211_stop_queues(ath12k_ar_to_hw(ar));
 		ath12k_mac_drain_tx(ar);
 		complete(&ar->scan.started);
 		complete(&ar->scan.completed);
@@ -976,7 +978,7 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 		case ATH12K_STATE_ON:
 			ar->state = ATH12K_STATE_RESTARTING;
 			ath12k_core_halt(ar);
-			ieee80211_restart_hw(ar->hw);
+			ieee80211_restart_hw(ath12k_ar_to_hw(ar));
 			break;
 		case ATH12K_STATE_OFF:
 			ath12k_warn(ab,
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ba0a30f1ea29..10a292b28d4d 100644
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
@@ -896,4 +896,8 @@ static inline const char *ath12k_bus_str(enum ath12k_bus bus)
 	return "unknown";
 }
 
+static inline struct ieee80211_hw *ath12k_ar_to_hw(struct ath12k *ar)
+{
+	return ar->hw;
+}
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index be4b39f5fa80..2432ab605c85 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "dp_mon.h"
@@ -1130,7 +1130,7 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 	    !(is_mcbc && rx_status->flag & RX_FLAG_DECRYPTED))
 		rx_status->flag |= RX_FLAG_8023;
 
-	ieee80211_rx_napi(ar->hw, pubsta, msdu, napi);
+	ieee80211_rx_napi(ath12k_ar_to_hw(ar), pubsta, msdu, napi);
 }
 
 static int ath12k_dp_mon_rx_deliver(struct ath12k *ar, u32 mac_id,
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 1ee83f765929..f0ab337e1dd4 100644
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
@@ -2458,7 +2458,7 @@ static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *nap
 	    !(is_mcbc && rx_status->flag & RX_FLAG_DECRYPTED))
 		rx_status->flag |= RX_FLAG_8023;
 
-	ieee80211_rx_napi(ar->hw, pubsta, msdu, napi);
+	ieee80211_rx_napi(ath12k_ar_to_hw(ar), pubsta, msdu, napi);
 }
 
 static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
@@ -2844,7 +2844,7 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer
 	ath12k_dp_rx_h_ppdu(ar, rx_desc, rxs);
 	ath12k_dp_rx_h_undecap(ar, msdu, rx_desc,
 			       HAL_ENCRYPT_TYPE_TKIP_MIC, rxs, true);
-	ieee80211_rx(ar->hw, msdu);
+	ieee80211_rx(ath12k_ar_to_hw(ar), msdu);
 	return -EINVAL;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 62f9cdbb811c..2257d7a3c950 100644
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
@@ -401,7 +401,7 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 		}
 	}
 
-	ieee80211_tx_status_skb(ar->hw, msdu);
+	ieee80211_tx_status_skb(ath12k_ar_to_hw(ar), msdu);
 }
 
 static void
@@ -498,7 +498,7 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	 * Might end up reporting it out-of-band from HTT stats.
 	 */
 
-	ieee80211_tx_status_skb(ar->hw, msdu);
+	ieee80211_tx_status_skb(ath12k_ar_to_hw(ar), msdu);
 
 exit:
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a90c0309230a..2fc6f23a42d2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -542,7 +542,7 @@ struct ath12k_vif *ath12k_mac_get_arvif(struct ath12k *ar, u32 vdev_id)
 	arvif_iter.vdev_id = vdev_id;
 
 	flags = IEEE80211_IFACE_ITER_RESUME_ALL;
-	ieee80211_iterate_active_interfaces_atomic(ar->hw,
+	ieee80211_iterate_active_interfaces_atomic(ath12k_ar_to_hw(ar),
 						   flags,
 						   ath12k_get_arvif_iter,
 						   &arvif_iter);
@@ -1040,7 +1040,7 @@ static int ath12k_mac_monitor_start(struct ath12k *ar)
 	if (ar->monitor_started)
 		return 0;
 
-	ieee80211_iter_chan_contexts_atomic(ar->hw,
+	ieee80211_iter_chan_contexts_atomic(ath12k_ar_to_hw(ar),
 					    ath12k_mac_get_any_chandef_iter,
 					    &chandef);
 	if (!chandef)
@@ -1085,7 +1085,7 @@ static int ath12k_mac_monitor_stop(struct ath12k *ar)
 
 static int ath12k_mac_config(struct ath12k *ar, u32 changed)
 {
-	struct ieee80211_hw *hw = ar->hw;
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	struct ieee80211_conf *conf = &hw->conf;
 	int ret = 0;
 
@@ -1139,7 +1139,7 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
 {
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_base *ab = ar->ab;
-	struct ieee80211_hw *hw = ar->hw;
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	struct ieee80211_vif *vif = arvif->vif;
 	struct ieee80211_mutable_offsets offs = {};
 	struct sk_buff *bcn;
@@ -1227,6 +1227,7 @@ static void ath12k_peer_assoc_h_basic(struct ath12k *ar,
 				      struct ath12k_wmi_peer_assoc_arg *arg)
 {
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	u32 aid;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -1241,7 +1242,7 @@ static void ath12k_peer_assoc_h_basic(struct ath12k *ar,
 	arg->peer_associd = aid;
 	arg->auth_flag = true;
 	/* TODO: STA WAR in ath10k for listen interval required? */
-	arg->peer_listen_intval = ar->hw->conf.listen_interval;
+	arg->peer_listen_intval = hw->conf.listen_interval;
 	arg->peer_nss = 1;
 	arg->peer_caps = vif->bss_conf.assoc_capability;
 }
@@ -1255,6 +1256,7 @@ static void ath12k_peer_assoc_h_crypto(struct ath12k *ar,
 	struct cfg80211_chan_def def;
 	struct cfg80211_bss *bss;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	const u8 *rsnie = NULL;
 	const u8 *wpaie = NULL;
 
@@ -1263,7 +1265,7 @@ static void ath12k_peer_assoc_h_crypto(struct ath12k *ar,
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
 
-	bss = cfg80211_get_bss(ar->hw->wiphy, def.chan, info->bssid, NULL, 0,
+	bss = cfg80211_get_bss(hw->wiphy, def.chan, info->bssid, NULL, 0,
 			       IEEE80211_BSS_TYPE_ANY, IEEE80211_PRIVACY_ANY);
 
 	if (arvif->rsnie_present || arvif->wpaie_present) {
@@ -1283,7 +1285,7 @@ static void ath12k_peer_assoc_h_crypto(struct ath12k *ar,
 						ies->data,
 						ies->len);
 		rcu_read_unlock();
-		cfg80211_put_bss(ar->hw->wiphy, bss);
+		cfg80211_put_bss(hw->wiphy, bss);
 	}
 
 	/* FIXME: base on RSN IE/WPA IE is a correct idea? */
@@ -1317,6 +1319,7 @@ static void ath12k_peer_assoc_h_rates(struct ath12k *ar,
 	struct cfg80211_chan_def def;
 	const struct ieee80211_supported_band *sband;
 	const struct ieee80211_rate *rates;
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	enum nl80211_band band;
 	u32 ratemask;
 	u8 rate;
@@ -1328,7 +1331,7 @@ static void ath12k_peer_assoc_h_rates(struct ath12k *ar,
 		return;
 
 	band = def.chan->band;
-	sband = ar->hw->wiphy->bands[band];
+	sband = hw->wiphy->bands[band];
 	ratemask = sta->deflink.supp_rates[band];
 	ratemask &= arvif->bitrate_mask.control[band].legacy;
 	rates = sband->bitrates;
@@ -2423,6 +2426,7 @@ static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
 					 struct cfg80211_chan_def *def)
 {
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	const struct ieee80211_supported_band *sband;
 	u8 basic_rate_idx;
 	int hw_rate_code;
@@ -2432,7 +2436,7 @@ static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
 
 	lockdep_assert_held(&ar->conf_mutex);
 
-	sband = ar->hw->wiphy->bands[def->chan->band];
+	sband = hw->wiphy->bands[def->chan->band];
 	basic_rate_idx = ffs(vif->bss_conf.basic_rates) - 1;
 	bitrate = sband->bitrates[basic_rate_idx].bitrate;
 
@@ -2459,6 +2463,7 @@ static int ath12k_mac_fils_discovery(struct ath12k_vif *arvif,
 				     struct ieee80211_bss_conf *info)
 {
 	struct ath12k *ar = arvif->ar;
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	struct sk_buff *tmpl;
 	int ret;
 	u32 interval;
@@ -2467,7 +2472,7 @@ static int ath12k_mac_fils_discovery(struct ath12k_vif *arvif,
 	if (info->fils_discovery.max_interval) {
 		interval = info->fils_discovery.max_interval;
 
-		tmpl = ieee80211_get_fils_discovery_tmpl(ar->hw, arvif->vif);
+		tmpl = ieee80211_get_fils_discovery_tmpl(hw, arvif->vif);
 		if (tmpl)
 			ret = ath12k_wmi_fils_discovery_tmpl(ar, arvif->vdev_id,
 							     tmpl);
@@ -2475,7 +2480,7 @@ static int ath12k_mac_fils_discovery(struct ath12k_vif *arvif,
 		unsol_bcast_probe_resp_enabled = 1;
 		interval = info->unsol_bcast_probe_resp_interval;
 
-		tmpl = ieee80211_get_unsol_bcast_probe_resp_tmpl(ar->hw,
+		tmpl = ieee80211_get_unsol_bcast_probe_resp_tmpl(hw,
 								 arvif->vif);
 		if (tmpl)
 			ret = ath12k_wmi_probe_resp_tmpl(ar, arvif->vdev_id,
@@ -2798,6 +2803,8 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 
 void __ath12k_mac_scan_finish(struct ath12k *ar)
 {
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
+
 	lockdep_assert_held(&ar->data_lock);
 
 	switch (ar->scan.state) {
@@ -2806,7 +2813,7 @@ void __ath12k_mac_scan_finish(struct ath12k *ar)
 	case ATH12K_SCAN_RUNNING:
 	case ATH12K_SCAN_ABORTING:
 		if (ar->scan.is_roc && ar->scan.roc_notify)
-			ieee80211_remain_on_channel_expired(ar->hw);
+			ieee80211_remain_on_channel_expired(hw);
 		fallthrough;
 	case ATH12K_SCAN_STARTING:
 		if (!ar->scan.is_roc) {
@@ -2817,7 +2824,7 @@ void __ath12k_mac_scan_finish(struct ath12k *ar)
 					    ATH12K_SCAN_STARTING)),
 			};
 
-			ieee80211_scan_completed(ar->hw, &info);
+			ieee80211_scan_completed(hw, &info);
 		}
 
 		ar->scan.state = ATH12K_SCAN_IDLE;
@@ -3036,7 +3043,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	}
 
 	/* Add a margin to account for event/command processing */
-	ieee80211_queue_delayed_work(ar->hw, &ar->scan.timeout,
+	ieee80211_queue_delayed_work(ath12k_ar_to_hw(ar), &ar->scan.timeout,
 				     msecs_to_jiffies(arg.max_scan_time +
 						      ATH12K_MAC_SCAN_TIMEOUT_MSECS));
 
@@ -4819,7 +4826,7 @@ static void ath12k_mgmt_over_wmi_tx_drop(struct ath12k *ar, struct sk_buff *skb)
 {
 	int num_mgmt;
 
-	ieee80211_free_txskb(ar->hw, skb);
+	ieee80211_free_txskb(ath12k_ar_to_hw(ar), skb);
 
 	num_mgmt = atomic_dec_if_positive(&ar->num_pending_mgmt_tx);
 
@@ -4996,7 +5003,7 @@ static int ath12k_mac_mgmt_tx(struct ath12k *ar, struct sk_buff *skb,
 
 	skb_queue_tail(q, skb);
 	atomic_inc(&ar->num_pending_mgmt_tx);
-	ieee80211_queue_work(ar->hw, &ar->wmi_mgmt_tx_work);
+	ieee80211_queue_work(ath12k_ar_to_hw(ar), &ar->wmi_mgmt_tx_work);
 
 	return 0;
 }
@@ -6357,7 +6364,7 @@ ath12k_mac_update_active_vif_chan(struct ath12k *ar,
 				  struct ieee80211_chanctx_conf *ctx)
 {
 	struct ath12k_mac_change_chanctx_arg arg = { .ctx = ctx };
-	struct ieee80211_hw *hw = ar->hw;
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -6874,7 +6881,7 @@ static void ath12k_mac_set_bitrate_mask_iter(void *data,
 	arsta->changed |= IEEE80211_RC_SUPP_RATES_CHANGED;
 	spin_unlock_bh(&ar->data_lock);
 
-	ieee80211_queue_work(ar->hw, &arsta->update_wk);
+	ieee80211_queue_work(ath12k_ar_to_hw(ar), &arsta->update_wk);
 }
 
 static void ath12k_mac_disable_peer_fixed_rate(void *data,
@@ -7350,7 +7357,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 static int ath12k_mac_setup_iface_combinations(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct ieee80211_hw *hw = ar->hw;
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	struct wiphy *wiphy = hw->wiphy;
 	struct ieee80211_iface_combination *combinations;
 	struct ieee80211_iface_limit *limits;
@@ -7457,7 +7464,7 @@ static void ath12k_mac_cleanup_unregister(struct ath12k *ar)
 
 static void ath12k_mac_hw_unregister(struct ath12k *ar)
 {
-	struct ieee80211_hw *hw = ar->hw;
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	struct wiphy *wiphy = hw->wiphy;
 
 	cancel_work_sync(&ar->regd_update_work);
@@ -7503,7 +7510,7 @@ static int ath12k_mac_setup_register(struct ath12k *ar,
 static int ath12k_mac_hw_register(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct ieee80211_hw *hw = ar->hw;
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	struct wiphy *wiphy = hw->wiphy;
 	struct ath12k_pdev *pdev = ar->pdev;
 	struct ath12k_pdev_cap *cap = &pdev->cap;
@@ -7777,7 +7784,7 @@ static void ath12k_mac_hw_destroy(struct ath12k_base *ab)
 		if (!ar)
 			continue;
 
-		ieee80211_free_hw(ar->hw);
+		ieee80211_free_hw(ath12k_ar_to_hw(ar));
 		pdev->ar = NULL;
 	}
 }
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index f924bc13ccff..88e71d171355 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/rtnetlink.h>
 #include "core.h"
@@ -95,7 +95,7 @@ int ath12k_reg_update_chan_list(struct ath12k *ar)
 	struct ieee80211_supported_band **bands;
 	struct ath12k_wmi_scan_chan_list_arg *arg;
 	struct ieee80211_channel *channel;
-	struct ieee80211_hw *hw = ar->hw;
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	struct ath12k_wmi_channel_arg *ch;
 	enum nl80211_band band;
 	int num_channels = 0;
@@ -199,7 +199,7 @@ static void ath12k_copy_regd(struct ieee80211_regdomain *regd_orig,
 
 int ath12k_regd_update(struct ath12k *ar, bool init)
 {
-	struct ieee80211_hw *hw = ar->hw;
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	struct ieee80211_regdomain *regd, *regd_copy = NULL;
 	int ret, regd_len, pdev_id;
 	struct ath12k_base *ab;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 553d2566b3f7..4d41c335ef34 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/skbuff.h>
 #include <linux/ctype.h>
@@ -4948,7 +4948,7 @@ static int wmi_process_mgmt_tx_comp(struct ath12k *ar, u32 desc_id,
 	if ((!(info->flags & IEEE80211_TX_CTL_NO_ACK)) && !status)
 		info->flags |= IEEE80211_TX_STAT_ACK;
 
-	ieee80211_tx_status_irqsafe(ar->hw, msdu);
+	ieee80211_tx_status_irqsafe(ath12k_ar_to_hw(ar), msdu);
 
 	num_mgmt = atomic_dec_if_positive(&ar->num_pending_mgmt_tx);
 
@@ -5076,6 +5076,8 @@ static void ath12k_wmi_event_scan_bss_chan(struct ath12k *ar)
 
 static void ath12k_wmi_event_scan_foreign_chan(struct ath12k *ar, u32 freq)
 {
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
+
 	lockdep_assert_held(&ar->data_lock);
 
 	switch (ar->scan.state) {
@@ -5087,7 +5089,7 @@ static void ath12k_wmi_event_scan_foreign_chan(struct ath12k *ar, u32 freq)
 		break;
 	case ATH12K_SCAN_RUNNING:
 	case ATH12K_SCAN_ABORTING:
-		ar->scan_channel = ieee80211_get_channel(ar->hw->wiphy, freq);
+		ar->scan_channel = ieee80211_get_channel(hw->wiphy, freq);
 		break;
 	}
 }
@@ -5226,13 +5228,14 @@ static int ath12k_pull_roam_ev(struct ath12k_base *ab, struct sk_buff *skb,
 static int freq_to_idx(struct ath12k *ar, int freq)
 {
 	struct ieee80211_supported_band *sband;
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	int band, ch, idx = 0;
 
 	for (band = NL80211_BAND_2GHZ; band < NUM_NL80211_BANDS; band++) {
 		if (!ar->mac.sbands[band].channels)
 			continue;
 
-		sband = ar->hw->wiphy->bands[band];
+		sband = hw->wiphy->bands[band];
 		if (!sband)
 			continue;
 
@@ -5863,7 +5866,7 @@ static void ath12k_mgmt_rx_event(struct ath12k_base *ab, struct sk_buff *skb)
 		   status->freq, status->band, status->signal,
 		   status->rate_idx);
 
-	ieee80211_rx_ni(ar->hw, skb);
+	ieee80211_rx_ni(ath12k_ar_to_hw(ar), skb);
 
 exit:
 	rcu_read_unlock();
@@ -6036,7 +6039,7 @@ static void ath12k_peer_sta_kickout_event(struct ath12k_base *ab, struct sk_buff
 		goto exit;
 	}
 
-	sta = ieee80211_find_sta_by_ifaddr(ar->hw,
+	sta = ieee80211_find_sta_by_ifaddr(ath12k_ar_to_hw(ar),
 					   arg.mac_addr, NULL);
 	if (!sta) {
 		ath12k_warn(ab, "Spurious quick kickout for STA %pM\n",
@@ -6530,7 +6533,7 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
 	if (ar->dfs_block_radar_events)
 		ath12k_info(ab, "DFS Radar detected, but ignored as requested\n");
 	else
-		ieee80211_radar_detected(ar->hw);
+		ieee80211_radar_detected(ath12k_ar_to_hw(ar));
 
 exit:
 	rcu_read_unlock();
-- 
2.34.1


