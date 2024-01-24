Return-Path: <linux-wireless+bounces-2444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D134C83AAEB
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 14:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC19E1C20CDE
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A2077F04;
	Wed, 24 Jan 2024 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M2E8M/7F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7132077622
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102925; cv=none; b=YwhYkQ4g0/KPfgmsIA1uukyxt9TMd6l7s8wCBSP5dfqEbuiyZACwLnEaeXPEhGC7fIURN6X7SNr1lII95EtHVee7Ssxuej9gMmQqfamrTrZDG6MAY41lGpaHRuoUBmbuuSJsHF+jSUpZN5BBjgiDx795bALGN1umgap3Iik4Mic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102925; c=relaxed/simple;
	bh=pFgxJjJbnp0YLKAjOwfUw5bHtK1ARZCYwZVAIifnTzk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mQRVNuDl3NOKjmiHkWXiENwB7jAz8FKRV6iE1Yn5xoXvF/TDUf6P7n2bYcMA0rQ3X2qtKvd8/+WQMqLT/ZR9H4UpOWS6pL4zaEMS0JufZMNhhrunGysDKFw1ge/E+H7vEcREvfvmbRLLPxP32fIhn3sOz3i99Py+zE3h/qhN2oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M2E8M/7F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40OCYklL002320;
	Wed, 24 Jan 2024 13:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=j5R7vvd
	coSYowHa6GzIzCCZR6J/O1SdEfcFvAMYL6ck=; b=M2E8M/7F8YrMd+5cqtVNReM
	ZxYAZw85V6pCKYXa5wY89inLFtr3hGtoWrrK5Ie3aPYzUBklyYZ95TY3P6BADCjj
	ceaeGqHt94DjoS6gNt6fRVWFISJewPMHBdxDfoQFlnCYwei+66PlO74LoGUnWYNS
	xRqJk8wvakgeNDtR1Z/jjf5UBHkZ6BQ3diORGHkRrTdeesmdLnnKWKhZXDUc9STc
	paB5aBqhbg0m2rYhd+wl/lBgLPTiguDChhKM1P48bQ3eCMXSZPxX69YfMKaQeqFg
	RV0AAxv2/tRPISUcrVQ0vsr+302xaCtbZXhyArMeyvPxyO1gaeZx15cysLcsTYg=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vu1ccg964-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 13:28:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ODScBt032712
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 13:28:38 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Jan 2024 05:28:36 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 0/3] wifi: cfg80211/mac80211: add support to flush stations based on link ID
Date: Wed, 24 Jan 2024 18:58:11 +0530
Message-ID: <20240124132814.802018-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-ORIG-GUID: oPcA5RaAdX3Dtn54TjybE4fciYtB2V06
X-Proofpoint-GUID: oPcA5RaAdX3Dtn54TjybE4fciYtB2V06
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=242
 clxscore=1011 malwarescore=0 adultscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240097

Currently whenever sta_flush() function is called, it flushes all stations
connected to the given interface. However in case of MLO, all the links
would be using the same interface and hence at certain cases flushing all
stations is not desireable.

There is a need to flush the stations based on link ID. This series aims
to add support for the same.

Currently two cases are handled - 
1. During NL80211_CMD_DEL_STATION command handling. If this is called
   without any mac address, all stations present on that interfaces are
   flushed. More details in the patch [1/3]

2. During stopping link AP via ieee80211_stop_ap(). Again here, all
   stations are flushed. More details in the patch [3/3]

Aditya Kumar Singh (3):
  wifi: cfg80211: add support for link id attribute in
    NL80211_CMD_DEL_STATION
  wifi: mac80211: add link id argument for sta_flush() function
  wifi: mac80211: remove only own link stations during stop_ap
---
 include/net/cfg80211.h       |  3 +++
 include/uapi/linux/nl80211.h |  3 ++-
 net/mac80211/cfg.c           |  4 ++--
 net/mac80211/ibss.c          |  4 ++--
 net/mac80211/iface.c         |  2 +-
 net/mac80211/mesh.c          |  2 +-
 net/mac80211/mlme.c          |  2 +-
 net/mac80211/ocb.c           |  2 +-
 net/mac80211/sta_info.c      | 20 +++++++++++++-------
 net/mac80211/sta_info.h      | 14 +++++++++++---
 net/wireless/nl80211.c       | 18 +++++++++++++++++-
 net/wireless/trace.h         |  7 +++++--
 12 files changed, 59 insertions(+), 22 deletions(-)


base-commit: acf868ff60b1cd1f2e597f0b15aee2ff43f9fcd3
-- 
2.25.1


