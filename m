Return-Path: <linux-wireless+bounces-22951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F23D0AB71E7
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 18:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFDC1BA1794
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 16:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F11527CB0A;
	Wed, 14 May 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jyS1zGMO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090F027EC78
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241378; cv=none; b=ES5k5BXLBCFv9JGq3ZOgUQbGqFt3uIlmVw+3zHbtYWMHrAYvEK+/ZNoBAqreKi5FGTD/329Ckl7qTfjMeWxKIjNLIpMgD2vUv3s7a0K0Pdcr8yVxPLqy2WtitbGnLAclpMJvmFZ//En/4BXNY0Of/pPztOB4VsvlXULDd/kTla8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241378; c=relaxed/simple;
	bh=jE4yGMGlfAZzDKYW6+RHzfxA/HH1Qe4Uf/YpM68J3LE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7TLAFAs1CYxDUucAfjYXXk9FoSJGpInkVGdVoNBhdKo9j7GjaK9+GL4EtK3Anjxq/1o3FpQaglu5ErAEMb9QGu95CuBUuOVbQt6TnY+9fY1VfIliOnd5fDQYtiEs/IWh5c5hh+1Mgz3uAdNVk0T9AWHbt6f8jf0NS6M/Xm4TiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jyS1zGMO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAuuk3009097;
	Wed, 14 May 2025 16:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FrrjbNTBHqb4IShqkHfE5+aPSNA7hwUmWxFDZanuHt0=; b=jyS1zGMO9Y1Y08FY
	sUnkEDE5otfr62iq+kek04oiWq7jteyW9pTC7oG+EY7iFnwSM82U5SDmnkCHK9Jt
	0ST4fHM9Hz1gS23lXmUfNZW82/fNmjt2xDetP7ksXO5JGuNcPJSGhjhAtLP3sOUy
	X8LD1vtu7XpHZoty3eVik3GqOjsOaARjPm+VABmc9NI6qgbJInNbkDNmCTq5Nvle
	BNqEIUb+PiE1OKiC2AihXHRT0ePcxGb6JsTABjwlHqVvrEuLXTIBHGeQoxjkQgfy
	gkBo3iI6I5xxbZzJ4jr1Kn7H58V9bx4sLHzg0akGnFZSFYfN9rqlMcQODLgtnpqE
	opPUFw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcpudce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 16:49:32 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54EGnVVD027870
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 16:49:31 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 09:49:30 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v7 07/10] wifi: cfg80211: reset sinfo->filled for MLO station statistics
Date: Wed, 14 May 2025 22:18:54 +0530
Message-ID: <20250514164857.227540-8-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514164857.227540-1-quic_sarishar@quicinc.com>
References: <20250514164857.227540-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NDTQtoQ3uzgliGNfIvTWGt5EnGhNHNIg
X-Proofpoint-ORIG-GUID: NDTQtoQ3uzgliGNfIvTWGt5EnGhNHNIg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE1MSBTYWx0ZWRfX02IfQVmr0793
 WoUY99T9ZXLW93XQyGpbyVzcMEg7sjQ1d3gAgjLi1vhGbBB0swr/Ia1/ZJ+5ygi1WQoalVq9qzX
 kAjZZKpbnKUXz8nbgE0AVYVc0jRgO3QbDT9cQNIHvqxhU2Y34H8aXcltvON0jmic6AOwxWXaYfU
 EiWQS6t7MB1JhxzvroOx9fSEsHYN2cBwwEMy43zYEEn3UWY+4MtZolYsrAbEJHpeLVQfYBMAEKg
 KQFYbS+0wZir/H1yDUBLxNplrE5ad61vxIONBCFLUwDLWwui20dFRwhMYE5dNHWhwtrohj2KVDK
 cJrEA5TkGRJ2XNzg8+GTtltsx/zoiIfYUMSNZypnIwZ4pFnnpPqPB1+nw9WIvd4BT+vz/9kKusj
 L3AuOHaZtecSAoij6axgzlUAq0ZAnB8btwJclg+7AWvD87/njTJ8Q0IM498WFokuWM4Nyv72
X-Authority-Analysis: v=2.4 cv=KcvSsRYD c=1 sm=1 tr=0 ts=6824c99c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=8v4YMbU2zBWlWxwmyqYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140151

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
index 392e7990f8f0..40d615d97a5c 100644
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


