Return-Path: <linux-wireless+bounces-6785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36F68B146A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 22:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040AE1C213FA
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 20:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA0313DB99;
	Wed, 24 Apr 2024 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="avFZR0U0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94452757EA
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990018; cv=none; b=eycTofvNCd/LunRuerQ964esViIhuz6y0KDl6S6sz0g9hg9SDTEPDN1e6nTnJ9rv6WJMy9UrvTE4TGNVbGsVOIC9xqB5qZDYmPkL024sceM2YVHDAVHVFiu4X5DtthS0eP76OWGu79AqxiNZv2sPaUnBZyb6NuIq0NF12QuVAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990018; c=relaxed/simple;
	bh=zzmUT/OGKdPisTITUpPZ4cXGepRXz9+1JQsU9DOkf1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlqGNusuibJlBiTcyC/erJA0IOMNXwDb+PEReZNtL0wRyY5OOLhoRAUlg+OPrtMDBssMkP86q29yG7+xLSaGGpK1GK7iWFOpSA4joOmOFn2FJRCOvsyqi0DJaYMGZJ44g8zsB15oO+0sf9r9NdwqvINvNzqMANfQQmzmS6F0abs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=avFZR0U0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OInijJ022241;
	Wed, 24 Apr 2024 20:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=blpPv3z/iOwQxQXwAdaP
	rXC9HejWmTefNKRk7RCUyw4=; b=avFZR0U0PY+bREV6oBQArFcZrdkG9eGmj980
	DJuO+fN1XCCpenlPeen4Rh7t76zvTfURptCnDNUEM6RIr7C9hSF0R4IbdgRq3Zm0
	85PCSSfwxXRL8eIu0I8YEPlhYR5Liugj1/3GKRo3XM0efLPw/kLpyKB98j1jjVbE
	EfRpwbw2CvAomFyzRmXNbSzrJzfnVUDaZgNyNSbOWmAZg1leyrCmc7u8e4si/hH1
	bZNBtfIRBiJweHvjpCqKMMKgWwepeKTodOCrvVVwBc2ZWKtuJUOS26vn5pjO+7UO
	xVkA/EeRFEJFgcADzxx0S4B6U/gJ6YqNle2mw8GvkEpoFTR+rQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9gj278-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 20:20:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OKKAH8002685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 20:20:10 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 13:20:10 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v3 02/10] wifi: ath12k: push HE MU-MIMO params from hostapd to hardware
Date: Wed, 24 Apr 2024 13:19:51 -0700
Message-ID: <20240424201959.935-3-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240424201959.935-1-quic_pradeepc@quicinc.com>
References: <20240424201959.935-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-ORIG-GUID: tjxIk-T3sbAStUnGRCKX1sUZowTDpB0_
X-Proofpoint-GUID: tjxIk-T3sbAStUnGRCKX1sUZowTDpB0_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_17,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240101

Currently, only the HE IE in management frames is updated with
respect to MU-MIMO configurations, but this change is not
reflected in the hardware. Add support to propagate MU-MIMO
configurations to the hardware as well.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 214 +++++++++++++++++---------
 drivers/net/wireless/ath/ath12k/mac.h |  15 ++
 drivers/net/wireless/ath/ath12k/wmi.h |  28 +---
 3 files changed, 155 insertions(+), 102 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 56b1f8b6844e..2bcc0e12a54f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2528,15 +2528,119 @@ static int ath12k_setup_peer_smps(struct ath12k *ar, struct ath12k_vif *arvif,
 					 ath12k_smps_map[smps]);
 }
 
