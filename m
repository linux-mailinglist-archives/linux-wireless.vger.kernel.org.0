Return-Path: <linux-wireless+bounces-19840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0649A542B3
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 07:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AF2168C68
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 06:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4D219CC39;
	Thu,  6 Mar 2025 06:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PpHKlOHV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BD619E966
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741242168; cv=none; b=B6dz8q+W3ZEBgDNHouxxggVxYmzSmsqC0MlTn5nMMUVw5I2zkPV0pqBqZ2VkztVkDzAifAH7uOeoojw64hN1s37NwTHR1m8Ho6MlzeBb53+b4SC+vgfXy45b6RDV0TCWnigF0aZiqxIJaGoFH40C+Sempbee3Q9pTcBYmOiEv4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741242168; c=relaxed/simple;
	bh=Z4Pz8EwNnciFbLJSFMgf1WL/VgL6AdVD7RFcJzyMp9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlT6CD+w1mT2NNy7TdoYr6rVXh1+REqLdBYRDd7NWy1dkfd+oMfdq17NiLIkXs3AN/osHa9ILs9pWPXGGpIBywdqI2RbeVx7xJRHiEIrj+dSRNgXMUMRIM+2ddcurrZ5adg+A3h7ywH/SL7HKVAS6/3OvbDzNAYbw+6tuQ40TYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PpHKlOHV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525MXns3013456;
	Thu, 6 Mar 2025 06:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sOyLJCxCWgotecAeatb0eT9G/3CPxuQqleRoXy8QoC0=; b=PpHKlOHVf1Ay34vd
	xXDVJyjgM8Szu5opSX4IAAEdgSlXqv6PNQr1IIf7VzsW4EQgjtdRwtg/C27MR6/B
	PqRf0y250Rm3GSH2HfylSjvx2PAOndN8A40DTAVUs5/OOSNIQOfvKjyEVqxTO69Y
	WNTQajC9UtLK0z99bE/dH6NkI4+9f/tCpftJfeU3IOXuk2amL5MEgwdBo6UEdBJP
	KQNQou3mk6qY+uwCEYKNii9C8yVVYfljqItW0NIxIlZZ8nt0f5/Tkf/Cc/OSoiKm
	30l1/Xj4vdidXb1YIiO5crwg4UVsmxKGTrSW1IhM8DlpAJ4v9O+AgPb52m+AJ0vb
	Ay8aOg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6wqtjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 06:22:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5266MKif027444
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Mar 2025 06:22:20 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Mar 2025 22:22:17 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        "Ramasamy
 Kaliappan" <quic_rkaliapp@quicinc.com>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
Subject: [PATCH wireless-next v4 1/4] wifi: cfg80211: Add support to get EMLSR capabilities of non-AP MLD
Date: Thu, 6 Mar 2025 11:51:54 +0530
Message-ID: <20250306062157.1185769-2-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306062157.1185769-1-quic_ramess@quicinc.com>
References: <20250306062157.1185769-1-quic_ramess@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=EZcyQOmC c=1 sm=1 tr=0 ts=67c93f1d cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=P1jSMS6-STP8i83e0X8A:9 a=xSf7fofPWiONnamsZ4Lw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: BCUABVju95WkKpm0IxazxVf07adh455L
X-Proofpoint-ORIG-GUID: BCUABVju95WkKpm0IxazxVf07adh455L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_03,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060045

From: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>

The Enhanced multi-link single-radio (EMLSR) operation allows a non-AP MLD
with multiple receive chains to listen on one or more EMLSR links when the
corresponding non-AP STA(s) affiliated with the non-AP MLD is (are) in
the awake state. [IEEE 802.11be-2024, (35.3.17 Enhanced multi-link
single-radio (EMLSR) operation)]

An MLD which intends to enable EMLSR operations will set the EML
Capabilities Present subfield to 1 and shall set the EMLSR Support
subfield in the Common Info field of the Basic Multi-Link element to 1 in
all Management frames that include the Basic Multi-Link element except
Authentication frames. EML capabilities contains information such as
EML Transition timeout, Padding delay and Transition delay. These fields
needs to updated to drivers to trigger EMLSR operation and to transmit and
receive initial control frame and data frames.

Add support to receive EML Capabilities subfield that non-AP MLD
advertises during (re)association request and send it to underlying
drivers during ADD/SET station.

Signed-off-by: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 include/net/cfg80211.h |  5 +++++
 net/wireless/nl80211.c | 16 +++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6b170a8d086c..43343392878a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1756,6 +1756,9 @@ struct cfg80211_ttlm_params {
  * @supported_oper_classes_len: number of supported operating classes
  * @support_p2p_ps: information if station supports P2P PS mechanism
  * @airtime_weight: airtime scheduler weight for this station
+ * @eml_cap_present: Specifies if EML capabilities field (@eml_cap) is
+ *	present/updated
+ * @eml_cap: EML capabilities of this station
  * @link_sta_params: link related params.
  */
 struct station_parameters {
@@ -1780,6 +1783,8 @@ struct station_parameters {
 	u8 supported_oper_classes_len;
 	int support_p2p_ps;
 	u16 airtime_weight;
+	bool eml_cap_present;
+	u16 eml_cap;
 	struct link_station_parameters link_sta_params;
 };
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2c4e06610a79..2aa971884d4c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -833,6 +833,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
+	[NL80211_ATTR_EML_CAPABILITY] = { .type = NLA_U16 },
 	[NL80211_ATTR_PUNCT_BITMAP] =
 		NLA_POLICY_FULL_RANGE(NLA_U32, &nl80211_punct_bitmap_range),
 
@@ -7095,7 +7096,8 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 		if (params->ext_capab || params->link_sta_params.ht_capa ||
 		    params->link_sta_params.vht_capa ||
 		    params->link_sta_params.he_capa ||
-		    params->link_sta_params.eht_capa)
+		    params->link_sta_params.eht_capa ||
+		    params->eml_cap_present)
 			return -EINVAL;
 		if (params->sta_flags_mask & BIT(NL80211_STA_FLAG_SPP_AMSDU))
 			return -EINVAL;
@@ -7462,6 +7464,12 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 		params.link_sta_params.he_6ghz_capa =
 			nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
 
+	if (info->attrs[NL80211_ATTR_EML_CAPABILITY]) {
+		params.eml_cap_present = true;
+		params.eml_cap =
+			nla_get_u16(info->attrs[NL80211_ATTR_EML_CAPABILITY]);
+	}
+
 	if (info->attrs[NL80211_ATTR_AIRTIME_WEIGHT])
 		params.airtime_weight =
 			nla_get_u16(info->attrs[NL80211_ATTR_AIRTIME_WEIGHT]);
@@ -7620,6 +7628,12 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
+	if (info->attrs[NL80211_ATTR_EML_CAPABILITY]) {
+		params.eml_cap_present = true;
+		params.eml_cap =
+			nla_get_u16(info->attrs[NL80211_ATTR_EML_CAPABILITY]);
+	}
+
 	if (info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY])
 		params.link_sta_params.he_6ghz_capa =
 			nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
-- 
2.34.1


