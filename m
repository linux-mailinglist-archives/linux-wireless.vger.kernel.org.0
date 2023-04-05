Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8DB6D8A77
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 00:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjDEWRM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 18:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjDEWRK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 18:17:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A30A59F9
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 15:17:09 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335LgDiM018240;
        Wed, 5 Apr 2023 22:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=GCsIN/pLvG9ONEAB+vvixI0dlnTgQHK97Xstd04L36I=;
 b=TpeNqcNOzcqvS9qjWFm7Hsxn1IYkjCzbFUMxTHniptItm7rn+bcd6CzLHZSZ3aTXvXRM
 Gluh/m/z8TW58EneuETGdwdBBkx4GFuNjCI50/m9vLJEa/9snKPlfY5RQY/O+iWXDhvJ
 /EEHDwF9tLpwULVGq809q6QH7gGP2owyhqp95MgcaFg4g5N5pAmRl7E4OF8yJkOc8i+U
 SkDmeb0bZLFoY4RjSoowBi0H6CGmzxcjz+UKvSCxQOn9yGr2KAbv9eLj+4WxT86o6LHt
 agfKf5xTFbBqh8Pz1gTECrJhPdcocGQyj9mInF85ownQZz7ByV6uYxY88TgKDPfv3Ku2 VQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3psf2w88yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 22:16:58 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 335MGv88002029
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 22:16:57 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 15:16:57 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 2/7] wifi: ath11k: MBSSID configuration during vdev create/start
Date:   Wed, 5 Apr 2023 15:16:43 -0700
Message-ID: <20230405221648.17950-3-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230405221648.17950-1-quic_alokad@quicinc.com>
References: <20230405221648.17950-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zKjmFTsPSIkhBW7Iz70Ajkh_dW0BkuDU
X-Proofpoint-GUID: zKjmFTsPSIkhBW7Iz70Ajkh_dW0BkuDU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_15,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050199
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
v3: Rebased patch 04/10 from v2.
v2: Rebase only.

 drivers/net/wireless/ath/ath11k/mac.c | 70 +++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/wmi.c |  5 ++
 drivers/net/wireless/ath/ath11k/wmi.h | 19 ++++++++
 3 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index d95c1e7ac83d..8c852bf6294f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6152,17 +6152,62 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
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
@@ -6177,6 +6222,7 @@ ath11k_mac_setup_vdev_create_params(struct ath11k_vif *arvif,
 		params->chains[NL80211_BAND_6GHZ].tx = ar->num_tx_chains;
 		params->chains[NL80211_BAND_6GHZ].rx = ar->num_rx_chains;
 	}
+	return 0;
 }
 
 static void ath11k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
@@ -6471,7 +6517,12 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
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
@@ -6871,6 +6922,17 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
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
index 39b362f6a374..362e2e95d8a6 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -718,6 +718,9 @@ int ath11k_wmi_vdev_create(struct ath11k *ar, u8 *macaddr,
 	cmd->vdev_subtype = param->subtype;
 	cmd->num_cfg_txrx_streams = WMI_NUM_SUPPORTED_BAND_MAX;
 	cmd->pdev_id = param->pdev_id;
+	cmd->mbssid_flags = param->mbssid_flags;
+	cmd->mbssid_tx_vdev_id = param->mbssid_tx_vdev_id;
+
 	ether_addr_copy(cmd->vdev_macaddr.addr, macaddr);
 
 	ptr = skb->data + sizeof(*cmd);
@@ -934,6 +937,8 @@ int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 	cmd->cac_duration_ms = arg->cac_duration_ms;
 	cmd->regdomain = arg->regdomain;
 	cmd->he_ops = arg->he_ops;
+	cmd->mbssid_flags = arg->mbssid_flags;
+	cmd->mbssid_tx_vdev_id = arg->mbssid_tx_vdev_id;
 
 	if (!restart) {
 		if (arg->ssid) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index b8671f88405c..b4940c1de9e8 100644
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
@@ -2096,6 +2104,7 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_EXT2_MSG = 220,
 	WMI_TLV_SERVICE_PEER_POWER_SAVE_DURATION_SUPPORT = 246,
 	WMI_TLV_SERVICE_SRG_SRP_SPATIAL_REUSE_SUPPORT = 249,
+	WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT = 253,
 	WMI_TLV_SERVICE_PASSIVE_SCAN_START_TIME_ENHANCE = 263,
 
 	/* The second 128 bits */
@@ -2581,6 +2590,8 @@ struct vdev_create_params {
 		u8 rx;
 	} chains[NUM_NL80211_BANDS];
 	u32 pdev_id;
+	u32 mbssid_flags;
+	u32 mbssid_tx_vdev_id;
 };
 
 struct wmi_vdev_create_cmd {
@@ -2591,6 +2602,8 @@ struct wmi_vdev_create_cmd {
 	struct wmi_mac_addr vdev_macaddr;
 	u32 num_cfg_txrx_streams;
 	u32 pdev_id;
+	u32 mbssid_flags;
+	u32 mbssid_tx_vdev_id;
 } __packed;
 
 struct wmi_vdev_txrx_streams {
@@ -2654,6 +2667,9 @@ struct wmi_vdev_start_request_cmd {
 	u32 he_ops;
 	u32 cac_duration_ms;
 	u32 regdomain;
+	u32 min_data_rate;
+	u32 mbssid_flags;
+	u32 mbssid_tx_vdev_id;
 } __packed;
 
 #define MGMT_TX_DL_FRM_LEN		     64
@@ -2823,6 +2839,9 @@ struct wmi_vdev_start_req_arg {
 	u32 pref_rx_streams;
 	u32 pref_tx_streams;
 	u32 num_noa_descriptors;
+	u32 min_data_rate;
+	u32 mbssid_flags;
+	u32 mbssid_tx_vdev_id;
 };
 
 struct peer_create_params {
-- 
2.39.0

