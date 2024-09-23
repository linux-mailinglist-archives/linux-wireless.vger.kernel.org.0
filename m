Return-Path: <linux-wireless+bounces-13077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E58397E4C2
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 04:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3351C209F3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 02:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0591210E9;
	Mon, 23 Sep 2024 02:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="if68uOYy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC0C624
	for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 02:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727057835; cv=none; b=kgoMr5WfLkECNm8OBxyeTtKCf29yftP87YvPzv1IM9QRu3u0VPP1X32NgTwaiqhlyGMe5CZHWD2y7xeI56XutrDSbn2eG41+TdGSnMAvygsEcGTROnrooYLAyDOiLZpaWn4/+51MrGqWhPEB4bi/nFZDpguRPzJS4qfVhj8SkHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727057835; c=relaxed/simple;
	bh=oWiloiv3BAtbwwky4W7SDLEZTPaEapqiRPFB1TlKpHI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bdI9OJAs+77Cyww4DX/z5MpSP0rNpnxOgA2Jy7Ap0K/LYGPFUamJuCG2oO/oOHqg69tHW9YZ4kfYse8wamO4wNURawQyXe8Famjf3SOx7xDM39DzZNt834N58ICP88XB2o1rxqGUhQAQ1aBT9MKw8gv35Gwynxb1xHLxGOPT4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=if68uOYy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48MMpEep011991;
	Mon, 23 Sep 2024 02:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=Pajfda4HFgQ5GUKBGbtkThyB9ld4abvFqk1WmITyDog=; b=if
	68uOYy/dzUiddU0Zj0ReNWCgNmIQfJpfChuFYFO2a5M8IQSV5eodhfrT5V++cSr6
	OauUpJtiUwq4YyCIAVLAKwpt3qUS/Wl/6LIi4mwmiVvlXI61yLmZpM7uXssryJ0l
	eP3Onc5BgJEsirhmIQEZZwUGYVGuOl+5oK6k0IY8xpgyyRS14yCLm93qq4Zb9srb
	9m+yseRwQ1OXNUR1fwinzFUxLr98U1R2lghZShNFK7OBrvGEr0iCLB8aUbdZgQDt
	0etKWekIMZaDhvR1+X7XYyCYTxktSY3DK4fxOsjLDK8j3lk1L46jh8k1VnYQT3Oh
	fQWdvKRE5XlJTBFTbEaQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41snfguhgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 02:17:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48N2H8bn024286
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 02:17:08 GMT
Received: from hu-chenhuan-sha.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 22 Sep 2024 19:17:07 -0700
From: Chenming Huang <quic_chenhuan@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH][RESEND] wifi: cfg80211: Do not create BSS entries for unsupported channels
Date: Mon, 23 Sep 2024 07:46:44 +0530
Message-ID: <20240923021644.12885-1-quic_chenhuan@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FSr7tg4Mla96YZ6u3K9qqx_oSN3Jc8Xb
X-Proofpoint-GUID: FSr7tg4Mla96YZ6u3K9qqx_oSN3Jc8Xb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=925
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230015

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


