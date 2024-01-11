Return-Path: <linux-wireless+bounces-1687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CC382A705
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 05:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7081F22893
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 04:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2509C2105;
	Thu, 11 Jan 2024 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O4876Ph8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149691879
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 04:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B2YdGu027554;
	Thu, 11 Jan 2024 04:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=eQQwQXNm4ytrHITYD/CQ
	CD9qIc8zsQu4M0qEc7KAJn4=; b=O4876Ph8uBhf1ArI78MT1Vk9r/67ZOz2AVPX
	oxk+1zI9ftlV8Fg0nRVP7PM6I62xvJ0hpL+1VcPEgjzOzo7dLv/obPGGsnX4ZC3Y
	Si/ACi4GslvLBbryE71SJig6wFQQxP2jZOUOmSGPZwesEYHFBCxFiQ1oVCla7uCi
	vukVx2F/yzIykTH8kjlxzAz9iTkEjXxonWWypYGtiQygylfkWicZED5nJHfi9Plu
	6CHOf+skw3oVzA9iYHxhsK6Mqn31xHDnGXmoYO71PtoI8njNvUPsHyDauInoaW2n
	h/3f1TfMkA3nfsmkm5DiR+T/ODAYFzzBZnb9LmZPmZuPe+irag==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhvqw1p8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 04:51:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40B4pLOs017282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 04:51:22 GMT
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 20:51:19 -0800
From: Sriram R <quic_srirrama@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 01/12] wifi: ath12k: add multiple radio support in a single MAC HW un/register
Date: Thu, 11 Jan 2024 10:20:34 +0530
Message-ID: <20240111045045.28377-2-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240111045045.28377-1-quic_srirrama@quicinc.com>
References: <20240111045045.28377-1-quic_srirrama@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D9n7vwpSEiscnlRyV5ADpR15DobcfTpI
X-Proofpoint-ORIG-GUID: D9n7vwpSEiscnlRyV5ADpR15DobcfTpI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=880 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401110035

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Currently MAC HW un/register helper function support the single radio.
To enable single/multi link operation in the future, the following helper
functions need to be refactored to accommodate multiple radios under a
single MAC HW un/register:

	* ath12k_ah_to_ar()
	* ath12k_mac_hw_allocate()
	* ath12k_mac_hw_register()
	* ath12k_mac_hw_unregister()

This refactoring will make it easier to scale these functionalities and
support Multi link operation.

                         Current Multi wiphy Model

 +---------------+          +---------------+            +---------------+
 |  Mac80211 hw  |          | Mac80211 hw   |            | Mac80211 hw   |
 |  private data |          | private data  |            | private data  |
 |               |          |               |            |               |
 |ath12k_hw (ah) |          |ath12k_hw (ah) |            |ath12k_hw (ah) |
 |               |          |               |            |               |
 | +-----------+ |          | +-----------+ |            | +-----------+ |
 | | ar (2GHz) | |          | | ar (5GHz) | |            | | ar (6GHz) | |
 | +-----------+ |          | +-----------+ |            | +-----------+ |
 |               |          |               |            |               |
 +---------------+          +---------------+            +---------------+

                           Single wiphy Model

                            +--------------+
                            | Mac80211 hw  |
                            | private data |
                            |              |
                            |ath12k hw (ah)|
                            | +----------+ |
                            | |ar (2GHz) | |
                            | +----------+ |
                            | |ar (5GHz) | |
                            | +----------+ |
                            | |ar (6GHz) | |
                            | +----------+ |
                            +--------------+

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  14 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 182 ++++++++++++++++---------
 drivers/net/wireless/ath/ath12k/reg.c  |   2 +-
 3 files changed, 129 insertions(+), 69 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index e0f04d77677f..5bce55799d98 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -930,13 +930,23 @@ static inline struct ath12k_hw *ath12k_hw_to_ah(struct ieee80211_hw  *hw)
 	return hw->priv;
 }
 
