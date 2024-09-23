Return-Path: <linux-wireless+bounces-13076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7887797E4A3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 03:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25ACF1F21145
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 01:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D9B4A33;
	Mon, 23 Sep 2024 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fcUh2GKh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29E391
	for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 01:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727055003; cv=none; b=oAomxU1mj6ELhUaGhn7LZO2fgx7wR73BSet4S3A7Wzo/NKkZIq0JUeEwfK72cRKv+WzOjnMid3ticyDOEOzlletK5ByiF0NJVu8CiFyzM6JgJ4DB0ZvYQvOzWeTTi1kfsDhuQZ4NS29QctsDgT3PViMHcqOdBNEnsz7iB7Kkybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727055003; c=relaxed/simple;
	bh=oWiloiv3BAtbwwky4W7SDLEZTPaEapqiRPFB1TlKpHI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HeHZaIR+NF2NXEdXBvzNjBorpNV3uf3yJLa7UioPDzr6UmLl7ApJU9JbLAOeS7491nglRYTKZ8H1Qn+H/PTc2JxgsC+2uRag/+spGmO4os3H6xxz8+JYNh/DfqEsrQTeGeq/0qu+ntvw5yUXrpDxycscQvJSQ4ygx5JetODidOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fcUh2GKh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48MNNpEo032075;
	Mon, 23 Sep 2024 01:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=Pajfda4HFgQ5GUKBGbtkThyB9ld4abvFqk1WmITyDog=; b=fc
	Uh2GKhLUOB5akj632jOi7ed7j/8RIKjkr3p8sCsNZRz/kYbN9THnpTphM+5PzdPs
	cd8hKO81LaAvjhKXBy8QWXMoKWASkoxzTerFU1Vadw+t58msKzUltPQkeozBQzQU
	OkYtnjunVd4wf4ZRlned9mcW27ip7SUfre8XDDeFf37KFupQfK3ohI2fYe1XnvuU
	WJvwJaTFTBuIXinDyUsM/xxRDGSYhw8ODEdAYreiOsX4AIThgyvJ3ddzAb2TVa7h
	LbR0xG1U/X6iaQiPHVHqviRwlaqtgn0sAlFunbQFSoe0Bhe3KNZ1YtQHRTGU0qxz
	iUYtvCCJVlkGzJ2ZqbzQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41snfgueyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 01:29:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48N1Tsrh022850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 01:29:54 GMT
Received: from hu-chenhuan-sha.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 22 Sep 2024 18:29:53 -0700
From: Chenming Huang <quic_chenhuan@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH] cfg80211: Do not create BSS entries for unsupported channels
Date: Mon, 23 Sep 2024 06:59:32 +0530
Message-ID: <20240923012932.22924-1-quic_chenhuan@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: If-V7qpyZCAZXuS7GY_LT9VpfzhsJFUM
X-Proofpoint-GUID: If-V7qpyZCAZXuS7GY_LT9VpfzhsJFUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=923
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230009

Currently, in cfg80211_parse_ml_elem_sta_data(), when RNR element
indicates a BSS that operates in a channel that current regulatory
domain doesn't support, a NULL value is returned by
ieee80211_get_channel_khz() and assigned to this BSS entry's channel
field. Later in cfg80211_inform_single_bss_data(), the reported
BSS entry's channel will be wrongly overridden by transmitted BSS's.
This could result in connection failure that when wpa_supplicant
tries to select this reported BSS entry while it actually resides in
an unsupported channel.

Since this channel is not supported, it is reasonable to skip such
entries instead of reporting wrong information.

Signed-off-by: Chenming Huang <quic_chenhuan@quicinc.com>
---
 net/wireless/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 59a90bf3c0d6..d0aed41ded2f 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3050,6 +3050,10 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 		freq = ieee80211_channel_to_freq_khz(ap_info->channel, band);
 		data.channel = ieee80211_get_channel_khz(wiphy, freq);
 
+		/* Skip if RNR element specifies an unsupported channel */
+		if (!data.channel)
+			continue;
+
 		/* Skip if BSS entry generated from MBSSID or DIRECT source
 		 * frame data available already.
 		 */
-- 
2.17.1


