Return-Path: <linux-wireless+bounces-5022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8E98817B3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 20:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139FD1F22A2C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 19:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CE085C44;
	Wed, 20 Mar 2024 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wqm4zcLs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A949585946
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710961847; cv=none; b=Wbi8nN/IQLz5Hoqxxcw81JE+SeM8Fi9ie4XsqZ4P6YjIem5mPfwiyjgZf17uvn6n+ZSI+fPejvEibLwQCHezkbwxA4OASIx1FhGytCPRJrV1Kl+8+Lzatxa4ssUWDNga1T8bWckcyLC6Xnh3gYHHrpuI+pyVia3zjEKBmlK5i1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710961847; c=relaxed/simple;
	bh=bymqOzi8M13XTjCygAt7CqMf2Wcwh8FR7YjLUgHE6Ak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnoM0xOxYIdOLXBZh/hyIhjmmv2el7nqD5BCSnehu26jdoe3K0sjuVvfqOPmuaLgolPojMn0BDE7nl7Y0mo03VCrnxufH5D2pE6O6CiNbZjca2fxP7nLZcva3HDNS0hymyZWE2zjgkvnizibKqOkUNUcmZV5SwwDQuJMvsu9lvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wqm4zcLs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KEjx18005220;
	Wed, 20 Mar 2024 19:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=yjVaNHaQP/dnX/MSXquQ0qpFYVt/ULjdzBEoZG8QbLM=; b=Wq
	m4zcLsxAWnoCu8UP0O7q3vDAiyVU1wrhdHFN+8nvyVSRRlNQCgSjbQQBzR83v4f/
	hIU7tXHAq8BttjKmOh2zC2cqYh/X+HQda5XYydSp67Yqn/P/7bJHOtMJgDwACAU1
	mUHHM6rJ0W04ON4fw0Nran1oC10JuNTjcL8Jgq2g87EuoEmvYrP1q4eQgiLXWOzI
	urhwK9gP4Ag41q21RnY4pyfwA5JCzJ9RdO5zi2JWLkJufsE2ao6L7is9aDWQq5UK
	/9HXEV3UMI6PwLO37ZG+6up9m1EUbpJTtXf5j+N05gpxxMTntGam9x5FuyVIjLb9
	TZMGjnV6YBjf+wlNB9aw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wypxq23pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 19:10:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KJA0ke017176
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 19:10:00 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 12:09:58 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v5 01/12] wifi: ath12k: add multiple radio support in a single MAC HW un/register
Date: Thu, 21 Mar 2024 00:39:32 +0530
Message-ID: <20240320190943.3850106-2-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320190943.3850106-1-quic_ramess@quicinc.com>
References: <20240320190943.3850106-1-quic_ramess@quicinc.com>
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
X-Proofpoint-ORIG-GUID: T1-6W-cZ9i-rFcfXz4U8TEkv3aF6Ah1y
X-Proofpoint-GUID: T1-6W-cZ9i-rFcfXz4U8TEkv3aF6Ah1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200154

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
Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  12 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 184 ++++++++++++++++---------
 drivers/net/wireless/ath/ath12k/reg.c  |   2 +-
 3 files changed, 127 insertions(+), 71 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 97e5a0ccd233..f16bb7621a74 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -951,13 +951,21 @@ static inline struct ath12k_hw *ath12k_hw_to_ah(struct ieee80211_hw  *hw)
 	return hw->priv;
 }
 
-static inline struct ath12k *ath12k_ah_to_ar(struct ath12k_hw *ah)
+static inline struct ath12k *ath12k_ah_to_ar(struct ath12k_hw *ah, u8 hw_link_id)
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
+#define for_each_ar(ah, ar, index) \
+	for ((index) = 0; ((index) < (ah)->num_radio && \
+	     ((ar) = &(ah)->radio[(index)])); (index)++)
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 52a5fb8b03e9..94ab2e705f61 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1169,7 +1169,7 @@ static int ath12k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 	struct ath12k *ar;
 	int ret;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	ret = ath12k_mac_config(ar, changed);
 	if (ret)
@@ -2970,7 +2970,7 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -3155,7 +3155,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	int ret;
 	int i;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -3245,7 +3245,7 @@ static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 	ath12k_scan_abort(ar);
@@ -3390,7 +3390,7 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256)
 		return 1;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags))
