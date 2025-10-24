Return-Path: <linux-wireless+bounces-28208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D268C03F27
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 02:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A710357373
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 00:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F7D146A72;
	Fri, 24 Oct 2025 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RJ735jNK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E7675809
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761265181; cv=none; b=JJz959HcyRCkwRx26phBOgTY7668s4kxHmqTG1K3mU4xj4o8a+5WPJ9Ab/Rz86kORj8lhLgyGBy4d82EHdbZEfUsgBrhF3SDSPf7HXTAdNfhgzvzz72e6EOETRRKSyPEPQIF90GyijVPULRQNDqaAUM82KpDKrqQY9Bz8jfBmG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761265181; c=relaxed/simple;
	bh=2HLtE19GiXdUboZvOsVU7ZB2CJoI8jEW5oDG1FgY1Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jiK+WqBQI4loPG+Hy2CvPrIltwcIhKoYzJzYb5lyV8a9snMA4Aopod+vepC4o0rO9dq4M4EsnzI/HY+WoooL+DsW9Ur4LUyOo3avgRy5gg/iEpyuMH4pX71BKjZ9FcnIIzgkJ85BtShYY5AbRTgOxzDKYwUy4jq2HRGBXHmxs/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RJ735jNK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NE4boh005645
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sLRqqQFx4Fd
	ldyN44zg/ySSFA4KDzMjdSY/d4qgS6TE=; b=RJ735jNKGziVU+G5k+PdDLXt1Oi
	hofY8f9fjcY69g73kn+CKuGi6ABzGJTuTi4hSKDHycV+DMiY8kN7Yg6+Iq40mUoq
	xoUcvG4Ur0bOZ1kY4qBYKgkOAEJw7JlDMzMJHfIDJD6dsH0eDq0XkJ7vMc8jEDtl
	i7Rnb1QGV4yW5HcGzljctkQeOOm4kveR9/bWOu2IiPKO0Sv/snVIGpxzdY9nYTwV
	ZeiTWvu3W0U1dIqzijKpeRouWeXCPtkXruTs9Ivsqr9flE6rE1uw7Tymnp4ah3yc
	7Dg/SPF3cRzkCinpQLGM5etVWtYr6wmAPbseTcoXZQO5rxL9+MbS8WI6/7Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27ja74e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:38 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6cff817142so651449a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 17:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761265177; x=1761869977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLRqqQFx4FdldyN44zg/ySSFA4KDzMjdSY/d4qgS6TE=;
        b=ABzvz+fgbpMsba8YHotT0c14FCZR/4SxgtD57hUKflLrNor9FexXKaVcDWPvWZYj3W
         c60UnOwoFLZ+UMayP5kR8uYDuiYb1mqdZzDyQL6GaDFRsfCEgwAtNaCIdNG2dnw+nDH4
         RPYjDvbGah+7JBGXnkqMsERyUQZze0FoSpuED8/PB2oRk571vaPTsxHp0HqzI4eR8giy
         Dkgw7oALF+L6WAtxK7uwt1Fa3ufNWl32KyvmdbJaVCUUm3dFR36Zy/zPyNTdTzU2eFlw
         YLLiMEXFIC0kSPaMDrTZpbIyuxfC22a0BPlqFLEtI2BPAKKKS92Hxig+rOy800R8ivG2
         ySag==
X-Gm-Message-State: AOJu0Yw5M6SEBuN5I+ScvBknU353SyC6VPQGDEMV8L2zUcslSqK4jemK
	lGWiWWrH26R7R1bOMEQFGCWV9SCgbHK/1kiVR2+nUoS0gDovq+s0BjLellHjXLVys/0emjpha/P
	nJaWam/k7+5LWZi39VoFk1T9Ecq3KSHJcepEYxsF/Y3lyxo/I8M2fkYsRjnSyrYSqMsTr158HoG
	uh8w==
