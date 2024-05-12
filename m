Return-Path: <linux-wireless+bounces-7532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EA18C3623
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 13:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32ADBB20DD6
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F521CAB2;
	Sun, 12 May 2024 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y4oqqoyN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B6F1CD11
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715511808; cv=none; b=KUQ8niM2THjv9vcHR8/ccGlSXB9dJdmIwAaY7hjuBCmbgt+BwXUeNZuh7LnjOIB8BCyHhArYGMcII3hsyKkyYtUAXvHbasDKJZM8XtbmgSSXNxvfMAHUpa2SqUdXMQa1ErTt1zJAWS2ThoV8MgfOcD9YiyXBqaJSfa0DQiyYk/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715511808; c=relaxed/simple;
	bh=jBoFJuXe0DSP1gb9b1TK06ICeKbrY6a6L42s1n9B4/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMciu9n1025x70+OqjYRCk8lMedkObyLvMD0eNHYdti1G+cWQCiKP0wUCJcbx/F1SndUW7vjqFnE/tF8qKQyg4u4oBDySLzUoeaTqiFfF5ET1IL+fI4Ao5EenNiVwia433BnO0/3hDVQTcdW7XPWEYx1ag/8J8pdx9tJ88l3CZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y4oqqoyN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44CAUQXU006879;
	Sun, 12 May 2024 11:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=4uY8ZPQ7UKtC4bJXS46AiSgVk44qbkkbS6nchoIrPk4=; b=Y4
	oqqoyNkmnubfii/afLGBUu5VMsW5gw9BusWQZzH//wCjnNwenfAFRhVKOyWqF6iY
	Vp7RMJEYZDxXftBTK4G/GwAFyHIoBYEiGYR8nYltEhUUly3RB3XlzyCUg3kVOpGq
	F8Rr/cVoz1BtHRsw5hyjPRyd7ZGPfDybsNg2UvPGlsjAsdKB/Pn1VGuqf6PGXn3U
	PcBw8/KxHOzz6bZzsAgIacViVwtP8k8Mvhx+/ldp+DYTOnMXFLWscLOX3Djntm6g
	Th1fYMJu/zUWvdDAp0IHAp+VEWXkkicPq7hiEkSFyq3jMThYLkl14p+x5JZacvL+
	T7bWxnYK68sI2I2c3xpw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y20w1skns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 11:03:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44CB3DYC020683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 11:03:13 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 12 May 2024 04:03:11 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH v3 2/3] wifi: ath12k: pass ath12k_link_vif instead of vif/ahvif
Date: Sun, 12 May 2024 16:32:50 +0530
Message-ID: <20240512110251.4062260-3-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512110251.4062260-1-quic_ramess@quicinc.com>
References: <20240512110251.4062260-1-quic_ramess@quicinc.com>
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
X-Proofpoint-ORIG-GUID: BmYwy-5R2QwStxvgAwmV8ZtO5VxNkk1J
X-Proofpoint-GUID: BmYwy-5R2QwStxvgAwmV8ZtO5VxNkk1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-12_07,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405120083

From: Sriram R <quic_srirrama@quicinc.com>

Currently ieee80211_vif/ahvif is passed as argument for all vif
related control path functions that are being called from
mac80211 ops. With MLO support being added multiple link vifs can
be part of an ieee80211_vif/ahvif and all these functions will need
link id along with ieee80211_vif/ahvif to be passed to fetch the
corresponding link vif (arvif) to which the control/config applies.
Also all these functions need to validate the locking dependency before
dereferencing and start using the link vifs.