@@ -3980,7 +3980,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	     new_state == IEEE80211_STA_NOTEXIST))
 		cancel_work_sync(&arsta->update_wk);
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -4109,7 +4109,7 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 	if (txpwr > ATH12K_TX_POWER_MAX_VAL || txpwr < ATH12K_TX_POWER_MIN_VAL)
 		return -EINVAL;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -4138,7 +4138,7 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 	struct ath12k_peer *peer;
 	u32 bw, smps;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	spin_lock_bh(&ar->ab->base_lock);
 
@@ -4319,7 +4319,7 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_conf_tx(arvif, link_id, ac, params);
@@ -5446,7 +5446,7 @@ static int ath12k_mac_start(struct ath12k *ar)
 static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
 	struct ath12k_base *ab = ar->ab;
 	int ret;
 
@@ -5555,7 +5555,7 @@ static void ath12k_mac_stop(struct ath12k *ar)
 static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
 
 	ath12k_mac_drain_tx(ar);
 
@@ -5749,7 +5749,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 
 	vif->driver_flags |= IEEE80211_VIF_SUPPORTS_UAPSD;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -6017,7 +6017,7 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	unsigned long time_left;
 	int ret;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -6132,7 +6132,7 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -6147,7 +6147,7 @@ static int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -6165,7 +6165,7 @@ static int ath12k_mac_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx
 	struct ath12k *ar;
 	int ret;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 	ret = __ath12k_set_antenna(ar, tx_ant, rx_ant);
@@ -6213,7 +6213,7 @@ static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret = -EINVAL;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_ampdu_action(arvif, params);
@@ -6233,7 +6233,7 @@ static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
 	struct ath12k *ar;
 	struct ath12k_base *ab;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
@@ -6261,7 +6261,7 @@ static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 	struct ath12k *ar;
 	struct ath12k_base *ab;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
@@ -6641,7 +6641,7 @@ static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 	struct ath12k *ar;
 	struct ath12k_base *ab;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -6712,7 +6712,7 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	int ret;
 	struct ath12k_wmi_peer_create_arg param;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -6794,7 +6794,7 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -6849,7 +6849,7 @@ ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -6895,7 +6895,7 @@ static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 	struct ath12k *ar;
 	int param_id = WMI_VDEV_PARAM_RTS_THRESHOLD, ret;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	ret = ath12k_set_vdev_param_to_all_vifs(ar, param_id, value);
 
@@ -6939,7 +6939,7 @@ static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *v
 				u32 queues, bool drop)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
 
 	if (drop)
 		return;
@@ -7306,7 +7306,7 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 	if (reconfig_type != IEEE80211_RECONFIG_TYPE_RESTART)
 		return;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -7401,7 +7401,7 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	if (idx >= ATH12K_NUM_CHANS)
 		return -ENOENT;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	ar_survey = &ar->survey[idx];
 
@@ -7478,7 +7478,7 @@ static int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -7508,7 +7508,7 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	u32 scan_time_msec;
 	int ret;
 
-	ar = ath12k_ah_to_ar(ah);
+	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
 	spin_lock_bh(&ar->data_lock);
@@ -7757,10 +7757,12 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 
 static u16 ath12k_mac_get_ifmodes(struct ath12k_hw *ah)
 {
-	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	struct ath12k *ar;
+	int i;
 	u16 interface_modes = U16_MAX;
 
-	interface_modes &= ar->ab->hw_params->interface_modes;
+	for_each_ar(ah, ar, i)
+		interface_modes &= ar->ab->hw_params->interface_modes;
 
 	return interface_modes == U16_MAX ? 0 : interface_modes;
 }
@@ -7768,15 +7770,19 @@ static u16 ath12k_mac_get_ifmodes(struct ath12k_hw *ah)
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
+	for_each_ar(ah, ar, i) {
+		interface_modes = ar->ab->hw_params->interface_modes;
+		if (!(interface_modes & mode)) {
+			is_enable = false;
+			break;
+		}
+	}
 
 	return is_enable;
 }
