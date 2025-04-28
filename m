Return-Path: <linux-wireless+bounces-22113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCC0A9E72A
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 06:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A6A67A8D99
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 04:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94E513AD38;
	Mon, 28 Apr 2025 04:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YrGeAGUQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EF919DF52
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 04:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745815136; cv=none; b=rAaDvebKZTcBy5SYmJPiHePzal5e+HFITaJ4ZASv33PmUqoLdjXC7b0vbt9+l+Sm7eOasY0XyFYRPMyzNu5w/Z2Ja09YOpJwwGeOtHeI/+yUlAxDcXNC+oJlGSr0/8nOhCbuwHBGHqieyJEKTaPeeuhvb0VSILPL3lQkO1Vh7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745815136; c=relaxed/simple;
	bh=1rdWRy03S6GgS7IrS98bD+zoREQeekC3AsBbSfczfAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWcZx7/WPJp3mVLF+Js7nhcDBNKCH1DY014ltdEL1RzBwtWx7fGmIqQ20eWg+SRCAeynObdRp4Hb41a4/2QK2/8J8wNySBvEPkQAusfbUTBp7ghu8reQUj1/QDYftGO7iqjBXHKF0dH1uMqr9/m5YaAJIWgdZ74sJZD3TPQ6o5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YrGeAGUQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53RKVhcU018434;
	Mon, 28 Apr 2025 04:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BIoz0HZFOVculGDc5vazIgBfGDSHeNiuMphZ/boaylk=; b=YrGeAGUQ/6M9brh7
	r6rQiomMvb7kwpMPjmel978a9hlqwmIlfRmyRrxF9Js0gNXfJG7i+eqhgY0AU7X/
	iGozmhd36wzxTaGQnyRAkiLGw8hpxn9EDjC4Gy5lsnO0h3KRTU686S9FVJ9uETRj
	c8KpvGeqGbFLbWt7IzS3ytXMk+qaG1rgcOMiRkMrCjcxIMSFOgHlBcRJAYRztKKa
	8aGqlp+92JB5iDi4FDW5hKzeXPFy4Ntkb+MXBap1VAkoLoRbRF+Rw6Xb3cJZ7+Tv
	dVayp9Kv+dK8zGp/z/GT7u9w7huYtZw5Xauxr17MzGKpi8lMqes5NZgz5s7MslpG
	JNnX3w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468r8hnts1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 04:38:50 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53S4co2K023969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 04:38:50 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 27 Apr 2025 21:38:48 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v8 2/3] wifi: cfg80211: Report per-radio RTS threshold to userspace
Date: Mon, 28 Apr 2025 10:08:27 +0530
Message-ID: <20250428043828.1931147-3-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428043828.1931147-1-quic_rdevanat@quicinc.com>
References: <20250428043828.1931147-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Ht47z4O_j2wyQzXp3qXnh5dDDXCpuqm9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDAzNyBTYWx0ZWRfX0Xm1HvhlZOle p9fyoDB4bbpvwGxvE0Rs8Ry8LTwX2t2xRkem3SDb8V8AG0ozCwGTDHvYe2WJTi1dhWQKQPXFIJO 8a4doagpS4UqgghciVJxnP7C5/Chmz4iV+9Cfz5Nm80Cj8MAeGMhN9RYfCBYnqmIwqpU+SENF3c
 TMxs3vxl2UBQnxotigvO3AYyQINngvjlMIR/pH2e5uxkzL67Iss0ALbvApq7i07wFBrry1gZsFn 8OxfLJin/kCx3vbKLu0+3mPEm+oUTt3Nqk+y9dpgxr+YS/VCzvfX+Hx/3UVekDfOCASNeJhQkBl u+mT6cG5n573Vebqj8E0ot9Q9MaqbmDUAU6DVqQC3lgeNXala1MT1GWdNkqsqzCY2cIxjXaK4ub
 d8zZ4FZbtRJ19l2HCvIgfX6hPgifuGysz5DWliu5PS8YK/f0qFw0OIrD5sprHxLyXAsfE4Ee
X-Authority-Analysis: v=2.4 cv=cfzSrmDM c=1 sm=1 tr=0 ts=680f065a cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=t2xFH_FA9tHEZGNgIz8A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Ht47z4O_j2wyQzXp3qXnh5dDDXCpuqm9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280037

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
index b734018f8869..27beca8ddb60 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8099,6 +8099,7 @@ enum nl80211_ap_settings_flags {
  *	and contains attributes defined in &enum nl80211_if_combination_attrs.
  * @NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK: bitmask (u32) of antennas
  *	connected to this radio.
+ * @NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD: RTS threshold (u32) of this radio.
  *
  * @__NL80211_WIPHY_RADIO_ATTR_LAST: Internal
  * @NL80211_WIPHY_RADIO_ATTR_MAX: Highest attribute
@@ -8110,6 +8111,7 @@ enum nl80211_wiphy_radio_attrs {
 	NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE,
 	NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATION,
 	NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK,
+	NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD,
 
 	/* keep last */
 	__NL80211_WIPHY_RADIO_ATTR_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3362dd9280b5..b9b53ac1b830 100644
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


