Return-Path: <linux-wireless+bounces-20888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C30A729CE
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 06:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC72173196
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 05:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96101BEF74;
	Thu, 27 Mar 2025 05:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bzSswRd5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE58D1C3BE6
	for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 05:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743052496; cv=none; b=UrHZ9OX5bB1+mxzvq2+H0Gc/AQgMAga6o/GwIp6AJoXYKaTWoSPiGcT9ML70FcfGTylPaNadWkfK7M09TUFzCJ2qv60qL96UxY5VzmDnkF7ugPz0o0xXJhYrvODHQNXQWbVrdn6lh9iOz2E0BdJKfy2a5RRXuQflO3yZjFTKhg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743052496; c=relaxed/simple;
	bh=dVTqn+yUKQbPTlnz1gdi1J/IWeWFKeeM58tTckHEgko=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AwybaDWTmw7R2/Fjkakp6rxLS/+X5czdfG/9bb4mE9zUH+pZp6Y8kPrFKiF4ZHlXgVdZxTjdXHAH+mpLI0Uz0iUbkdvOQaXctiEB8pu3XKgWFB9XVQS01ZoBxhU/qIPOBsms318kPn+kz1dtvRYfFpjWebLfC1kgeZT7Q6BySRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bzSswRd5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R4VUV9026118;
	Thu, 27 Mar 2025 05:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QUhOskaIDEpl/zvby6m6AW
	uEZxqSqFGZdP9G1J0Rm1s=; b=bzSswRd5Z6ncGLcN5MTs0dYJsiHGe9xof6Zo3m
	DEaoc1G25irXtqgUmcaJNVlsA3R/pFul6tyTaoUXWSKFBQ7y+ng5VC/MERnh+XGC
	UynHREEy8Si/n009xi3folhgnBMX7zR8opyCIKcrtyk9+8NdyBd/feMQHaxSWXTK
	s4pqMzosMDekuy3Ohsdjw3gkHNF4nDpo4ObSXbfDGR9pYgEPZT4NoC317+LbIrvT
	JA2BZmAg9FTTMzn99dNXenM4ygDyebipYq/v3S4hmb8u4fndTmxxKfijuE1ASsv6
	yjRz3W/e1hNjP6OROQLR1A+Db/+DuEfzuR3BGPp3TqkpzpCA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45m0xdvyue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 05:14:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52R5EKgv024338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 05:14:20 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Mar 2025 22:13:50 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
Subject: [PATCH wireless-next v5 0/4] wifi: cfg80211: update EML capabilities of an ML Station
Date: Thu, 27 Mar 2025 10:43:16 +0530
Message-ID: <20250327051320.3253783-1-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oCkAVn-efcgrr9SFrKXZIplwMTnUlbYK
X-Proofpoint-GUID: oCkAVn-efcgrr9SFrKXZIplwMTnUlbYK
X-Authority-Analysis: v=2.4 cv=Q43S452a c=1 sm=1 tr=0 ts=67e4dead cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=8LewXQ0cgpWvfN4UeSQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=996 malwarescore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270031

When EMLSR is enabled for an ML association, the EML capabilities
advertised by the ML Station needs to be updated to drivers in order to
trigger EMLSR operation.
Add support to fetch EML capabilities advertised by ML station and
cache it in ieee80211_sta data structure so that drivers can use them
whenever required.

*v5:
  - Restricted eml_capability change, if STA is already in
    ASSOCIATED state only for ML STA associated to AP interface.
*v4:
  - Fixed checkpatch warnings for line length exceeding 80 columns
  - Used unconverted values in PATCH 4/4 in print statement.

*v3:
   - Restricted eml_capability change, if STA is already in
     ASSOCIATED state
   - Added new PATCH (3/4) and defined helper functions to get
     EML delay and timeout values from eml capability
   - Used the helpers defined in PATCH 3/4 to fetch values in
     PATCH 4/4

*v2:
   - Added new flag eml_cap_present to indicate if EML attribute is
     present as part of new/set station command.

Ramasamy Kaliappan (3):
  wifi: cfg80211: Add support to get EMLSR capabilities of non-AP MLD
  wifi: mac80211: update ML STA with EML capabilities
  wifi: ath12k: update EMLSR capabilities of ML Station

Rameshkumar Sundaram (1):
  wifi: mac80211: Add helpers to fetch EMLSR delay and timeout values

 drivers/net/wireless/ath/ath12k/mac.c |  1 +
 drivers/net/wireless/ath/ath12k/wmi.c | 23 ++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h |  1 +
 include/linux/ieee80211.h             | 74 +++++++++++++++++++++++++++
 include/net/cfg80211.h                |  5 ++
 include/net/mac80211.h                |  2 +
 net/mac80211/cfg.c                    |  3 ++
 net/wireless/nl80211.c                | 17 ++++++
 8 files changed, 124 insertions(+), 2 deletions(-)


base-commit: 1794d7ab34d2221ac7eb921b171e75b856e10561
-- 
2.34.1


