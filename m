Return-Path: <linux-wireless+bounces-22984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418F1AB7D45
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 07:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2123AD4A9
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DB2295520;
	Thu, 15 May 2025 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EoWC4gn4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6817E29671F
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 05:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288179; cv=none; b=tCNhAoSlgaNJ8Fb2eo+wAJfl4z20ep8Ze1K3oXtGAhrWihUTgZ6mxgLrW+mKmGzA4PkfQwHqRfDrG10Nnp5qYW208YLIyOqpkUE7Ahd9arc8+Jka4nojL6t4U0PLIkFCtwKacAbhMJ8x2PSJQ7iVRC0SHSPStACfkXrH3eaROic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288179; c=relaxed/simple;
	bh=ez7s7/25+29U3ghNt9iIEhlHwaGeeI5ZW+q2SAwoXQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krJB0+gLQqLep8xDQ7I6fVLxdJ6vRZZ/b655JQvS0LZZmx1Q6nDOFZ73Qj/bJ1uguiK6Es3/qZraoWJVqFYMZswjkqgQ6cgepvJjNSSfQmMhGk0Dbj3X2F2/9YSpbgCAfB0JwBL0ho539eXv0vvQYL7B/lSv2kTR/r7ZzhhhPj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EoWC4gn4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EIG9lH003115;
	Thu, 15 May 2025 05:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sA0klOSEdHwfYr9z06UNZIKpzjbe57kSsKKianSQGcw=; b=EoWC4gn4QP8RXun9
	zG2OKvrXsXpyjGGTgX+mWSCR1h65fA2/+oQ85lwY2sIrVj6oSrHxYr+q8TTD3MSd
	JOkb0bwRacgwVlpeXUd5+XPw/FWHDFKz9UVMFvmvgxFF1wiFOnu1cCRKxIcMRTHb
	UUBUirYWf8aNQOl0GDFWwZ7+sa+fCVt7AxwquGk3eo5ZrxMAwU0dwBJtE+DZ5GlX
	c32Lmu/uQK1XcR99Ib9pLKoyDED0CMl5Gn7WFNpN7ELq9iOdfN58c9PhEtkzxdpM
	61aJchgcdCMgXCuk6hI7EaYr34TRhzn9Gk8gjoZLOaXZgDqrWasCyvqYy6UCDY6Q
	xj42JQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcrcyfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:34 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54F5nX1x030773
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:33 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 22:49:32 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v8 07/10] wifi: cfg80211: reset sinfo->filled for MLO station statistics
Date: Thu, 15 May 2025 11:19:01 +0530
Message-ID: <20250515054904.1214096-8-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: VqlKVbLOQfei5J8fw560LmnuUTZAT0D5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA1NSBTYWx0ZWRfX1mEgHmiNG+wV
 3+t95RwREodL5tSOfk1CIVPX+kiycBBOZ+yfHjG25bbQrLwXFy1kMjoBE7AYuL7fCbV3EvugVjU
 ewkFZFRYWUV6MNmZq1Kl0lg81yNBFMNAeDumMXRKwSp9WHmjJKHKkpG6XdDYCyDPewjBFbtEoIk
 UrchHpViPdg4qZuWCg0VK03J6wIE4YwUd6Wz4TgJuo0BId6PR1pQndMXLPgv83Vd/fd8CHVj/By
 9J2skfvQ+smKwdFWc/kKIDbC7pHXZCeB+VXXZnRFKG1iODEIMqfNsc04In0seCMGD9ibOw2a5f7
 wC4sZXU2EBZZ3O0bhIHCzaBjBKpcHFjZYuQVQkJX+2azJknSKN8hnaPhTxi+WWhqVLPuLIGbeYj
 A4X1edA2u8Olf+C5dCbK/XwBsGCFkFig/POjPwoLCXFiGTEwOG+FcIozVYTZxhkG+qFN4aMo
X-Authority-Analysis: v=2.4 cv=K7UiHzWI c=1 sm=1 tr=0 ts=6825806e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=8v4YMbU2zBWlWxwmyqYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: VqlKVbLOQfei5J8fw560LmnuUTZAT0D5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_02,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150055

Currently, sinfo->filled is for set in sta_set_sinfo() after filling
the corresponding fields in station_info structure for station statistics.

For non-ML stations, the fields are correctly filled from sta->deflink
and corresponding sinfo->filled bit are set, but for MLO any one of
link's data is filled and corresponding sinfo->filled bit is set.

For MLO before embed NL message, fields of sinfo structure like
bytes, packets, signal are updated with accumulated, best, least of all
links data. But some of fields like rssi, pertid don't make much sense
at MLO level.

Hence, to prevent misinterpretation, reset sinfo->filled for fields
which don't make much sense at MLO level. This will prevent filling the
unnecessary values in NL message.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/wireless/nl80211.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index cc0b89d0578c..9a8bc08aa54b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7350,6 +7350,13 @@ static void cfg80211_sta_set_mld_sinfo(struct station_info *sinfo)
 		}
 		init++;
 	}
+
+	/* Resetting sinfo->filled bits to exclude fields which don't
+	 * make much sense at the MLO level.
+	 */
+	sinfo->filled &= ~(1 << NL80211_STA_INFO_CHAIN_SIGNAL);
+	sinfo->filled &= ~(1 << NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
+	sinfo->filled &= ~(1 << NL80211_STA_INFO_TID_STATS);
 }
 
 static int nl80211_dump_station(struct sk_buff *skb,
-- 
2.34.1


