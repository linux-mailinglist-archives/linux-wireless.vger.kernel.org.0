Return-Path: <linux-wireless+bounces-2116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53A9830ACF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 17:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3BD1C24DF8
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 16:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB44E224C1;
	Wed, 17 Jan 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SbVMggTQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427DF22325
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508121; cv=none; b=D6hMlun5i759xcizYvwpowBu3xwbrDKziLWb+fzO/RAtWHlO71BYOh1bTJGF0Bp1vJ60FfeWCDqhbHmRBTSsAuVXnMp+LWLhlCQnbWfraRasNmbsQfHaz0UY6sv7ZHQX13EWsKRBppXxnfuEhIpr+snWZA/z4FOIX3imkEqZpQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508121; c=relaxed/simple;
	bh=+vXuEkX5Wr4KP5UxPyHBRK90FWV2GZD4lGjgWex/2m0=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=QXKASEaGbCaopDeQWpu5K9neccekQC4kxnK9ES6Esc2MilGXoW/gMI6tt/x7K/+T7dzerJ/lyI1HBW6ujVwxELimZMmmXw9Fev31nuLwb/p8NMUmrTaaBw0NLl+LOKDTPgWkUyPJFXEfOuPq4dUmGeS1LBwGk+us/CR0huUUCGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SbVMggTQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HFUEHV023157;
	Wed, 17 Jan 2024 16:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=F3XEZ34rnqaSS0wqbD6VCQnCCw/Dga4V+FHhOsSeRt8=; b=Sb
	VMggTQqJDJVVFK0HsAj0bEtvkO1zKD/JDJ8i5HS6Nbvg1jXqs+25ymTAvEa6E9/l
	luYgTw1lVqTiL/7NBoiFKjuapWD1VfqrL9TcvkBTSnMxzw4gTeJi4g6noFK9+QLl
	+8n0knKDF8Id742boCcjpB52T16GP3cuwaPT0SypdUu0jpMo4TdSZQy3ldjs4QzW
	DLreBQbsSl8wdx8sz4K68VypArpLfhW4TT0XVnVyBuLW9KpmNruCQ3rqwCPl400h
	WXMRPJdOUaLHKfgBVos8DysVRJos3szRobSEMOslWKGBN/FFudbe/Cd1uKM/RWLT
	TgEk9ICdCPSCYfyMKBdw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp8gwhb6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 16:15:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HGFBim004464
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 16:15:12 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 08:15:09 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v3 2/2] wifi: ath12k: Introduce the container for mac80211 hw
Date: Wed, 17 Jan 2024 21:44:51 +0530
Message-ID: <20240117161451.3385227-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117161451.3385227-1-quic_periyasa@quicinc.com>
References: <20240117161451.3385227-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: 0vEyKbFoX8zmmbJjHRS-rfqwwA139I0a
X-Proofpoint-ORIG-GUID: 0vEyKbFoX8zmmbJjHRS-rfqwwA139I0a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_10,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401170118

