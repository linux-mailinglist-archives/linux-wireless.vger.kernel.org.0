Return-Path: <linux-wireless+bounces-23459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B3FAC6160
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 07:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19FC1BC2A0B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 05:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CE420ADD6;
	Wed, 28 May 2025 05:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mwlaE5jK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7A20C038
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748411097; cv=none; b=M7mgLaZ8O7YA4cdbX4Y3Rbub8+ZrF+LDb9tKqBf5eEdnsCXjO9Dvb+UOcFaMLXyXKlnhCzrfYd0y4F1t251QCEpKoKbwiEtHYP63XUFBV4lXfp2S4v42sWuVXJPHZ2f3YYWlcYrs5DnbBcUsZoQ/WsA9sljePxWFKmkvowo6sVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748411097; c=relaxed/simple;
	bh=wCJ3PLNK1mAt3ftuPjrfPMCw4y0QmLSjFtYF2WHx+fk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psnTr4JfZJhRnnD2YcgxmKydRjWHBPx2u25t6kQ9iIZcFcS5/iXWpjXaRX88mn03R0JpAKaZN2xrrIsc1cbXgwZ6oOgQB8Pm9TH+Nvetl1kM2bKkX8OnGyBHwfw8pGJqmO2pAqQaTIVrSy+XYReybbd6cYj/FoDJnaZ7YHjxZUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mwlaE5jK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RIHnst003458;
	Wed, 28 May 2025 05:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xt4XHnThKObJm2mwOk0N/J930Xg1pQKAZ0S9GE4SLA4=; b=mwlaE5jKKtvD92d3
	4ws3M0qqw+cnwcua564Nwo6p2ZR/HzpmDyk/C+PV6zM7djSu6wmdcykgRH7jSB8T
	rTFcZ5gX85WIewfcvH9Wm+mCx/dk9/yt/3XfVYTfVHpBqT7HP6cpjmpzDq7LBa3p
	s4uDSmTyLxm3QTZoo/fZ6NWGB+gba2Ets6rj0aWkbJyXzC1JamnnaW/33F153alh
	3IJEwkOndnCDEidXBMm+Y+W5/FA4yD1R7ITnt+hPuhrJi+sJ5ex3+FNNBq5Qg29M
	SGo7lJaziQp52WWQOTChm2OTsCuXvpgsPZAtelIeKi5yiaCv74oFWEI/Vi70JpSx
	fTdeDQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u66whdr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 05:44:51 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54S5iofG010259
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 05:44:50 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 27 May 2025 22:44:49 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v10 07/10] wifi: cfg80211: clear sinfo->filled for MLO station statistics
Date: Wed, 28 May 2025 11:14:17 +0530
Message-ID: <20250528054420.3050133-8-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528054420.3050133-1-quic_sarishar@quicinc.com>
References: <20250528054420.3050133-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=aYJhnQot c=1 sm=1 tr=0 ts=6836a2d3 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=8v4YMbU2zBWlWxwmyqYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: oEJXGWd-tt22l1qno6SK2nXWDJYKyriL
X-Proofpoint-GUID: oEJXGWd-tt22l1qno6SK2nXWDJYKyriL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA0OSBTYWx0ZWRfX6vzaXalCNq90
 oJRneNWn9FeXiV/j5fESRQCrWKDLcYH//bLer5+M/+UsJi4Qy/me1GHwjpTAMyyV0mhv6ybuKnQ
 FOqY1abdl2xB7awB0lhtrKza0f5uPPsxj3pqLEKS6YTF/exE+0JHcZnMjqsHTVwzULm0YI8H/Yd
 /sezASoOgxbCkl7on7yOW60Aptt4xhFEhiZXwhvsF9S55pIH1/4yggUUfuMiPk2GZtaOcvNShFR
 laD5h4sXplHT9OkYSDZau/N60USK61wGVh8qLmJvOEsqLP3cZ9jHy7O+RY9pkr25jm3dXZLsb9p
 q/AU1j7HpwGIMnctQpljywN7pNOS/5xt8ZDMz6LV83fn8JJAGcrlbc4DCvVlnGddrtC+eJ4MiKn
 Tf1bAMKiR2FNPwAcB8qVBHP7bVqULtvuLRpqMtTImuc6dyl+52hf0KpLfUlwfxUcnsER47LX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_03,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0
 clxscore=1015 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505280049

Currently, sinfo->filled is for set in sta_set_sinfo() after filling
the corresponding fields in station_info structure for station statistics.

For non-ML stations, the fields are correctly filled from sta->deflink
and corresponding sinfo->filled bit are set, but for MLO any one of
link's data is filled and corresponding sinfo->filled bit is set.

For MLO before embed NL message, fields of sinfo structure like
bytes, packets, signal are updated with accumulated, best, least of all
links data. But some of fields like rssi, pertid don't make much sense
at MLO level.

Hence, to prevent misinterpretation, clear sinfo->filled for fields
which don't make much sense at MLO level. This will prevent filling
misleading values in NL message.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/wireless/nl80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0ed64ec3d49a..bb9feb4b160e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7356,6 +7356,12 @@ static void cfg80211_sta_set_mld_sinfo(struct station_info *sinfo)
 				BIT(NL80211_TID_STATS_TX_MSDU_FAILED);
 		}
 	}
+
+	/* Reset sinfo->filled bits to exclude fields which don't make
+	 * much sense at the MLO level.
+	 */
+	sinfo->filled &= ~BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
+	sinfo->filled &= ~BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
 }
 
 static int nl80211_dump_station(struct sk_buff *skb,
-- 
2.34.1


