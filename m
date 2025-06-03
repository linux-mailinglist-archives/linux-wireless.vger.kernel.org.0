Return-Path: <linux-wireless+bounces-23574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B06ACCC34
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 19:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7380E176CB5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 17:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF681BC099;
	Tue,  3 Jun 2025 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OhVGPrXF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939EF1DE2A0
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971800; cv=none; b=OFDubwUB7ChnVvVWnzriJMklUaQJS2y/W2wObvi45d/j3lg2YiR0Qj24m69NpFJ5EDVZZE4LwZyJgvmYRn7ubbUk39l+MHoFEX0g1wwwVUrxvn7coGtlpiNibvuUQ7MktIVC8pqU22ArNS4UB/8CSji6GpFfDyWB3pA6UtK/Ulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971800; c=relaxed/simple;
	bh=a7nOKTcicySruXl6Hdl1fgKZyMw2yj6ZMDvc6FC8Qj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RG7qTAL6H0ob43OMHgLqxqFGGIKuFnRTAIICwjc9986hSf8MsUq4ih8YawYTNkiL97evOlu5a5/+gTyell8tdTfvWJuZG7nnxxlq+hFIwmS2FzsfjQwM3eosDszzlPDQmIMbZClbOvlMsQeVAQdAq/fzxj0zhg2VLqn4Pbmnixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OhVGPrXF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5539JMGq027548;
	Tue, 3 Jun 2025 17:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n1z2J5gPNvfIEuXBjhOqq0dQvWOvwRWXevhftH4gu1c=; b=OhVGPrXFSX3XqqX+
	pd3CVYlLiREitmKwwabJbxmgdD5acvMz9tl9S924UkU6zPagFEMHPPcREH/TL2C9
	XW/1XrBYiCMwLx3H0la/Cy7mcZpq7XudGo2JD4PWd3P5uAfK00NYKq3PSfKgntVB
	sOHfEhqOPOdb5pXFr7sqczXYIdPuQaBD46s40A+LlmqANS8y+qrsxVom5l4ipyqf
	+wM6eEPifBV7ubf3a+wWDp7ya9XmylgNnifDZy7z8GAlmwLG3P4Q+YXO/HBa9erz
	n8Lxj7fmoensB9AU4KOaqPqnPo6spBpiyA3+8mYLxx9y1ZRO+kiPuZu345y6V6E4
	rifwhA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8t3dgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 17:29:53 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 553HTrvV023390
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Jun 2025 17:29:53 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 3 Jun 2025 10:29:51 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v12 4/4] wifi: mac80211: Set RTS threshold on per-radio basis
Date: Tue, 3 Jun 2025 22:59:24 +0530
Message-ID: <20250603172924.336883-5-quic_rdevanat@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=eJQTjGp1 c=1 sm=1 tr=0 ts=683f3111 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=BOf_PJH6FHNS0jIfWvQA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: FzwF43gDQmD6Li9wul6GUbzph0N0qPcq
X-Proofpoint-GUID: FzwF43gDQmD6Li9wul6GUbzph0N0qPcq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE1MyBTYWx0ZWRfX0vptKJgid3xe
 5d9cG+6VEEo+KxVreL3SfaehTesEqnkm5ejPxUimGUOEytFHJLUIpLIoBeOtHcfbgzqoRNef9fI
 KJFV/L5ReqVdZiTDlnrUL5Ucdkj+IzgbykSLCGyWA1LIG6FvK0sl01nqnrEGsTpsQFt2bh/65lT
 UNri3YJK6daVNyDxQAJbele+jfy0+RMvHA2cMj+K4fFd8lQTjNu3AVeiJLSqd0VEGFzeYahmjzQ
 Hanhaw3cGx0GwAxXNB415GLaciTEMXgpKiqsC5owxsMm+MVAX1AnQxQh6/JtA6EhxdrtF+dXDoa
 St+HKV5O2Zobud5O00PQi8fbg3sWMTn7ev1pOY8hkI96J20gKX6C4TTulMzRM740sVbfb5T1hH2
 Bbo1xmeKJnEdyILNyF40v6L9n80mBSck+brm0Q2i6xmahL+SjKTWnaky1IP3HRSOvNX6Ezz3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_02,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506030153

Add support to get the radio for which RTS threshold needs to be changed
from userspace. Pass on this radio index to underlying drivers as an
additional argument.

A value of -1 indicates radio index is not mentioned and that the
configuration applies to all radio(s) of the wiphy.

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 net/mac80211/cfg.c  | 8 ++++++++
 net/mac80211/util.c | 7 ++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c0645de95a53..59b5b2337886 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3060,6 +3060,14 @@ static int ieee80211_set_wiphy_params(struct wiphy *wiphy, int radio_idx,
 	}
 
 	if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
+		u32 rts_threshold;
+
+		if (radio_idx >= wiphy->n_radio)
+			rts_threshold = wiphy->rts_threshold;
+		else
+			rts_threshold =
+				wiphy->radio_cfg[radio_idx].rts_threshold;
+
 		err = drv_set_rts_threshold(local, radio_idx,
 					    wiphy->rts_threshold);
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 78cdce9d3993..272f2a4a0b02 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1829,7 +1829,12 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	drv_set_frag_threshold(local, -1, hw->wiphy->frag_threshold);
 
 	/* setup RTS threshold */
-	drv_set_rts_threshold(local, -1, hw->wiphy->rts_threshold);
+	if (hw->wiphy->n_radio > 0)
+		for (i = 0; i < hw->wiphy->n_radio; i++)
+			drv_set_rts_threshold(local, i,
+					      hw->wiphy->radio_cfg[i].rts_threshold);
+	else
+		drv_set_rts_threshold(local, -1, hw->wiphy->rts_threshold);
 
 	/* reset coverage class */
 	drv_set_coverage_class(local, -1, hw->wiphy->coverage_class);
-- 
2.25.1


