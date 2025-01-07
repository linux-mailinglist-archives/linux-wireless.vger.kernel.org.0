Return-Path: <linux-wireless+bounces-17158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1276EA0489E
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 18:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E2C3A63AA
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 17:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A59315D1;
	Tue,  7 Jan 2025 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hWAYCw6a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5BD1898F8
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736272314; cv=none; b=UiZ/Xd0TBKlzhKKucK/qvpgZzBKKJEzci5SGDPPeLo/ZborSwZHK+9H5oM1RiHs84qM1ay4j/XuAXN3UYOtoLpmuLNUnzA44vLpLLIdvq4Oc17bIEK11Hjm6KjXN4EYyYVk/s3KZ29J5tN0u9qQpzRqLibYEbNBS9fBeO/dBptA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736272314; c=relaxed/simple;
	bh=fszSB19qpumZEn59n9ClkUTCeWwCsH74kLFqRe75EVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIMEncbOfSKRpdA5PfoRgSKRmykyr4lkUEyghhxBvmXU7Xae9R/XIPTxJRBhvx0LauLa4phHFOoiwS56/xBzK2yjpWuR4RVROmmg7GiG95/hD42C6O+8HbZjCPUCVDpmX7aC+hEcqmYQN/D0dcpwWPVwACadvHnyAYGSa4TjJHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hWAYCw6a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507A8g9P023524;
	Tue, 7 Jan 2025 17:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eCCSh1DACLIv5hWMV3+5xU1KCWv0Ytm/J9IChqZwMzM=; b=hWAYCw6afK5CqZYL
	Z7lVLIbROCCHySCs4Na3cXqlPbCkCOUqryh6kiEL5mNDaa6YQK2gdtfEwbYFiqaX
	CvKX7crJWVfii63EBZR0DnupgP9UPNNU8Am209y/LAqhN1uW8wV0U8t1SFwQNoM7
	WYlwZD3fw3Fflon7IZTbn/UFa9g/6cCW3a49xCM/NXYveYz6eIoIQwwCUZDYP92o
	x1+vMInh+xA+RlftiMG6AhUqf7mhUYSkxnzpwecsKK6/rPJyaYVz6vufsRYYFkCI
	0h5JNYasEaEM0LBp9JA+S1GWaQDJ9VW4gSfUew+auWxt9w1wKE9RBWSnsP5QrpyM
	bOn/QA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44128ns5ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 17:51:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 507Hpbp5032478
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 17:51:37 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 Jan 2025 09:51:35 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Ramasamy Kaliappan
	<quic_rkaliapp@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH 1/3] wifi: cfg80211: Add support to get EMLSR capabilities of non-AP MLD
Date: Tue, 7 Jan 2025 23:18:00 +0530
Message-ID: <20250107174802.1793252-2-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107174802.1793252-1-quic_ramess@quicinc.com>
References: <20250107174802.1793252-1-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: Ak0LweqwhII0e7cxcPOPI_MPER7yIcXh
X-Proofpoint-ORIG-GUID: Ak0LweqwhII0e7cxcPOPI_MPER7yIcXh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070148

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
 include/net/cfg80211.h | 2 ++
 net/wireless/nl80211.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0a48f47a77dc..84d2a0b25144 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1756,6 +1756,7 @@ struct cfg80211_ttlm_params {
  * @supported_oper_classes_len: number of supported operating classes
  * @support_p2p_ps: information if station supports P2P PS mechanism
  * @airtime_weight: airtime scheduler weight for this station
+ * @eml_cap: EML capabilities of this station
  * @link_sta_params: link related params.
  */
 struct station_parameters {
@@ -1780,6 +1781,7 @@ struct station_parameters {
 	u8 supported_oper_classes_len;
 	int support_p2p_ps;
 	u16 airtime_weight;
+	u16 eml_cap;
 	struct link_station_parameters link_sta_params;
 };
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8789d8b73f0f..41abbdf3e571 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -818,6 +818,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
+	[NL80211_ATTR_EML_CAPABILITY] = { .type = NLA_U16 },
 	[NL80211_ATTR_PUNCT_BITMAP] =
 		NLA_POLICY_FULL_RANGE(NLA_U32, &nl80211_punct_bitmap_range),
 
@@ -7437,6 +7438,10 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 		params.link_sta_params.he_6ghz_capa =
 			nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
 
+	if (info->attrs[NL80211_ATTR_EML_CAPABILITY])
+		params.eml_cap =
+			nla_get_u16(info->attrs[NL80211_ATTR_EML_CAPABILITY]);
+
 	if (info->attrs[NL80211_ATTR_AIRTIME_WEIGHT])
 		params.airtime_weight =
 			nla_get_u16(info->attrs[NL80211_ATTR_AIRTIME_WEIGHT]);
@@ -7595,6 +7600,9 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
+	if (info->attrs[NL80211_ATTR_EML_CAPABILITY])
+		params.eml_cap = nla_get_u16(info->attrs[NL80211_ATTR_EML_CAPABILITY]);
+
 	if (info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY])
 		params.link_sta_params.he_6ghz_capa =
 			nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
-- 
2.34.1


