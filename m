Return-Path: <linux-wireless+bounces-23698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F471ACDC39
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 12:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0371618997B0
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 10:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776D128E59B;
	Wed,  4 Jun 2025 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dy5566km"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED1028C030
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749034701; cv=none; b=Qczyga96kYMX/XpHWR98ZwXJU7ticwR1CMYM0O2f83TFmSjh74PheDEZAF42zA15fEM71/oV0VInIEsM3TJwbfn7pdXFZpJvMaFrqyu8NpGFCNeFSTuCsB4rYUXKV6nsfvgMOKpstbUrmkEhTSaSJ/BF+H084pgMAKppetq07xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749034701; c=relaxed/simple;
	bh=3Ky6Qh5QNex+OmkvbHPGAsKA4CVSV2p0Cj3gnYU1AqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDBdShHYxicU8YPMb/mVAey/o5IFfCDjvZqaseznuCetzHXDr/ZVMfdUAWQ0RPhbKYjo4XBMGHWwpU7KWCQLcAmlLU1Rl/0eV5ICJoewIgAd54BOW9+kTJJfRHKX4T43fe3rAaNhZTvS3LKhZaqLO0O9sSQIyg5fflvEnnYBl7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dy5566km; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5548EoiE023754;
	Wed, 4 Jun 2025 10:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PXvzfMmRAh1ST6uR11x0THzP
	cZvrNRi2rBOLGkPUHcY=; b=Dy5566kmwILrVOb+YZwfhfdOt6FOeJXtz09Xe8kn
	reX6/xu3HvCCd+hvuQzyT8JkrYxigPJFSNcTBZQ17iVGyt6T6gqXd+lr4OdxmxY9
	BXaWEJV9rduYzIJ5epqdYCXVF2YoRSlevoW340Y8pqyfm2/fYobaLiTFmRqK2xhi
	1YN32JTo424NBh7shrx7JaI7/ONkEZiQnaNlr7EOTzGoaQyJCtN55CphGHdhFNWD
	1AdXRI+VaiZhPsL11IjES6pr7H2POnH1OHr7qY5BEgQJs20+cRy8XTyu6cfLeBsC
	3iqsxqShbDMRgeuYt3rNORqkd6dUvw9ov5Tlnj1K5DTbxw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8rwtpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 10:58:15 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 554AwETH002757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Jun 2025 10:58:14 GMT
Received: from hu-kkavita-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Jun 2025 03:58:13 -0700
From: Kavita Kavita <quic_kkavita@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_kkavita@quicinc.com>
Subject: [PATCH wireless-next 1/2] wifi: cfg80211: Improve the documentation for NL80211_CMD_ASSOC_MLO_RECONF
Date: Wed, 4 Jun 2025 16:27:56 +0530
Message-ID: <20250604105757.2542-2-quic_kkavita@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604105757.2542-1-quic_kkavita@quicinc.com>
References: <20250604105757.2542-1-quic_kkavita@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a7qfHOyjFbRieWQ2ybrtkN2Jvokbt0iP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA4MyBTYWx0ZWRfX5UcKwD6a3GP1
 ZhtZJ29Zb39GXMMDqxspAn0dTqGadrJv/0Q18dd4GFU5FApcTf87UZ+lsM/wpBhLBwpU0ENJSrO
 Nt5mlRATJP3mAnjiwAVvubC4Jww13ghygt0UTmBsonuoXT89f2xd53x+ReC8fVhQa0OmeaE0X8a
 dEG4QK1s3P+nzVJ5sM6EuyZ38TGVvWnSVsBjuq12aVfGz8pygXieFnP5D2EQ9ap1WYc13o9DSQB
 cBnsgOUqPk5SCS4MipDzV9/CehRoeNGg3Ihdg7Pq+wHp78y29XERuXiRLKImdRpTj3dvCHriV9G
 CZjmTjGFkM0nJPzTHKTU0ZFa0oiYfOHCJLWVcgVEWvG95du/xrOytkcuN1nYmmZegSfcaSxdb7+
 at7weJlgcey2a+5u9BaFWdpkqSC5jiwQaCwU5DBniFo7dDNNDrmxOkRapkAQg5ZODuEVfSIl
X-Authority-Analysis: v=2.4 cv=RdWQC0tv c=1 sm=1 tr=0 ts=684026c7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=jIlKrmsvsoudjEtk5DUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: a7qfHOyjFbRieWQ2ybrtkN2Jvokbt0iP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=689 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040083

The existing documentation for the NL80211_CMD_ASSOC_MLO_RECONF
does not clearly explain handling of link reconfiguration request
results from the driver.

Add documentation to explain that the command is used as an event to
notify userspace about added links information, and that the existing
NL80211_CMD_LINKS_REMOVED command is used to notify userspace about
removed links information.

Signed-off-by: Kavita Kavita <quic_kkavita@quicinc.com>
---
 include/uapi/linux/nl80211.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index e9ccf43fe3c6..e53840d009d1 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1330,7 +1330,11 @@
  *      TID to Link mapping for downlink/uplink traffic.
  *
  * @NL80211_CMD_ASSOC_MLO_RECONF: For a non-AP MLD station, request to
- *      add/remove links to/from the association.
+ *      add/remove links to/from the association. To indicate link
+ *      reconfiguration request results from the driver, this command is also
+ *      used as an event to notify userspace about the added links information.
+ *      For notifying the removed links information, the existing
+ *      %NL80211_CMD_LINKS_REMOVED command is used.
  *
  * @NL80211_CMD_EPCS_CFG: EPCS configuration for a station. Used by userland to
  *	control EPCS configuration. Used to notify userland on the current state
-- 
2.17.1


