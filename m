Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860C05FCABC
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 20:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJLShH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 14:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJLShG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 14:37:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7F672ECB
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 11:37:05 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CGmEPQ018231;
        Wed, 12 Oct 2022 18:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=kosP5MDyAvjqY3PTX4MOZg0Kig8hGlM75Knvd5W0x5E=;
 b=E22zc3iIwOjYlEjbX32t7EuSvb0aHwetI/hXabca48JeNiS3ZWcSwj1i7oO/WAl40WT6
 WBjHXs8bVPeAg7cyCIQKEgTqCMuzwhKix4v/dzpxasE9Ce7hfUNIQUyfa+uaKqD2ckYU
 FZaQm15XYoxdI9fdHHeonIR8H0hQRD/TFl964ROt+4e0bArR/SP9TbOcHeFRRSg5lH6m
 Gca2f4jk8mcuHLWaY5EXk+b6krfb4o+OFAw74EYUA5qoQzV1hL83h+UIgcGMVfsER7W0
 zGDbwwoNHdWieJQIOaqdiYue7tAF16g5Nk8FQkdFgBF5XVm6p5LCtaEvIBj9cE5KR0O8 XA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5eg4be8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 18:36:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29CIavvq021380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 18:36:57 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 12 Oct 2022 11:36:56 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Anilkumar Kolli <quic_akolli@quicinc.com>
Subject: [PATCH 2/4] wifi: ath11k: push MU-MIMO params from hostapd to hardware
Date:   Wed, 12 Oct 2022 11:36:45 -0700
Message-ID: <1665599807-12908-3-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1665599807-12908-1-git-send-email-quic_msinada@quicinc.com>
References: <1665599807-12908-1-git-send-email-quic_msinada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LDrlHN9eQgPFR0QXbPFRhhSI9zO62CFz
X-Proofpoint-ORIG-GUID: LDrlHN9eQgPFR0QXbPFRhhSI9zO62CFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_09,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120120
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the previous behaviour only HE IE in management frames are changed
regarding MU-MIMO configurations and not in hardware. Adding push of
MU-MIMO configurations to the hardware as well.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00356-QCAHKSWPL_SILICONZ-1

Co-developed-by: Anilkumar Kolli <quic_akolli@quicinc.com>
Signed-off-by: Anilkumar Kolli <quic_akolli@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 199 +++++++++++++++++++++-------------
 drivers/net/wireless/ath/ath11k/wmi.h |   3 +
 2 files changed, 129 insertions(+), 73 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ce15693c1804..3a2f3ffe253b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2697,6 +2697,117 @@ static int ath11k_setup_peer_smps(struct ath11k *ar, struct ath11k_vif *arvif,
 					 ath11k_smps_map[smps]);
 }
 
