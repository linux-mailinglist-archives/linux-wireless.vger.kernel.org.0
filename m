Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362C6628A5A
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Nov 2022 21:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbiKNUTg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 15:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbiKNUT3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 15:19:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CC164D7
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 12:19:27 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEIlYiV022498;
        Mon, 14 Nov 2022 20:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=n1u8lgND2NspSqS7fclnxaoUJTXOalzz0ATvaki6NqE=;
 b=K5bR4eBuKziYVyNOfPAxbcoRvp+HYuxQo4t0Vwwn1l6PfF5xBxXOkP2GrmchPoXEdkWF
 BLXvFl2kBP2VnlnFjzoBQ9+SIGNM29ejNA73yCg6Ue8fcabh2PhUtVsYmkbJ7grG/Bpb
 iUhUZPrBuWfSCq48IKkt7g1As4hdJtF9fg7KDr+Dy90O4mMWVxj3uagZXMRGoX+FHeqG
 EXaMsagwdDidqLTzFm+RxQIA77gzZbPVY14rhhUkYI39KRST1GOOascckIqNTTURggbi
 4TjA5j6mkESTQVQDGf408X/keEYHqQW/JFNAifS/mhBMi4heFmkhGTN1o65omu+jImQT kQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kusm28jf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 20:19:24 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AEKJN53028462
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 20:19:23 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 14 Nov 2022 12:19:22 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 04/10] ath11k: MBSSID configuration during vdev create/start
Date:   Mon, 14 Nov 2022 12:19:06 -0800
Message-ID: <20221114201912.22893-5-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114201912.22893-1-quic_alokad@quicinc.com>
References: <20221114201912.22893-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cggih4_hnMrPUzys6efGFy1LuXb5GNIv
X-Proofpoint-GUID: cggih4_hnMrPUzys6efGFy1LuXb5GNIv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Configure multiple BSSID flags and index of the transmitting interface
in vdev create/start commands depending on the service bit
WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT.

Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-developed-by: John Crispin <john@phrozen.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
v2: Rebase only

drivers/net/wireless/ath/ath11k/mac.c | 70 +++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/wmi.c |  5 ++
 drivers/net/wireless/ath/ath11k/wmi.h | 22 +++++++++
 3 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 26616a7fc7e6..2b96205e996e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5977,17 +5977,62 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
 	atomic_set(&ar->num_pending_mgmt_tx, 0);
 }
 
-static void
-ath11k_mac_setup_vdev_create_params(struct ath11k_vif *arvif,
-				    struct vdev_create_params *params)
+static int ath11k_mac_setup_vdev_params_mbssid(struct ath11k_vif *arvif,
+					       u32 *flags, u32 *tx_vdev_id)
+{
+	struct ath11k *ar = arvif->ar;
+	struct ath11k_vif *tx_arvif;
+	struct ieee80211_vif *tx_vif;
+
+	*tx_vdev_id = 0;
+	tx_vif = arvif->vif->mbssid_tx_vif;
+	if (!tx_vif) {
+		*flags = WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP;
+		return 0;
+	}
+
+	tx_arvif = (void *)tx_vif->drv_priv;
+
+	if (arvif->vif->bss_conf.nontransmitted) {
+		if (ar->hw->wiphy != ieee80211_vif_to_wdev(tx_vif)->wiphy)
+			return -EINVAL;
+
+		*flags = WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP;
+		*tx_vdev_id = ath11k_vif_to_arvif(tx_vif)->vdev_id;
+	} else if (tx_arvif == arvif) {
+		*flags = WMI_HOST_VDEV_FLAGS_TRANSMIT_AP;
+	} else {
+		return -EINVAL;
+	}
+
+	if (arvif->vif->bss_conf.ema_ap)
+		*flags |= WMI_HOST_VDEV_FLAGS_EMA_MODE;
+
+	return 0;
+}
+
+static int ath11k_mac_setup_vdev_create_params(struct ath11k_vif *arvif,
+					       struct vdev_create_params *params)
 {
 	struct ath11k *ar = arvif->ar;
 	struct ath11k_pdev *pdev = ar->pdev;
+	int ret;
 
 	params->if_id = arvif->vdev_id;
 	params->type = arvif->vdev_type;
 	params->subtype = arvif->vdev_subtype;
 	params->pdev_id = pdev->pdev_id;
+	params->mbssid_flags = 0;
+	params->mbssid_tx_vdev_id = 0;
+
+	if (!test_bit(WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT,
+		      ar->ab->wmi_ab.svc_map)) {
+		ret = ath11k_mac_setup_vdev_params_mbssid(arvif,
+							  &params->mbssid_flags,
+							  &params->mbssid_tx_vdev_id);
+		if (ret)
+			return ret;
+	}
 
 	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP) {
 		params->chains[NL80211_BAND_2GHZ].tx = ar->num_tx_chains;
@@ -6002,6 +6047,7 @@ ath11k_mac_setup_vdev_create_params(struct ath11k_vif *arvif,
 		params->chains[NL80211_BAND_6GHZ].tx = ar->num_tx_chains;
 		params->chains[NL80211_BAND_6GHZ].rx = ar->num_rx_chains;
 	}
+	return 0;
 }
 
 static u32
