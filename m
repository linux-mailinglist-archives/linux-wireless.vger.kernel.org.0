Return-Path: <linux-wireless+bounces-23572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565BAACCC33
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 19:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903BC17280B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867AB179A3;
	Tue,  3 Jun 2025 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ipb/QRQe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9041D6DB5
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971798; cv=none; b=FhuhzhIBljO1aWa9GXZnsSIS6mr748L9CKwDTC6IrvQLnhkqXGGto4+t5f/+TRFa3BXmUpqqHXXZmLSumSRi+dxK+FCmAuTKZC7wQ+5GJIVaoW+qk1P9A7jdsHJXQeUSOCakfTlzR48y96h3rSRumIzG1cErAFHV/y+TUHb5mPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971798; c=relaxed/simple;
	bh=GS1V1d3vucARyQOuPaP3FEU9JYCZpYmSKoomuLLnDVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tezHcJHehgCKhuTQ1ONm0EPULWeLxk8WRyxjkGVeTEQUI8pQeMQznA3BiO+a84R6+41k0zPJIxTJIPJfDaAOZb7G9qoWF9RBXhstv9gEzOBD+8wn2N7AqhOG8Wss7J+UNSvL1OH67Y+n1EDHdpKY2AmonYl9BGYuji/NePrZz/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ipb/QRQe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5539JKnl006543;
	Tue, 3 Jun 2025 17:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KU+aKITSc1Myv9xAmUjz8FuYZwoo9nMtpmqKC1D3q44=; b=ipb/QRQe89Ffu6/h
	sHr8Ry3NQH4DTpWvOE1p2/Z2GxXcQ5ohWIwjZLNRP9yS7fS4JzL+tZ5UJT6Sso99
	zcnt4OtIaTYnKlxSjLhMXI4QmwmlxrF6mOP2BRx1n1qEeJYOSayRqgLcCPOsvneh
	c70PsETWVE+EwUpW7e1jfc8yPJ2JcPVuuHqB2dVaVBgW6SzbGCosVeD3IrzjAFh3
	pRLBRfzebXwC3rFz3hV8IhmkoTOgiQfykpa4umRgsXj4uOpzyTRHweH9KZdu8wKA
	m9tJqg/LWmZKotJspC+Gvxeb4KfIZnUYeUiKqFWoUVR+nm/f/YGwR+2pZST8Bhkt
	pqF1TQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8sucdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 17:29:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 553HTpMC024219
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Jun 2025 17:29:51 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 3 Jun 2025 10:29:49 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v12 3/4] wifi: cfg80211: Report per-radio RTS threshold to userspace
Date: Tue, 3 Jun 2025 22:59:23 +0530
Message-ID: <20250603172924.336883-4-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250603172924.336883-1-quic_rdevanat@quicinc.com>
References: <20250603172924.336883-1-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LRGukDufm1JppMgPOHOdP1gZ_Qq5dpGf
X-Authority-Analysis: v=2.4 cv=EPcG00ZC c=1 sm=1 tr=0 ts=683f3110 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=t2xFH_FA9tHEZGNgIz8A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: LRGukDufm1JppMgPOHOdP1gZ_Qq5dpGf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE1MiBTYWx0ZWRfX+3pJwBQsybCj
 OON/v6b1+YOmQ61lSL4zBKIHJ+297aY+/wBErMy5u3bnUMYVEXxpotmtTzUyes8DzxIjT31bhvB
 7MCRWMLvFKlSrrXOglQICNmtSDOA7HMPBaCrwResCPAEIe788lYmQJpCxYtqYd7gZ3LaDExSIwP
 /PAyz6ueUqcS9bG1Dj3EeR/8QkNi2IXPNXNaPhtw3pEAmwjajbVtXRaGlBhcrfMleaCW1m6sdw4
 mtdhN9AebjxoA11q4V6Gse/IZP6u+A8OUOAN8EZCurylOBMUxN0kxufuEiWI0pO7mZC1c1/tl5h
 sn8C3f6McAnp09bhJC3jEqqQs5AedgXVf9jpOlaeO898/Sq4up0L6o46axLgqhXNR9RQbYoR31I
 YofG4Y/oAMcM/xa/ypJbSiz7KyV5jkIkOZdnigSFbYDLYltHW/BBBbEnymvs+bWOkCEgpCGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_02,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030152

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
 net/wireless/nl80211.c       | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 464240e1903f..fe559fd1d4b2 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8098,6 +8098,7 @@ enum nl80211_ap_settings_flags {
  *	and contains attributes defined in &enum nl80211_if_combination_attrs.
  * @NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK: bitmask (u32) of antennas
  *	connected to this radio.
+ * @NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD: RTS threshold (u32) of this radio.
  *
  * @__NL80211_WIPHY_RADIO_ATTR_LAST: Internal
  * @NL80211_WIPHY_RADIO_ATTR_MAX: Highest attribute
@@ -8109,6 +8110,7 @@ enum nl80211_wiphy_radio_attrs {
 	NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE,
 	NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATION,
 	NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK,
+	NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD,
 
 	/* keep last */
 	__NL80211_WIPHY_RADIO_ATTR_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 23f4bfd404e9..787a020f550a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2447,6 +2447,7 @@ static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
 static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, int idx)
 {
 	const struct wiphy_radio *r = &wiphy->radio[idx];
+	const struct wiphy_radio_cfg *rcfg = &wiphy->radio_cfg[idx];
 	struct nlattr *radio, *freq;
 	int i;
 
@@ -2457,6 +2458,11 @@ static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, int idx)
 	if (nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_INDEX, idx))
 		goto nla_put_failure;
 
+	if (rcfg->rts_threshold &&
+	    nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD,
+			rcfg->rts_threshold))
+		goto nla_put_failure;
+
 	if (r->antenna_mask &&
 	    nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK,
 			r->antenna_mask))
-- 
2.25.1


