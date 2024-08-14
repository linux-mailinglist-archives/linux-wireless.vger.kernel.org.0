Return-Path: <linux-wireless+bounces-11425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866879518E4
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 12:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A4A1C212C8
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 10:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFE01AE02D;
	Wed, 14 Aug 2024 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eRmiquc+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EF41AE03E
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631691; cv=none; b=dh1xdG2v3ECBsuXUIUE1btG4IZm4lkEyHfpigfbX8kyjFGaVAYfCt/uCl8XpNz/E290dQDlO/8R/mCSMJN8XaKgGX+YAjaUL399G/zSE00VvP+IV00/r1stb1TYNEuoy4nwec0p+z5yn7PWHvvZDQrrvY/RARS+DO9filOJ/+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631691; c=relaxed/simple;
	bh=SqCJBPXneuVXiDD3p5YhL1zk4Y7PBnKKe5HZvkEcYPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNHTHsRtYOEeRu9Kz32AtPkanOBAc3qUhTOmT5oJQxsvXbL1EsiSvf6tqut2jREJRfoqZHsg1S2jAbl0fKBW39m3B2HMfbvhff+9Uuma8SAo+GRpK7+HIVXPJtISHlxDCZTzXamU0MG6oWhW4u9tVSTepwdwr3n6Etju8aYhHzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eRmiquc+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EA8CU6013450;
	Wed, 14 Aug 2024 10:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GBiesLn8Znc1Fkx6Sp/YdFimi+qml5VvM2sa0AQmyWA=; b=eRmiquc+MIVuIdOG
	TWrd/oscp9uCEx5E5SaaGi6FGS2vva5rXC/e/ytMNK7Hs3Vaxn1oT/zMChtKNZ2I
	rjozzxNXTSTI3K7+gHGu11/vh4UaFXOIyC9/1onbZ/FTOfQzZ1Fc+Sr6h5TOe67Q
	rns5bXKxyDyS9CARhzQrkaV5VRfJv7FSryH51zRsWDRWImw6UfvPbtEssnPQ2V14
	ICjE1lX+ZKZ06k1ajo5OsUb7JxfWe5vjJJTp6sMog+qehV+mFndfa/g7AD3u2il6
	KWp62eVewfDeon9kfZNkcOmluPQj3yuVQh3Jt3wqZG2ABZu3skgBXyRUd7aYCJ46
	lco/KQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410tjd026t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 10:34:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47EAYjM3030758
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 10:34:45 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 Aug 2024 03:34:43 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 3/3] wifi: ath12k: Advertise multi device iface combination
Date: Wed, 14 Aug 2024 16:04:23 +0530
Message-ID: <20240814103423.3980958-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814103423.3980958-1-quic_periyasa@quicinc.com>
References: <20240814103423.3980958-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: DS1odpZSAdP6BqgB76PIVoxHUiO5TSIj
X-Proofpoint-GUID: DS1odpZSAdP6BqgB76PIVoxHUiO5TSIj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_08,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140073

