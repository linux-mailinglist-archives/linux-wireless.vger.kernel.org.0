Return-Path: <linux-wireless+bounces-266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB5E80011A
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 02:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5BA1F20EEA
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 01:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FA710E6;
	Fri,  1 Dec 2023 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mo2Uh/ZY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F5310F9
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 17:37:58 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B10rXlX031670;
	Fri, 1 Dec 2023 01:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=2zRwbuPoPfvFcuvWiCCmyNhamUyniJqv2AXmQ3z+SUs=;
 b=Mo2Uh/ZYeiXLgBABCB8/D3w+BkQgISGEjq3QtU3ZIv7Jj5jD4txXt5A2e0qBti+j4jWo
 hrFwdUoG3ZzkRVjJ/b9g9iJM68AGoTAGVp3lIdi8Eujib45ok6mSzeiLBHRE/mQUcUq/
 S8u7cVzqp2ujsOvM/J5jYXp2d9kUNqd1pDA2nj5zssWWU3xZixS/yd4QIhZX7WGVG3cz
 bHD4w3XMkOh8Fpzv5TqtllZJMjl/859LLAEUYEv0BMR76zi0gTZABDVqWPdtD7nwwOK5
 a/jQleSJ31/UbPKLVz/Fcm821ioSU8jrhngVNLrw/vtE+7S0uP6suABo7lx9AefvAFMO Vw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up5e8w4n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 01:37:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B11bsYl016293
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Dec 2023 01:37:54 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 30 Nov 2023 17:37:52 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH] wifi: ath12k: avoid repeated wiphy access from hw
Date: Fri, 1 Dec 2023 07:07:35 +0530
Message-ID: <20231201013735.2292313-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: qMUugoS0PR896kOlGCPnYu6-dQmWEwl-
X-Proofpoint-ORIG-GUID: qMUugoS0PR896kOlGCPnYu6-dQmWEwl-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_25,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 mlxlogscore=777 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010008

Currently repeated access of wiphy data from mac80211 hw structure is
happen inside the mac80211 registration helper functions. So optimize
these helper functions by storing wiphy data locally and accessing it
directly.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 72 ++++++++++++++-------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 45b5c642a0fd..6b4a3ee24ed4 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7247,6 +7247,7 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_hw *hw = ar->hw;
+	struct wiphy *wiphy = hw->wiphy;
 	struct ieee80211_iface_combination *combinations;
 	struct ieee80211_iface_limit *limits;
 	int n_limits, max_interfaces;
@@ -7297,8 +7298,8 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k *ar)
 						BIT(NL80211_CHAN_WIDTH_40) |
 						BIT(NL80211_CHAN_WIDTH_80);
 
-	hw->wiphy->iface_combinations = combinations;
-	hw->wiphy->n_iface_combinations = 1;
+	wiphy->iface_combinations = combinations;
+	wiphy->n_iface_combinations = 1;
 
 	return 0;
 }
@@ -7343,6 +7344,7 @@ static const struct wiphy_iftype_ext_capab ath12k_iftypes_ext_capa[] = {
 static void __ath12k_mac_unregister(struct ath12k *ar)
 {
 	struct ieee80211_hw *hw = ar->hw;
+	struct wiphy *wiphy = hw->wiphy;
 
 	cancel_work_sync(&ar->regd_update_work);
 
@@ -7355,8 +7357,8 @@ static void __ath12k_mac_unregister(struct ath12k *ar)
 	kfree(ar->mac.sbands[NL80211_BAND_5GHZ].channels);
 	kfree(ar->mac.sbands[NL80211_BAND_6GHZ].channels);
 
-	kfree(hw->wiphy->iface_combinations[0].limits);
-	kfree(hw->wiphy->iface_combinations);
+	kfree(wiphy->iface_combinations[0].limits);
+	kfree(wiphy->iface_combinations);
 
 	SET_IEEE80211_DEV(hw, NULL);
 }
@@ -7381,6 +7383,7 @@ static int __ath12k_mac_register(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_hw *hw = ar->hw;
+	struct wiphy *wiphy = hw->wiphy;
 	struct ath12k_pdev_cap *cap = &ar->pdev->cap;
 	static const u32 cipher_suites[] = {
 		WLAN_CIPHER_SUITE_TKIP,
@@ -7416,14 +7419,14 @@ static int __ath12k_mac_register(struct ath12k *ar)
 		goto err_free_channels;
 	}
 
-	hw->wiphy->available_antennas_rx = cap->rx_chain_mask;
-	hw->wiphy->available_antennas_tx = cap->tx_chain_mask;
+	wiphy->available_antennas_rx = cap->rx_chain_mask;
+	wiphy->available_antennas_tx = cap->tx_chain_mask;
 
-	hw->wiphy->interface_modes = ab->hw_params->interface_modes;
+	wiphy->interface_modes = ab->hw_params->interface_modes;
 
-	if (hw->wiphy->bands[NL80211_BAND_2GHZ] &&
-	    hw->wiphy->bands[NL80211_BAND_5GHZ] &&
-	    hw->wiphy->bands[NL80211_BAND_6GHZ])
+	if (wiphy->bands[NL80211_BAND_2GHZ] &&
+	    wiphy->bands[NL80211_BAND_5GHZ] &&
+	    wiphy->bands[NL80211_BAND_6GHZ])
 		ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 
 	ieee80211_hw_set(hw, SIGNAL_DBM);
@@ -7449,60 +7452,59 @@ static int __ath12k_mac_register(struct ath12k *ar)
 		ieee80211_hw_set(hw, USES_RSS);
 	}
 
-	hw->wiphy->features |= NL80211_FEATURE_STATIC_SMPS;
-	hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
+	wiphy->features |= NL80211_FEATURE_STATIC_SMPS;
+	wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
 
 	/* TODO: Check if HT capability advertised from firmware is different
 	 * for each band for a dual band capable radio. It will be tricky to
 	 * handle it when the ht capability different for each band.
 	 */
 	if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS)
