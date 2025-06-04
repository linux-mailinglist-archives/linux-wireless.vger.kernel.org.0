Return-Path: <linux-wireless+bounces-23697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C5FACDC37
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 12:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF233A1832
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 10:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F12828D839;
	Wed,  4 Jun 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iGxlsu1x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4665319F480
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749034699; cv=none; b=kqj6vlprEUkOgSnTTEryj2THikPMM/xI6JxaDNt43AZLC0sDn64NwY7Wt9U416tEaSoBYPQGroUTT+MaaEgFr2oVxeE/yWn47wXp7Z+v/TTPfrhSRmDFa+mAl5NFleLFLMZVjlWwRf4X5fYMMArAFrg6LPnJt0OwNeXV9KC1y/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749034699; c=relaxed/simple;
	bh=gY0mJOctRn86jRtTUezyzhNzvmP6GbNfy7Ile3+JwQE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mgqfCRrLYRSm1D0+rZurbSKS/rXW0iPsBI5eSg9hiFoc3VBd/LyYCVm/1jPvCLXAfFI5S2q7GtAU+4zVu3fq7tEB8WwgUEQMmY2x+sapOgpee9t0w3hXDJIB7dLGFc9nEN1PYP0Q8MWzi+DuVcd7CWhRIdMvl5ayz0BzTnzt/WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iGxlsu1x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5547Akia010398;
	Wed, 4 Jun 2025 10:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=yyIgCqg3yOxjD8Kzbl4OoNq0RycawEE3A7NAaE9LKGU=; b=iG
	xlsu1x7D4oJbT7leSHW6Edt1ClANKoo65+IgLMDEiXZI/F1cGheK5+NpfDAtKN3C
	Q5QVsuBYm3yPKXe7lauOF0fLdXcM8YBRtRCa6Lwkvmlcck/5Q3/brsVpmzamsKvr
	EkWW+JgPIlSBI65jzx4IUxWeJR3rhcjAnKpKniCWslvihzSG6XBLaN4giY4eqJik
	g2CaHI/rzospMmwBgNLPxn5BrKKqPaCFJ3xJFdLXBPa+QAHr70bmUNC5k59LPz4D
	42RPrIFrRSWP6bGc8wpfnGjLA9W/HXVD+kkAhsZ/IsDAWpXAcDQMuUiKaFLgzgXm
	4BV6ErWe8PktEnmQ4pcQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8yns5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 10:58:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 554AwCq6002699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Jun 2025 10:58:12 GMT
Received: from hu-kkavita-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Jun 2025 03:58:11 -0700
From: Kavita Kavita <quic_kkavita@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_kkavita@quicinc.com>
Subject: [PATCH wireless-next 0/2] wifi: cfg80211: Add support for link reconfiguration offload to driver
Date: Wed, 4 Jun 2025 16:27:55 +0530
Message-ID: <20250604105757.2542-1-quic_kkavita@quicinc.com>
X-Mailer: git-send-email 2.17.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA4MyBTYWx0ZWRfX/EqEQZAhJ0/D
 6BRePyHn3Wz8OZFhaKtsVeRlkiUVCZVEG3FAmzNKXBr9krKdEq5bTGMys84/MsKRrnAa0/6uvNl
 dLpjNYJJ5G58xKhHGh/MDJfBo/gzeltBevbt2K15OZgU7mTOUPr2RnnEacl7oYZwauujperbxGY
 WH3Y6/+KZkPhED4bHUD2FBhKIwMIOkV/QqZon5pFje16/khbd8xowIiQ310QHdo2rzx447XygkA
 JVS51kWIq5BmcwvioDWIKIcBp6FynP9UnJaYKKGLIPwB6Sk41ucoYeLj2yikIhBpGNtWH9TlYhV
 mt4FJBevvsyu41Vpxp3FwCE6XJIfT5WeG+0XoMHCwkfzlM1CbGHJof7jG0hdK634X1CMav10Xu+
 suVVwqsvtogbuRvJ75EUyPu0YiJ3uqlO/kXxkGz5MGCP9fUortyrkFQxNV5Lc+rDfnEO9XXt
X-Proofpoint-ORIG-GUID: ch5cRyvh9enPrZvR59nMN7bqVx5zOhrM
X-Proofpoint-GUID: ch5cRyvh9enPrZvR59nMN7bqVx5zOhrM
X-Authority-Analysis: v=2.4 cv=T/uMT+KQ c=1 sm=1 tr=0 ts=684026c5 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=WPqYBIgJSKlNBoNPAVMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=846 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040083

This patch series adding below changes:
- Add detailed documentation for how the link reconfiguration results
  are indicated from the driver for user initiated link
  reconfiguration requests.
- Extend link reconfiguration result event path to support AP-initiated
  link reconfiguration results for the SME-in-driver cases.

Kavita Kavita (2):
  wifi: cfg80211: Improve the documentation for
    NL80211_CMD_ASSOC_MLO_RECONF
  wifi: cfg80211: Add support for link reconfiguration negotiation
    offload to driver

 include/net/cfg80211.h       |  6 ++++++
 include/uapi/linux/nl80211.h | 10 +++++++++-
 net/wireless/mlme.c          | 10 ++++++++--
 net/wireless/trace.h         | 10 ++++++----
 4 files changed, 29 insertions(+), 7 deletions(-)


base-commit: 1b98f357dadd6ea613a435fbaef1a5dd7b35fd21
-- 
2.17.1