To support multi link operation, we need to combine all the link/pdev
under a single wiphy. This avoids the overhead of synchronization
across multiple hardware instances in both the cfg80211 and mac80211
layers. Currently, each link/pdev is registered as separate wiphy,
tightly coupled with link/pdev/radio (ar) structure. To enable single
wiphy registration within the chip, we decouple the wiphy data entity from
the link/pdev/radio (ar) structure and move it under the chip (ab)
structure with a new data container (ath12k_hw) structure. This approach
improves scalability for future multi link operation support.

		mac80211 hw private data structure diagram
		------------------------------------------

	Now						After

 +---------------------+                          +---------------------+
 |mac80211 hw priv data|                          |mac80211 hw priv data|
 |                     |                          |                     |
 |                     |                          |                     |
 |                     |                          |                     |
 |                     |                          |   ath12k_hw (ah)    |
 |                     |                          |                     |
 |                     |  +------------------->   |                     |
 |    ath12k (ar)      |                          |   +-------------+   |
 |                     |                          |   |             |   |
 |                     |                          |   | ath12k (ar) |   |
 |                     |                          |   |             |   |
 |                     |                          |   |             |   |
 |                     |                          |   +-------------+   |
 |                     |                          |                     |
 |                     |                          |                     |
 +---------------------+                          +---------------------+

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  10 +-
 drivers/net/wireless/ath/ath12k/core.h |  38 ++-
 drivers/net/wireless/ath/ath12k/mac.c  | 417 +++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/mac.h  |   4 +-
 drivers/net/wireless/ath/ath12k/reg.c  |   3 +-
 5 files changed, 336 insertions(+), 136 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index d21618ca70b9..1baad3302157 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -923,6 +923,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 {
 	struct ath12k *ar;
 	struct ath12k_pdev *pdev;
+	struct ath12k_hw *ah;
 	int i;
 
 	spin_lock_bh(&ab->base_lock);
@@ -932,13 +933,20 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 	if (ab->is_reset)
 		set_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
+	for (i = 0; i < ab->num_hw; i++) {
+		if (!ab->ah[i])
+			continue;
+
+		ah = ab->ah[i];
+		ieee80211_stop_queues(ah->hw);
+	}
+
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
 		if (!ar || ar->state == ATH12K_STATE_OFF)
 			continue;
 
-		ieee80211_stop_queues(ath12k_ar_to_hw(ar));
 		ath12k_mac_drain_tx(ar);
 		complete(&ar->scan.started);
 		complete(&ar->scan.completed);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 10a292b28d4d..9f84f1d8b0de 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -473,7 +473,7 @@ struct ath12k_per_peer_tx_stats {
 struct ath12k {
 	struct ath12k_base *ab;
 	struct ath12k_pdev *pdev;
-	struct ieee80211_hw *hw;
+	struct ath12k_hw *ah;
 	struct ath12k_wmi_pdev *wmi;
 	struct ath12k_pdev_dp dp;
 	u8 mac_addr[ETH_ALEN];
@@ -537,6 +537,7 @@ struct ath12k {
 	/* pdev_idx starts from 0 whereas pdev->pdev_id starts with 1 */
 	u8 pdev_idx;
 	u8 lmac_id;
+	u8 hw_link_id;
 
 	struct completion peer_assoc_done;
 	struct completion peer_delete_done;
@@ -596,6 +597,13 @@ struct ath12k {
 	int monitor_vdev_id;
 };
 
+struct ath12k_hw {
+	struct ieee80211_hw *hw;
+
+	u8 num_radio;
+	struct ath12k radio[] __aligned(sizeof(void *));
+};
+
 struct ath12k_band_cap {
 	u32 phy_id;
 	u32 max_bw_supported;
@@ -729,6 +737,17 @@ struct ath12k_base {
 	u8 fw_pdev_count;
 
 	struct ath12k_pdev __rcu *pdevs_active[MAX_RADIOS];
+
+	/* Holds information of wiphy (hw) registration.
+	 *
+	 * In Multi/Single Link Operation case, all pdevs are registered as a
+	 * single wiphy.
+	 * In other (legacy/Non-MLO) cases, each pdev is registered as separate
+	 * wiphys.
+	 */
+	struct ath12k_hw *ah[MAX_RADIOS];
+	u8 num_hw;
+
 	struct ath12k_wmi_hal_reg_capabilities_ext_arg hal_reg_cap[MAX_RADIOS];
 	unsigned long long free_vdev_map;
 	unsigned long long free_vdev_stats_id_map;
@@ -810,6 +829,11 @@ struct ath12k_base {
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
 
+struct ath12k_pdev_map {
+	struct ath12k_base *ab;
+	u8 pdev_idx;
+};
+
 int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab);
 int ath12k_core_pre_init(struct ath12k_base *ab);
 int ath12k_core_init(struct ath12k_base *ath12k);
@@ -896,8 +920,18 @@ static inline const char *ath12k_bus_str(enum ath12k_bus bus)
 	return "unknown";
 }
 
+static inline struct ath12k_hw *ath12k_hw_to_ah(struct ieee80211_hw  *hw)
+{
+	return hw->priv;
+}
+
+static inline struct ath12k *ath12k_ah_to_ar(struct ath12k_hw *ah)
+{
+	return ah->radio;
+}
+
 static inline struct ieee80211_hw *ath12k_ar_to_hw(struct ath12k *ar)
 {
-	return ar->hw;
+	return ar->ah->hw;
 }
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2fc6f23a42d2..d702e7e7b4c9 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1124,9 +1124,12 @@ static int ath12k_mac_config(struct ath12k *ar, u32 changed)
 
 static int ath12k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	int ret;
 
+	ar = ath12k_ah_to_ar(ah);
+
 	ret = ath12k_mac_config(ar, changed);
 	if (ret)
 		ath12k_warn(ar->ab, "failed to update config pdev idx %d: %d\n",
@@ -2791,9 +2794,12 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 					   struct ieee80211_bss_conf *info,
 					   u64 changed)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 
+	ar = ath12k_ah_to_ar(ah);
+
 	mutex_lock(&ar->conf_mutex);
 
 	ath12k_mac_bss_info_changed(ar, arvif, info, changed);
@@ -2969,13 +2975,16 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_scan_request *hw_req)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct cfg80211_scan_request *req = &hw_req->req;
 	struct ath12k_wmi_scan_req_arg arg = {};
 	int ret;
 	int i;
 
+	ar = ath12k_ah_to_ar(ah);
+
 	mutex_lock(&ar->conf_mutex);
 
 	spin_lock_bh(&ar->data_lock);
@@ -3054,13 +3063,17 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		kfree(arg.extraie.ptr);
 
 	mutex_unlock(&ar->conf_mutex);
+
 	return ret;
 }
 
 static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+
+	ar = ath12k_ah_to_ar(ah);
 
 	mutex_lock(&ar->conf_mutex);
 	ath12k_scan_abort(ar);
@@ -3188,8 +3201,9 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 				 struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 				 struct ieee80211_key_conf *key)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	struct ath12k_base *ab;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_peer *peer;
 	struct ath12k_sta *arsta;
@@ -3204,6 +3218,9 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256)
 		return 1;
 
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
+
 	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags))
 		return 1;
 
