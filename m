Return-Path: <linux-wireless+bounces-24106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB84ADA145
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Jun 2025 10:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84011188D6CA
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Jun 2025 08:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A342641C8;
	Sun, 15 Jun 2025 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mRDZQN0V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2E81E4BE
	for <linux-wireless@vger.kernel.org>; Sun, 15 Jun 2025 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749975877; cv=none; b=WIMC1682qf57yudusWzhFo3iMOTi69nKwUVL3Yf8NtuAnE7Z/MZwiN+SsqkzgR+cFHv1qiDBKba4V5Abi9TIZQdXHQ1YMs4IK05B41k7fV4m4jaBWLmTap54dWNo+NzaMr/v3J+yuF8YfS32SkqXi3Gw/z8EnxpgJ+N1NK616c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749975877; c=relaxed/simple;
	bh=YkRafB5JpE6tlp07WlFgEAtX/7/nqUpygPSSk9ZDnio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neOpR6t0CzoFPd0HsFSdgk0XFepzOuSKu3zEQaBTDzUf+WchLtS+QWPr3C3uE6vuyGMmGq97fM7nFCh+H3DAnWnEixYbwOypmTwbwfyA3WiJdFUXUW/1jCB1+3jIMJmaIN3nXJVCH4KhAs+71JN16Tfhg0+/ekooNQSccoJTUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mRDZQN0V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55F5h3tT029878;
	Sun, 15 Jun 2025 08:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Txp07OpfBXZpyGbLd39vjjGpyMoKD1lYvL78MKFS6Ts=; b=mRDZQN0Vz3HO9N0m
	42G1O8Vk+4xPkI+SeGSe2odgR8UEVoygD0nu5SbR5XwcSWin1SLDlBP5qt5Gh3Q9
	C095bJQdrBI2DKCueLXG8t58xR1NukSkmeXKoXPYnoJtkmjOQB7XVf49TuYR2dic
	k+ZvIjcRNTsycrxwtK2DJjHhTPgZ7zdZJPXrxubnUKtO7ADyxHnxIu9SJvafCx+W
	V5wps86X1LgBSCUUTNXG41PkD2TYxY3pXz2TOO+ezRr1qaHXfdel8VvZRAkFmpkd
	Jo8JY3RlCF6lCeOYaHN2bRmzcsO5c+MYXMqVakKk/ITN3Dq1Vgqszr9We1E3/QTB
	dpWC0w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 479qp5g6bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jun 2025 08:24:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55F8OTIW007292
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jun 2025 08:24:29 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 15 Jun 2025 01:24:28 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v15 4/4] wifi: mac80211: Set RTS threshold on per-radio basis
Date: Sun, 15 Jun 2025 13:53:12 +0530
Message-ID: <20250615082312.619639-5-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250615082312.619639-1-quic_rdevanat@quicinc.com>
References: <20250615082312.619639-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: gnqTCrr1h38rohlEZ4nf9FNsUuuttDsq
X-Proofpoint-ORIG-GUID: gnqTCrr1h38rohlEZ4nf9FNsUuuttDsq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE1MDA2MCBTYWx0ZWRfX5WT0nEei1LJ8
 Lz6pQKdOwu9IneEIkwfVtRFX9upL6ScrNUt15hO4qEDC/8JrF8j8YMF+KzycsjfXnbhQWYrTn/S
 gIJR71TlMI1yAn0FK4AmOIlFEBUWJbT9if36GBxHeuGxdsKU0SyGrpRWPfQ4z851cIeRK2rt+gz
 GIl9QqBhPsIRxQ44n15MFu7PbOauejVbmcIMHKQwaGC4xDSU17Ft5Z3eFOu5ykOd18akyba4+Rm
 AUYdxW9GiI6SgJs3KySTI+kgEzJwNfyG6/Z+kn1ienVThJMp0gWvgDj90RYqgiIasN4qaj9wb4s
 r+PQ9YeAxto9br59sOeHE5ZmMifyRadnqtebpUWPncw6h4xTXzuDGs3SOmGHeNF3Um/Bp9D+M2q
 Li95IQYtQsyaFHlY966G1XTl2UPs9OQKIpnk86Wu6X7Km5SRTE8SR0LL+RY2dWZ7Ks+gxNVv
X-Authority-Analysis: v=2.4 cv=fMc53Yae c=1 sm=1 tr=0 ts=684e833e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=g5wSwWOxn4LvmP80Mh8A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_04,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506150060

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
index e2ed8401bd32..d0c2eea4895b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3060,8 +3060,15 @@ static int ieee80211_set_wiphy_params(struct wiphy *wiphy, int radio_idx,
 	}
 
 	if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
-		err = drv_set_rts_threshold(local, radio_idx,
-					    wiphy->rts_threshold);
+		u32 rts_threshold;
+
+		if ((radio_idx == -1) || (radio_idx >= wiphy->n_radio))
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


