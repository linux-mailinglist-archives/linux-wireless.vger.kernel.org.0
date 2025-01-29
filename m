Return-Path: <linux-wireless+bounces-18152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 837C1A220EC
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 16:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9D518845CD
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F72518F2EA;
	Wed, 29 Jan 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BF4LT93m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB31DE4F8
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165997; cv=none; b=QXYBeDEh9IM3DtPnyoV45WXkFPPz9KtahhO2BhYtQoxyZi/e6oHckjgdb/g1QPaQ9oeTtMaswdLbIsnyHJ8IEzvQEm4efQpW2jP2ChWqEW8S1GrKEL/ZUSAiLC0X7g0LABoMJrTxGqY+gfByPkhe265fHm2USQjHsslcYpTMGy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165997; c=relaxed/simple;
	bh=RTZbuDZDJuHI3V4L1j7ii78atK9wWg37C5vp8cDMb7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnI/THHKxwebnDOQ1lZsZTakMzpMBP8sqqjo5BdbyrjuX+0qxmnIDNgE8mXHDp1vRbg6ybMELGvrvZjvtLaCQtddkOO40S0Os3bT4exB9P7W6Foqf0oPMFsnF3WMaZCx36mFYPiOEJihrRdSlwgM7k46JaHjWfjE6wEl7uzOPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BF4LT93m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TFXk4K002563;
	Wed, 29 Jan 2025 15:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FVAz9kkYu0VLsoEhbkDOQcaBLCextydq9SyoJpR3Muo=; b=BF4LT93mB2+GMRVO
	ln+lAhQfBzMz9BQS9NIyG5F2u+mSGG7yNUO1ftNjQ0coyMppsaQETdryuf6HBEZv
	Cb+zMTBzwZ1T/MUlRfm0pqir82laT0DBr64hS/Fv2b1nN/L/6TDpd4e+8Vq9cNm5
	YnVYH9f9ZWDwz9GJtVZKHiQBTMQeMNd+7/bSTupqlFtwxlaXm5CXzr8BQ7eQ00R6
	06gVmXVlARCBf+u7mQZ7/ydnjSmvUemrp9azN+RWFldSp/sge1+u3Uk3TBO0hOPB
	Li/aHOKyJjwXecpfzEq7tJ6ygAV9MabL1ZAfkg6tet2eyHu8h6QWcciL01VIaohk
	0kb/yg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fq3401qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 15:53:09 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50TFr834025386
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 15:53:08 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 29 Jan 2025 07:53:06 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v4 2/5] wifi: cfg80211: Report per-radio RTS threshold to userspace
Date: Wed, 29 Jan 2025 21:22:43 +0530
Message-ID: <20250129155246.155587-3-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
References: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: NnasDb3u7zUFW0M0K4BOD001er46_wlS
X-Proofpoint-ORIG-GUID: NnasDb3u7zUFW0M0K4BOD001er46_wlS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501290128

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
 include/uapi/linux/nl80211.h | 2 ++
 net/wireless/nl80211.c       | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 5e7dca7c6083..17ed4e8bca33 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8076,6 +8076,7 @@ enum nl80211_ap_settings_flags {
  *	and contains attributes defined in &enum nl80211_if_combination_attrs.
  * @NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK: bitmask (u32) of antennas
  *	connected to this radio.
+ * @NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD: RTS threshold (u32) of this radio.
  *
  * @__NL80211_WIPHY_RADIO_ATTR_LAST: Internal
  * @NL80211_WIPHY_RADIO_ATTR_MAX: Highest attribute
@@ -8087,6 +8088,7 @@ enum nl80211_wiphy_radio_attrs {
 	NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE,
 	NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATION,
 	NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK,
+	NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD,
 
 	/* keep last */
 	__NL80211_WIPHY_RADIO_ATTR_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index be443a9bf6cd..b5ca793eb853 100644
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


