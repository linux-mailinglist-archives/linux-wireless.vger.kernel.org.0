Return-Path: <linux-wireless+bounces-23289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A88AC07F8
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5331BC4FC4
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 08:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB746288C12;
	Thu, 22 May 2025 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TqenPfnh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5F289E2F
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904204; cv=none; b=R1D+nXzPJptBYM28GmxNXTrIjGpNjwnqL9KWvCxQiVKQkDp3usRf0nOSLGUMIqmIhnWf4vhhJIc7QlRKG/BDoGi7gDAJHI3nRxVHuJqLnwYj4nLBOmUIW1sdPaIqHtHRB0PB64rmx8Lgsmy9iyI0j1wX/gqGgvK+n3bmk2HzaeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904204; c=relaxed/simple;
	bh=aOIvr/u2OV69igdVEnDXwNwcfVixxxaj/ORko+Bq6xI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxHGg+FpuXv6pDF3mwPTSN5fexctuWNvAXlxpe1++2RkY4h/Uem40I9Do5xvEcwjQYTmBfNghxhwUdmtW58UPim8Y1jzGpgJWAinhCPBL3DhRgIzYRQOBx5Y310QJDS3PC4LFpu25VqJzsp8K1ceQRa9ib9bFPMO9aZ7NbIGt4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TqenPfnh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7UHom020574;
	Thu, 22 May 2025 08:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GASpvTNQPzLdUC25xQij+xsBWgQARyymy0x4O3yDy2E=; b=TqenPfnhpTM9jwjR
	i1MwduTAGDKIk7VJFB31enk03oTEj6lVt/3/T6O4if0JqbLMifBWwPEyictkw/Ps
	OY/nzgYuPLAZ9GhIatXGIVkdzJBI4R8JPRYckKWU+MlbbyYiF5t8rNkAb+uovzg8
	3VFe/BGIZjcOfUAGq9YzP00I8i7Pb72UOEWq02ajxYUGjbYzQNoWbZYO739eZYED
	Z8a/be9alst3U2eFwHY37PHRofQOjLwnZQAXMtLb1/wqDPKodGMn6k/lKYBU9vQC
	4dSOB2nn6tmX87sT75os4RCrztAPk6nIULR4pP8nx5P4ppeUxz0IMFA4iJgrju9q
	lFIVOQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s9pb420v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:56:38 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M8ub4P016379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:56:37 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 22 May 2025 01:56:36 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v9 07/10] wifi: cfg80211: clear sinfo->filled for MLO station statistics
Date: Thu, 22 May 2025 14:25:58 +0530
Message-ID: <20250522085601.2741458-8-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522085601.2741458-1-quic_sarishar@quicinc.com>
References: <20250522085601.2741458-1-quic_sarishar@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=WJl/XmsR c=1 sm=1 tr=0 ts=682ee6c6 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=8v4YMbU2zBWlWxwmyqYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: q4NBnjpDTQ5UH-hrqlygkhylcqdsH8h_
X-Proofpoint-GUID: q4NBnjpDTQ5UH-hrqlygkhylcqdsH8h_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA4OSBTYWx0ZWRfXwF1BBoq1Sqnh
 okTRrzJ4flNUpZL+HtZALV1VFmHNnKHDeki1BQw0jeVMvNfown7qmmpLbLfzGa68HQBKG4Om8Cc
 sLz45jUUpBJ9IjwFCkLRT1hxQ4ky+F+BXwHZ+Ne8oFSyBNt4sqTMvb94A6dbQ+DdcjZO3PlrAoI
 YJcfGNG8BmHTSj9Ni+aHSUwxblzYtMfAD5B6zawrv1aNG+QfMpy+M2QXpShzWZgIpuhR6/WQs+f
 2CMj3hlXh0JnvE8r9okOFpBDzCCvqfhovCMUTuTJzV4HfFpgkEj629iozYtiO1POuFpcbvWUseF
 Ei+GV1qh9QrwW9BTeFUtH8Fdh0Hj+EX/L5DbOGA9mIeHAfe2NJSVD7K943W5/3CrgNndkIKGkzZ
 VKe7tCn9OMO3zasE8B2VUHrzBXEnYGi/P+qDTw0AWGfPikks4zJmXFlDRbD3VpjbImrJvF80
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220089

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
index 71d3b6107983..72ce397b6aab 100644
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