+static bool ath11k_mac_set_he_txbf_conf(struct ath11k_vif *arvif)
+{
+	struct ath11k *ar = arvif->ar;
+	u32 param, value;
+	int ret;
+
+	if (!arvif->vif->bss_conf.he_support)
+		return true;
+
+	param = WMI_VDEV_PARAM_SET_HEMU_MODE;
+	value = 0;
+	if (arvif->vif->bss_conf.he_su_beamformer) {
+		value |= FIELD_PREP(HE_MODE_SU_TX_BFER, HE_SU_BFER_ENABLE);
+		if (arvif->vif->bss_conf.he_mu_beamformer &&
+		    arvif->vdev_type == WMI_VDEV_TYPE_AP)
+			value |= FIELD_PREP(HE_MODE_MU_TX_BFER, HE_MU_BFER_ENABLE);
+	}
+
+	if (arvif->vif->type != NL80211_IFTYPE_MESH_POINT) {
+		value |= FIELD_PREP(HE_MODE_DL_OFDMA, HE_DL_MUOFDMA_ENABLE) |
+			 FIELD_PREP(HE_MODE_UL_OFDMA, HE_UL_MUOFDMA_ENABLE);
+
+		if (arvif->vif->bss_conf.he_full_ul_mumimo)
+			value |= FIELD_PREP(HE_MODE_UL_MUMIMO, HE_UL_MUMIMO_ENABLE);
+
+		if (arvif->vif->bss_conf.he_su_beamformee)
+			value |= FIELD_PREP(HE_MODE_SU_TX_BFEE, HE_SU_BFEE_ENABLE);
+	}
+
+	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id, param, value);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to set vdev %d HE MU mode: %d\n",
+			    arvif->vdev_id, ret);
+		return false;
+	}
+
+	param = WMI_VDEV_PARAM_SET_HE_SOUNDING_MODE;
+	value =	FIELD_PREP(HE_VHT_SOUNDING_MODE, HE_VHT_SOUNDING_MODE_ENABLE) |
+		FIELD_PREP(HE_TRIG_NONTRIG_SOUNDING_MODE,
+			   HE_TRIG_NONTRIG_SOUNDING_MODE_ENABLE);
+	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+					    param, value);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to set vdev %d sounding mode: %d\n",
+			    arvif->vdev_id, ret);
+		return false;
+	}
+	return true;
+}
+
+static bool ath11k_mac_vif_recalc_sta_he_txbf(struct ath11k *ar,
+					      struct ieee80211_vif *vif,
+					      struct ieee80211_sta_he_cap *he_cap)
+{
+	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ieee80211_he_cap_elem he_cap_elem = {0};
+	struct ieee80211_sta_he_cap *cap_band = NULL;
+	struct cfg80211_chan_def def;
+	u32 param = WMI_VDEV_PARAM_SET_HEMU_MODE;
+	u32 hemode = 0;
+	int ret;
+
+	if (!vif->bss_conf.he_support)
+		return true;
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return false;
+
+	if (WARN_ON(ath11k_mac_vif_chan(vif, &def)))
+		return false;
+
+	if (def.chan->band == NL80211_BAND_2GHZ)
+		cap_band = &ar->mac.iftype[NL80211_BAND_2GHZ][vif->type].he_cap;
+	else
+		cap_band = &ar->mac.iftype[NL80211_BAND_5GHZ][vif->type].he_cap;
+
+	memcpy(&he_cap_elem, &cap_band->he_cap_elem, sizeof(he_cap_elem));
+
+	if (HECAP_PHY_SUBFME_GET(he_cap_elem.phy_cap_info)) {
+		if (HECAP_PHY_SUBFMR_GET(he_cap->he_cap_elem.phy_cap_info))
+			hemode |= FIELD_PREP(HE_MODE_SU_TX_BFEE, HE_SU_BFEE_ENABLE);
+		if (HECAP_PHY_MUBFMR_GET(he_cap->he_cap_elem.phy_cap_info))
+			hemode |= FIELD_PREP(HE_MODE_MU_TX_BFEE, HE_MU_BFEE_ENABLE);
+	}
+
+	if (vif->type != NL80211_IFTYPE_MESH_POINT) {
+		hemode |= FIELD_PREP(HE_MODE_DL_OFDMA, HE_DL_MUOFDMA_ENABLE) |
+			  FIELD_PREP(HE_MODE_UL_OFDMA, HE_UL_MUOFDMA_ENABLE);
+
+		if (HECAP_PHY_ULMUMIMO_GET(he_cap_elem.phy_cap_info))
+			if (HECAP_PHY_ULMUMIMO_GET(he_cap->he_cap_elem.phy_cap_info))
+				hemode |= FIELD_PREP(HE_MODE_UL_MUMIMO,
+						     HE_UL_MUMIMO_ENABLE);
+
+		if (FIELD_GET(HE_MODE_MU_TX_BFEE, hemode))
+			hemode |= FIELD_PREP(HE_MODE_SU_TX_BFEE, HE_SU_BFEE_ENABLE);
+
+		if (FIELD_GET(HE_MODE_MU_TX_BFER, hemode))
+			hemode |= FIELD_PREP(HE_MODE_SU_TX_BFER, HE_SU_BFER_ENABLE);
+	}
+
+	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id, param, hemode);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to submit vdev param txbf 0x%x: %d\n",
+			    hemode, ret);
+		return false;
+	}
+
+	return true;
+}
+
 static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
 			     struct ieee80211_bss_conf *bss_conf)
@@ -2707,6 +2818,7 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	struct ieee80211_sta *ap_sta;
 	struct ath11k_peer *peer;
 	bool is_auth = false;
+	struct ieee80211_sta_he_cap  he_cap;
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -2723,6 +2835,8 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 		rcu_read_unlock();
 		return;
 	}
+	/* he_cap here is updated at assoc success for sta mode only */
+	he_cap  = ap_sta->deflink.he_cap;
 
 	ath11k_peer_assoc_prepare(ar, vif, ap_sta, &peer_arg, false);
 
@@ -2751,6 +2865,12 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 		return;
 	}
 
+	if (!ath11k_mac_vif_recalc_sta_he_txbf(ar, vif, &he_cap)) {
+		ath11k_warn(ar->ab, "failed to recalc he txbf for vdev %i on bss %pM\n",
+			    arvif->vdev_id, bss_conf->bssid);
+		return;
+	}
+
 	WARN_ON(arvif->is_up);
 
 	arvif->aid = vif->cfg.aid;
@@ -3200,6 +3320,8 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		ether_addr_copy(arvif->bssid, info->bssid);
 
 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