@@ -7906,13 +7912,16 @@ static void ath12k_mac_hw_unregister(struct ath12k_hw *ah)
 {
 	struct ieee80211_hw *hw = ah->hw;
 	struct wiphy *wiphy = hw->wiphy;
-	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	struct ath12k *ar;
+	int i;
 
-	cancel_work_sync(&ar->regd_update_work);
+	for_each_ar(ah, ar, i)
+		cancel_work_sync(&ar->regd_update_work);
 
 	ieee80211_unregister_hw(hw);
 
-	ath12k_mac_cleanup_unregister(ar);
+	for_each_ar(ah, ar, i)
+		ath12k_mac_cleanup_unregister(ar);
 
 	kfree(wiphy->iface_combinations[0].limits);
 	kfree(wiphy->iface_combinations);
@@ -7952,7 +7961,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 {
 	struct ieee80211_hw *hw = ah->hw;
 	struct wiphy *wiphy = hw->wiphy;
-	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_pdev *pdev;
 	struct ath12k_pdev_cap *cap;
@@ -7967,39 +7976,71 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
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
+	for_each_ar(ah, ar, i) {
+		u32 ht_cap_info = 0;
 
-	ret = ath12k_mac_setup_register(ar, &ht_cap, hw->wiphy->bands);
-	if (ret)
-		goto out;
+		pdev = ar->pdev;
+		if (ar->ab->pdevs_macaddr_valid) {
+			ether_addr_copy(ar->mac_addr, pdev->mac_addr);
+		} else {
+			ether_addr_copy(ar->mac_addr, ar->ab->mac_addr);
+			ar->mac_addr[4] += ar->pdev_idx;
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
@@ -8067,7 +8108,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	wiphy->iftype_ext_capab = ath12k_iftypes_ext_capa;
 	wiphy->num_iftype_ext_capab = ARRAY_SIZE(ath12k_iftypes_ext_capa);
 
-	if (ar->supports_6ghz) {
+	if (is_6ghz) {
 		wiphy_ext_feature_set(wiphy,
 				      NL80211_EXT_FEATURE_FILS_DISCOVERY);
 		wiphy_ext_feature_set(wiphy,
@@ -8078,7 +8119,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 
 	ath12k_reg_init(hw);
 
-	if (!test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags)) {
+	if (!is_raw_mode) {
 		hw->netdev_features = NETIF_F_HW_CSUM;
 		ieee80211_hw_set(hw, SW_CRYPTO_CONTROL);
 		ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
@@ -8090,7 +8131,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 		goto err_free_if_combs;
 	}
 
-	if (!ab->hw_params->supports_monitor)
+	if (is_monitor_disable)
 		/* There's a race between calling ieee80211_register_hw()
 		 * and here where the monitor mode is enabled for a little
 		 * while. But that time is so short and in practise it make
@@ -8098,11 +8139,13 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 		 */
 		wiphy->interface_modes &= ~BIT(NL80211_IFTYPE_MONITOR);
 
-	/* Apply the regd received during initialization */
-	ret = ath12k_regd_update(ar, true);
-	if (ret) {
-		ath12k_err(ar->ab, "ath12k regd update failed: %d\n", ret);
-		goto err_unregister_hw;
+	for_each_ar(ah, ar, i) {
+		/* Apply the regd received during initialization */
+		ret = ath12k_regd_update(ar, true);
+		if (ret) {
+			ath12k_err(ar->ab, "ath12k regd update failed: %d\n", ret);
+			goto err_unregister_hw;
+		}
 	}
 
 	return 0;
@@ -8114,10 +8157,15 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	kfree(wiphy->iface_combinations[0].limits);
 	kfree(wiphy->iface_combinations);
 
+err_complete_cleanup_unregister:
+	i = ah->num_radio;
+
 err_cleanup_unregister:
-	ath12k_mac_cleanup_unregister(ar);
+	for (j = 0; j < i; j++) {
+		ar = ath12k_ah_to_ar(ah, j);
+		ath12k_mac_cleanup_unregister(ar);
+	}
 
-out:
 	SET_IEEE80211_DEV(hw, NULL);
 
 	return ret;
@@ -8243,7 +8291,7 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,
 		pdev_idx = pdev_map[i].pdev_idx;
 		pdev = &ab->pdevs[pdev_idx];
 
-		ar = ath12k_ah_to_ar(ah);
+		ar = ath12k_ah_to_ar(ah, i);
 		ar->ah = ah;
 		ar->ab = ab;
 		ar->hw_link_id = i;
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index f308e9a6ed55..e73b716a2d80 100644
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
2.25.1


