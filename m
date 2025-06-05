Return-Path: <linux-wireless+bounces-23753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9E0ACEE55
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D21189A250
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DDB214A64;
	Thu,  5 Jun 2025 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i5DiWJ9/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF15721ABAA
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749121886; cv=none; b=mCPb7qjoE2QSnIkMmzAw6N2+00HTFSO39YNQKeh/xWp/vXFyYf37NFIsUFlVznTWzkrwSaVLbKR7FQv2MzMTRv2WhMi6IyHg1THvbzG9oNVWCNTZMZStEJjgpRjbqvAK3OqNVwzPcswnBIkK4fmqycNUBRUjLvdCCNXKlkLqoVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749121886; c=relaxed/simple;
	bh=yx1MSiLRJiH2+Hg+oiL0gdHngaWlq8v0yR8uS1fict0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOdUVBXOUKt8zu98v+WlJxCVIcFwGyd7xaL/g2y1nu1bDHqJzTR0aIrvkm+FZnwZUwLY5PUWow5iAuUkW2z3HuuwxMTEXY/njvayPC3REOHSVkoBYyuyCJ+JQzVPlTEbbOK3pxdh+3vxEwKUaQUBlO3ZG5o6GBIk69LcP24PNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i5DiWJ9/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5559keZP027115;
	Thu, 5 Jun 2025 11:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1j2dR2z+TdX+fQD72yMAZg7vrkxsfrRaW5zjvQtUtFo=; b=i5DiWJ9/IVVZExn5
	7Fi9kOmW1rX1pbzYRwBSvh8MVUGftZop6tbrcEKF71rTuXwRWIVI6UQfRZlIdWMf
	dJ+SYrMi/XU4YFIPo0V+VZibElFJGs42Jxx2FvAsuY7U0Nw/zyieKUGnwz51aZT8
	sKTGNZZ38RKnNcyW/vWZdmymnhX7XisHt2AewVdw2EAy+Fbb8Cz/bnChfyBBvl4y
	SCaVH8CqKc4fmTS0IRSIpoRWvURnb18AwiH8mF2RcZGwp4QxDVPEBZtp/j9k7qZD
	ghmgUrQxo6gfL8kXDjgZVoDzaVMoWy0vs0T6WR+h1P1F+gMIsJIFRr+wCABXqZaC
	Im0/Tg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8ns1vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 11:11:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 555BBHSa013286
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 11:11:17 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Jun 2025 04:11:16 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v14 4/4] wifi: mac80211: Set RTS threshold on per-radio basis
Date: Thu, 5 Jun 2025 16:40:40 +0530
Message-ID: <20250605111040.3451328-5-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250605111040.3451328-1-quic_rdevanat@quicinc.com>
References: <20250605111040.3451328-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: cyCFLoLSxw4kPcGF-oNQ6W_SAFq_IMFQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA5NiBTYWx0ZWRfXyU6QHQPQ9OQi
 UL7wokKnFh/2RW1l5NIndW0emL5m2xfHC7/bE2K5CoeNQ7Aj8iphAxw2Nl1RcD80doDCtS4DvvG
 dz7PRNHhSSW/2c7MEPjjb+GJmVTihkqMZnZ+oZjtXCoyk2o0C41556zcDxN9V+vsH6ItKatd6Tf
 YtHug73qstOF84phFVa8RrV8arSGIeFR8siwLWQryY/jQo4XcdvtagF6enxi1Q/W95bQDukN5CD
 PafNjd36I0diJ2fupbcEpaksDiyUjL1r6J8a/+ztbhaU7Nys679oweppEjwn1khk+61qc3qY477
 RLtL+9lcSPTmzSJ7VsS1FGvi10Phlm1bFPqfmGCbqSY77qBtTDgP8DOf5cxzap6G6OciYJs2hKQ
 wLzix87wy4jutknXXkxCLsCwQ+H6NO8o0U8k490Wu6iNats1YdoYcWL1iCHXxY5kinHFJOS6
X-Proofpoint-ORIG-GUID: cyCFLoLSxw4kPcGF-oNQ6W_SAFq_IMFQ
X-Authority-Analysis: v=2.4 cv=UphjN/wB c=1 sm=1 tr=0 ts=68417b57 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=xHEeQlBAHYfg8jAzN9EA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050096

Add support to get the radio for which RTS threshold needs to be changed
from userspace. Pass on this radio index to underlying drivers as an
additional argument.

A value of -1 indicates radio index is not mentioned and that the
configuration applies to all radio(s) of the wiphy.

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 net/mac80211/cfg.c  | 11 +++++++++--
 net/mac80211/util.c | 10 +++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e2ed8401bd32..c46bf160a6a0 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3060,8 +3060,15 @@ static int ieee80211_set_wiphy_params(struct wiphy *wiphy, int radio_idx,
 	}
 
 	if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
-		err = drv_set_rts_threshold(local, radio_idx,
-					    wiphy->rts_threshold);
+		u32 rts_threshold;
+
+		if (radio_idx >= wiphy->n_radio)
+			rts_threshold = wiphy->rts_threshold;
+		else
+			rts_threshold =
+				wiphy->radio_cfg[radio_idx].rts_threshold;
+
+		err = drv_set_rts_threshold(local, radio_idx, rts_threshold);
 
 		if (err)
 			return err;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 78cdce9d3993..cf61716c0bb3 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1756,6 +1756,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	bool sched_scan_stopped = false;
 	bool suspended = local->suspended;
 	bool in_reconfig = false;
+	u32 rts_threshold;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1829,7 +1830,14 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	drv_set_frag_threshold(local, -1, hw->wiphy->frag_threshold);
 
 	/* setup RTS threshold */
-	drv_set_rts_threshold(local, -1, hw->wiphy->rts_threshold);
+	if (hw->wiphy->n_radio > 0) {
+		for (i = 0; i < hw->wiphy->n_radio; i++) {
+			rts_threshold = hw->wiphy->radio_cfg[i].rts_threshold;
+			drv_set_rts_threshold(local, i, rts_threshold);
+		}
+	} else {
+		drv_set_rts_threshold(local, -1, hw->wiphy->rts_threshold);
+	}
 
 	/* reset coverage class */
 	drv_set_coverage_class(local, -1, hw->wiphy->coverage_class);
-- 
2.25.1


