Return-Path: <linux-wireless+bounces-3134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7440A849F78
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 17:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFA61C21A3C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 16:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAEE28DD0;
	Mon,  5 Feb 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="knT1MEFy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83AF28DD1
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150616; cv=none; b=IkG/LAizbZwOBGfP/rs4RXAgqQ7pRx2dgt9IMMeIlIW0etj4cVOyVMb0IO8/17aWrPWoImQ9uX2T2X5jBdDUBfsgALR6o7Sd8J67GJQhbXAg6AjxzMmHKBeCmWn688ZXkbdWFsVd/5GWNEw1gnoWR/hNk7NdQFUJwj2ARGx0NIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150616; c=relaxed/simple;
	bh=oLeKogeI5GfB5toZMcEEGEsSPP9Xtv1v4xuXXpCwwI4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FTl1bi7Z6CWGNzfavPpao9h5tTyvDiuf6UWCRAofDe6KVxHMFSnH6BIBE86OHlOYRbnLpm04ASoBGGdNKU0jVooy0iOPUztBB5t9QhOWLj3vGDpKnbmYLfKYrN4MtTJXFkEdAbDMr+PCQQPdL8xQyPTM4yLoTgAALfyvEUFYKEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=knT1MEFy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415GCPer021143;
	Mon, 5 Feb 2024 16:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=JzKuRVb
	tAP79+ylIb2f44gpDJMpuqtlbLqMJmqKLhR4=; b=knT1MEFyF3QpWYcNkYjhsdz
	qfSt3+fXymGyimx6UyU0KJrBIzboq9YCXnN6nAC5PRwfwa/pyk29y9Kkn37dGypf
	UPDSLe+Hccy/ok+mXo0CNXQEJB7mLHcxtTcH/RFSC4YUGHQz+B4AxWN5giqOg65a
	JcFd8V3iBFg1nxoWqg7d7Nd/jcKO4jt/8nK8R4A0y9c6l58dGSR2t6d+KKFzY5NX
	h+9ouKFVeplOENaz01KUepvuDUSI3Am8rHDCkaDrzVTiT+4ut9tgdwFVBEA6slli
	xjGnyP4sMmBKxVfQYIvrOnarjJWF1HTFQ8CkZ3WUbGm2sGsnKPOv20t/1MEYOeg=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2rvj9cuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 16:30:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415GUAOt023595
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 16:30:10 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 08:30:08 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 0/3] wifi: cfg80211/mac80211: add support to flush stations based on link ID
Date: Mon, 5 Feb 2024 21:59:49 +0530
Message-ID: <20240205162952.1697646-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-ORIG-GUID: R_CVGu1ZInrSaWSWWRQ6HH4yInj7ZcvJ
X-Proofpoint-GUID: R_CVGu1ZInrSaWSWWRQ6HH4yInj7ZcvJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=259 bulkscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050124

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
v2: * re-phrased commit message in 1/3, 2/3 and 3/3.
    * rebased on latest ToT

---
 include/net/cfg80211.h       |  3 +++
 include/uapi/linux/nl80211.h |  4 +++-
 net/mac80211/cfg.c           |  4 ++--
 net/mac80211/ibss.c          |  4 ++--
 net/mac80211/iface.c         |  2 +-
 net/mac80211/mesh.c          |  2 +-
 net/mac80211/mlme.c          |  2 +-
 net/mac80211/ocb.c           |  2 +-
 net/mac80211/sta_info.c      | 21 ++++++++++++++-------
 net/mac80211/sta_info.h      | 14 +++++++++++---
 net/wireless/nl80211.c       | 19 ++++++++++++++++++-
 net/wireless/trace.h         |  7 +++++--
 12 files changed, 62 insertions(+), 22 deletions(-)


base-commit: 679dd27b4ef33d4f596cbf450a3b2742fc54962a
-- 
2.25.1


