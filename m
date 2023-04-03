Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C67D6D54F1
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 00:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjDCWwf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 18:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjDCWwX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 18:52:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D434218
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 15:52:08 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333GLJIv006465;
        Mon, 3 Apr 2023 22:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=fvY7uYZUMtSpb1HADo6uR1tVKsXVWjRJqWl221RYWNM=;
 b=UoGYGHrL6gbdP+CQryY1jhQnAGXwugcDFIFLl5+TCBK6CGKhneew5IbbS185ltU2+bFv
 yotitpJf/X7+yJBwgJ5sMip9bziWEOT53fkPlqgDALjx90gb6sAOe9Qdn9E0CCDIGO58
 uYx6Vv+C4pwjPDyfd2oCIR1k8ccbnBD0AnRlBMvxH1iFItfw2Dsolv2+KLYosJmF4GU3
 QfazTbw7cuvRjLeusFgWHqC4cZxYShVR5fsROLt762iUbARA8amXXt1UjR6DvB0WegaE
 D7nIcQPPr6wwFqw0naek4q9cn27QWqxSpfB8KjimUSDlYiVWvi2FjNrisWjnRD3011k2 JQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqusu1vv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 22:52:01 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333Mq0rY013041
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 22:52:00 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 3 Apr 2023 15:52:00 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v2 11/11] wifi: ath12k: configure puncturing bitmap
Date:   Mon, 3 Apr 2023 15:51:46 -0700
Message-ID: <20230403225146.14139-12-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230403225146.14139-1-quic_alokad@quicinc.com>
References: <20230403225146.14139-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gmOkUShUaU5jWerw6BmvCAhE1jDSfzVL
X-Proofpoint-ORIG-GUID: gmOkUShUaU5jWerw6BmvCAhE1jDSfzVL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_17,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030180
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable the feature flag to indicate the driver support for
preamble puncturing. Firmware will support this feature
by default from IEEE 802.11be onwards.
Configure the bitmap as part of VDEV start/restart and
peer association commands.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
v2: No change from v1.

 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 16 ++++++++++++++--
 drivers/net/wireless/ath/ath12k/wmi.c  |  2 ++
 drivers/net/wireless/ath/ath12k/wmi.h  | 12 +++++++++++-
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ed21dd78a2b9..e4287add2bcd 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -238,6 +238,7 @@ struct ath12k_vif {
 	u32 key_cipher;
 	u8 tx_encap_type;
 	u8 vdev_stats_id;
+	u32 punct_bitmap;
 };
 
 struct ath12k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 06abd7786eb8..865de31f2813 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -839,6 +839,7 @@ static int ath12k_mac_monitor_vdev_start(struct ath12k *ar, int vdev_id,
 
 	arg.pref_tx_streams = ar->num_tx_chains;
 	arg.pref_rx_streams = ar->num_rx_chains;
+	arg.punct_bitmap = 0xFFFFFFFF;
 
 	arg.passive |= !!(chandef->chan->flags & IEEE80211_CHAN_NO_IR);
 
@@ -2138,6 +2139,7 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 {
 	const struct ieee80211_sta_eht_cap *eht_cap = &sta->deflink.eht_cap;
 	const struct ieee80211_eht_mcs_nss_supp_bw *bw;
+	struct ath12k_vif *arvif = (struct ath12k_vif *)vif->drv_priv;
 	u32 *rx_mcs, *tx_mcs;
 
 	if (!sta->deflink.he_cap.has_he || !eht_cap->has_eht)
@@ -2202,6 +2204,8 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 		arg->peer_eht_mcs_count++;
 		break;
 	}
+
+	arg->punct_bitmap = ~arvif->punct_bitmap;
 }
 
 static void ath12k_peer_assoc_prepare(struct ath12k *ar,
@@ -2755,6 +2759,9 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 	    changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP)
 		ath12k_mac_fils_discovery(arvif, info);
 
+	if (changed & BSS_CHANGED_EHT_PUNCTURING)
+		arvif->punct_bitmap = info->eht_puncturing;
+
 	mutex_unlock(&ar->conf_mutex);
 }
 
@@ -5783,6 +5790,7 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 	arg.vdev_id = arvif->vdev_id;
 	arg.dtim_period = arvif->dtim_period;
 	arg.bcn_intval = arvif->beacon_interval;
+	arg.punct_bitmap = ~arvif->punct_bitmap;
 
 	arg.freq = chandef->chan->center_freq;
 	arg.band_center_freq1 = chandef->center_freq1;