@@ -6359,7 +6405,12 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	for (i = 0; i < ARRAY_SIZE(vif->hw_queue); i++)
 		vif->hw_queue[i] = i % (ATH11K_HW_MAX_QUEUES - 1);
 
-	ath11k_mac_setup_vdev_create_params(arvif, &vdev_param);
+	ret = ath11k_mac_setup_vdev_create_params(arvif, &vdev_param);
+	if (ret) {
+		ath11k_warn(ab, "failed to create vdev parameters %d: %d\n",
+			    arvif->vdev_id, ret);
+		goto err;
+	}
 
 	ret = ath11k_wmi_vdev_create(ar, vif->addr, &vdev_param);
 	if (ret) {
@@ -6760,6 +6811,17 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
 	arg.pref_tx_streams = ar->num_tx_chains;
 	arg.pref_rx_streams = ar->num_rx_chains;
 
+	arg.mbssid_flags = 0;
+	arg.mbssid_tx_vdev_id = 0;
+	if (test_bit(WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT,
+		     ar->ab->wmi_ab.svc_map)) {
+		ret = ath11k_mac_setup_vdev_params_mbssid(arvif,
+							  &arg.mbssid_flags,
+							  &arg.mbssid_tx_vdev_id);
+		if (ret)
+			return ret;
+	}
+
 	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
 		arg.ssid = arvif->u.ap.ssid;
 		arg.ssid_len = arvif->u.ap.ssid_len;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 97f6914354fd..6a1d9ad699e2 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -716,6 +716,9 @@ int ath11k_wmi_vdev_create(struct ath11k *ar, u8 *macaddr,
 	cmd->vdev_subtype = param->subtype;
 	cmd->num_cfg_txrx_streams = WMI_NUM_SUPPORTED_BAND_MAX;
 	cmd->pdev_id = param->pdev_id;
+	cmd->mbssid_flags = param->mbssid_flags;
+	cmd->mbssid_tx_vdev_id = param->mbssid_tx_vdev_id;
+
 	ether_addr_copy(cmd->vdev_macaddr.addr, macaddr);
 
 	ptr = skb->data + sizeof(*cmd);
@@ -932,6 +935,8 @@ int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 	cmd->cac_duration_ms = arg->cac_duration_ms;
 	cmd->regdomain = arg->regdomain;
 	cmd->he_ops = arg->he_ops;
+	cmd->mbssid_flags = arg->mbssid_flags;
+	cmd->mbssid_tx_vdev_id = arg->mbssid_tx_vdev_id;
 
 	if (!restart) {
 		if (arg->ssid) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 39e301b2cf8f..5d915adfe90c 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -137,6 +137,14 @@ enum {
 	WMI_AUTORATE_3200NS_GI = BIT(11),
 };
 
+enum {
+	WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP       = 0x00000001,
+	WMI_HOST_VDEV_FLAGS_TRANSMIT_AP         = 0x00000002,
+	WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP     = 0x00000004,
+	WMI_HOST_VDEV_FLAGS_EMA_MODE            = 0x00000008,
+	WMI_HOST_VDEV_FLAGS_SCAN_MODE_VAP       = 0x00000010,
+};
+
 /*
  * wmi command groups.
  */
@@ -2092,6 +2100,10 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_EXT2_MSG = 220,
 	WMI_TLV_SERVICE_PEER_POWER_SAVE_DURATION_SUPPORT = 246,
 	WMI_TLV_SERVICE_SRG_SRP_SPATIAL_REUSE_SUPPORT = 249,
+	WMI_TLV_REQUEST_CTRL_PATH_STATS_REQUEST = 250,
+	WMI_TLV_SERVICE_TPC_STATS_EVENT = 251,
+	WMI_TLV_SERVICE_NO_INTERBAND_MCC_SUPPORT = 252,
+	WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT = 253,
 
 	/* The second 128 bits */
 	WMI_MAX_EXT_SERVICE = 256,
@@ -2572,6 +2584,8 @@ struct vdev_create_params {
 		u8 rx;
 	} chains[NUM_NL80211_BANDS];
 	u32 pdev_id;
+	u32 mbssid_flags;
+	u32 mbssid_tx_vdev_id;
 };
 
 struct wmi_vdev_create_cmd {
@@ -2582,6 +2596,8 @@ struct wmi_vdev_create_cmd {
 	struct wmi_mac_addr vdev_macaddr;
 	u32 num_cfg_txrx_streams;
 	u32 pdev_id;
+	u32 mbssid_flags;
+	u32 mbssid_tx_vdev_id;
 } __packed;
 
 struct wmi_vdev_txrx_streams {
@@ -2645,6 +2661,9 @@ struct wmi_vdev_start_request_cmd {
 	u32 he_ops;
 	u32 cac_duration_ms;
 	u32 regdomain;
+	u32 min_data_rate;
+	u32 mbssid_flags;
+	u32 mbssid_tx_vdev_id;
 } __packed;
 
 #define MGMT_TX_DL_FRM_LEN		     64
@@ -2814,6 +2833,9 @@ struct wmi_vdev_start_req_arg {
 	u32 pref_rx_streams;
 	u32 pref_tx_streams;
 	u32 num_noa_descriptors;
+	u32 min_data_rate;
+	u32 mbssid_flags;
+	u32 mbssid_tx_vdev_id;
 };
 
 struct peer_create_params {
-- 
2.17.1