The prerequisite for MLO support in cfg80211/mac80211 requires that all
the links participating in MLO belong to the same wiphy/ieee80211_hw.
The driver needs to group multiple discrete hardware components, each
acting as a link in MLO, under one wiphy. Consequently, the driver
advertises multi-hardware device interface combination capabilities
specific to the radio, including supported frequencies. The global
interface combination represent the combined interface capabilities.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00183-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 212 +++++++++++++++++++++-----
 1 file changed, 175 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 6761204048f6..8f5f6a08446f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8850,14 +8850,20 @@ static bool ath12k_mac_is_iface_mode_enable(struct ath12k_hw *ah,
 {
 	struct ath12k *ar;
 	int i;
-	u16 interface_modes, mode;
-	bool is_enable = true;
+	u16 interface_modes, mode = 0;
+	bool is_enable = false;
+
+	if (type == NL80211_IFTYPE_MESH_POINT) {
+		if (IS_ENABLED(CONFIG_MAC80211_MESH))
+			mode = BIT(type);
+	} else {
+		mode = BIT(type);
+	}
 
-	mode = BIT(type);
 	for_each_ar(ah, ar, i) {
 		interface_modes = ar->ab->hw_params->interface_modes;
-		if (!(interface_modes & mode)) {
-			is_enable = false;
+		if (interface_modes & mode) {
+			is_enable = true;
 			break;
 		}
 	}
@@ -8865,31 +8871,20 @@ static bool ath12k_mac_is_iface_mode_enable(struct ath12k_hw *ah,
 	return is_enable;
 }
 
-static void ath12k_mac_cleanup_iface_combinations(struct ath12k_hw *ah)
-{
-	struct wiphy *wiphy = ah->hw->wiphy;
-
-	kfree(wiphy->iface_combinations[0].limits);
-	kfree(wiphy->iface_combinations);
-}
-
-static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
+static int
+ath12k_mac_setup_radio_iface_comb(struct ath12k *ar,
+				  struct ieee80211_iface_combination *comb)
 {
-	struct wiphy *wiphy = ah->hw->wiphy;
-	struct ieee80211_iface_combination *combinations;
 	struct ieee80211_iface_limit *limits;
 	int n_limits, max_interfaces;
+	u16 interface_modes = ar->ab->hw_params->interface_modes;
 	bool ap, mesh, p2p;
 
-	ap = ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_AP);
-	p2p = ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_P2P_DEVICE);
+	ap = interface_modes & BIT(NL80211_IFTYPE_AP);
+	p2p = interface_modes & BIT(NL80211_IFTYPE_P2P_DEVICE);
 
 	mesh = IS_ENABLED(CONFIG_MAC80211_MESH) &&
-		ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_MESH_POINT);
-
-	combinations = kzalloc(sizeof(*combinations), GFP_KERNEL);
-	if (!combinations)
-		return -ENOMEM;
+	       (interface_modes & BIT(NL80211_IFTYPE_MESH_POINT));
 
 	if ((ap || mesh) && !p2p) {
 		n_limits = 2;
@@ -8906,10 +8901,8 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
 	}
 
 	limits = kcalloc(n_limits, sizeof(*limits), GFP_KERNEL);
-	if (!limits) {
-		kfree(combinations);
+	if (!limits)
 		return -ENOMEM;
-	}
 
 	limits[0].max = 1;
 	limits[0].types |= BIT(NL80211_IFTYPE_STATION);
@@ -8925,26 +8918,171 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
 
 	if (p2p) {
 		limits[1].types |= BIT(NL80211_IFTYPE_P2P_CLIENT) |
-				   BIT(NL80211_IFTYPE_P2P_GO);
+					BIT(NL80211_IFTYPE_P2P_GO);
 		limits[2].max = 1;
 		limits[2].types |= BIT(NL80211_IFTYPE_P2P_DEVICE);
 	}
 
-	combinations[0].limits = limits;
-	combinations[0].n_limits = n_limits;
-	combinations[0].max_interfaces = max_interfaces;
-	combinations[0].num_different_channels = 1;
-	combinations[0].beacon_int_infra_match = true;
-	combinations[0].beacon_int_min_gcd = 100;
-	combinations[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
-						BIT(NL80211_CHAN_WIDTH_20) |
-						BIT(NL80211_CHAN_WIDTH_40) |
-						BIT(NL80211_CHAN_WIDTH_80);
+	comb[0].limits = limits;
+	comb[0].n_limits = n_limits;
+	comb[0].max_interfaces = max_interfaces;
+	comb[0].num_different_channels = 1;
+	comb[0].beacon_int_infra_match = true;
+	comb[0].beacon_int_min_gcd = 100;
+	comb[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+					BIT(NL80211_CHAN_WIDTH_20) |
+					BIT(NL80211_CHAN_WIDTH_40) |
+					BIT(NL80211_CHAN_WIDTH_80);
+
+	return 0;
+}
+
+static int
+ath12k_mac_setup_global_iface_comb(struct ath12k_hw *ah,
+				   struct wiphy_radio *radio,
+				   u8 n_radio,
+				   struct ieee80211_iface_combination *comb)
+{
+	struct ieee80211_iface_limit *limits;
+	const struct ieee80211_iface_combination *iter_comb;
+	int i, j, n_limits;
+	bool ap, mesh, p2p;
+
+	if (!n_radio)
+		return 0;
+
+	ap = ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_AP);
+	p2p = ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_P2P_DEVICE);
+	mesh = ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_MESH_POINT);
+
+	if ((ap || mesh) && !p2p)
+		n_limits = 2;
+	else if (p2p)
+		n_limits = 3;
+	else
+		n_limits = 1;
+
+	limits = kcalloc(n_limits, sizeof(*limits), GFP_KERNEL);
+	if (!limits)
+		return -ENOMEM;
+
+	for (i = 0; i < n_radio; i++) {
+		iter_comb = radio[i].iface_combinations;
+		for (j = 0; j < iter_comb->n_limits && j < n_limits; j++) {
+			limits[j].types |= iter_comb->limits[j].types;
+			limits[j].max += iter_comb->limits[j].max;
+		}
+
+		comb->max_interfaces += iter_comb->max_interfaces;
+		comb->num_different_channels += iter_comb->num_different_channels;
+		comb->radar_detect_widths |= iter_comb->radar_detect_widths;
+	}
+
+	comb->limits = limits;
+	comb->n_limits = n_limits;
+	comb->beacon_int_infra_match = true;
+	comb->beacon_int_min_gcd = 100;
+
+	return 0;
+}
+
+static
+void ath12k_mac_cleanup_iface_comb(const struct ieee80211_iface_combination *iface_comb)
+{
+	kfree(iface_comb[0].limits);
+	kfree(iface_comb);
+}
+
+static void ath12k_mac_cleanup_iface_combinations(struct ath12k_hw *ah)
+{
+	struct wiphy *wiphy = ah->hw->wiphy;
+	const struct wiphy_radio *radio;
+	int i;
+
+	if (wiphy->n_radio > 0) {
+		radio = wiphy->radio;
+		for (i = 0; i < wiphy->n_radio; i++)
+			ath12k_mac_cleanup_iface_comb(radio[i].iface_combinations);
+
+		kfree(wiphy->radio);
+	}
+
+	ath12k_mac_cleanup_iface_comb(wiphy->iface_combinations);
+}
+
+static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
+{
+	struct wiphy *wiphy = ah->hw->wiphy;
+	struct wiphy_radio *radio;
+	struct ath12k *ar;
+	struct ieee80211_iface_combination *combinations;
+	int i = 0, ret;
+
+	combinations = kzalloc(sizeof(*combinations), GFP_KERNEL);
+	if (!combinations)
+		return -ENOMEM;
+
+	if (ah->num_radio > 1) {
+		struct ieee80211_iface_combination *comb;
+
+		radio = kcalloc(ah->num_radio, sizeof(*radio), GFP_KERNEL);
+		if (!radio) {
+			ret = -ENOMEM;
+			goto err_combination;
+		}
+
+		for_each_ar(ah, ar, i) {
+			comb = kzalloc(sizeof(*comb), GFP_KERNEL);
+			if (!comb) {
+				ret = -ENOMEM;
+				goto err_radio_comb;
+			}
+
+			ret = ath12k_mac_setup_radio_iface_comb(ar, comb);
+			if (ret) {
+				kfree(comb);
+				goto err_radio_comb;
+			}
+
+			radio[i].freq_range = &ar->freq_range;
+			radio[i].n_freq_range = 1;
+
+			radio[i].iface_combinations = comb;
+			radio[i].n_iface_combinations = 1;
+		}
+
+		ret = ath12k_mac_setup_global_iface_comb(ah, radio,
+							 ah->num_radio,
+							 combinations);
+		if (ret)
+			goto err_full_radio_comb;
+
+		wiphy->radio = radio;
+		wiphy->n_radio = ah->num_radio;
+	} else {
+		ret = ath12k_mac_setup_radio_iface_comb(&ah->radio[0],
+							combinations);
+		if (ret)
+			goto err_combination;
+	}
 
 	wiphy->iface_combinations = combinations;
 	wiphy->n_iface_combinations = 1;
 
 	return 0;
+
+err_full_radio_comb:
+	i = ah->num_radio;
+err_radio_comb:
+	while (i--)
+		ath12k_mac_cleanup_iface_comb(radio[i].iface_combinations);
+
+	kfree(radio);
+
+err_combination:
+	kfree(combinations);
+
+	return ret;
 }
 
 static const u8 ath12k_if_types_ext_capa[] = {
-- 
2.34.1