@@ -3779,7 +3796,8 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 				   enum ieee80211_sta_state old_state,
 				   enum ieee80211_sta_state new_state)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k_peer *peer;
@@ -3790,6 +3808,8 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	     new_state == IEEE80211_STA_NOTEXIST))
 		cancel_work_sync(&arsta->update_wk);
 
+	ar = ath12k_ah_to_ar(ah);
+
 	mutex_lock(&ar->conf_mutex);
 
 	if (old_state == IEEE80211_STA_NOTEXIST &&
@@ -3885,6 +3905,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	}
 
 	mutex_unlock(&ar->conf_mutex);
+
 	return ret;
 }
 
@@ -3892,7 +3913,8 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_sta *sta)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 	s16 txpwr;
@@ -3908,6 +3930,8 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 	if (txpwr > ATH12K_TX_POWER_MAX_VAL || txpwr < ATH12K_TX_POWER_MIN_VAL)
 		return -EINVAL;
 
+	ar = ath12k_ah_to_ar(ah);
+
 	mutex_lock(&ar->conf_mutex);
 
 	ret = ath12k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
@@ -3928,12 +3952,15 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 					struct ieee80211_sta *sta,
 					u32 changed)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_peer *peer;
 	u32 bw, smps;
 
+	ar = ath12k_ah_to_ar(ah);
+
 	spin_lock_bh(&ar->ab->base_lock);
 
 	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
@@ -4108,10 +4135,13 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
 				 unsigned int link_id, u16 ac,
 				 const struct ieee80211_tx_queue_params *params)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 
+	ar = ath12k_ah_to_ar(ah);
+
 	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_conf_tx(arvif, link_id, ac, params);
 	mutex_unlock(&ar->conf_mutex);
