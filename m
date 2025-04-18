Return-Path: <linux-wireless+bounces-21730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6660CA93C30
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 19:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A60C8A40EE
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 17:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE3F21C9F0;
	Fri, 18 Apr 2025 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k9ae3Psl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796D821A928
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998529; cv=none; b=qmJP9P8TlE74BMyQFHqn/ySaSies62J2OUP7u8grMQivmEMTggBPaUeh7Td3laW0Mcr4WuWEgIuQrJSwJGDxf8BpCRuZjwRbpIWPAmhCQqwuGzLdWLd9i1N5vRvT0ev+prRHVOfQATZSVT5qTmjeI2Njwp1NQttbGApOKEHsRRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998529; c=relaxed/simple;
	bh=8nf6258zDf78MUx8KeUoL3tL29vt2QaBCxSNhyhUVo8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDj7JkCnLvvwyQb19JcqfbaVAkEKZDkmolY5P765usKCWOXLvSQmgU8xtGe2KufhX1m6bcA78v6gv84DfWa9WlA0J+SxAleVyWvledkXDsiOQT0HKToeHYLu1ft8vhJk+/MbZNS7wFyB8anKpdT8Zc4kUDuwRzM2xfh7FAwtMTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k9ae3Psl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ICDFBq005848;
	Fri, 18 Apr 2025 17:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qPFDyjYsXqbfdyJpxG48qyOD0QRCEJK7y5PAfePUXsA=; b=k9ae3PslmIFAYc6u
	Hwr3yHvl5gSeiNsdHSaZxrwJRwM1yeLiSZgXd+80nGGEIVXCfTKvaZ+W3cPEP2ui
	PsogF73nb/C95DGtXSIA8qZO4mKxKRQWfOWobzRaBHAuvII4tx0tEIA+TRd72ekj
	hLRDaj2hKg+x3JS1h372DZ8mPGch3LaN4/iLo6iaNgu9GmmraOZocD0xkLGas6cR
	c3K3EvqwWbjouy0AxiiNpHtCEYk03ruA2IVO2umZrZ8OAUUBwufscGF/bsdwH8rN
	6TNdoOZhcXPnFo94IX2NtyZgd3SSh6wWxJMCnUtxMuK2I0U1uSS7thvuY+Bzipbv
	qkfTVA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydvjjuuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 17:48:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53IHmhaf024485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 17:48:43 GMT
Received: from ath12k-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 18 Apr 2025 10:48:42 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
Subject: [PATCH V13 1/9] wifi: ath12k: push HE MU-MIMO params to hardware
Date: Fri, 18 Apr 2025 10:48:10 -0700
Message-ID: <20250418174818.3336510-2-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
References: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=ZIrXmW7b c=1 sm=1 tr=0 ts=6802907b cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=-_O-Wy8N5QNPZvNXkjkA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 2-eS4spaijA-2M_NqRec2lMbY6hfs4uj
X-Proofpoint-ORIG-GUID: 2-eS4spaijA-2M_NqRec2lMbY6hfs4uj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180133

Currently, only the HE IE in management frames is updated with
respect to MU-MIMO configurations, but this change is not
reflected in the hardware. Add support to propagate MU-MIMO
configurations to the hardware as well.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 228 +++++++++++++++++---------
 drivers/net/wireless/ath/ath12k/mac.h |  15 ++
 drivers/net/wireless/ath/ath12k/wmi.h |  28 +---
 3 files changed, 169 insertions(+), 102 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d170bca72948..8d7c210bc160 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3115,6 +3115,125 @@ static int ath12k_setup_peer_smps(struct ath12k *ar, struct ath12k_link_vif *arv
 					 ath12k_smps_map[smps]);
 }
 