+static int ath12k_mac_set_he_txbf_conf(struct ath12k_vif *arvif)
+{
+	struct ath12k *ar = arvif->ar;
+	u32 param = WMI_VDEV_PARAM_SET_HEMU_MODE;
+	u32 value = 0;
+	int ret;
+
+	if (!arvif->vif->bss_conf.he_support)
+		return 0;
+
+	if (arvif->vif->bss_conf.he_su_beamformer) {
+		value |= u32_encode_bits(HE_SU_BFER_ENABLE, HE_MODE_SU_TX_BFER);
+		if (arvif->vif->bss_conf.he_mu_beamformer &&
+		    arvif->vdev_type == WMI_VDEV_TYPE_AP)
+			value |= u32_encode_bits(HE_MU_BFER_ENABLE, HE_MODE_MU_TX_BFER);
+	}
+
+	if (arvif->vif->type != NL80211_IFTYPE_MESH_POINT) {
+		value |= u32_encode_bits(HE_DL_MUOFDMA_ENABLE, HE_MODE_DL_OFDMA) |
+			 u32_encode_bits(HE_UL_MUOFDMA_ENABLE, HE_MODE_UL_OFDMA);
+
+		if (arvif->vif->bss_conf.he_full_ul_mumimo)
+			value |= u32_encode_bits(HE_UL_MUMIMO_ENABLE, HE_MODE_UL_MUMIMO);
+
+		if (arvif->vif->bss_conf.he_su_beamformee)
+			value |= u32_encode_bits(HE_SU_BFEE_ENABLE, HE_MODE_SU_TX_BFEE);
+	}
+
+	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id, param, value);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to set vdev %d HE MU mode: %d\n",
+			    arvif->vdev_id, ret);
+		return ret;
+	}
+
+	param = WMI_VDEV_PARAM_SET_HE_SOUNDING_MODE;
+	value =	u32_encode_bits(HE_VHT_SOUNDING_MODE_ENABLE, HE_VHT_SOUNDING_MODE) |
+		u32_encode_bits(HE_TRIG_NONTRIG_SOUNDING_MODE_ENABLE,
+				HE_TRIG_NONTRIG_SOUNDING_MODE);
+	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+					    param, value);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to set vdev %d sounding mode: %d\n",
+			    arvif->vdev_id, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ath12k_mac_vif_recalc_sta_he_txbf(struct ath12k *ar,
+					     struct ieee80211_vif *vif,
+					     struct ieee80211_sta_he_cap *he_cap,
+					     int *hemode)
+{
+	struct ieee80211_he_cap_elem he_cap_elem = {};
+	struct ieee80211_sta_he_cap *cap_band;
+	struct cfg80211_chan_def def;
+
+	if (!vif->bss_conf.he_support)
+		return 0;
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return -EINVAL;
+
+	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
+		return -EINVAL;
+
+	if (def.chan->band == NL80211_BAND_2GHZ)
+		cap_band = &ar->mac.iftype[NL80211_BAND_2GHZ][vif->type].he_cap;
+	else
+		cap_band = &ar->mac.iftype[NL80211_BAND_5GHZ][vif->type].he_cap;
+
+	memcpy(&he_cap_elem, &cap_band->he_cap_elem, sizeof(he_cap_elem));
+
+	*hemode = 0;
+	if (HECAP_PHY_SUBFME_GET(he_cap_elem.phy_cap_info)) {
+		if (HECAP_PHY_SUBFMR_GET(he_cap->he_cap_elem.phy_cap_info))
+			*hemode |= u32_encode_bits(HE_SU_BFEE_ENABLE, HE_MODE_SU_TX_BFEE);
+		if (HECAP_PHY_MUBFMR_GET(he_cap->he_cap_elem.phy_cap_info))
+			*hemode |= u32_encode_bits(HE_MU_BFEE_ENABLE, HE_MODE_MU_TX_BFEE);
+	}
+
+	if (vif->type != NL80211_IFTYPE_MESH_POINT) {
+		*hemode |= u32_encode_bits(HE_DL_MUOFDMA_ENABLE, HE_MODE_DL_OFDMA) |
+			  u32_encode_bits(HE_UL_MUOFDMA_ENABLE, HE_MODE_UL_OFDMA);
+
+		if (HECAP_PHY_ULMUMIMO_GET(he_cap_elem.phy_cap_info))
+			if (HECAP_PHY_ULMUMIMO_GET(he_cap->he_cap_elem.phy_cap_info))
+				*hemode |= u32_encode_bits(HE_UL_MUMIMO_ENABLE,
+							  HE_MODE_UL_MUMIMO);
+
+		if (u32_get_bits(*hemode, HE_MODE_MU_TX_BFEE))
+			*hemode |= u32_encode_bits(HE_SU_BFEE_ENABLE, HE_MODE_SU_TX_BFEE);
+
+		if (u32_get_bits(*hemode, HE_MODE_MU_TX_BFER))
+			*hemode |= u32_encode_bits(HE_SU_BFER_ENABLE, HE_MODE_SU_TX_BFER);
+	}
+
+	return 0;
+}
+
 static void ath12k_bss_assoc(struct ath12k *ar,
 			     struct ath12k_vif *arvif,
 			     struct ieee80211_bss_conf *bss_conf)
 {
 	struct ieee80211_vif *vif = arvif->vif;
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
+	struct ieee80211_sta_he_cap he_cap;
 	struct ieee80211_sta *ap_sta;
 	struct ath12k_peer *peer;
 	bool is_auth = false;
+	u32 hemode = 0;
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -2556,8 +2660,28 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 
 	ath12k_peer_assoc_prepare(ar, vif, ap_sta, &peer_arg, false);
 
+	/* he_cap here is updated at assoc success for sta mode only */
+	he_cap = ap_sta->deflink.he_cap;
+
+	/* ap_sta->deflink.he_cap must be protected by rcu_read_lock */
+	ret = ath12k_mac_vif_recalc_sta_he_txbf(ar, vif, &he_cap, &hemode);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to recalc he txbf for vdev %i on bss %pM: %d\n",
+			    arvif->vdev_id, bss_conf->bssid, ret);
+		return;
+	}
+
 	rcu_read_unlock();
 
