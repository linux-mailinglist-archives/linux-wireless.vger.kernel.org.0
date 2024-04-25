Return-Path: <linux-wireless+bounces-6893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8F78B2CF5
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 00:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE401F24F6D
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 22:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330E415534E;
	Thu, 25 Apr 2024 22:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DDZREhtA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EBB12BF28
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083559; cv=none; b=gcz05UttpNylZl9o6F64+W6e+QBY0ZbYgfJ7ndKxpCikmkwrIFDaEJMHgCWogGSL6YGviApPHPUOoH9DOLdnfxDJiiFrAi4KeE2QFf3pcjAYGfT5+IBTXFvk3PwUkYftMhV7XDl0mrk82kqHB6gsNAccCTrOJUBtZeugrd3ix6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083559; c=relaxed/simple;
	bh=24pB/PeNAqB0FIM6cMtv0BKq/iULjbg2ogZaOPJaPAI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bhvn3e2Vs06new+6UrBLcXgyOqloh2RRNkVJb++IFm8qI7iiPhEbrlfWaQ2tsiUhg3paHkEVnH+V3BQ4VHVZKKyQ23EnS4Q5lkSwp7o4GknNS9j1wrsFAdXZBf9Uf5TqJ4/BswPtpD734/HiY1jWLIFyAINF/BtSo8UqHHBM4qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DDZREhtA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PKoaMY001070;
	Thu, 25 Apr 2024 22:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=oHKA8+VqBDzsY8fayU1Q
	6hNtqjqQoKF8Lqi7tRWllWM=; b=DDZREhtAki8iW4geWfSvjZJ/T1flk41p8jSY
	6fTNBlmZfBjyjfGzknXDASWo44EQgEfgeG/CBIqyBxEo3+ITt3y44j5r32adeDho
	nWAWg/Fm3lhkkD01/3A46SNjA0eR3nLiLQU9eVTE7gxsv3zuMuIYb29OEvJo65/0
	pWSatnD/zu6D1x70L+KZF+HWrlH8aEND8lDMzPkIe+SnRjCexDf9SAqn59buduk5
	2c4A/cS6POouaFO+EGVFUTDKKZIU7ap6CwkoeFsksI4IQtZYXJNLJk93Pqj1hQrf
	9rdNBFeHM3AtN6Hcnjnrxr0SmVeWSphg7wMFWYMpL699wFRgKg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqn0whyxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 22:19:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PMJEU4009333
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 22:19:14 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 15:19:13 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Avula Sri Charan <quic_asrichar@quicinc.com>
Subject: [PATCH V4 4/6] wifi: ath12k: add 6 GHz params in peer assoc command
Date: Thu, 25 Apr 2024 15:19:00 -0700
Message-ID: <20240425221902.11553-5-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240425221902.11553-1-quic_pradeepc@quicinc.com>
References: <20240425221902.11553-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S576gB03XVZDWxFR2-Bzygv5kL6j6CFh
X-Proofpoint-GUID: S576gB03XVZDWxFR2-Bzygv5kL6j6CFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250163

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
index 830f35fb89fe..8836dc67f7e0 100644
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
@@ -8690,7 +8745,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	ieee80211_hw_set(hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(hw, REPORTS_LOW_ACK);
 
-	if (ht_cap & WMI_HT_CAP_ENABLED) {
+	if ((ht_cap & WMI_HT_CAP_ENABLED) || ar->supports_6ghz) {
 		ieee80211_hw_set(hw, AMPDU_AGGREGATION);
 		ieee80211_hw_set(hw, TX_AMPDU_SETUP_IN_HW);
 		ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
-- 
2.17.1