-static inline struct ath12k *ath12k_ah_to_ar(struct ath12k_hw *ah)
+static inline struct ath12k *ath12k_ah_to_ar(struct ath12k_hw *ah,
+					     u8 hw_link_id)
 {
-	return ah->radio;
+	if (WARN(hw_link_id >= ah->num_radio,
+		 "bad hw link id %d, so switch to default link\n", hw_link_id))
+		hw_link_id = 0;
+
+	return &ah->radio[hw_link_id];
 }
 
 static inline struct ieee80211_hw *ath12k_ar_to_hw(struct ath12k *ar)
 {
 	return ar->ah->hw;
 }
+
+#define for_each_ar(index, ah, ar) \
+	for ((index) = 0, (ar) = (ah)->radio; (index) < (ah)->num_radio; \
+	     (index)++, (ar)++)
+
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index aa1cedbf9410..fbb2d195d778 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1130,7 +1130,7 @@ static int ath12k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	ret = ath12k_mac_config(ar, changed);
 	if (ret)
@@ -2804,7 +2804,7 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -2993,7 +2993,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -3087,7 +3087,7 @@ static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 	ath12k_scan_abort(ar);
@@ -3236,7 +3236,7 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags)) {
@@ -3833,7 +3833,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -3959,7 +3959,7 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -3989,7 +3989,7 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 	struct ath12k_peer *peer;
 	u32 bw, smps;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	spin_lock_bh(&ar->ab->base_lock);
 
@@ -4172,7 +4172,7 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_conf_tx(arvif, link_id, ac, params);
@@ -5275,7 +5275,7 @@ static int ath12k_mac_start(struct ath12k *ar)
 static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
 	struct ath12k_base *ab = ar->ab;
 	int ret;
 
@@ -5389,7 +5389,7 @@ static void ath12k_mac_stop(struct ath12k *ar)
 static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
 
 	ath12k_mac_drain_tx(ar);
 
@@ -5589,7 +5589,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -5849,7 +5849,7 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -5967,7 +5967,7 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -5986,7 +5986,7 @@ static int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -6008,7 +6008,7 @@ static int ath12k_mac_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 	ret = __ath12k_set_antenna(ar, tx_ant, rx_ant);
@@ -6060,7 +6060,7 @@ static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_ampdu_action(arvif, params);
@@ -6084,7 +6084,7 @@ static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
@@ -6116,7 +6116,7 @@ static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
@@ -6533,7 +6533,7 @@ static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -6606,7 +6606,7 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -6691,7 +6691,7 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -6748,7 +6748,7 @@ ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -6798,7 +6798,7 @@ static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	ret = ath12k_set_vdev_param_to_all_vifs(ar, param_id, value);
 
@@ -6844,7 +6844,7 @@ static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *v
 				u32 queues, bool drop)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
 
 	if (drop)
 		return;
@@ -7218,7 +7218,7 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -7317,7 +7317,7 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	ar_survey = &ar->survey[idx];
 
@@ -7553,10 +7553,12 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 
 static u16 ath12k_mac_get_ifmodes(struct ath12k_hw *ah)
 {
-	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	struct ath12k *ar;
+	int i;
 	u16 interface_modes = U16_MAX;
 
-	interface_modes &= ar->ab->hw_params->interface_modes;
+	for_each_ar(i, ah, ar)
+		interface_modes &= ar->ab->hw_params->interface_modes;
 
 	return interface_modes == U16_MAX ? 0 : interface_modes;
 }
@@ -7564,15 +7566,19 @@ static u16 ath12k_mac_get_ifmodes(struct ath12k_hw *ah)
 static bool ath12k_mac_is_iface_mode_enable(struct ath12k_hw *ah,
 					    enum nl80211_iftype type)
 {
-	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	struct ath12k *ar;
+	int i;
 	u16 interface_modes, mode;
 	bool is_enable = true;
 
 	mode = BIT(type);
-
-	interface_modes = ar->ab->hw_params->interface_modes;
-	if (!(interface_modes & mode))
-		is_enable = false;
+	for_each_ar(i, ah, ar) {
+		interface_modes = ar->ab->hw_params->interface_modes;
+		if (!(interface_modes & mode)) {
+			is_enable = false;
+			break;
+		}
+	}
 
 	return is_enable;
 }