X-Gm-Gg: ASbGncv4AKnWG4ZvZdmut+HgWt92VhFKBrvEjo5UEnrCPtdnZPBR+FlW52DGy/wkSaX
	S8YqNHm36EGU31eULYJOLrnQ0xHoBP/EC4H17Z5mpaH/wTqy4IIS5gvVpeJ/rUyG/s/8LDHQxAz
	tcnhG6Uqvxd/Vu+fu0TVAhxAP7g7TYbjoBLaEhm8571i6M7ZRO1GNhcJcNrkrAfXt8aDx7oSMxw
	ecl/87ZpPNH4kFp+8zqflhkNdBplaxMwdnR7wrAyFxR/7zqtC4ZIlfwFPfd7QiHcToZGTuI9lFe
	zfKB5hAPywGXKDsdMWYYl+3V6rojjJmhBSH1IyFq90qAku0pV/SKFK66hJWo5R5DNcxRWc7+2vW
	oA2rEIhq/tdyBXk/UP0f3HUqLKJa63s5NdByW5E0AF1OHS0bPGTasQ/c=
X-Received: by 2002:a05:6a20:9f47:b0:334:9e81:4e5b with SMTP id adf61e73a8af0-33c5fbaadf0mr5191235637.5.1761265177456;
        Thu, 23 Oct 2025 17:19:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+ozWpKhtNHnU8aRqoMMcfQd69f2qBcbKL7PkB4h+kIQHfxDof3+r3sCOaEE6ZMpZ4wE97tQ==
X-Received: by 2002:a05:6a20:9f47:b0:334:9e81:4e5b with SMTP id adf61e73a8af0-33c5fbaadf0mr5191215637.5.1761265176986;
        Thu, 23 Oct 2025 17:19:36 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb65b3sm3296264a12.8.2025.10.23.17.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 17:19:36 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>,
        Vishal Kumar <quic_visk@quicinc.com>,
        Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH ath-next 3/6] wifi: ath12k: Add EHT MCS/NSS rates to Peer Assoc
Date: Thu, 23 Oct 2025 17:19:25 -0700
Message-Id: <20251024001928.257356-4-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024001928.257356-1-muna.sinada@oss.qualcomm.com>
References: <20251024001928.257356-1-muna.sinada@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX8nEGL8kZM5EA
 daL0+iZf7z2zxlRu956IMuWdfaC+j8URzBVKhmJe7Ebjl9l9iosE0/wQPmBFPuQU4DlOzr/ZdAG
 uYkjZcaTQw0npH+pcQaXFdUx/pMqfg++z3tTBY9ea5QnWl5FEsuqmC6xZaGdV+Tym0CkCoXz4vE
 ABhvh/KPrPVPDKDzcZmC3lvmFZv/1QxbaZKi3GMdYATK+Ot6nQhiMXd0tfR+h4GG42ueZu/iF5L
 9MK97vkZq03YezLebl6sny7Hp4AoO1LawMLonENDhDUw7kPJe2uThBkyjvj4Sk+7MWCS9GtnJvs
 CIk8s7j9fGx9E6hk0JodROmcT99aKe36MUD2F17ttkQO1RgwWxz3PFV14vmRAil8OyOvJ9W2gHZ
 7PNBb1yAaDIQBSiTTjiWdfcUWEvekQ==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68fac61a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=DPe7GoXiTccg4i4ia6cA:9 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: M8AQQiFPclGS4wTn9cxWVMozu752reiM
X-Proofpoint-ORIG-GUID: M8AQQiFPclGS4wTn9cxWVMozu752reiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

Add EHT MCS/NSS rate functionality to peer association. As part of
ath12k_peer_assoc_h_eht() add the calculation of EHT MCS/NSS using
intersection of link_sta and phy capability.

ath12k_mac_max_eht_mcs_nss() function is utilized when comparing the
max NSS of link STA and phy capability since in split phy case, phy
supports max NSS of 2 for 5G band.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Co-developed-by: Vishal Kumar <quic_visk@quicinc.com>
Signed-off-by: Vishal Kumar <quic_visk@quicinc.com>
Co-developed-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 110 ++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 397fe320e558..eff1ec1eb4e0 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -545,6 +545,18 @@ ath12k_mac_max_eht_nss(const u16 eht_mcs_mask[NL80211_EHT_NSS_MAX])
 	return 1;
 }
 