-		hw->wiphy->features |= NL80211_FEATURE_DYNAMIC_SMPS;
+		wiphy->features |= NL80211_FEATURE_DYNAMIC_SMPS;
 
-	hw->wiphy->max_scan_ssids = WLAN_SCAN_PARAMS_MAX_SSID;
-	hw->wiphy->max_scan_ie_len = WLAN_SCAN_PARAMS_MAX_IE_LEN;
+	wiphy->max_scan_ssids = WLAN_SCAN_PARAMS_MAX_SSID;
+	wiphy->max_scan_ie_len = WLAN_SCAN_PARAMS_MAX_IE_LEN;
 
 	hw->max_listen_interval = ATH12K_MAX_HW_LISTEN_INTERVAL;
 
-	hw->wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
-	hw->wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
-	hw->wiphy->max_remain_on_channel_duration = 5000;
+	wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
+	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+	wiphy->max_remain_on_channel_duration = 5000;
 
-	hw->wiphy->flags |= WIPHY_FLAG_AP_UAPSD;
-	hw->wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
+	wiphy->flags |= WIPHY_FLAG_AP_UAPSD;
+	wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
 				   NL80211_FEATURE_AP_SCAN;
 
 	ar->max_num_stations = TARGET_NUM_STATIONS;
 	ar->max_num_peers = TARGET_NUM_PEERS_PDEV;
 
-	hw->wiphy->max_ap_assoc_sta = ar->max_num_stations;
+	wiphy->max_ap_assoc_sta = ar->max_num_stations;
 
 	hw->queues = ATH12K_HW_MAX_QUEUES;
-	hw->wiphy->tx_queue_len = ATH12K_QUEUE_LEN;
+	wiphy->tx_queue_len = ATH12K_QUEUE_LEN;
 	hw->offchannel_tx_hw_queue = ATH12K_HW_MAX_QUEUES - 1;
 	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 
 	hw->vif_data_size = sizeof(struct ath12k_vif);
 	hw->sta_data_size = sizeof(struct ath12k_sta);
 
-	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
-	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
 
-	hw->wiphy->cipher_suites = cipher_suites;
-	hw->wiphy->n_cipher_suites = ARRAY_SIZE(cipher_suites);
+	wiphy->cipher_suites = cipher_suites;
+	wiphy->n_cipher_suites = ARRAY_SIZE(cipher_suites);
 
-	hw->wiphy->iftype_ext_capab = ath12k_iftypes_ext_capa;
-	hw->wiphy->num_iftype_ext_capab =
-		ARRAY_SIZE(ath12k_iftypes_ext_capa);
+	wiphy->iftype_ext_capab = ath12k_iftypes_ext_capa;
+	wiphy->num_iftype_ext_capab = ARRAY_SIZE(ath12k_iftypes_ext_capa);
 
 	if (ar->supports_6ghz) {
-		wiphy_ext_feature_set(hw->wiphy,
+		wiphy_ext_feature_set(wiphy,
 				      NL80211_EXT_FEATURE_FILS_DISCOVERY);
-		wiphy_ext_feature_set(hw->wiphy,
+		wiphy_ext_feature_set(wiphy,
 				      NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP);
 	}
 
-	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_PUNCT);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_PUNCT);
 
 	ath12k_reg_init(hw);
 
@@ -7524,7 +7526,7 @@ static int __ath12k_mac_register(struct ath12k *ar)
 		 * while. But that time is so short and in practise it make
 		 * a difference in real life.
 		 */
-		hw->wiphy->interface_modes &= ~BIT(NL80211_IFTYPE_MONITOR);
+		wiphy->interface_modes &= ~BIT(NL80211_IFTYPE_MONITOR);
 
 	/* Apply the regd received during initialization */
 	ret = ath12k_regd_update(ar, true);
@@ -7539,8 +7541,8 @@ static int __ath12k_mac_register(struct ath12k *ar)
 	ieee80211_unregister_hw(hw);
 
 err_free_if_combs:
-	kfree(hw->wiphy->iface_combinations[0].limits);
-	kfree(hw->wiphy->iface_combinations);
+	kfree(wiphy->iface_combinations[0].limits);
+	kfree(wiphy->iface_combinations);
 
 err_free_channels:
 	kfree(ar->mac.sbands[NL80211_BAND_2GHZ].channels);

base-commit: ca4f872acfb5f093b6c68ae156dc9f163da414e3
prerequisite-patch-id: 4f660d65ba08d3375e613278664a9f31d2c9e539
prerequisite-patch-id: dfbdb03ae418047c172c12c285a8b0c14435aeed
-- 
2.34.1


