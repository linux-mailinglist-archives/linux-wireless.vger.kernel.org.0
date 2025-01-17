Return-Path: <linux-wireless+bounces-17654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4AEA15542
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 18:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FCC97A1A18
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430281A00F2;
	Fri, 17 Jan 2025 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mY/3tgfu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B219F419
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133490; cv=none; b=KSo5hucfhdmyZBMnDa//DoZpCw1LG5DWxL6HzeeBjWkyg0BPpNYna1e62/9XtoUjpvPMDT7REM4tn/A63HA2wES+7jLZxRUh43SKof3bvzVtsmt3jLKBMHCr2gKVx4F65rv06yPlgpCjWF8BdEFYFWbVCWDoX9Pz+bjs70g4qSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133490; c=relaxed/simple;
	bh=i+RzHJQN0ZCQZ6Bk9RTDZz0cUB6cdbxXMCWCHzkF3IE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaPVoX8CH0ItLxX3htXarc/gioeaGxQDUUDPqt1qUY0xiCEnxx4blOAOgNj0TjI6uV+AvZ8X6lqrwHTaUIYHiD5C11eMLbUWZmNM7HJNFauYOWdbG3CKvkSvYhWsJ5BEpWv0ox6gbpMstOVQX5XxSfEtBSxBIfj6bIU4UHu0rEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mY/3tgfu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H9J2Bw030838;
	Fri, 17 Jan 2025 17:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KjBeHy+JsYR11EmXaMnb367kiBQ7+Qc6TgIurHgpesE=; b=mY/3tgfuAADAzTjQ
	qQqomrKbzl1ISIXdG/qf4/U7NNGbb1Yq81nTD6r4UzXyiXBo0aCXl0FOVOS8avXk
	ZQRwJMgzppjJHwhEe9H3OLE/7PuP8A0dwuDJaog3XyRsSuGxIn68OoZf+QvPzBm5
	Aq+GtvfbAIcuCcjrAa+xo8EqhgvGMs/8+mFB/fR6V4iVvFu8cITGcHJhyfG+z33b
	tA3ip9pbj2AK2tinwPsIIlVjRW0SNTlyqoI5zAC5gSPLTtpDFmXMdtjmhhmrVYeW
	YdP2vMzEwQKgh9xQdHHwHyLXqz8OblrqWImrFnEZP8QoJCh7bTrXM25Gzva8gyWb
	b8Am3Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447mfcs61f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 17:04:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50HH4fE1020827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 17:04:41 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 17 Jan 2025 09:04:38 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        "Ramasamy
 Kaliappan" <quic_rkaliapp@quicinc.com>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
Subject: [PATCH v2 1/3] wifi: cfg80211: Add support to get EMLSR capabilities of non-AP MLD
Date: Fri, 17 Jan 2025 22:34:14 +0530
Message-ID: <20250117170416.2907530-2-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250117170416.2907530-1-quic_ramess@quicinc.com>
References: <20250117170416.2907530-1-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: aqDtKxLtzHi2GTGLfWvX2EBQfwlZ5AV-
X-Proofpoint-ORIG-GUID: aqDtKxLtzHi2GTGLfWvX2EBQfwlZ5AV-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170134

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
 net/wireless/nl80211.c | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 363d7dd2255a..7a80dbf37881 100644
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
index d7d3da0f6833..8e5002aaedab 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -833,6 +833,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
+	[NL80211_ATTR_EML_CAPABILITY] = { .type = NLA_U16 },
 	[NL80211_ATTR_PUNCT_BITMAP] =
 		NLA_POLICY_FULL_RANGE(NLA_U32, &nl80211_punct_bitmap_range),
 
@@ -7457,6 +7458,12 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
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
@@ -7615,6 +7622,11 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
+	if (info->attrs[NL80211_ATTR_EML_CAPABILITY]) {
+		params.eml_cap_present = true;
+		params.eml_cap = nla_get_u16(info->attrs[NL80211_ATTR_EML_CAPABILITY]);
+	}
+
 	if (info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY])
 		params.link_sta_params.he_6ghz_capa =
 			nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
-- 
2.34.1


