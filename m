Return-Path: <linux-wireless+bounces-7348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8162C8C0341
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 19:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F78280F62
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 17:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E0012AAC7;
	Wed,  8 May 2024 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GDyhBSF3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BB838F9A
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189839; cv=none; b=OIenjXz+dOWjel+b7AveSyhgLOPva6q3Zu4tVyJNbRehN7L4yECnJf1MrRYkGcQOYC1bxcAa4WdN9hEYkTSO+d5LS0br4ZwuZrzLHO0lAmRaTYzW43O3dFirSC0+W+0T14vRgjdlJ4xY2czOZDGxG6pv1sTnS+uuDUeEO5ERp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189839; c=relaxed/simple;
	bh=tgyA6sqcsuowTN18RjQKhfPwNfJFFZMI2QzbE0QFUes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3mXqOvxJtkafCX0QgV6Wdfms1lvRX/tzMUWAmtr1qa7jOsLSWl0YsNRoRYKoAGFyH82VpSvBW6/6Ldr8VoXkvWUTwOrmNo+Fz1nDtgC7Gra25b/uFvWUWGHtehtc0y/jfUYM7msKJkn3aV/drWxi4LPtt9gg/rdNiBXIei7MUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GDyhBSF3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448AeAUP004932;
	Wed, 8 May 2024 17:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=NaODXAH2dc8GoaRnwU9S
	1sigBWDVKpmwT+z7Pcub4Mo=; b=GDyhBSF3vw0s/W41LplwKy6C+Ml7zNe1yeiD
	ngw9MBGS6/KZm+gvGSqEphEQ4Lo7rfvW0A8EOEduItAUPJf3y1mb96W9zrlTvb24
	ONA3jwP/8MZ1vdLlxsbQ/XfTNfjTwCpvxIRkiGWVJBtDKEeJHPiZU6XvFkvDR6Pz
	K/CKs25cNTZfLt8+GgFJqO51tv7lRyB/AySRfOwRW6EclfCtoxAxx/LkfqxSfbmE
	w9WC1JUInpWugRFESlKjgJGP1Xh7Mwd4pId0QwZHNpFPqOHDoNwb5NpzW9V+R7eN
	P7X3bzLmOcW+irEfNWFUnzH1UwkNBg/LDP+y4O2C5XC8IrOX/g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y07u990xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 17:37:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 448Hb8p3001895
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 17:37:08 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 May 2024 10:37:07 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Avula Sri Charan <quic_asrichar@quicinc.com>
Subject: [PATCH V5 4/6] wifi: ath12k: add 6 GHz params in peer assoc command
Date: Wed, 8 May 2024 10:36:53 -0700
Message-ID: <20240508173655.22191-5-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508173655.22191-1-quic_pradeepc@quicinc.com>
References: <20240508173655.22191-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-GUID: SzmVjxMlkzjiydPzS8Fw_W3Q6NC2wnhG
X-Proofpoint-ORIG-GUID: SzmVjxMlkzjiydPzS8Fw_W3Q6NC2wnhG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080128

Currently A-MPDU aggregation parameters are not being configured
during peer association for 6 GHz band. Hence, extract these
parameters from station's capabilities received in association
request and send to firmware. Without this, A-MPDU aggregation
is not happening in 6 GHz band.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Co-developed-by: Avula Sri Charan <quic_asrichar@quicinc.com>
Signed-off-by: Avula Sri Charan <quic_asrichar@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 57 ++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8af450cdace6..b9b9f4d17b34 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2032,6 +2032,60 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	}
 }
 
+static void ath12k_peer_assoc_h_he_6ghz(struct ath12k *ar,
+					struct ieee80211_vif *vif,
+					struct ieee80211_sta *sta,
+					struct ath12k_wmi_peer_assoc_arg *arg)
+{
+	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
+	struct cfg80211_chan_def def;
+	enum nl80211_band band;
+	u8 ampdu_factor, mpdu_density;
+
+	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
+		return;
+
+	band = def.chan->band;
+
+	if (!arg->he_flag || band != NL80211_BAND_6GHZ || !sta->deflink.he_6ghz_capa.capa)
+		return;
+
+	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_40)
+		arg->bw_40 = true;
+
+	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_80)
+		arg->bw_80 = true;
+
+	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
+		arg->bw_160 = true;
+
+	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_320)
+		arg->bw_320 = true;
+
+	arg->peer_he_caps_6ghz = le16_to_cpu(sta->deflink.he_6ghz_capa.capa);
+
+	mpdu_density = u32_get_bits(arg->peer_he_caps_6ghz,
+				    IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
+	arg->peer_mpdu_density = ath12k_parse_mpdudensity(mpdu_density);
+
+	/* From IEEE Std 802.11ax-2021 - Section 10.12.2: An HE STA shall be capable of
+	 * receiving A-MPDU where the A-MPDU pre-EOF padding length is up to the value
+	 * indicated by the Maximum A-MPDU Length Exponent Extension field in the HE
+	 * Capabilities element and the Maximum A-MPDU Length Exponent field in HE 6 GHz
+	 * Band Capabilities element in the 6 GHz band.
+	 *
+	 * Here, we are extracting the Max A-MPDU Exponent Extension from HE caps and
+	 * factor is the Maximum A-MPDU Length Exponent from HE 6 GHZ Band capability.
+	 */
+	ampdu_factor = u8_get_bits(he_cap->he_cap_elem.mac_cap_info[3],
+				   IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK) +
+			u32_get_bits(arg->peer_he_caps_6ghz,
+				     IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
+
+	arg->peer_max_mpdu = (1u << (IEEE80211_HE_6GHZ_MAX_AMPDU_FACTOR +
+				     ampdu_factor)) - 1;
+}
+
 static void ath12k_peer_assoc_h_smps(struct ieee80211_sta *sta,
 				     struct ath12k_wmi_peer_assoc_arg *arg)
 {
@@ -2504,6 +2558,7 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 	ath12k_peer_assoc_h_ht(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_vht(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_he(ar, vif, sta, arg);
+	ath12k_peer_assoc_h_he_6ghz(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_eht(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_qos(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_phymode(ar, vif, sta, arg);
@@ -8701,7 +8756,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	ieee80211_hw_set(hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(hw, REPORTS_LOW_ACK);
 
-	if (ht_cap & WMI_HT_CAP_ENABLED) {
+	if ((ht_cap & WMI_HT_CAP_ENABLED) || ar->supports_6ghz) {
 		ieee80211_hw_set(hw, AMPDU_AGGREGATION);
 		ieee80211_hw_set(hw, TX_AMPDU_SETUP_IN_HW);
 		ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
-- 
2.17.1