@@ -5013,10 +5043,10 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 			     struct sk_buff *skb)
 {
 	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB(skb);
-	struct ath12k *ar = hw->priv;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k *ar = arvif->ar;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_key_conf *key = info->control.hw_key;
 	u32 info_flags = info->flags;
@@ -5210,7 +5240,8 @@ static int ath12k_mac_start(struct ath12k *ar)
 
 static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar = ath12k_ah_to_ar(ah);
 	struct ath12k_base *ab = ar->ab;
 	int ret;
 
@@ -5318,7 +5349,8 @@ static void ath12k_mac_stop(struct ath12k *ar)
 
 static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar = ath12k_ah_to_ar(ah);
 
 	ath12k_mac_drain_tx(ar);
 
@@ -5498,8 +5530,9 @@ static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
 static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	struct ath12k_base *ab;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_wmi_vdev_create_arg vdev_arg = {0};
 	struct ath12k_wmi_peer_create_arg peer_param;
@@ -5511,6 +5544,9 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 
 	vif->driver_flags |= IEEE80211_VIF_SUPPORTS_UAPSD;
 
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
+
 	mutex_lock(&ar->conf_mutex);
 
 	if (vif->type == NL80211_IFTYPE_AP &&
@@ -5757,12 +5793,16 @@ static void ath12k_mac_vif_unref(struct ath12k_dp *dp, struct ieee80211_vif *vif
 static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_base *ab;
 	unsigned long time_left;
 	int ret;
 
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
+
 	mutex_lock(&ar->conf_mutex);
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "mac remove interface (vdev %d)\n",
@@ -5872,7 +5912,10 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
 					   unsigned int *total_flags,
 					   u64 multicast)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+
+	ar = ath12k_ah_to_ar(ah);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -5884,7 +5927,10 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
 
 static int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+
+	ar = ath12k_ah_to_ar(ah);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -5898,9 +5944,12 @@ static int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *
 
 static int ath12k_mac_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	int ret;
 
+	ar = ath12k_ah_to_ar(ah);
+
 	mutex_lock(&ar->conf_mutex);
 	ret = __ath12k_set_antenna(ar, tx_ant, rx_ant);
 	mutex_unlock(&ar->conf_mutex);
@@ -5942,10 +5991,13 @@ static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_ampdu_params *params)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret = -EINVAL;
 
+	ar = ath12k_ah_to_ar(ah);
+
 	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_ampdu_action(arvif, params);
 	mutex_unlock(&ar->conf_mutex);
@@ -5960,8 +6012,12 @@ static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
 static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
 				     struct ieee80211_chanctx_conf *ctx)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	struct ath12k_base *ab;
+
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
 		   "mac chanctx add freq %u width %d ptr %pK\n",
@@ -5984,8 +6040,12 @@ static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
 static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 					 struct ieee80211_chanctx_conf *ctx)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	struct ath12k_base *ab;
+
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
 		   "mac chanctx remove freq %u width %d ptr %pK\n",
@@ -6393,8 +6453,12 @@ static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 					 struct ieee80211_chanctx_conf *ctx,
 					 u32 changed)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	struct ath12k_base *ab;
+
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -6456,12 +6520,16 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 				 struct ieee80211_bss_conf *link_conf,
 				 struct ieee80211_chanctx_conf *ctx)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	struct ath12k_base *ab;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 	struct ath12k_wmi_peer_create_arg param;
 
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
+
 	mutex_lock(&ar->conf_mutex);
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
@@ -6535,11 +6603,15 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 				   struct ieee80211_bss_conf *link_conf,
 				   struct ieee80211_chanctx_conf *ctx)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	struct ath12k_base *ab;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
+
 	mutex_lock(&ar->conf_mutex);
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
@@ -6587,7 +6659,10 @@ ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 				 int n_vifs,
 				 enum ieee80211_chanctx_switch_mode mode)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+
+	ar = ath12k_ah_to_ar(ah);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -6629,10 +6704,15 @@ ath12k_set_vdev_param_to_all_vifs(struct ath12k *ar, int param, u32 value)
  */
 static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 {
-	struct ath12k *ar = hw->priv;
-	int param_id = WMI_VDEV_PARAM_RTS_THRESHOLD;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	int param_id = WMI_VDEV_PARAM_RTS_THRESHOLD, ret;
 
-	return ath12k_set_vdev_param_to_all_vifs(ar, param_id, value);
+	ar = ath12k_ah_to_ar(ah);
+
+	ret = ath12k_set_vdev_param_to_all_vifs(ar, param_id, value);
+
+	return ret;
 }
 
 static int ath12k_mac_op_set_frag_threshold(struct ieee80211_hw *hw, u32 value)