+static u32
+ath12k_mac_max_eht_mcs_nss(const u8 *eht_mcs, int eht_mcs_set_size)
+{
+	int i;
+	u8 nss = 0;
+
+	for (i = 0; i < eht_mcs_set_size; i++)
+		nss = max(nss, u8_get_bits(eht_mcs[i], IEEE80211_EHT_MCS_NSS_RX));
+
+	return nss;
+}
+
 static u8 ath12k_parse_mpdudensity(u8 mpdudensity)
 {
 /*  From IEEE Std 802.11-2020 defined values for "Minimum MPDU Start Spacing":
@@ -3016,6 +3028,18 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_eht(struct ath12k *ar,
 	return MODE_UNKNOWN;
 }
 
+static bool
+ath12k_peer_assoc_h_eht_masked(const u16 eht_mcs_mask[NL80211_EHT_NSS_MAX])
+{
+	int nss;
+
+	for (nss = 0; nss < NL80211_EHT_NSS_MAX; nss++)
+		if (eht_mcs_mask[nss])
+			return false;
+
+	return true;
+}
+
 static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 					struct ath12k_link_vif *arvif,
 					struct ath12k_link_sta *arsta,
@@ -3027,6 +3051,7 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 	const u8 *ht_mcs_mask;
 	const u16 *vht_mcs_mask;
 	const u16 *he_mcs_mask;
+	const u16 *eht_mcs_mask;
 	enum wmi_phy_mode phymode = MODE_UNKNOWN;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -3041,6 +3066,7 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 	ht_mcs_mask = arvif->bitrate_mask.control[band].ht_mcs;
 	vht_mcs_mask = arvif->bitrate_mask.control[band].vht_mcs;
 	he_mcs_mask = arvif->bitrate_mask.control[band].he_mcs;
+	eht_mcs_mask = arvif->bitrate_mask.control[band].eht_mcs;
 
 	link_sta = ath12k_mac_get_link_sta(arsta);
 	if (!link_sta) {
@@ -3051,7 +3077,8 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 
 	switch (band) {
 	case NL80211_BAND_2GHZ:
-		if (link_sta->eht_cap.has_eht) {
+		if (link_sta->eht_cap.has_eht &&
+		    !ath12k_peer_assoc_h_eht_masked(eht_mcs_mask)) {
 			if (link_sta->bandwidth == IEEE80211_STA_RX_BW_40)
 				phymode = MODE_11BE_EHT40_2G;
 			else
@@ -3197,16 +3224,21 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 {
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
+	const struct ieee80211_eht_mcs_nss_supp *own_eht_mcs_nss_supp;
 	const struct ieee80211_eht_mcs_nss_supp_20mhz_only *bw_20;
+	const struct ieee80211_sta_eht_cap *eht_cap, *own_eht_cap;
+	const struct ieee80211_sband_iftype_data *iftd;
 	const struct ieee80211_eht_mcs_nss_supp_bw *bw;
-	const struct ieee80211_sta_eht_cap *eht_cap;
 	const struct ieee80211_sta_he_cap *he_cap;
 	struct ieee80211_link_sta *link_sta;
 	struct ieee80211_bss_conf *link_conf;
 	struct cfg80211_chan_def def;
+	bool user_rate_valid = true;
 	enum nl80211_band band;
+	int eht_nss, nss_idx;
 	u32 *rx_mcs, *tx_mcs;
 	u16 *eht_mcs_mask;
+	u8 max_nss = 0;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -3234,6 +3266,16 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 	band = def.chan->band;
 	eht_mcs_mask = arvif->bitrate_mask.control[band].eht_mcs;
 
+	iftd = ieee80211_get_sband_iftype_data(&ar->mac.sbands[band], vif->type);
+	if (!iftd) {
+		ath12k_warn(ar->ab,
+			    "unable to access iftype_data in struct ieee80211_supported_band\n");
+		return;
+	}
+
+	own_eht_cap = &iftd->eht_cap;
+	own_eht_mcs_nss_supp = &own_eht_cap->eht_mcs_nss_supp;
+
 	arg->eht_flag = true;
 
 	if ((eht_cap->eht_cap_elem.phy_cap_info[5] &
@@ -3250,6 +3292,28 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 	rx_mcs = arg->peer_eht_rx_mcs_set;
 	tx_mcs = arg->peer_eht_tx_mcs_set;
 
+	eht_nss = ath12k_mac_max_eht_mcs_nss((void *)own_eht_mcs_nss_supp,
+					     sizeof(*own_eht_mcs_nss_supp));
+	if (eht_nss > link_sta->rx_nss) {
+		user_rate_valid = false;
+		for (nss_idx = (link_sta->rx_nss - 1); nss_idx >= 0; nss_idx--) {
+			if (eht_mcs_mask[nss_idx]) {
+				user_rate_valid = true;
+				break;
+			}
+		}
+	}
+
+	if (!user_rate_valid) {
+		ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+			   "Setting eht range MCS value to peer supported nss %d for peer %pM\n",
+			   link_sta->rx_nss, arsta->addr);
+		eht_mcs_mask[link_sta->rx_nss - 1] = eht_mcs_mask[eht_nss - 1];
+	}
+
+	bw_20 = &eht_cap->eht_mcs_nss_supp.only_20mhz;
+	bw = &eht_cap->eht_mcs_nss_supp.bw._80;
+
 	switch (link_sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_320:
 		bw = &eht_cap->eht_mcs_nss_supp.bw._320;
@@ -3274,11 +3338,8 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 		arg->peer_eht_mcs_count++;
 		fallthrough;
 	default:
-		if ((he_cap->he_cap_elem.phy_cap_info[0] &
-		     (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
-		      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
-		      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
-		      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)) == 0) {
+		if (!(link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
+		      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL)) {
 			bw_20 = &eht_cap->eht_mcs_nss_supp.only_20mhz;
 
 			ath12k_mac_set_eht_mcs(bw_20->rx_tx_mcs7_max_nss,
@@ -3305,6 +3366,41 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 
 	arg->punct_bitmap = ~arvif->punct_bitmap;
 	arg->eht_disable_mcs15 = link_conf->eht_disable_mcs15;
+
+	if (!(link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL)) {
+		if (bw_20->rx_tx_mcs13_max_nss)
+			max_nss = max(max_nss, u8_get_bits(bw_20->rx_tx_mcs13_max_nss,
+							   IEEE80211_EHT_MCS_NSS_RX));
+		if (bw_20->rx_tx_mcs11_max_nss)
+			max_nss = max(max_nss, u8_get_bits(bw_20->rx_tx_mcs11_max_nss,
+							   IEEE80211_EHT_MCS_NSS_RX));
+		if (bw_20->rx_tx_mcs9_max_nss)
+			max_nss = max(max_nss, u8_get_bits(bw_20->rx_tx_mcs9_max_nss,
+							   IEEE80211_EHT_MCS_NSS_RX));
+		if (bw_20->rx_tx_mcs7_max_nss)
+			max_nss = max(max_nss, u8_get_bits(bw_20->rx_tx_mcs7_max_nss,
+							   IEEE80211_EHT_MCS_NSS_RX));
+	} else {
+		if (bw->rx_tx_mcs13_max_nss)
+			max_nss = max(max_nss, u8_get_bits(bw->rx_tx_mcs13_max_nss,
+							   IEEE80211_EHT_MCS_NSS_RX));
+		if (bw->rx_tx_mcs11_max_nss)
+			max_nss = max(max_nss, u8_get_bits(bw->rx_tx_mcs11_max_nss,
+							   IEEE80211_EHT_MCS_NSS_RX));
+		if (bw->rx_tx_mcs9_max_nss)
+			max_nss = max(max_nss, u8_get_bits(bw->rx_tx_mcs9_max_nss,
+							   IEEE80211_EHT_MCS_NSS_RX));
+	}
+
+	max_nss = min(max_nss, (uint8_t)eht_nss);
+
+	arg->peer_nss = min(link_sta->rx_nss, max_nss);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "mac eht peer %pM nss %d mcs cnt %d ru_punct_bitmap 0x%x\n",
+		   arsta->addr, arg->peer_nss, arg->peer_eht_mcs_count,
+		   arg->punct_bitmap);
 }
 
 static void ath12k_peer_assoc_h_mlo(struct ath12k_link_sta *arsta,
-- 
2.34.1