To avoid these redundant link dereferences and validations,
limit ieee80211_vif/ahvif argument to mac80211 ops unless
otherwise really required. Do link vif dereference and locking only in
mac80211 ops.
Replace vif arg with ath12k_link_vif and internally fetch ath12k_vif(ahvif)
and vif(ieee80211_vif) if required on other functions.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 189 ++++++++++----------------
 1 file changed, 70 insertions(+), 119 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 788e209ccc75..17a946a2adfc 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -245,8 +245,8 @@ static const u32 ath12k_smps_map[] = {
 static int ath12k_start_vdev_delay(struct ath12k *ar,
 				   struct ath12k_link_vif *arvif);
 static void ath12k_mac_stop(struct ath12k *ar);
-static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif);
-static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ieee80211_vif *vif);
+static int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif);
+static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ath12k_link_vif *arvif);
 
 static const char *ath12k_mac_phymode_str(enum wmi_phy_mode mode)
 {
@@ -1478,19 +1478,16 @@ static void ath12k_mac_vif_sta_connection_loss_work(struct work_struct *work)
 }
 
 static void ath12k_peer_assoc_h_basic(struct ath12k *ar,
-				      struct ieee80211_vif *vif,
+				      struct ath12k_link_vif *arvif,
 				      struct ieee80211_sta *sta,
 				      struct ath12k_wmi_peer_assoc_arg *arg)
 {
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
-	struct ath12k_link_vif *arvif;
 	u32 aid;
 
-	lockdep_assert_held(&ahvif->ah->conf_mutex);
 	lockdep_assert_held(&ar->conf_mutex);
 
-	arvif = &ahvif->deflink;
 	if (vif->type == NL80211_IFTYPE_STATION)
 		aid = vif->cfg.aid;
 	else
@@ -1507,11 +1504,12 @@ static void ath12k_peer_assoc_h_basic(struct ath12k *ar,
 }
 
 static void ath12k_peer_assoc_h_crypto(struct ath12k *ar,
-				       struct ieee80211_vif *vif,
+				       struct ath12k_link_vif *arvif,
 				       struct ieee80211_sta *sta,
 				       struct ath12k_wmi_peer_assoc_arg *arg)
 {
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
+	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_bss_conf *info = &vif->bss_conf;
 	struct cfg80211_chan_def def;
 	struct cfg80211_bss *bss;
@@ -1569,26 +1567,23 @@ static void ath12k_peer_assoc_h_crypto(struct ath12k *ar,
 }
 
 static void ath12k_peer_assoc_h_rates(struct ath12k *ar,
-				      struct ieee80211_vif *vif,
+				      struct ath12k_link_vif *arvif,
 				      struct ieee80211_sta *sta,
 				      struct ath12k_wmi_peer_assoc_arg *arg)
 {
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
 	struct wmi_rate_set_arg *rateset = &arg->peer_legacy_rates;
 	struct cfg80211_chan_def def;
 	const struct ieee80211_supported_band *sband;
 	const struct ieee80211_rate *rates;
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
-	struct ath12k_link_vif *arvif;
 	enum nl80211_band band;
 	u32 ratemask;
 	u8 rate;
 	int i;
 
-	lockdep_assert_held(&ahvif->ah->conf_mutex);
 	lockdep_assert_held(&ar->conf_mutex);
 
-	arvif = &ahvif->deflink;
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
 
@@ -1635,13 +1630,12 @@ ath12k_peer_assoc_h_vht_masked(const u16 *vht_mcs_mask)
 }
 
 static void ath12k_peer_assoc_h_ht(struct ath12k *ar,
-				   struct ieee80211_vif *vif,
+				   struct ath12k_link_vif *arvif,
 				   struct ieee80211_sta *sta,
 				   struct ath12k_wmi_peer_assoc_arg *arg)
 {
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
 	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
-	struct ath12k_link_vif *arvif;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
@@ -1649,10 +1643,8 @@ static void ath12k_peer_assoc_h_ht(struct ath12k *ar,
 	u8 max_nss;
 	u32 stbc;
 
-	lockdep_assert_held(&ahvif->ah->conf_mutex);
 	lockdep_assert_held(&ar->conf_mutex);
 
-	arvif = &ahvif->deflink;
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
 
@@ -1799,13 +1791,12 @@ ath12k_peer_assoc_h_vht_limit(u16 tx_mcs_set,
 }
 
 static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
-				    struct ieee80211_vif *vif,
+				    struct ath12k_link_vif *arvif,
 				    struct ieee80211_sta *sta,
 				    struct ath12k_wmi_peer_assoc_arg *arg)
 {
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
 	const struct ieee80211_sta_vht_cap *vht_cap = &sta->deflink.vht_cap;
-	struct ath12k_link_vif *arvif;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	const u16 *vht_mcs_mask;
@@ -1814,9 +1805,6 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	u8 max_nss, vht_mcs;
 	int i;
 
-	lockdep_assert_held(&ahvif->ah->conf_mutex);
-	arvif = &ahvif->deflink;
-
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
 
@@ -1898,10 +1886,11 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 }
 
 static void ath12k_peer_assoc_h_he(struct ath12k *ar,
-				   struct ieee80211_vif *vif,
+				   struct ath12k_link_vif *arvif,
 				   struct ieee80211_sta *sta,
 				   struct ath12k_wmi_peer_assoc_arg *arg)
 {
+	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
 	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
 	int i;
 	u8 ampdu_factor, rx_mcs_80, rx_mcs_160, max_nss;
@@ -2079,13 +2068,11 @@ static void ath12k_peer_assoc_h_smps(struct ieee80211_sta *sta,
 }
 
 static void ath12k_peer_assoc_h_qos(struct ath12k *ar,
-				    struct ieee80211_vif *vif,
+				    struct ath12k_link_vif *arvif,
 				    struct ieee80211_sta *sta,
 				    struct ath12k_wmi_peer_assoc_arg *arg)
 {
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
-
-	switch (ahvif->vdev_type) {
+	switch (arvif->ahvif->vdev_type) {
 	case WMI_VDEV_TYPE_AP:
 		if (sta->wme) {
 			/* TODO: Check WME vs QoS */
@@ -2277,7 +2264,7 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_eht(struct ath12k *ar,
 }
 
 static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
-					struct ieee80211_vif *vif,
+					struct ath12k_link_vif *arvif,
 					struct ieee80211_sta *sta,
 					struct ath12k_wmi_peer_assoc_arg *arg)
 {
@@ -2286,12 +2273,8 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 	const u8 *ht_mcs_mask;
 	const u16 *vht_mcs_mask;
 	enum wmi_phy_mode phymode = MODE_UNKNOWN;
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
-	struct ath12k_link_vif *arvif;
-
-	lockdep_assert_held(&ahvif->ah->conf_mutex);
+	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
 
-	arvif = &ahvif->deflink;
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
 
@@ -2426,21 +2409,16 @@ static void ath12k_mac_set_eht_ppe_threshold(const u8 *ppe_thres,
 }
 
 static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
-				    struct ieee80211_vif *vif,
+				    struct ath12k_link_vif *arvif,
 				    struct ieee80211_sta *sta,
 				    struct ath12k_wmi_peer_assoc_arg *arg)
 {
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	const struct ieee80211_sta_eht_cap *eht_cap = &sta->deflink.eht_cap;
 	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
 	const struct ieee80211_eht_mcs_nss_supp_20mhz_only *bw_20;
 	const struct ieee80211_eht_mcs_nss_supp_bw *bw;
-	struct ath12k_link_vif *arvif;
 	u32 *rx_mcs, *tx_mcs;
 
-	lockdep_assert_held(&ahvif->ah->conf_mutex);
-
-	arvif = &ahvif->deflink;
 	if (!sta->deflink.he_cap.has_he || !eht_cap->has_eht)
 		return;
 
@@ -2513,7 +2491,7 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 }
 
 static void ath12k_peer_assoc_prepare(struct ath12k *ar,
-				      struct ieee80211_vif *vif,
+				      struct ath12k_link_vif *arvif,
 				      struct ieee80211_sta *sta,
 				      struct ath12k_wmi_peer_assoc_arg *arg,
 				      bool reassoc)
@@ -2525,15 +2503,15 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 	reinit_completion(&ar->peer_assoc_done);
 
 	arg->peer_new_assoc = !reassoc;
-	ath12k_peer_assoc_h_basic(ar, vif, sta, arg);
-	ath12k_peer_assoc_h_crypto(ar, vif, sta, arg);
-	ath12k_peer_assoc_h_rates(ar, vif, sta, arg);
-	ath12k_peer_assoc_h_ht(ar, vif, sta, arg);
-	ath12k_peer_assoc_h_vht(ar, vif, sta, arg);
-	ath12k_peer_assoc_h_he(ar, vif, sta, arg);
-	ath12k_peer_assoc_h_eht(ar, vif, sta, arg);
-	ath12k_peer_assoc_h_qos(ar, vif, sta, arg);
-	ath12k_peer_assoc_h_phymode(ar, vif, sta, arg);
+	ath12k_peer_assoc_h_basic(ar, arvif, sta, arg);
+	ath12k_peer_assoc_h_crypto(ar, arvif, sta, arg);
+	ath12k_peer_assoc_h_rates(ar, arvif, sta, arg);
+	ath12k_peer_assoc_h_ht(ar, arvif, sta, arg);
+	ath12k_peer_assoc_h_vht(ar, arvif, sta, arg);
+	ath12k_peer_assoc_h_he(ar, arvif, sta, arg);
+	ath12k_peer_assoc_h_eht(ar, arvif, sta, arg);
+	ath12k_peer_assoc_h_qos(ar, arvif, sta, arg);
+	ath12k_peer_assoc_h_phymode(ar, arvif, sta, arg);
 	ath12k_peer_assoc_h_smps(sta, arg);
 
 	/* TODO: amsdu_disable req? */
@@ -2586,7 +2564,7 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 		return;
 	}
 
-	ath12k_peer_assoc_prepare(ar, vif, ap_sta, &peer_arg, false);
+	ath12k_peer_assoc_prepare(ar, arvif, ap_sta, &peer_arg, false);
 
 	rcu_read_unlock();
 
@@ -2701,23 +2679,20 @@ static u32 ath12k_mac_get_rate_hw_value(int bitrate)
 }
 
 static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
-					 struct ieee80211_vif *vif,
+					 struct ath12k_link_vif *arvif,
 					 struct cfg80211_chan_def *def)
 {
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	const struct ieee80211_supported_band *sband;
-	struct ath12k_link_vif *arvif;
 	u8 basic_rate_idx;
 	int hw_rate_code;
 	u32 vdev_param;
 	u16 bitrate;
 	int ret;
 
-	lockdep_assert_held(&ahvif->ah->conf_mutex);
 	lockdep_assert_held(&ar->conf_mutex);
 
-	arvif = &ahvif->deflink;
 	sband = hw->wiphy->bands[def->chan->band];
 	basic_rate_idx = ffs(vif->bss_conf.basic_rates) - 1;
 	bitrate = sband->bitrates[basic_rate_idx].bitrate;
@@ -3070,7 +3045,7 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 
 	if (changed & BSS_CHANGED_BASIC_RATES &&
 	    !ath12k_mac_vif_chan(vif, &def))
-		ath12k_recalculate_mgmt_rate(ar, vif, &def);
+		ath12k_recalculate_mgmt_rate(ar, arvif, &def);
 
 	if (changed & BSS_CHANGED_TWT) {
 		if (info->twt_requester || info->twt_responder)
@@ -3435,7 +3410,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 			 */
 			prev_ar = arvif->ar;
 			mutex_lock(&prev_ar->conf_mutex);
-			ret = ath12k_mac_vdev_delete(prev_ar, vif);
+			ret = ath12k_mac_vdev_delete(prev_ar, arvif);
 			mutex_unlock(&prev_ar->conf_mutex);
 			if (ret)
 				ath12k_warn(prev_ar->ab,
@@ -3446,7 +3421,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	}
 	if (create) {
 		mutex_lock(&ar->conf_mutex);
-		ret = ath12k_mac_vdev_create(ar, vif);
+		ret = ath12k_mac_vdev_create(ar, arvif);
 		mutex_unlock(&ar->conf_mutex);
 		if (ret) {
 			ath12k_warn(ar->ab, "unable to create scan vdev %d\n", ret);
@@ -3682,22 +3657,20 @@ static int ath12k_clear_peer_keys(struct ath12k_link_vif *arvif,
 }
 
 static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
-			      struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+			      struct ath12k_link_vif *arvif, struct ieee80211_sta *sta,
 			      struct ieee80211_key_conf *key)
 {
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ieee80211_vif *vif = ath12k_vif_to_vif(ahvif);
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_link_vif *arvif;
 	struct ath12k_peer *peer;
 	struct ath12k_sta *arsta;
 	const u8 *peer_addr;
 	int ret = 0;
 	u32 flags = 0;
 
-	lockdep_assert_held(&ahvif->ah->conf_mutex);
 	lockdep_assert_held(&ar->conf_mutex);
 
-	arvif = &ahvif->deflink;
 	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags))
 		return 1;
 
@@ -3850,7 +3823,7 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	 */
 
 	mutex_lock(&ar->conf_mutex);
-	ret = ath12k_mac_set_key(ar, cmd, vif, sta, key);
+	ret = ath12k_mac_set_key(ar, cmd, arvif, sta, key);
 	mutex_unlock(&ar->conf_mutex);
 	mutex_unlock(&ah->conf_mutex);
 	return ret;
@@ -3917,30 +3890,27 @@ ath12k_mac_set_peer_vht_fixed_rate(struct ath12k_link_vif *arvif,
 }
 
 static int ath12k_station_assoc(struct ath12k *ar,
-				struct ieee80211_vif *vif,
+				struct ath12k_link_vif *arvif,
 				struct ieee80211_sta *sta,
 				bool reassoc)
 {
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
 	int ret;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
-	struct ath12k_link_vif *arvif;
 	struct cfg80211_bitrate_mask *mask;
 	u8 num_vht_rates;
 
-	lockdep_assert_held(&ahvif->ah->conf_mutex);
 	lockdep_assert_held(&ar->conf_mutex);
 
-	arvif = &ahvif->deflink;
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return -EPERM;
 
 	band = def.chan->band;
 	mask = &arvif->bitrate_mask;
 
-	ath12k_peer_assoc_prepare(ar, vif, sta, &peer_arg, reassoc);
+	ath12k_peer_assoc_prepare(ar, arvif, sta, &peer_arg, reassoc);
 
 	ret = ath12k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
 	if (ret) {
@@ -4003,17 +3973,13 @@ static int ath12k_station_assoc(struct ath12k *ar,
 }
 
 static int ath12k_station_disassoc(struct ath12k *ar,
-				   struct ieee80211_vif *vif,
+				   struct ath12k_link_vif *arvif,
 				   struct ieee80211_sta *sta)
 {
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
-	struct ath12k_link_vif *arvif;
 	int ret;
 
-	lockdep_assert_held(&ahvif->ah->conf_mutex);
 	lockdep_assert_held(&ar->conf_mutex);
 
-	arvif = &ahvif->deflink;
 	if (!sta->wme) {
 		arvif->num_legacy_stations--;
 		ret = ath12k_recalc_rtscts_prot(arvif);
@@ -4079,7 +4045,7 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 			   ath12k_mac_max_vht_nss(vht_mcs_mask)));
 
 	if (changed & IEEE80211_RC_BW_CHANGED) {
-		ath12k_peer_assoc_h_phymode(ar, vif, sta, &peer_arg);
+		ath12k_peer_assoc_h_phymode(ar, arvif, sta, &peer_arg);
 		peer_phymode = peer_arg.peer_phymode;
 
 		if (bw > bw_prev) {
@@ -4174,7 +4140,7 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 			 * is provided in the new bitrate mask we set the
 			 * other rates using peer_assoc command.
 			 */
-			ath12k_peer_assoc_prepare(ar, vif, sta,
+			ath12k_peer_assoc_prepare(ar, arvif, sta,
 						  &peer_arg, true);
 
 			err = ath12k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
@@ -4223,20 +4189,17 @@ static void ath12k_mac_dec_num_stations(struct ath12k_link_vif *arvif,
 }
 
 static int ath12k_mac_station_add(struct ath12k *ar,
-				  struct ieee80211_vif *vif,
+				  struct ath12k_link_vif *arvif,
 				  struct ieee80211_sta *sta)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k_wmi_peer_create_arg peer_param;
-	struct ath12k_link_vif *arvif;
 	int ret;
 
-	lockdep_assert_held(&ahvif->ah->conf_mutex);
 	lockdep_assert_held(&ar->conf_mutex);
 
-	arvif = &ahvif->deflink;
 	ret = ath12k_mac_inc_num_stations(arvif, sta);
 	if (ret) {
 		ath12k_warn(ab, "refusing to associate station: too many connected already (%d)\n",
@@ -4368,7 +4331,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 		arsta->arvif = arvif;
 		INIT_WORK(&arsta->update_wk, ath12k_sta_rc_update_wk);
 
-		ret = ath12k_mac_station_add(ar, vif, sta);
+		ret = ath12k_mac_station_add(ar, arvif, sta);
 		if (ret)
 			ath12k_warn(ar->ab, "Failed to add station: %pM for VDEV: %d\n",
 				    sta->addr, arvif->vdev_id);
@@ -4411,7 +4374,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 		   (vif->type == NL80211_IFTYPE_AP ||
 		    vif->type == NL80211_IFTYPE_MESH_POINT ||
 		    vif->type == NL80211_IFTYPE_ADHOC)) {
-		ret = ath12k_station_assoc(ar, vif, sta, false);
+		ret = ath12k_station_assoc(ar, arvif, sta, false);
 		if (ret)
 			ath12k_warn(ar->ab, "Failed to associate station: %pM\n",
 				    sta->addr);
@@ -4455,7 +4418,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 		   (vif->type == NL80211_IFTYPE_AP ||
 		    vif->type == NL80211_IFTYPE_MESH_POINT ||
 		    vif->type == NL80211_IFTYPE_ADHOC)) {
-		ret = ath12k_station_disassoc(ar, vif, sta);
+		ret = ath12k_station_disassoc(ar, arvif, sta);
 		if (ret)
 			ath12k_warn(ar->ab, "Failed to disassociate station: %pM\n",
 				    sta->addr);
@@ -6195,24 +6158,22 @@ static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
 	ath12k_mac_update_vif_offload(&ahvif->deflink);
 }
 
-int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
+int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 {
 	struct ath12k_hw *ah = ar->ah;
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_hw *hw = ah->hw;
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ieee80211_vif *vif = ath12k_vif_to_vif(ahvif);
 	struct ath12k_wmi_vdev_create_arg vdev_arg = {0};
 	struct ath12k_wmi_peer_create_arg peer_param;
-	struct ath12k_link_vif *arvif;
 	u32 param_id, param_value;
 	u16 nss;
 	int i;
 	int ret, vdev_id;
 
-	lockdep_assert_held(&ah->conf_mutex);
 	lockdep_assert_held(&ar->conf_mutex);
 
-	arvif = &ahvif->deflink;
 	arvif->ar = ar;
 	vdev_id = __ffs64(ab->free_vdev_map);
 	arvif->vdev_id = vdev_id;
@@ -6413,19 +6374,16 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 	return ret;
 }
 
-static void ath12k_mac_vif_cache_flush(struct ath12k *ar, struct ieee80211_vif *vif)
+static void ath12k_mac_vif_cache_flush(struct ath12k *ar,  struct ath12k_link_vif *arvif)
 {
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
-	struct ath12k_vif_cache *cache;
+	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
+	struct ath12k_vif_cache *cache = arvif->cache;
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_link_vif *arvif;
+
 	int ret;
 
-	lockdep_assert_held(&ahvif->ah->conf_mutex);
 	lockdep_assert_held(&ar->conf_mutex);
 
-	arvif = &ahvif->deflink;
-	cache = arvif->cache;
 	if (!cache)
 		return;
 
@@ -6444,7 +6402,7 @@ static void ath12k_mac_vif_cache_flush(struct ath12k *ar, struct ieee80211_vif *
 	}
 
 	if (cache->key_conf.changed) {
-		ret = ath12k_mac_set_key(ar, cache->key_conf.cmd, vif, NULL,
+		ret = ath12k_mac_set_key(ar, cache->key_conf.cmd, arvif, NULL,
 					 cache->key_conf.key);
 		if (ret)
 			ath12k_warn(ab, "unable to apply set key param to vdev %d ret %d\n",
@@ -6454,19 +6412,15 @@ static void ath12k_mac_vif_cache_flush(struct ath12k *ar, struct ieee80211_vif *
 }
 
 static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
-						    struct ieee80211_vif *vif,
+						    struct ath12k_link_vif *arvif,
 						    struct ieee80211_chanctx_conf *ctx)
 {
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
-	struct ath12k_link_vif *arvif;
+	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
 	struct ath12k_hw *ah = hw->priv;
 	struct ath12k *ar, *prev_ar;
 	struct ath12k_base *ab;
 	int ret;
 
-	lockdep_assert_held(&ah->conf_mutex);
-	arvif = &ahvif->deflink;
-
 	if (ah->num_radio == 1)
 		ar = ah->radio;
 	else if (ctx)
@@ -6500,7 +6454,7 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 			 */
 			prev_ar = arvif->ar;
 			mutex_lock(&prev_ar->conf_mutex);
-			ret = ath12k_mac_vdev_delete(prev_ar, vif);
+			ret = ath12k_mac_vdev_delete(prev_ar, arvif);
 
 			if (ret)
 				ath12k_warn(prev_ar->ab, "unable to delete vdev %d\n",
@@ -6528,7 +6482,7 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 		goto unlock;
 	}
 
-	ret = ath12k_mac_vdev_create(ar, vif);
+	ret = ath12k_mac_vdev_create(ar, arvif);
 	if (ret) {
 		ath12k_warn(ab, "failed to create vdev %pM ret %d", vif->addr, ret);
 		goto unlock;
@@ -6539,7 +6493,7 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 	 * add_interface(), Apply any parameters for the vdev which were received
 	 * after add_interface, corresponding to this vif.
 	 */
-	ath12k_mac_vif_cache_flush(ar, vif);
+	ath12k_mac_vif_cache_flush(ar, arvif);
 unlock:
 	mutex_unlock(&ar->conf_mutex);
 	return arvif->ar;
@@ -6585,7 +6539,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 	 * creation until channel_assign to determine the radio on which the
 	 * vdev needs to be created
 	 */
-	ath12k_mac_assign_vif_to_vdev(hw, vif, NULL);
+	ath12k_mac_assign_vif_to_vdev(hw, arvif, NULL);
 	mutex_unlock(&ah->conf_mutex);
 	return 0;
 }
@@ -6615,18 +6569,15 @@ static void ath12k_mac_vif_unref(struct ath12k_dp *dp, struct ieee80211_vif *vif
 	}
 }
 
-static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ieee80211_vif *vif)
+static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ath12k_link_vif *arvif)
 {
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ieee80211_vif *vif = ath12k_vif_to_vif(ahvif);
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_link_vif *arvif;
 	unsigned long time_left;
 	int ret;
 
-	lockdep_assert_held(&ahvif->ah->conf_mutex);
 	lockdep_assert_held(&ar->conf_mutex);
-
-	arvif = &ahvif->deflink;
 	reinit_completion(&ar->vdev_delete_done);
 
 	ret = ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
@@ -6725,7 +6676,7 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 				    arvif->vdev_id, ret);
 	}
 
-	ath12k_mac_vdev_delete(ar, vif);
+	ath12k_mac_vdev_delete(ar, arvif);
 
 	mutex_unlock(&ar->conf_mutex);
 	mutex_unlock(&ah->conf_mutex);
@@ -7475,7 +7426,7 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	 */
 	mutex_lock(&ah->conf_mutex);
 	arvif = &ahvif->deflink;
-	ar = ath12k_mac_assign_vif_to_vdev(hw, vif, ctx);
+	ar = ath12k_mac_assign_vif_to_vdev(hw, arvif, ctx);
 	if (!ar) {
 		WARN_ON(1);
 		mutex_unlock(&ah->conf_mutex);
-- 
2.25.1