+static int ath12k_mac_set_he_txbf_conf(struct ath12k_link_vif *arvif)
+{
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ath12k *ar = arvif->ar;
+	u32 param = WMI_VDEV_PARAM_SET_HEMU_MODE;
+	u32 value = 0;
+	int ret;
+	struct ieee80211_bss_conf *link_conf;
+
+	link_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!link_conf) {
+		ath12k_warn(ar->ab, "unable to access bss link conf in txbf conf\n");
+		return -EINVAL;
+	}
+
+	if (!link_conf->he_support)
+		return 0;
+
+	if (link_conf->he_su_beamformer) {
+		value |= u32_encode_bits(HE_SU_BFER_ENABLE, HE_MODE_SU_TX_BFER);
+		if (link_conf->he_mu_beamformer &&
+		    ahvif->vdev_type == WMI_VDEV_TYPE_AP)
+			value |= u32_encode_bits(HE_MU_BFER_ENABLE, HE_MODE_MU_TX_BFER);
+	}
+
+	if (ahvif->vif->type != NL80211_IFTYPE_MESH_POINT) {
+		value |= u32_encode_bits(HE_DL_MUOFDMA_ENABLE, HE_MODE_DL_OFDMA) |
+			 u32_encode_bits(HE_UL_MUOFDMA_ENABLE, HE_MODE_UL_OFDMA);
+
+		if (link_conf->he_full_ul_mumimo)
+			value |= u32_encode_bits(HE_UL_MUMIMO_ENABLE, HE_MODE_UL_MUMIMO);
+
+		if (link_conf->he_su_beamformee)
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
+					     struct ath12k_link_vif *arvif,
+					     struct ieee80211_sta_he_cap *he_cap,
+					     int *hemode)
+{
+	struct ieee80211_vif *vif = arvif->ahvif->vif;
+	struct ieee80211_he_cap_elem he_cap_elem = {};
+	struct ieee80211_sta_he_cap *cap_band;
+	struct cfg80211_chan_def def;
+	u8 link_id = arvif->link_id;
+	struct ieee80211_bss_conf *link_conf;
+
+	link_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!link_conf) {
+		ath12k_warn(ar->ab, "unable to access bss link conf in recalc txbf conf\n");
+		return -EINVAL;
+	}
+
+	if (!link_conf->he_support)
+		return 0;
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return -EINVAL;
+
+	if (WARN_ON(ath12k_mac_vif_link_chan(vif, link_id, &def)))
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
 static u32 ath12k_mac_ieee80211_sta_bw_to_wmi(struct ath12k *ar,
 					      struct ieee80211_link_sta *link_sta)
 {
@@ -3160,6 +3279,7 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	struct ath12k_sta *ahsta;
 	struct ath12k_peer *peer;
 	bool is_auth = false;
+	u32 hemode = 0;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -3203,8 +3323,26 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 
 	ath12k_peer_assoc_prepare(ar, arvif, arsta, peer_arg, false);
 
+	/* link_sta->he_cap must be protected by rcu_read_lock */
+	ret = ath12k_mac_vif_recalc_sta_he_txbf(ar, arvif, &link_sta->he_cap, &hemode);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to recalc he txbf for vdev %i on bss %pM: %d\n",
+			    arvif->vdev_id, bss_conf->bssid, ret);
+		rcu_read_unlock();
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
 	ret = ath12k_wmi_send_peer_assoc_cmd(ar, peer_arg);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to run peer assoc for %pM vdev %i: %d\n",
@@ -3818,6 +3956,13 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
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
 
 		if (arvif->is_up && info->he_support &&
@@ -6759,11 +6904,14 @@ static void ath12k_mac_copy_he_cap(struct ath12k_band_cap *band_cap,
 
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
@@ -8054,72 +8202,6 @@ static int ath12k_mac_setup_vdev_create_arg(struct ath12k_link_vif *arvif,
 	return 0;
 }
 
-static u32
-ath12k_mac_prepare_he_mode(struct ath12k_pdev *pdev, u32 viftype)
-{
-	struct ath12k_pdev_cap *pdev_cap = &pdev->cap;
-	struct ath12k_band_cap *cap_band = NULL;
-	u32 *hecap_phy_ptr = NULL;
-	u32 hemode;
-
-	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2GHZ_CAP)
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
-					  struct ath12k_link_vif *arvif)
-{
-	u32 param_id, param_value;
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_vif *ahvif = arvif->ahvif;
-	int ret;
-
-	param_id = WMI_VDEV_PARAM_SET_HEMU_MODE;
-	param_value = ath12k_mac_prepare_he_mode(ar->pdev, ahvif->vif->type);
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
 static void ath12k_mac_update_vif_offload(struct ath12k_link_vif *arvif)
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
@@ -9278,14 +9360,6 @@ ath12k_mac_vdev_start_restart(struct ath12k_link_vif *arvif,
 		spin_unlock_bh(&ab->base_lock);
 
 		/* TODO: Notify if secondary 80Mhz also needs radar detection */
-		if (link_conf->he_support) {
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
index da37332352fe..3ddfa00a5a17 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -54,6 +54,21 @@ struct ath12k_generic_iter {
 #define ATH12K_DEFAULT_SCAN_LINK	IEEE80211_MLD_MAX_NUM_LINKS
 #define ATH12K_NUM_MAX_LINKS		(IEEE80211_MLD_MAX_NUM_LINKS + 1)
 
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
index 80fdbc566518..804992bb055c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3096,31 +3096,6 @@ struct ath12k_wmi_rx_reorder_queue_remove_arg {
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
@@ -3132,8 +3107,11 @@ struct ath12k_wmi_rx_reorder_queue_remove_arg {
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
2.34.1