@@ -7687,13 +7693,16 @@ void ath12k_mac_hw_unregister(struct ath12k_hw *ah)
 {
 	struct ieee80211_hw *hw = ah->hw;
 	struct wiphy *wiphy = hw->wiphy;
-	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	struct ath12k *ar;
+	int i;
 
-	cancel_work_sync(&ar->regd_update_work);
+	for_each_ar(i, ah, ar)
+		cancel_work_sync(&ar->regd_update_work);
 
 	ieee80211_unregister_hw(hw);
 
-	ath12k_mac_cleanup_unregister(ar);
+	for_each_ar(i, ah, ar)
+		ath12k_mac_cleanup_unregister(ar);
 
 	kfree(wiphy->iface_combinations[0].limits);
 	kfree(wiphy->iface_combinations);
@@ -7733,7 +7742,7 @@ int ath12k_mac_hw_register(struct ath12k_hw *ah)
 {
 	struct ieee80211_hw *hw = ah->hw;
 	struct wiphy *wiphy = hw->wiphy;
-	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_pdev *pdev;
 	struct ath12k_pdev_cap *cap;
@@ -7748,39 +7757,72 @@ int ath12k_mac_hw_register(struct ath12k_hw *ah)
 		WLAN_CIPHER_SUITE_GCMP_256,
 		WLAN_CIPHER_SUITE_CCMP_256,
 	};
-	int ret;
-	u32 ht_cap = 0;
+	int ret, i, j;
+	u32 ht_cap = U32_MAX, antennas_rx = 0, antennas_tx = 0;
+	bool is_6ghz = false, is_raw_mode = false, is_monitor_disable = false;
+	u8 *mac_addr = NULL;
 
-	pdev = ar->pdev;
+	wiphy->max_ap_assoc_sta = 0;
 
-	if (ab->pdevs_macaddr_valid)
-		ether_addr_copy(ar->mac_addr, pdev->mac_addr);
-	else
-		ether_addr_copy(ar->mac_addr, ab->mac_addr);
+	for_each_ar(i, ah, ar) {
+		u32 ht_cap_info = 0;
 
-	ret = ath12k_mac_setup_register(ar, &ht_cap, hw->wiphy->bands);
-	if (ret)
-		goto out;
+		pdev = ar->pdev;
+
+		if (ab->pdevs_macaddr_valid) {
+			ether_addr_copy(ar->mac_addr, pdev->mac_addr);
+		} else {
+			ether_addr_copy(ar->mac_addr, ab->mac_addr);
+			ar->mac_addr[4] += i;
+		}
+
+		ret = ath12k_mac_setup_register(ar, &ht_cap_info, hw->wiphy->bands);
+		if (ret)
+			goto err_cleanup_unregister;
 
-	wiphy->max_ap_assoc_sta = ar->max_num_stations;
+		ht_cap &= ht_cap_info;
+		wiphy->max_ap_assoc_sta += ar->max_num_stations;
+
+		/* Advertise the max antenna support of all radios, driver can handle
+		 * per pdev specific antenna setting based on pdev cap when antenna
+		 * changes are made
+		 */
+		cap = &pdev->cap;
 
-	cap = &pdev->cap;
+		antennas_rx = max_t(u32, antennas_rx, cap->rx_chain_mask);
+		antennas_tx = max_t(u32, antennas_tx, cap->tx_chain_mask);
 
-	wiphy->available_antennas_rx = cap->rx_chain_mask;
-	wiphy->available_antennas_tx = cap->tx_chain_mask;
+		if (ar->supports_6ghz)
+			is_6ghz = true;
 
-	SET_IEEE80211_PERM_ADDR(hw, ar->mac_addr);
+		if (test_bit(ATH12K_FLAG_RAW_MODE, &ar->ab->dev_flags))
+			is_raw_mode = true;
+
+		if (!ar->ab->hw_params->supports_monitor)
+			is_monitor_disable = true;
+
+		if (i == 0)
+			mac_addr = ar->mac_addr;
+		else
+			mac_addr = ab->mac_addr;
+	}
+
+	wiphy->available_antennas_rx = antennas_rx;
+	wiphy->available_antennas_tx = antennas_tx;
+
+	SET_IEEE80211_PERM_ADDR(hw, mac_addr);
 	SET_IEEE80211_DEV(hw, ab->dev);
 
 	ret = ath12k_mac_setup_iface_combinations(ah);
 	if (ret) {
 		ath12k_err(ab, "failed to setup interface combinations: %d\n", ret);
-		goto err_cleanup_unregister;
+		goto err_complete_cleanup_unregister;
 	}
 
 	wiphy->interface_modes = ath12k_mac_get_ifmodes(ah);
 
-	if (wiphy->bands[NL80211_BAND_2GHZ] &&
+	if (ah->num_radio == 1 &&
+	    wiphy->bands[NL80211_BAND_2GHZ] &&
 	    wiphy->bands[NL80211_BAND_5GHZ] &&
 	    wiphy->bands[NL80211_BAND_6GHZ])
 		ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
@@ -7848,7 +7890,7 @@ int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	wiphy->iftype_ext_capab = ath12k_iftypes_ext_capa;
 	wiphy->num_iftype_ext_capab = ARRAY_SIZE(ath12k_iftypes_ext_capa);
 
-	if (ar->supports_6ghz) {
+	if (is_6ghz) {
 		wiphy_ext_feature_set(wiphy,
 				      NL80211_EXT_FEATURE_FILS_DISCOVERY);
 		wiphy_ext_feature_set(wiphy,
@@ -7859,7 +7901,7 @@ int ath12k_mac_hw_register(struct ath12k_hw *ah)
 
 	ath12k_reg_init(hw);
 
-	if (!test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags)) {
+	if (!is_raw_mode) {
 		hw->netdev_features = NETIF_F_HW_CSUM;
 		ieee80211_hw_set(hw, SW_CRYPTO_CONTROL);
 		ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
@@ -7871,7 +7913,7 @@ int ath12k_mac_hw_register(struct ath12k_hw *ah)
 		goto err_free_if_combs;
 	}
 
-	if (!ab->hw_params->supports_monitor)
+	if (is_monitor_disable)
 		/* There's a race between calling ieee80211_register_hw()
 		 * and here where the monitor mode is enabled for a little
 		 * while. But that time is so short and in practise it make
@@ -7879,11 +7921,13 @@ int ath12k_mac_hw_register(struct ath12k_hw *ah)
 		 */
 		wiphy->interface_modes &= ~BIT(NL80211_IFTYPE_MONITOR);
 
-	/* Apply the regd received during initialization */
-	ret = ath12k_regd_update(ar, true);
-	if (ret) {
-		ath12k_err(ar->ab, "ath12k regd update failed: %d\n", ret);
-		goto err_unregister_hw;
+	for_each_ar(i, ah, ar) {
+		/* Apply the regd received during initialization */
+		ret = ath12k_regd_update(ar, true);
+		if (ret) {
+			ath12k_err(ar->ab, "ath12k regd update failed: %d\n", ret);
+			goto err_unregister_hw;
+		}
 	}
 
 	return 0;
@@ -7895,10 +7939,16 @@ int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	kfree(wiphy->iface_combinations[0].limits);
 	kfree(wiphy->iface_combinations);
 
+err_complete_cleanup_unregister:
+	i = ah->num_radio;
+
 err_cleanup_unregister:
-	ath12k_mac_cleanup_unregister(ar);
+	ar = ath12k_ah_to_ar(ah, 0);
+	for (j = 0; j < i; j++) {
+		ath12k_mac_cleanup_unregister(ar);
+		ar++;
+	}
 
-out:
 	SET_IEEE80211_DEV(hw, NULL);
 
 	return ret;
@@ -7971,7 +8021,7 @@ struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,
 		pdev_idx = pdev_map[i].pdev_idx;
 		pdev = &ab->pdevs[pdev_idx];
 
-		ar = ath12k_ah_to_ar(ah);
+		ar = ath12k_ah_to_ar(ah, i);
 		ar->ah = ah;
 		ar->ab = ab;
 		ar->hw_link_id = i;
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index a164f15d1e2b..da64482f1024 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -49,7 +49,7 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct ath12k_wmi_init_country_arg arg;
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
 	int ret;
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_REG,
-- 
2.17.1