+	/* keep this before ath12k_wmi_send_peer_assoc_cmd() */
+	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+					    WMI_VDEV_PARAM_SET_HEMU_MODE, hemode);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to submit vdev param txbf 0x%x: %d\n",
+			    hemode, ret);
+		return;
+	}
+
 	ret = ath12k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to run peer assoc for %pM vdev %i: %d\n",
@@ -2884,6 +3008,13 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 		ether_addr_copy(arvif->bssid, info->bssid);
 
 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
+		if (info->enable_beacon) {
+			ret = ath12k_mac_set_he_txbf_conf(arvif);
+			if (ret)
+				ath12k_warn(ar->ab,
+					    "failed to set HE TXBF config for vdev: %d\n",
+					    arvif->vdev_id);
+		}
 		ath12k_control_beaconing(arvif, info);
 
 		if (arvif->is_up && vif->bss_conf.he_support &&
@@ -4995,11 +5126,14 @@ static void ath12k_mac_copy_he_cap(struct ath12k_band_cap *band_cap,
 
 	he_cap_elem->mac_cap_info[1] &=
 		IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_MASK;
-
+	he_cap_elem->phy_cap_info[0] &=
+		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
+		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+	he_cap_elem->phy_cap_info[0] &=
+		~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
 	he_cap_elem->phy_cap_info[5] &=
 		~IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK;
-	he_cap_elem->phy_cap_info[5] &=
-		~IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK;
 	he_cap_elem->phy_cap_info[5] |= num_tx_chains - 1;
 
 	switch (iftype) {
@@ -5920,71 +6054,6 @@ static void ath12k_mac_setup_vdev_create_arg(struct ath12k_vif *arvif,
 	arg->if_stats_id = ath12k_mac_get_vdev_stats_id(arvif);
 }
 
-static u32
-ath12k_mac_prepare_he_mode(struct ath12k_pdev *pdev, u32 viftype)
-{
-	struct ath12k_pdev_cap *pdev_cap = &pdev->cap;
-	struct ath12k_band_cap *cap_band = NULL;
-	u32 *hecap_phy_ptr = NULL;
-	u32 hemode;
-
-	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP)
-		cap_band = &pdev_cap->band[NL80211_BAND_2GHZ];
-	else
-		cap_band = &pdev_cap->band[NL80211_BAND_5GHZ];
-
-	hecap_phy_ptr = &cap_band->he_cap_phy_info[0];
-
-	hemode = u32_encode_bits(HE_SU_BFEE_ENABLE, HE_MODE_SU_TX_BFEE) |
-		 u32_encode_bits(HECAP_PHY_SUBFMR_GET(hecap_phy_ptr),
-				 HE_MODE_SU_TX_BFER) |
-		 u32_encode_bits(HECAP_PHY_ULMUMIMO_GET(hecap_phy_ptr),
-				 HE_MODE_UL_MUMIMO);
-
-	/* TODO: WDS and other modes */
-	if (viftype == NL80211_IFTYPE_AP) {
-		hemode |= u32_encode_bits(HECAP_PHY_MUBFMR_GET(hecap_phy_ptr),
-					  HE_MODE_MU_TX_BFER) |
-			  u32_encode_bits(HE_DL_MUOFDMA_ENABLE, HE_MODE_DL_OFDMA) |
-			  u32_encode_bits(HE_UL_MUOFDMA_ENABLE, HE_MODE_UL_OFDMA);
-	} else {
-		hemode |= u32_encode_bits(HE_MU_BFEE_ENABLE, HE_MODE_MU_TX_BFEE);
-	}
-
-	return hemode;
-}
-
-static int ath12k_set_he_mu_sounding_mode(struct ath12k *ar,
-					  struct ath12k_vif *arvif)
-{
-	u32 param_id, param_value;
-	struct ath12k_base *ab = ar->ab;
-	int ret;
-
-	param_id = WMI_VDEV_PARAM_SET_HEMU_MODE;
-	param_value = ath12k_mac_prepare_he_mode(ar->pdev, arvif->vif->type);
-	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-					    param_id, param_value);
-	if (ret) {
-		ath12k_warn(ab, "failed to set vdev %d HE MU mode: %d param_value %x\n",
-			    arvif->vdev_id, ret, param_value);
-		return ret;
-	}
-	param_id = WMI_VDEV_PARAM_SET_HE_SOUNDING_MODE;
-	param_value =
-		u32_encode_bits(HE_VHT_SOUNDING_MODE_ENABLE, HE_VHT_SOUNDING_MODE) |
-		u32_encode_bits(HE_TRIG_NONTRIG_SOUNDING_MODE_ENABLE,
-				HE_TRIG_NONTRIG_SOUNDING_MODE);
-	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-					    param_id, param_value);
-	if (ret) {
-		ath12k_warn(ab, "failed to set vdev %d HE MU mode: %d\n",
-			    arvif->vdev_id, ret);
-		return ret;
-	}
-	return ret;
-}
-
 static void ath12k_mac_update_vif_offload(struct ath12k_vif *arvif)
 {
 	struct ieee80211_vif *vif = arvif->vif;
@@ -6810,7 +6879,6 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 	struct ath12k_base *ab = ar->ab;
 	struct wmi_vdev_start_req_arg arg = {};
 	const struct cfg80211_chan_def *chandef = &ctx->def;
-	int he_support = arvif->vif->bss_conf.he_support;
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -6860,14 +6928,6 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 		spin_unlock_bh(&ab->base_lock);
 
 		/* TODO: Notify if secondary 80Mhz also needs radar detection */
-		if (he_support) {
-			ret = ath12k_set_he_mu_sounding_mode(ar, arvif);
-			if (ret) {
-				ath12k_warn(ar->ab, "failed to set he mode vdev %i\n",
-					    arg.vdev_id);
-				return ret;
-			}
-		}
 	}
 
 	arg.passive |= !!(chandef->chan->flags & IEEE80211_CHAN_NO_IR);
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 69fd282b9dd3..e5193a44f344 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -40,6 +40,21 @@ struct ath12k_generic_iter {
 #define ATH12K_TX_POWER_MAX_VAL	70
 #define ATH12K_TX_POWER_MIN_VAL	0
 
+#define HECAP_PHY_SUBFMR_GET(hecap_phy) \
+	u8_get_bits(hecap_phy[3], IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER)
+
+#define HECAP_PHY_SUBFME_GET(hecap_phy) \
+	u8_get_bits(hecap_phy[4], IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE)
+
+#define HECAP_PHY_MUBFMR_GET(hecap_phy) \
+	u8_get_bits(hecap_phy[4], IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER)
+
+#define HECAP_PHY_ULMUMIMO_GET(hecap_phy) \
+	u8_get_bits(hecap_phy[2], IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO)
+
+#define HECAP_PHY_ULOFDMA_GET(hecap_phy) \
+	u8_get_bits(hecap_phy[2], IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO)
+
 enum ath12k_supported_bw {
 	ATH12K_BW_20    = 0,
 	ATH12K_BW_40    = 1,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 496866673aea..03aab0531aa4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2968,31 +2968,6 @@ struct ath12k_wmi_rx_reorder_queue_remove_arg {
 #define WMI_VDEV_PARAM_TXBF_SU_TX_BFER BIT(2)
 #define WMI_VDEV_PARAM_TXBF_MU_TX_BFER BIT(3)
 
-#define HECAP_PHYDWORD_0	0
-#define HECAP_PHYDWORD_1	1
-#define HECAP_PHYDWORD_2	2
-
-#define HECAP_PHY_SU_BFER		BIT(31)
-#define HECAP_PHY_SU_BFEE		BIT(0)
-#define HECAP_PHY_MU_BFER		BIT(1)
-#define HECAP_PHY_UL_MUMIMO		BIT(22)
-#define HECAP_PHY_UL_MUOFDMA		BIT(23)
-
-#define HECAP_PHY_SUBFMR_GET(hecap_phy) \
-	u32_get_bits(hecap_phy[HECAP_PHYDWORD_0], HECAP_PHY_SU_BFER)
-
-#define HECAP_PHY_SUBFME_GET(hecap_phy) \
-	u32_get_bits(hecap_phy[HECAP_PHYDWORD_1], HECAP_PHY_SU_BFEE)
-
-#define HECAP_PHY_MUBFMR_GET(hecap_phy) \
-	u32_get_bits(hecap_phy[HECAP_PHYDWORD_1], HECAP_PHY_MU_BFER)
-
-#define HECAP_PHY_ULMUMIMO_GET(hecap_phy) \
-	u32_get_bits(hecap_phy[HECAP_PHYDWORD_0], HECAP_PHY_UL_MUMIMO)
-
-#define HECAP_PHY_ULOFDMA_GET(hecap_phy) \
-	u32_get_bits(hecap_phy[HECAP_PHYDWORD_0], HECAP_PHY_UL_MUOFDMA)
-
 #define HE_MODE_SU_TX_BFEE	BIT(0)
 #define HE_MODE_SU_TX_BFER	BIT(1)
 #define HE_MODE_MU_TX_BFEE	BIT(2)
@@ -3004,8 +2979,11 @@ struct ath12k_wmi_rx_reorder_queue_remove_arg {
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
2.17.1


