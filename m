Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8627F21D0
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 00:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjKTX6w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 18:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjKTX6v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 18:58:51 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695E299
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 15:58:47 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKNuIc1026161;
        Mon, 20 Nov 2023 23:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=TZeThEiX5G0iUOEziWjRZhkDw2WRzBNBBKV8kvZX6F4=;
 b=p119T6UhalIVlt/FJ4dhVtejrl82stusVRYVXFsPx395iKNufMCy5OM96BqBYHADGu+d
 TxdteYS14fxLS4uZ3sz232k9iXoBJOA7UurKtSxROH73bMlzTCzilk+jsBVEQXnUUL9m
 RBrImFLRwp9iqDpblcr1JrTUeETalZjbiNBSAyHv1ntpMO5tuaBeQVjOaPbZNEhG0kBu
 xkrFVblc+WlufKMS8wE8VGNgW38gVK77BrzmKPR6A8JVTO9uwSfOWz+Drve+xBIpLNOK
 SrdbGpLlYFiQgxGDm5ucLiOtA4VydqIirRgMkltAFb6WdAxItDFLF7QmavN1yglkkhzw ng== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug2axaa69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 23:58:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AKNwWPE009614
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 23:58:32 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 20 Nov 2023 15:58:30 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH 2/2] wifi: ath12k: avoid repeated hw access from ar
Date:   Tue, 21 Nov 2023 05:28:12 +0530
Message-ID: <20231120235812.2602198-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120235812.2602198-1-quic_periyasa@quicinc.com>
References: <20231120235812.2602198-1-quic_periyasa@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wDQarreiaUst3imTbeV8KMh3gsL_-ikf
X-Proofpoint-ORIG-GUID: wDQarreiaUst3imTbeV8KMh3gsL_-ikf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311200176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, the helper functions are accessing mac80211 hw data from the
radio (ar) structure repeatedly. So optimize these helper functions by
storing mac80211 hw data locally and accessing it directly.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 158 +++++++++++++-------------
 drivers/net/wireless/ath/ath12k/reg.c |  13 ++-
 drivers/net/wireless/ath/ath12k/reg.h |   2 +-
 3 files changed, 90 insertions(+), 83 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a85862ba134e..6c352c6755af 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6258,10 +6258,11 @@ ath12k_mac_update_active_vif_chan(struct ath12k *ar,
 				  struct ieee80211_chanctx_conf *ctx)
 {
 	struct ath12k_mac_change_chanctx_arg arg = { .ctx = ctx };
+	struct ieee80211_hw *hw = ar->hw;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
-	ieee80211_iterate_active_interfaces_atomic(ar->hw,
+	ieee80211_iterate_active_interfaces_atomic(hw,
 						   IEEE80211_IFACE_ITER_NORMAL,
 						   ath12k_mac_change_chanctx_cnt_iter,
 						   &arg);
@@ -6272,7 +6273,7 @@ ath12k_mac_update_active_vif_chan(struct ath12k *ar,
 	if (!arg.vifs)
 		return;
 
-	ieee80211_iterate_active_interfaces_atomic(ar->hw,
+	ieee80211_iterate_active_interfaces_atomic(hw,
 						   IEEE80211_IFACE_ITER_NORMAL,
 						   ath12k_mac_change_chanctx_fill_iter,
 						   &arg);
@@ -7151,6 +7152,7 @@ static u32 ath12k_get_phy_id(struct ath12k *ar, u32 band)
 static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 					   u32 supported_bands)
 {
+	struct ieee80211_hw *hw = ar->hw;
 	struct ieee80211_supported_band *band;
 	struct ath12k_wmi_hal_reg_capabilities_ext_arg *reg_cap;
 	void *channels;
@@ -7176,7 +7178,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 		band->channels = channels;
 		band->n_bitrates = ath12k_g_rates_size;
 		band->bitrates = ath12k_g_rates;
-		ar->hw->wiphy->bands[NL80211_BAND_2GHZ] = band;
+		hw->wiphy->bands[NL80211_BAND_2GHZ] = band;
 
 		if (ar->ab->hw_params->single_pdev_only) {
 			phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_2G_CAP);
@@ -7203,7 +7205,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 			band->channels = channels;
 			band->n_bitrates = ath12k_a_rates_size;
 			band->bitrates = ath12k_a_rates;
-			ar->hw->wiphy->bands[NL80211_BAND_6GHZ] = band;
+			hw->wiphy->bands[NL80211_BAND_6GHZ] = band;
 			ath12k_mac_update_ch_list(ar, band,
 						  reg_cap->low_5ghz_chan,
 						  reg_cap->high_5ghz_chan);
@@ -7225,7 +7227,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 			band->channels = channels;
 			band->n_bitrates = ath12k_a_rates_size;
 			band->bitrates = ath12k_a_rates;
-			ar->hw->wiphy->bands[NL80211_BAND_5GHZ] = band;
+			hw->wiphy->bands[NL80211_BAND_5GHZ] = band;
 
 			if (ar->ab->hw_params->single_pdev_only) {
 				phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_5G_CAP);
@@ -7244,6 +7246,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 static int ath12k_mac_setup_iface_combinations(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
+	struct ieee80211_hw *hw = ar->hw;
 	struct ieee80211_iface_combination *combinations;
 	struct ieee80211_iface_limit *limits;
 	int n_limits, max_interfaces;
@@ -7294,8 +7297,8 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k *ar)
 						BIT(NL80211_CHAN_WIDTH_40) |
 						BIT(NL80211_CHAN_WIDTH_80);
 
-	ar->hw->wiphy->iface_combinations = combinations;
-	ar->hw->wiphy->n_iface_combinations = 1;
+	hw->wiphy->iface_combinations = combinations;
+	hw->wiphy->n_iface_combinations = 1;
 
 	return 0;
 }
@@ -7339,9 +7342,11 @@ static const struct wiphy_iftype_ext_capab ath12k_iftypes_ext_capa[] = {
 
 static void __ath12k_mac_unregister(struct ath12k *ar)
 {
+	struct ieee80211_hw *hw = ar->hw;
+
 	cancel_work_sync(&ar->regd_update_work);
 
-	ieee80211_unregister_hw(ar->hw);
+	ieee80211_unregister_hw(hw);
 
 	idr_for_each(&ar->txmgmt_idr, ath12k_mac_tx_mgmt_pending_free, ar);
 	idr_destroy(&ar->txmgmt_idr);
@@ -7350,10 +7355,10 @@ static void __ath12k_mac_unregister(struct ath12k *ar)
 	kfree(ar->mac.sbands[NL80211_BAND_5GHZ].channels);
 	kfree(ar->mac.sbands[NL80211_BAND_6GHZ].channels);
 
-	kfree(ar->hw->wiphy->iface_combinations[0].limits);
-	kfree(ar->hw->wiphy->iface_combinations);
+	kfree(hw->wiphy->iface_combinations[0].limits);
+	kfree(hw->wiphy->iface_combinations);
 
-	SET_IEEE80211_DEV(ar->hw, NULL);
+	SET_IEEE80211_DEV(hw, NULL);
 }
 
 void ath12k_mac_unregister(struct ath12k_base *ab)
@@ -7375,6 +7380,7 @@ void ath12k_mac_unregister(struct ath12k_base *ab)
 static int __ath12k_mac_register(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
+	struct ieee80211_hw *hw = ar->hw;
 	struct ath12k_pdev_cap *cap = &ar->pdev->cap;
 	static const u32 cipher_suites[] = {
 		WLAN_CIPHER_SUITE_TKIP,
@@ -7392,9 +7398,9 @@ static int __ath12k_mac_register(struct ath12k *ar)
 
 	ath12k_pdev_caps_update(ar);
 
-	SET_IEEE80211_PERM_ADDR(ar->hw, ar->mac_addr);
+	SET_IEEE80211_PERM_ADDR(hw, ar->mac_addr);
 
-	SET_IEEE80211_DEV(ar->hw, ab->dev);
+	SET_IEEE80211_DEV(hw, ab->dev);
 
 	ret = ath12k_mac_setup_channels_rates(ar,
 					      cap->supported_bands);
@@ -7410,103 +7416,103 @@ static int __ath12k_mac_register(struct ath12k *ar)
 		goto err_free_channels;
 	}
 
-	ar->hw->wiphy->available_antennas_rx = cap->rx_chain_mask;
-	ar->hw->wiphy->available_antennas_tx = cap->tx_chain_mask;
+	hw->wiphy->available_antennas_rx = cap->rx_chain_mask;
+	hw->wiphy->available_antennas_tx = cap->tx_chain_mask;
 
-	ar->hw->wiphy->interface_modes = ab->hw_params->interface_modes;
+	hw->wiphy->interface_modes = ab->hw_params->interface_modes;
 
-	if (ar->hw->wiphy->bands[NL80211_BAND_2GHZ] &&
-	    ar->hw->wiphy->bands[NL80211_BAND_5GHZ] &&
-	    ar->hw->wiphy->bands[NL80211_BAND_6GHZ])
-		ieee80211_hw_set(ar->hw, SINGLE_SCAN_ON_ALL_BANDS);
+	if (hw->wiphy->bands[NL80211_BAND_2GHZ] &&
+	    hw->wiphy->bands[NL80211_BAND_5GHZ] &&
+	    hw->wiphy->bands[NL80211_BAND_6GHZ])
+		ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 
-	ieee80211_hw_set(ar->hw, SIGNAL_DBM);
-	ieee80211_hw_set(ar->hw, SUPPORTS_PS);
-	ieee80211_hw_set(ar->hw, SUPPORTS_DYNAMIC_PS);
-	ieee80211_hw_set(ar->hw, MFP_CAPABLE);
-	ieee80211_hw_set(ar->hw, REPORTS_TX_ACK_STATUS);
-	ieee80211_hw_set(ar->hw, HAS_RATE_CONTROL);
-	ieee80211_hw_set(ar->hw, AP_LINK_PS);
-	ieee80211_hw_set(ar->hw, SPECTRUM_MGMT);
-	ieee80211_hw_set(ar->hw, CONNECTION_MONITOR);
-	ieee80211_hw_set(ar->hw, SUPPORTS_PER_STA_GTK);
-	ieee80211_hw_set(ar->hw, CHANCTX_STA_CSA);
-	ieee80211_hw_set(ar->hw, QUEUE_CONTROL);
-	ieee80211_hw_set(ar->hw, SUPPORTS_TX_FRAG);
-	ieee80211_hw_set(ar->hw, REPORTS_LOW_ACK);
+	ieee80211_hw_set(hw, SIGNAL_DBM);
+	ieee80211_hw_set(hw, SUPPORTS_PS);
+	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
+	ieee80211_hw_set(hw, MFP_CAPABLE);
+	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
+	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+	ieee80211_hw_set(hw, AP_LINK_PS);
+	ieee80211_hw_set(hw, SPECTRUM_MGMT);
+	ieee80211_hw_set(hw, CONNECTION_MONITOR);
+	ieee80211_hw_set(hw, SUPPORTS_PER_STA_GTK);
+	ieee80211_hw_set(hw, CHANCTX_STA_CSA);
+	ieee80211_hw_set(hw, QUEUE_CONTROL);
+	ieee80211_hw_set(hw, SUPPORTS_TX_FRAG);
+	ieee80211_hw_set(hw, REPORTS_LOW_ACK);
 
 	if (ht_cap & WMI_HT_CAP_ENABLED) {
-		ieee80211_hw_set(ar->hw, AMPDU_AGGREGATION);
-		ieee80211_hw_set(ar->hw, TX_AMPDU_SETUP_IN_HW);
-		ieee80211_hw_set(ar->hw, SUPPORTS_REORDERING_BUFFER);
-		ieee80211_hw_set(ar->hw, SUPPORTS_AMSDU_IN_AMPDU);
-		ieee80211_hw_set(ar->hw, USES_RSS);
+		ieee80211_hw_set(hw, AMPDU_AGGREGATION);
+		ieee80211_hw_set(hw, TX_AMPDU_SETUP_IN_HW);
+		ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
+		ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
+		ieee80211_hw_set(hw, USES_RSS);
 	}
 
-	ar->hw->wiphy->features |= NL80211_FEATURE_STATIC_SMPS;
-	ar->hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
+	hw->wiphy->features |= NL80211_FEATURE_STATIC_SMPS;
+	hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
 
 	/* TODO: Check if HT capability advertised from firmware is different
 	 * for each band for a dual band capable radio. It will be tricky to
 	 * handle it when the ht capability different for each band.
 	 */
 	if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS)
-		ar->hw->wiphy->features |= NL80211_FEATURE_DYNAMIC_SMPS;
+		hw->wiphy->features |= NL80211_FEATURE_DYNAMIC_SMPS;
 
-	ar->hw->wiphy->max_scan_ssids = WLAN_SCAN_PARAMS_MAX_SSID;
-	ar->hw->wiphy->max_scan_ie_len = WLAN_SCAN_PARAMS_MAX_IE_LEN;
+	hw->wiphy->max_scan_ssids = WLAN_SCAN_PARAMS_MAX_SSID;
+	hw->wiphy->max_scan_ie_len = WLAN_SCAN_PARAMS_MAX_IE_LEN;
 
-	ar->hw->max_listen_interval = ATH12K_MAX_HW_LISTEN_INTERVAL;
+	hw->max_listen_interval = ATH12K_MAX_HW_LISTEN_INTERVAL;
 
-	ar->hw->wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
-	ar->hw->wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
-	ar->hw->wiphy->max_remain_on_channel_duration = 5000;
+	hw->wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
+	hw->wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+	hw->wiphy->max_remain_on_channel_duration = 5000;
 
-	ar->hw->wiphy->flags |= WIPHY_FLAG_AP_UAPSD;
-	ar->hw->wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
+	hw->wiphy->flags |= WIPHY_FLAG_AP_UAPSD;
+	hw->wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
 				   NL80211_FEATURE_AP_SCAN;
 
 	ar->max_num_stations = TARGET_NUM_STATIONS;
 	ar->max_num_peers = TARGET_NUM_PEERS_PDEV;
 
-	ar->hw->wiphy->max_ap_assoc_sta = ar->max_num_stations;
+	hw->wiphy->max_ap_assoc_sta = ar->max_num_stations;
 
-	ar->hw->queues = ATH12K_HW_MAX_QUEUES;
-	ar->hw->wiphy->tx_queue_len = ATH12K_QUEUE_LEN;
-	ar->hw->offchannel_tx_hw_queue = ATH12K_HW_MAX_QUEUES - 1;
-	ar->hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
+	hw->queues = ATH12K_HW_MAX_QUEUES;
+	hw->wiphy->tx_queue_len = ATH12K_QUEUE_LEN;
+	hw->offchannel_tx_hw_queue = ATH12K_HW_MAX_QUEUES - 1;
+	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 
-	ar->hw->vif_data_size = sizeof(struct ath12k_vif);
-	ar->hw->sta_data_size = sizeof(struct ath12k_sta);
+	hw->vif_data_size = sizeof(struct ath12k_vif);
+	hw->sta_data_size = sizeof(struct ath12k_sta);
 
-	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
-	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
 
-	ar->hw->wiphy->cipher_suites = cipher_suites;
-	ar->hw->wiphy->n_cipher_suites = ARRAY_SIZE(cipher_suites);
+	hw->wiphy->cipher_suites = cipher_suites;
+	hw->wiphy->n_cipher_suites = ARRAY_SIZE(cipher_suites);
 
-	ar->hw->wiphy->iftype_ext_capab = ath12k_iftypes_ext_capa;
-	ar->hw->wiphy->num_iftype_ext_capab =
+	hw->wiphy->iftype_ext_capab = ath12k_iftypes_ext_capa;
+	hw->wiphy->num_iftype_ext_capab =
 		ARRAY_SIZE(ath12k_iftypes_ext_capa);
 
 	if (ar->supports_6ghz) {
-		wiphy_ext_feature_set(ar->hw->wiphy,
+		wiphy_ext_feature_set(hw->wiphy,
 				      NL80211_EXT_FEATURE_FILS_DISCOVERY);
-		wiphy_ext_feature_set(ar->hw->wiphy,
+		wiphy_ext_feature_set(hw->wiphy,
 				      NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP);
 	}
 
-	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_PUNCT);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_PUNCT);
 
-	ath12k_reg_init(ar);
+	ath12k_reg_init(hw);
 
 	if (!test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags)) {
-		ar->hw->netdev_features = NETIF_F_HW_CSUM;
-		ieee80211_hw_set(ar->hw, SW_CRYPTO_CONTROL);
-		ieee80211_hw_set(ar->hw, SUPPORT_FAST_XMIT);
+		hw->netdev_features = NETIF_F_HW_CSUM;
+		ieee80211_hw_set(hw, SW_CRYPTO_CONTROL);
+		ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	}
 
-	ret = ieee80211_register_hw(ar->hw);
+	ret = ieee80211_register_hw(hw);
 	if (ret) {
 		ath12k_err(ar->ab, "ieee80211 registration failed: %d\n", ret);
 		goto err_free_if_combs;
@@ -7518,7 +7524,7 @@ static int __ath12k_mac_register(struct ath12k *ar)
 		 * while. But that time is so short and in practise it make
 		 * a difference in real life.
 		 */
-		ar->hw->wiphy->interface_modes &= ~BIT(NL80211_IFTYPE_MONITOR);
+		hw->wiphy->interface_modes &= ~BIT(NL80211_IFTYPE_MONITOR);
 
 	/* Apply the regd received during initialization */
 	ret = ath12k_regd_update(ar, true);
@@ -7530,11 +7536,11 @@ static int __ath12k_mac_register(struct ath12k *ar)
 	return 0;
 
 err_unregister_hw:
-	ieee80211_unregister_hw(ar->hw);
+	ieee80211_unregister_hw(hw);
 
 err_free_if_combs:
-	kfree(ar->hw->wiphy->iface_combinations[0].limits);
-	kfree(ar->hw->wiphy->iface_combinations);
+	kfree(hw->wiphy->iface_combinations[0].limits);
+	kfree(hw->wiphy->iface_combinations);
 
 err_free_channels:
 	kfree(ar->mac.sbands[NL80211_BAND_2GHZ].channels);
@@ -7542,7 +7548,7 @@ static int __ath12k_mac_register(struct ath12k *ar)
 	kfree(ar->mac.sbands[NL80211_BAND_6GHZ].channels);
 
 err:
-	SET_IEEE80211_DEV(ar->hw, NULL);
+	SET_IEEE80211_DEV(hw, NULL);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index b7fe4a6e7873..a31b9d9f3b48 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -199,6 +199,7 @@ static void ath12k_copy_regd(struct ieee80211_regdomain *regd_orig,
 
 int ath12k_regd_update(struct ath12k *ar, bool init)
 {
+	struct ieee80211_hw *hw = ar->hw;
 	struct ieee80211_regdomain *regd, *regd_copy = NULL;
 	int ret, regd_len, pdev_id;
 	struct ath12k_base *ab;
@@ -246,9 +247,9 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 	}
 
 	rtnl_lock();
-	wiphy_lock(ar->hw->wiphy);
-	ret = regulatory_set_wiphy_regd_sync(ar->hw->wiphy, regd_copy);
-	wiphy_unlock(ar->hw->wiphy);
+	wiphy_lock(hw->wiphy);
+	ret = regulatory_set_wiphy_regd_sync(hw->wiphy, regd_copy);
+	wiphy_unlock(hw->wiphy);
 	rtnl_unlock();
 
 	kfree(regd_copy);
@@ -729,10 +730,10 @@ void ath12k_regd_update_work(struct work_struct *work)
 	}
 }
 
-void ath12k_reg_init(struct ath12k *ar)
+void ath12k_reg_init(struct ieee80211_hw *hw)
 {
-	ar->hw->wiphy->regulatory_flags = REGULATORY_WIPHY_SELF_MANAGED;
-	ar->hw->wiphy->reg_notifier = ath12k_reg_notifier;
+	hw->wiphy->regulatory_flags = REGULATORY_WIPHY_SELF_MANAGED;
+	hw->wiphy->reg_notifier = ath12k_reg_notifier;
 }
 
 void ath12k_reg_free(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/reg.h b/drivers/net/wireless/ath/ath12k/reg.h
index 35569f03042d..cae59ffa1cd2 100644
--- a/drivers/net/wireless/ath/ath12k/reg.h
+++ b/drivers/net/wireless/ath/ath12k/reg.h
@@ -89,7 +89,7 @@ enum ath12k_reg_phy_bitmap {
 	ATH12K_REG_PHY_BITMAP_NO11BE	= BIT(6),
 };
 
-void ath12k_reg_init(struct ath12k *ar);
+void ath12k_reg_init(struct ieee80211_hw *hw);
 void ath12k_reg_free(struct ath12k_base *ab);
 void ath12k_regd_update_work(struct work_struct *work);
 struct ieee80211_regdomain *ath12k_reg_build_regd(struct ath12k_base *ab,
-- 
2.34.1

