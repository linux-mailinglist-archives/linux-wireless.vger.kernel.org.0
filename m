Return-Path: <linux-wireless+bounces-6780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103A68B134D
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 21:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315F11C21DD9
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 19:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BE82B9CD;
	Wed, 24 Apr 2024 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XwgUlVOF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EF9208A8
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985961; cv=none; b=HLtmsBG8yxgNmFvoqLIcUtDjQev5v1MTcuLbOBl8Labn8oVrK9/kOOWrhv2SqAOZo18+VEdRp6Qxh5TAV4dzLVimYE9C5/RIKXe/C5KuvtBUwkbcf/6/YzYbAbO6GvKMHdKs8F18KB0jpxwwjFBnsLkg+PRxMkL9CBunn0+603A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985961; c=relaxed/simple;
	bh=SfdMzEQ7oa7XylOR7O7iKFc3pM9dvS2jqWtPBhpKS2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D76APAlykeh5dBTzYuAFqhBvgZ0J1wBSjWZWp4fEoLSuZzInJ0ojzcJMH2+Hok/is+o9OfEeqvFHTsqoqsj0axNgzdEQYQH+Fymfky3BEs3oDYQL1FLjDGAoP6HPFMyKZSEwgqGLor16DgDZfKh8n/W6U6IyTQvG8pAUjWiZ8XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XwgUlVOF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OImhqh019668;
	Wed, 24 Apr 2024 19:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=/LBYD78N5xxMFvpRN/qj
	416xiF+z8ZPkCsfE+IMV1dc=; b=XwgUlVOFMF+h3g6tXH8BOUX9mBmh/3ik22f0
	0kJhLp6drwvE6VN5POBeETTkh3U+kIX7xTyEn1GhIdCtqSfQU9FB1oW5eBrDwe/d
	uiDx47UZvCz/zI0I29XKnstf1kYv3E9jtybdPV5QrSSlvuQ1F7CbaKftof47PtV8
	IHrYAwJRbus1TSGNZrCWV7m/jxz8ve3j2+b9Mr4NpF1q28wtl91KC2ufmTr7AMOn
	sR+ArTINoqkXoSwbpaN3HJm621jZVHSCQWtN72GKN3G9SYDHdBNae2fBY3Axw4+3
	s/FAvRT6sfEil1gAloKd5JecliX8Ham8wYDenTpHPHjIFRoIVg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9gswv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 19:11:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OJBrjm019402
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 19:11:53 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 12:11:52 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Avula Sri Charan <quic_asrichar@quicinc.com>
Subject: [PATCH V3 4/6] wifi: ath12k: add 6 GHz params in peer assoc command
Date: Wed, 24 Apr 2024 12:11:39 -0700
Message-ID: <20240424191141.32549-5-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240424191141.32549-1-quic_pradeepc@quicinc.com>
References: <20240424191141.32549-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-GUID: rpJLQro0wOu2NvOsTF4sXTcUZv7aNaRc
X-Proofpoint-ORIG-GUID: rpJLQro0wOu2NvOsTF4sXTcUZv7aNaRc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_16,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240091

Currently A-MPDU aggregation parameters are not being configured
during peer association for 6 GHz band. Hence, extract these
parameters from station's capabilities received in association
request and send to firmware. Without this, A-MPDU aggregation
is not happening in 6 GHz band.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Avula Sri Charan <quic_asrichar@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
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