+		if (info->enable_beacon)
+			ath11k_mac_set_he_txbf_conf(arvif);
 		ath11k_control_beaconing(arvif, info);
 
 		if (arvif->is_up && vif->bss_conf.he_support &&
@@ -5369,6 +5491,10 @@ static int ath11k_mac_copy_he_cap(struct ath11k *ar,
 
 		he_cap_elem->mac_cap_info[1] &=
 			IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_MASK;
+		he_cap_elem->phy_cap_info[0] &=
+			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+		he_cap_elem->phy_cap_info[0] &=
+			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
 
 		he_cap_elem->phy_cap_info[5] &=
 			~IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK;
@@ -6003,69 +6129,6 @@ ath11k_mac_setup_vdev_create_params(struct ath11k_vif *arvif,
 	}
 }
 
-static u32
-ath11k_mac_prepare_he_mode(struct ath11k_pdev *pdev, u32 viftype)
-{
-	struct ath11k_pdev_cap *pdev_cap = &pdev->cap;
-	struct ath11k_band_cap *cap_band = NULL;
-	u32 *hecap_phy_ptr = NULL;
-	u32 hemode = 0;
-
-	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP)
-		cap_band = &pdev_cap->band[NL80211_BAND_2GHZ];
-	else
-		cap_band = &pdev_cap->band[NL80211_BAND_5GHZ];
-
-	hecap_phy_ptr = &cap_band->he_cap_phy_info[0];
-
-	hemode = FIELD_PREP(HE_MODE_SU_TX_BFEE, HE_SU_BFEE_ENABLE) |
-		 FIELD_PREP(HE_MODE_SU_TX_BFER, HECAP_PHY_SUBFMR_GET(hecap_phy_ptr)) |
-		 FIELD_PREP(HE_MODE_UL_MUMIMO, HECAP_PHY_ULMUMIMO_GET(hecap_phy_ptr));
-
-	/* TODO WDS and other modes */
-	if (viftype == NL80211_IFTYPE_AP) {
-		hemode |= FIELD_PREP(HE_MODE_MU_TX_BFER,
-			  HECAP_PHY_MUBFMR_GET(hecap_phy_ptr)) |
-			  FIELD_PREP(HE_MODE_DL_OFDMA, HE_DL_MUOFDMA_ENABLE) |
-			  FIELD_PREP(HE_MODE_UL_OFDMA, HE_UL_MUOFDMA_ENABLE);
-	} else {
-		hemode |= FIELD_PREP(HE_MODE_MU_TX_BFEE, HE_MU_BFEE_ENABLE);
-	}
-
-	return hemode;
-}
-
-static int ath11k_set_he_mu_sounding_mode(struct ath11k *ar,
-					  struct ath11k_vif *arvif)
-{
-	u32 param_id, param_value;
-	struct ath11k_base *ab = ar->ab;
-	int ret = 0;
-
-	param_id = WMI_VDEV_PARAM_SET_HEMU_MODE;
-	param_value = ath11k_mac_prepare_he_mode(ar->pdev, arvif->vif->type);
-	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-					    param_id, param_value);
-	if (ret) {
-		ath11k_warn(ab, "failed to set vdev %d HE MU mode: %d param_value %x\n",
-			    arvif->vdev_id, ret, param_value);
-		return ret;
-	}
-	param_id = WMI_VDEV_PARAM_SET_HE_SOUNDING_MODE;
-	param_value =
-		FIELD_PREP(HE_VHT_SOUNDING_MODE, HE_VHT_SOUNDING_MODE_ENABLE) |
-		FIELD_PREP(HE_TRIG_NONTRIG_SOUNDING_MODE,
-			   HE_TRIG_NONTRIG_SOUNDING_MODE_ENABLE);
-	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-					    param_id, param_value);
-	if (ret) {
-		ath11k_warn(ab, "failed to set vdev %d HE MU mode: %d\n",
-			    arvif->vdev_id, ret);
-		return ret;
-	}
-	return ret;
-}
-
 static void ath11k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
 					     struct ieee80211_vif *vif)
 {
@@ -6720,7 +6783,6 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
 	struct ath11k_base *ab = ar->ab;
 	struct wmi_vdev_start_req_arg arg = {};
 	const struct cfg80211_chan_def *chandef = &ctx->def;
-	int he_support = arvif->vif->bss_conf.he_support;
 	int ret = 0;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -6761,15 +6823,6 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
 		spin_lock_bh(&ab->base_lock);
 		arg.regdomain = ar->ab->dfs_region;
 		spin_unlock_bh(&ab->base_lock);
-
-		if (he_support) {
-			ret = ath11k_set_he_mu_sounding_mode(ar, arvif);
-			if (ret) {
-				ath11k_warn(ar->ab, "failed to set he mode vdev %i\n",
-					    arg.vdev_id);
-				return ret;
-			}
-		}
 	}
 
 	arg.channel.passive |= !!(chandef->chan->flags & IEEE80211_CHAN_NO_IR);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 368b7755e800..7e1eea784eb5 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2895,8 +2895,11 @@ struct rx_reorder_queue_remove_params {
 #define HE_DL_MUOFDMA_ENABLE	1
 #define HE_UL_MUOFDMA_ENABLE	1
 #define HE_DL_MUMIMO_ENABLE	1
+#define HE_UL_MUMIMO_ENABLE	1
 #define HE_MU_BFEE_ENABLE	1
 #define HE_SU_BFEE_ENABLE	1
+#define HE_MU_BFER_ENABLE	1
+#define HE_SU_BFER_ENABLE	1
 
 #define HE_VHT_SOUNDING_MODE_ENABLE		1
 #define HE_SU_MU_SOUNDING_MODE_ENABLE		1
-- 
2.7.4

