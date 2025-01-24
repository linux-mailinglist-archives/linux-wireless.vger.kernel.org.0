Return-Path: <linux-wireless+bounces-17909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F159CA1BB4F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 18:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 833C57A33F6
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 17:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFB31CEACD;
	Fri, 24 Jan 2025 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="anhtpx9a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD31C5F2B
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737739128; cv=none; b=djg81OerNZpxur5pDbTzjV76s19uwPH1Ea5dQYYRVSOzmDHj++6xIt9ffxZNMInUqWEUmTLG+Z0iRgXVkmE28SXquqoBinyTDVE6Hvyc2P0MwGjJpW2BSoGqbE46H8vjSJ8/r0Ab98XLO2SGMpyF512up5ox9kDhMpYlbVRxl7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737739128; c=relaxed/simple;
	bh=EcOrJlFZicRcbnJ9uI8smwG2hJLHD61BsDKEzsIgBSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tx8Lj5uDJ2iJAA+KCF9A4FQMMcbLgVQv752AbrUUNUSAy6MY8qMgzk1eEx1HY0cNbP6qquWZoisGQp1wYopTPCZx6RN8LE1fw66D6K7e+y0p/bKFeRtA2KI5Yj5AM0YGDtoJSiRFW1vfOyME2tB8bqWLtEdRojTvtj3y90bJFBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=anhtpx9a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OESdWm000841;
	Fri, 24 Jan 2025 17:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fWr5jYj/qo/u5XZ1klxphiK0LlfAgc7CITgqsHw0MjE=; b=anhtpx9aT52QsYz8
	sXqorewnOTfoI0R4XzNtOHpDc9jfwpIwQLHj+boJdR3rvXCosMWBGKYPwGDxJj+3
	DE7VmvG1wVQohMmLH05qHL1JMTy5DcqQCem6dwsOzb8K0FgLDBmwqCqOzfx+9lbA
	Wjr0g8Lc6u+houqH1yGpYrTLI1j6+LgnipbAQC3WPaHrRU20CAj7+O8068ZQ/1hP
	WtawjBFwRMrkJt6Uqc37ijeVgY7UqL0mJAid6WttLw9BuoSZeYHBSoXzOfBIRbj9
	UFhv1yOsOP4bGoQpYguA5u16v5IFV6uHxOlng2s+K8NiIuusCSM9uv98rTDXKMWK
	t7IuwQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ccnn8cx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 17:18:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50OHIgeM027855
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 17:18:42 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 24 Jan 2025 09:18:40 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v2 2/5] wifi: cfg80211: Report per-radio RTS threshold to userspace
Date: Fri, 24 Jan 2025 22:47:53 +0530
Message-ID: <20250124171756.3418663-3-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124171756.3418663-1-quic_rdevanat@quicinc.com>
References: <20250124171756.3418663-1-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ep28B7rQ7H_1SXMKtOj8LHnebK8-8h9x
X-Proofpoint-GUID: Ep28B7rQ7H_1SXMKtOj8LHnebK8-8h9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240120

In case of multi-radio wiphys, with per-radio RTS threshold brought
into use, RTS threshold for each radio in a wiphy can be recorded in
wiphy parameter - wiphy_radio_cfg, as an array. Add a new attribute -
NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD in nested parameter -
NL80211_ATTR_WIPHY_RADIOS. When a request for getting RTS threshold
for a particular radio is received, parse the radio id and get the
required data. Add this data to the newly added nested attribute
NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD. Add support to report this
data to userspace.

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 include/uapi/linux/nl80211.h | 1 +
 net/wireless/nl80211.c       | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 5e7dca7c6083..a140e2f2f7ee 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8087,6 +8087,7 @@ enum nl80211_wiphy_radio_attrs {
 	NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE,
 	NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATION,
 	NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK,
+	NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD,
 
 	/* keep last */
 	__NL80211_WIPHY_RADIO_ATTR_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0cf6533a7ecb..e2e70250527e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2439,6 +2439,7 @@ static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
 static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, int idx)
 {
 	const struct wiphy_radio *r = &wiphy->radio[idx];
+	const struct wiphy_radio_cfg *rcfg = &wiphy->radio_cfg[idx];
 	struct nlattr *radio, *freq;
 	int i;
 
@@ -2449,6 +2450,9 @@ static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, int idx)
 	if (nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_INDEX, idx))
 		goto nla_put_failure;
 
+	if (nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD, rcfg->rts_threshold))
+		goto nla_put_failure;
+
 	if (r->antenna_mask &&
 	    nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK,
 			r->antenna_mask))
@@ -3231,7 +3235,8 @@ static int nl80211_dump_wiphy(struct sk_buff *skb, struct netlink_callback *cb)
 						 skb,
 						 NETLINK_CB(cb->skb).portid,
 						 cb->nlh->nlmsg_seq,
-						 NLM_F_MULTI, state);
+						 NLM_F_MULTI,
+						 state);
 			if (ret < 0) {
 				/*
 				 * If sending the wiphy data didn't fit (ENOBUFS
-- 
2.17.1


