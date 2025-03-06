Return-Path: <linux-wireless+bounces-19841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCE7A542B4
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 07:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C453AC068
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 06:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F1419E966;
	Thu,  6 Mar 2025 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WrbrWZ7D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CA11362
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 06:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741242170; cv=none; b=fr9v0bHH5pOnQH0upnmaXJDB8ON2mDHfc3/qVqLt+LqAAGkq1jjgp9nYf6/4cxHvWQ0rIq9mPZgU9VgnXf5MbbyW9MP6spHYmgztpJgulzUlhRFIfnnDlEo3+OmYSB0UEQy5I2GrlzymzkxaG8PdtnLJg1ziQ8yWMEy2UF9BAyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741242170; c=relaxed/simple;
	bh=q6YlPTlB8De/fFpbf5DBR5GilZgmO8pmKfwuKJBCBqw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SSLBcg1UGOAmPzIspoe5N3m6PB7l8jq1sj8ZreXdo0M3itudMoTP9WrZNXciBae8cKriC9dJuPnZSVSaRcFLKpur5ng35m1pIFLXCfg+WY0d2OgO17MEcSbL989egEO87a03MF8A+jjdNm0mMn9pLQsJDwqYRJV9+TVD7ePZAKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WrbrWZ7D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525IUZkq030957;
	Thu, 6 Mar 2025 06:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XMJN+LxCQBPdoSbc8uMdhX
	4SF0lcfi7KfNT4z8CnZm0=; b=WrbrWZ7De0eLRWfsqyWvcSH3mVYZlaIB7w9E9L
	JBaU8esec/ze6ybVdGp2B6Jo6XjYPignwjx3pQZCqqFzUNBlde/cCqju/WjGoQ2K
	JeNRJ2EzV62vLE7Iq/upJRU9nGii/q8bHI04gwfHheOW1xr9Di2vzkT4peP7fkj4
	2YXz/EG0NnglhKkJH9nOTGV1qfw+QpLN4iut9Tj1noZ/f0490CtYJ39/mStFyC7/
	/WdOwG4FAGniscnSEbQK2fP79ahT1ZAQyUp9g0Vdz8XsRoSHCrr9JLSiELyecOP4
	RbDGgInWrPTzK+5+YOuzqrgfHn/8pjaIDSMS9vKOwduJXnqg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 456uy09jd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 06:22:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5266MHhc028488
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Mar 2025 06:22:17 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Mar 2025 22:22:16 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH wireless-next v4 0/4] wifi: cfg80211: update EML capabilities of an ML Station
Date: Thu, 6 Mar 2025 11:51:53 +0530
Message-ID: <20250306062157.1185769-1-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Pq5pbxM3 c=1 sm=1 tr=0 ts=67c93f1a cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=hCxGI5hFRZFY7DLbiS4A:9
X-Proofpoint-ORIG-GUID: oAr9v8_2vu-XJhsFgITcfhXEOo_QQtrf
X-Proofpoint-GUID: oAr9v8_2vu-XJhsFgITcfhXEOo_QQtrf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_03,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 mlxlogscore=877 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060045

From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

When EMLSR is enabled for an ML association, the EML capabilities
advertised by the ML Station needs to be updated to drivers in order to
trigger EMLSR operation.
Add support to fetch EML capabilities advertised by ML station and
cache it in ieee80211_sta data structure so that drivers can use them
whenever required.

*v4:
  - Fixed checkpatch warnings for line length exceeding 80 coloumns
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
 net/wireless/nl80211.c                | 16 +++++-
 8 files changed, 122 insertions(+), 3 deletions(-)


base-commit: 71f8992e34a9f358a53da6bfcd8b00226df177a2
-- 
2.34.1