@@ -5825,9 +5833,9 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 	arg.passive |= !!(chandef->chan->flags & IEEE80211_CHAN_NO_IR);
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
-		   "mac vdev %d start center_freq %d phymode %s\n",
+		   "mac vdev %d start center_freq %d phymode %s punct_bitmap 0x%x\n",
 		   arg.vdev_id, arg.freq,
-		   ath12k_mac_phymode_str(arg.mode));
+		   ath12k_mac_phymode_str(arg.mode), arg.punct_bitmap);
 
 	ret = ath12k_wmi_vdev_start(ar, &arg, restart);
 	if (ret) {
@@ -6154,6 +6162,8 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		   "mac chanctx assign ptr %pK vdev_id %i\n",
 		   ctx, arvif->vdev_id);
 
+	arvif->punct_bitmap = link_conf->eht_puncturing;
+
 	/* for some targets bss peer must be created before vdev_start */
 	if (ab->hw_params->vdev_start_delay &&
 	    arvif->vdev_type != WMI_VDEV_TYPE_AP &&
@@ -7254,6 +7264,8 @@ static int __ath12k_mac_register(struct ath12k *ar)
 				      NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP);
 	}
 
+	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_PUNCT);
+
 	ath12k_reg_init(ar);
 
 	if (!test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags)) {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 9634d90c559b..38c5f3984a0b 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1013,6 +1013,7 @@ int ath12k_wmi_vdev_start(struct ath12k *ar, struct wmi_vdev_start_req_arg *arg,
 	cmd->cac_duration_ms = cpu_to_le32(arg->cac_duration_ms);
 	cmd->regdomain = cpu_to_le32(arg->regdomain);
 	cmd->he_ops = cpu_to_le32(arg->he_ops);
+	cmd->punct_bitmap = cpu_to_le32(arg->punct_bitmap);
 
 	if (!restart) {
 		if (arg->ssid) {
@@ -1934,6 +1935,7 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 
 	cmd->peer_new_assoc = cpu_to_le32(arg->peer_new_assoc);
 	cmd->peer_associd = cpu_to_le32(arg->peer_associd);
+	cmd->punct_bitmap = cpu_to_le32(arg->punct_bitmap);
 
 	ath12k_wmi_copy_peer_flags(cmd, arg,
 				   test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index d457a087dc39..f791534f1f6f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2771,6 +2771,11 @@ struct wmi_vdev_start_request_cmd {
 	__le32 he_ops;
 	__le32 cac_duration_ms;
 	__le32 regdomain;
+	__le32 min_data_rate;
+	__le32 mbssid_flags;
+	__le32 mbssid_tx_vdev_id;
+	__le32 eht_ops;
+	__le32 punct_bitmap;
 } __packed;
 
 #define MGMT_TX_DL_FRM_LEN		     64
@@ -2870,6 +2875,10 @@ struct wmi_vdev_start_req_arg {
 	u32 pref_rx_streams;
 	u32 pref_tx_streams;
 	u32 num_noa_descriptors;
+	u32 min_data_rate;
+	u32 mbssid_flags;
+	u32 mbssid_tx_vdev_id;
+	u32 punct_bitmap;
 };
 
 struct ath12k_wmi_peer_create_arg {
@@ -3601,6 +3610,7 @@ struct ath12k_wmi_peer_assoc_arg {
 	u32 peer_eht_rx_mcs_set[WMI_MAX_EHTCAP_RATE_SET];
 	u32 peer_eht_tx_mcs_set[WMI_MAX_EHTCAP_RATE_SET];
 	struct ath12k_wmi_ppe_threshold_arg peer_eht_ppet;
+	u32 punct_bitmap;
 };
 
 struct wmi_peer_assoc_complete_cmd {
@@ -3636,7 +3646,7 @@ struct wmi_peer_assoc_complete_cmd {
 	__le32 bss_max_idle_option;
 	__le32 auth_mode;
 	__le32 peer_flags_ext;
-	__le32 puncture_20mhz_bitmap;
+	__le32 punct_bitmap;
 	__le32 peer_eht_cap_mac[WMI_MAX_EHTCAP_MAC_SIZE];
 	__le32 peer_eht_cap_phy[WMI_MAX_EHTCAP_PHY_SIZE];
 	__le32 peer_eht_ops;
-- 
2.39.0