@@ -6671,7 +6751,8 @@ static void ath12k_mac_flush(struct ath12k *ar)
 static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 				u32 queues, bool drop)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar = ath12k_ah_to_ar(ah);
 
 	if (drop)
 		return;
@@ -6929,8 +7010,10 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	ldpc = !!(ar->ht_cap_info & WMI_HT_CAP_LDPC);
 
 	sgi = mask->control[band].gi;
-	if (sgi == NL80211_TXRATE_FORCE_LGI)
-		return -EINVAL;
+	if (sgi == NL80211_TXRATE_FORCE_LGI) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* mac80211 doesn't support sending a fixed HT/VHT MCS alone, rather it
 	 * requires passing at least one of used basic rates along with them.
@@ -6946,7 +7029,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to get single legacy rate for vdev %i: %d\n",
 				    arvif->vdev_id, ret);
-			return ret;
+			goto out;
 		}
 		ieee80211_iterate_stations_atomic(hw,
 						  ath12k_mac_disable_peer_fixed_rate,
@@ -6991,7 +7074,8 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			 */
 			ath12k_warn(ar->ab,
 				    "Setting more than one MCS Value in bitrate mask not supported\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 
 		ieee80211_iterate_stations_atomic(hw,
@@ -7018,6 +7102,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 
 	mutex_unlock(&ar->conf_mutex);
 
+out:
 	return ret;
 }
 
@@ -7025,14 +7110,18 @@ static void
 ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 				enum ieee80211_reconfig_type reconfig_type)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	struct ath12k_base *ab;
 	struct ath12k_vif *arvif;
 	int recovery_count;
 
 	if (reconfig_type != IEEE80211_RECONFIG_TYPE_RESTART)
 		return;
 
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
+
 	mutex_lock(&ar->conf_mutex);
 
 	if (ar->state == ATH12K_STATE_RESTARTED) {
@@ -7116,7 +7205,8 @@ ath12k_mac_update_bss_chan_survey(struct ath12k *ar,
 static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 				    struct survey_info *survey)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ieee80211_supported_band *sband;
 	struct survey_info *ar_survey;
 	int ret = 0;
@@ -7124,6 +7214,8 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	if (idx >= ATH12K_NUM_CHANS)
 		return -ENOENT;
 
+	ar = ath12k_ah_to_ar(ah);
+
 	ar_survey = &ar->survey[idx];
 
 	mutex_lock(&ar->conf_mutex);
@@ -7155,6 +7247,7 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 
 exit:
 	mutex_unlock(&ar->conf_mutex);
+
 	return ret;
 }
 
@@ -7354,20 +7447,44 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 	return 0;
 }
 
-static int ath12k_mac_setup_iface_combinations(struct ath12k *ar)
+static u16 ath12k_mac_get_ifmodes(struct ath12k_hw *ah)
 {
-	struct ath12k_base *ab = ar->ab;
-	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
-	struct wiphy *wiphy = hw->wiphy;
+	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	u16 interface_modes = U16_MAX;
+
+	interface_modes &= ar->ab->hw_params->interface_modes;
+
+	return interface_modes == U16_MAX ? 0 : interface_modes;
+}
+
+static bool ath12k_mac_is_iface_mode_enable(struct ath12k_hw *ah,
+					    enum nl80211_iftype type)
+{
+	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	u16 interface_modes, mode;
+	bool is_enable = true;
+
+	mode = BIT(type);
+
+	interface_modes = ar->ab->hw_params->interface_modes;
+	if (!(interface_modes & mode))
+		is_enable = false;
+
+	return is_enable;
+}
+
+static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
+{
+	struct wiphy *wiphy = ah->hw->wiphy;
 	struct ieee80211_iface_combination *combinations;
 	struct ieee80211_iface_limit *limits;
 	int n_limits, max_interfaces;
 	bool ap, mesh;
 
-	ap = ab->hw_params->interface_modes & BIT(NL80211_IFTYPE_AP);
+	ap = ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_AP);
 
 	mesh = IS_ENABLED(CONFIG_MAC80211_MESH) &&
