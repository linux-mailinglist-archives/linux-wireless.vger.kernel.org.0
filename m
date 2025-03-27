Return-Path: <linux-wireless+bounces-20885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39470A729CC
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 06:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF9E17230F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 05:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEA51B87C0;
	Thu, 27 Mar 2025 05:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CchQFZTk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12591B87CE
	for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 05:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743052490; cv=none; b=JbGbzdMc+F9tPAefqLgFlZvU8u+jLnNeckSSnyrkHzs9WJH2WdwPLvkt7/Fthtg5LQBC8SGyTS2wYMJUGDUrQKszyWmXPYwPrIZPDmEdf7tNEDJnik9oknLebciKEpAT+PgD82DKHN39zBvG2oeyVZH+obOqSID0tn7MUUtEE4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743052490; c=relaxed/simple;
	bh=c84nu7Z/BAX54NdB4TTQJrQeMcGOPytSOd3VLvdeaRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fS5So1U4uASYvkEqZ4mg3Vn2/KPhMYRxnXv88EcJbFscUWj6s6EcDtyjsbtXJqFk0/Z5a9N9GUB6NFfzpJUESoedDfypDNdeFjtLDKLVsHIQKxtXS/j21VsrxpA52pbwIG00XzyKHw1jXKITf6bVfVwylpHbXq+8nsJo9wYGLOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CchQFZTk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R4eAoT024572;
	Thu, 27 Mar 2025 05:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5W9qT738Fw8H57Pc3GZROhCuGf2CoW0X8Pb5cKFgQa0=; b=CchQFZTkoTIA8dWi
	mcWup0IIwMC+oFXBnjxD/nFyJbRb9Xseg3GJWM9Foxs00KpnMXtlOx89sCvhltKf
	jm/8tEmYcMH7EW64SFJICjbJRigCS3X5TfUev8LfZA4pLjfSjxMstBfQfaQQ5W17
	uco1FdCHshda1yE+bbN1Y64PVVvppxbrZT+NPfovHN5CExC8gzS576oNC2t/lqJc
	AqO+vgScc4WKedJYwjnECD95XduVnGucrEoRMcvQ6uloyDgoThGylBn2qgD7foUi
	yx/+PIAC344Y+990aM2OPRblnLKT9plb8UEgSlhQWRN7iLEC/+hPIHz/BJ37eKlo
	ZsiXVw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmd379s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 05:14:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52R5EKgw024338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 05:14:20 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Mar 2025 22:13:52 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Ramasamy Kaliappan
	<quic_rkaliapp@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH wireless-next v5 1/4] wifi: cfg80211: Add support to get EMLSR capabilities of non-AP MLD
Date: Thu, 27 Mar 2025 10:43:17 +0530
Message-ID: <20250327051320.3253783-2-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327051320.3253783-1-quic_ramess@quicinc.com>
References: <20250327051320.3253783-1-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: Vk0w9MSGjXN4wIkLOanU8jpj8z-ArSxG
X-Proofpoint-ORIG-GUID: Vk0w9MSGjXN4wIkLOanU8jpj8z-ArSxG
X-Authority-Analysis: v=2.4 cv=P646hjAu c=1 sm=1 tr=0 ts=67e4dead cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=P1jSMS6-STP8i83e0X8A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270031

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
 net/wireless/nl80211.c | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index efbd79c67be2..b9032649b081 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1770,6 +1770,9 @@ struct cfg80211_ttlm_params {
  * @supported_oper_classes_len: number of supported operating classes
  * @support_p2p_ps: information if station supports P2P PS mechanism
  * @airtime_weight: airtime scheduler weight for this station
+ * @eml_cap_present: Specifies if EML capabilities field (@eml_cap) is
+ *	present/updated
+ * @eml_cap: EML capabilities of this station
  * @link_sta_params: link related params.
  */
 struct station_parameters {
@@ -1794,6 +1797,8 @@ struct station_parameters {
 	u8 supported_oper_classes_len;
 	int support_p2p_ps;
 	u16 airtime_weight;
+	bool eml_cap_present;
+	u16 eml_cap;
 	struct link_station_parameters link_sta_params;
 };
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f039a7d0d6f7..e1c1c06ebbb4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -833,6 +833,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
+	[NL80211_ATTR_EML_CAPABILITY] = { .type = NLA_U16 },
 	[NL80211_ATTR_PUNCT_BITMAP] =
 		NLA_POLICY_FULL_RANGE(NLA_U32, &nl80211_punct_bitmap_range),
 
@@ -7118,6 +7119,10 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 			return -EINVAL;
 	}
 
+	/* Reject EMLSR capabilities change after association */
+	if (statype == CFG80211_STA_AP_CLIENT && params->eml_cap_present)
+		return -EINVAL;
+
 	switch (statype) {
 	case CFG80211_STA_AP_MLME_CLIENT:
 		/* Use this only for authorizing/unauthorizing a station */
@@ -7473,6 +7478,12 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
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
@@ -7631,6 +7642,12 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
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