-		ab->hw_params->interface_modes & BIT(NL80211_IFTYPE_MESH_POINT);
+		ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_MESH_POINT);
 
 	combinations = kzalloc(sizeof(*combinations), GFP_KERNEL);
 	if (!combinations)
@@ -7462,10 +7579,11 @@ static void ath12k_mac_cleanup_unregister(struct ath12k *ar)
 	kfree(ar->mac.sbands[NL80211_BAND_6GHZ].channels);
 }
 
-static void ath12k_mac_hw_unregister(struct ath12k *ar)
+static void ath12k_mac_hw_unregister(struct ath12k_hw *ah)
 {
-	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
+	struct ieee80211_hw *hw = ah->hw;
 	struct wiphy *wiphy = hw->wiphy;
+	struct ath12k *ar = ath12k_ah_to_ar(ah);
 
 	cancel_work_sync(&ar->regd_update_work);
 
@@ -7507,13 +7625,14 @@ static int ath12k_mac_setup_register(struct ath12k *ar,
 	return 0;
 }
 
-static int ath12k_mac_hw_register(struct ath12k *ar)
+static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 {
-	struct ath12k_base *ab = ar->ab;
-	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
+	struct ieee80211_hw *hw = ah->hw;
 	struct wiphy *wiphy = hw->wiphy;
-	struct ath12k_pdev *pdev = ar->pdev;
-	struct ath12k_pdev_cap *cap = &pdev->cap;
+	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_pdev *pdev;
+	struct ath12k_pdev_cap *cap;
 	static const u32 cipher_suites[] = {
 		WLAN_CIPHER_SUITE_TKIP,
 		WLAN_CIPHER_SUITE_CCMP,
@@ -7528,30 +7647,34 @@ static int ath12k_mac_hw_register(struct ath12k *ar)
 	int ret;
 	u32 ht_cap = 0;
 
-	if (ab->pdevs_macaddr_valid) {
+	pdev = ar->pdev;
+
+	if (ab->pdevs_macaddr_valid)
 		ether_addr_copy(ar->mac_addr, pdev->mac_addr);
-	} else {
+	else
 		ether_addr_copy(ar->mac_addr, ab->mac_addr);
-		ar->mac_addr[4] += ar->pdev_idx;
-	}
 
 	ret = ath12k_mac_setup_register(ar, &ht_cap, hw->wiphy->bands);
 	if (ret)
 		goto out;
 
+	wiphy->max_ap_assoc_sta = ar->max_num_stations;
+
+	cap = &pdev->cap;
+
+	wiphy->available_antennas_rx = cap->rx_chain_mask;
+	wiphy->available_antennas_tx = cap->tx_chain_mask;
+
 	SET_IEEE80211_PERM_ADDR(hw, ar->mac_addr);
 	SET_IEEE80211_DEV(hw, ab->dev);
 
-	ret = ath12k_mac_setup_iface_combinations(ar);
+	ret = ath12k_mac_setup_iface_combinations(ah);
 	if (ret) {
-		ath12k_err(ar->ab, "failed to setup interface combinations: %d\n", ret);
-		goto err_setup_unregister;
+		ath12k_err(ab, "failed to setup interface combinations: %d\n", ret);
+		goto err_cleanup_unregister;
 	}
 
-	wiphy->available_antennas_rx = cap->rx_chain_mask;
-	wiphy->available_antennas_tx = cap->tx_chain_mask;
-
-	wiphy->interface_modes = ab->hw_params->interface_modes;
+	wiphy->interface_modes = ath12k_mac_get_ifmodes(ah);
 
 	if (wiphy->bands[NL80211_BAND_2GHZ] &&
 	    wiphy->bands[NL80211_BAND_5GHZ] &&
@@ -7604,8 +7727,6 @@ static int ath12k_mac_hw_register(struct ath12k *ar)
 	wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
 				   NL80211_FEATURE_AP_SCAN;
 
-	wiphy->max_ap_assoc_sta = ar->max_num_stations;
-
 	hw->queues = ATH12K_HW_MAX_QUEUES;
 	wiphy->tx_queue_len = ATH12K_QUEUE_LEN;
 	hw->offchannel_tx_hw_queue = ATH12K_HW_MAX_QUEUES - 1;
@@ -7642,7 +7763,7 @@ static int ath12k_mac_hw_register(struct ath12k *ar)
 
 	ret = ieee80211_register_hw(hw);
 	if (ret) {
-		ath12k_err(ar->ab, "ieee80211 registration failed: %d\n", ret);
+		ath12k_err(ab, "ieee80211 registration failed: %d\n", ret);
 		goto err_free_if_combs;
 	}
 
@@ -7670,14 +7791,12 @@ static int ath12k_mac_hw_register(struct ath12k *ar)
 	kfree(wiphy->iface_combinations[0].limits);
 	kfree(wiphy->iface_combinations);
 
-err_setup_unregister:
-	kfree(ar->mac.sbands[NL80211_BAND_2GHZ].channels);
-	kfree(ar->mac.sbands[NL80211_BAND_5GHZ].channels);
-	kfree(ar->mac.sbands[NL80211_BAND_6GHZ].channels);
+err_cleanup_unregister:
+	ath12k_mac_cleanup_unregister(ar);
 
+out:
 	SET_IEEE80211_DEV(hw, NULL);
 
-out:
 	return ret;
 }
 
@@ -7723,8 +7842,7 @@ static void ath12k_mac_setup(struct ath12k *ar)
 
 int ath12k_mac_register(struct ath12k_base *ab)
 {
-	struct ath12k *ar;
-	struct ath12k_pdev *pdev;
+	struct ath12k_hw *ah;
 	int i;
 	int ret;
 
@@ -7735,22 +7853,23 @@ int ath12k_mac_register(struct ath12k_base *ab)
 	ab->cc_freq_hz = 320000;
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
 
-	for (i = 0; i < ab->num_radios; i++) {
-		pdev = &ab->pdevs[i];
-		ar = pdev->ar;
+	for (i = 0; i < ab->num_hw; i++) {
+		ah = ab->ah[i];
 
-		ret = ath12k_mac_hw_register(ar);
+		ret = ath12k_mac_hw_register(ah);
 		if (ret)
-			goto err_cleanup;
+			goto err;
 	}
 
 	return 0;
 
-err_cleanup:
+err:
 	for (i = i - 1; i >= 0; i--) {
-		pdev = &ab->pdevs[i];
-		ar = pdev->ar;
-		ath12k_mac_hw_unregister(ar);
+		ah = ab->ah[i];
+		if (!ah)
+			continue;
+
+		ath12k_mac_hw_unregister(ah);
 	}
 
 	return ret;
@@ -7758,89 +7877,125 @@ int ath12k_mac_register(struct ath12k_base *ab)
 
 void ath12k_mac_unregister(struct ath12k_base *ab)
 {
-	struct ath12k *ar;
-	struct ath12k_pdev *pdev;
+	struct ath12k_hw *ah;
 	int i;
 
-	for (i = 0; i < ab->num_radios; i++) {
-		pdev = &ab->pdevs[i];
-		ar = pdev->ar;
-		if (!ar)
+	for (i = ab->num_hw - 1; i >= 0; i--) {
+		ah = ab->ah[i];
+		if (!ah)
 			continue;
 
-		ath12k_mac_hw_unregister(ar);
+		ath12k_mac_hw_unregister(ah);
 	}
 }
 
-static void ath12k_mac_hw_destroy(struct ath12k_base *ab)
+static void ath12k_mac_hw_destroy(struct ath12k_hw *ah)
 {
-	struct ath12k *ar;
-	struct ath12k_pdev *pdev;
-	int i;
-
-	for (i = 0; i < ab->num_radios; i++) {
-		pdev = &ab->pdevs[i];
-		ar = pdev->ar;
-		if (!ar)
-			continue;
-
-		ieee80211_free_hw(ath12k_ar_to_hw(ar));
-		pdev->ar = NULL;
-	}
+	ieee80211_free_hw(ah->hw);
 }
 
-static int ath12k_mac_hw_allocate(struct ath12k_base *ab)
+struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,
+					 struct ath12k_pdev_map *pdev_map,
+					 u8 num_pdev_map)
 {
 	struct ieee80211_hw *hw;
 	struct ath12k *ar;
 	struct ath12k_pdev *pdev;
-	int ret;
+	struct ath12k_hw *ah;
 	int i;
+	u8 pdev_idx;
 
-	for (i = 0; i < ab->num_radios; i++) {
-		pdev = &ab->pdevs[i];
-		hw = ieee80211_alloc_hw(sizeof(struct ath12k), &ath12k_ops);
-		if (!hw) {
-			ath12k_warn(ab, "failed to allocate mac80211 hw device\n");
-			ret = -ENOMEM;
-			goto err_free_mac;
-		}
+	hw = ieee80211_alloc_hw(struct_size(ah, radio, num_pdev_map),
+				&ath12k_ops);
+	if (!hw)
+		return NULL;
+
+	ah = ath12k_hw_to_ah(hw);
+	ah->hw = hw;
+	ah->num_radio = num_pdev_map;
+
+	for (i = 0; i < num_pdev_map; i++) {
+		ab = pdev_map[i].ab;
+		pdev_idx = pdev_map[i].pdev_idx;
+		pdev = &ab->pdevs[pdev_idx];
 
-		ar = hw->priv;
-		ar->hw = hw;
+		ar = ath12k_ah_to_ar(ah);
+		ar->ah = ah;
 		ar->ab = ab;
+		ar->hw_link_id = i;
 		ar->pdev = pdev;
-		ar->pdev_idx = i;
+		ar->pdev_idx = pdev_idx;
 		pdev->ar = ar;
 
 		ath12k_mac_setup(ar);
 	}
 
-	return 0;
-
-err_free_mac:
-	ath12k_mac_hw_destroy(ab);
-
-	return ret;
+	return ah;
 }
 
 void ath12k_mac_destroy(struct ath12k_base *ab)
 {
-	ath12k_mac_hw_destroy(ab);
+	struct ath12k_pdev *pdev;
+	int i;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		if (!pdev->ar)
+			continue;
+
+		pdev->ar = NULL;
+	}
+
+	for (i = 0; i < ab->num_hw; i++) {
+		if (!ab->ah[i])
+			continue;
+
+		ath12k_mac_hw_destroy(ab->ah[i]);
+		ab->ah[i] = NULL;
+	}
 }
 
 int ath12k_mac_allocate(struct ath12k_base *ab)
 {
-	int ret;
+	struct ath12k_hw *ah;
+	struct ath12k_pdev_map pdev_map[MAX_RADIOS];
+	int ret, i, j;
+	u8 radio_per_hw;
 
 	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags))
 		return 0;
 
-	ret = ath12k_mac_hw_allocate(ab);
-	if (ret)
-		return ret;
+	ab->num_hw = ab->num_radios;
+	radio_per_hw = 1;
+
+	for (i = 0; i < ab->num_hw; i++) {
+		for (j = 0; j < radio_per_hw; j++) {
+			pdev_map[j].ab = ab;
+			pdev_map[j].pdev_idx = (i * radio_per_hw) + j;
+		}
+
+		ah = ath12k_mac_hw_allocate(ab, pdev_map, radio_per_hw);
+		if (!ah) {
+			ath12k_warn(ab, "failed to allocate mac80211 hw device for hw_idx %d\n",
+				    i);
+			goto err;
+		}
+
+		ab->ah[i] = ah;
+	}
 
 	ath12k_dp_pdev_pre_alloc(ab);
 
 	return 0;
+
+err:
+	for (i = i - 1; i >= 0; i--) {
+		if (!ab->ah[i])
+			continue;
+
+		ath12k_mac_hw_destroy(ab->ah[i]);
+		ab->ah[i] = NULL;
+	}
+
+	return ret;
 }
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 7c63bb628adc..3f5e1be0dff9 100644
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
@@ -12,6 +12,8 @@
 
 struct ath12k;
 struct ath12k_base;
+struct ath12k_hw;
+struct ath12k_pdev_map;
 
 struct ath12k_generic_iter {
 	struct ath12k *ar;
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 88e71d171355..a164f15d1e2b 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -48,7 +48,8 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct ath12k_wmi_init_country_arg arg;
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar = ath12k_ah_to_ar(ah);
 	int ret;
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_REG,
-- 
2.34.1


