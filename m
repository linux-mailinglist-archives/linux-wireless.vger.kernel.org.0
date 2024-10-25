Return-Path: <linux-wireless+bounces-14483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEE39AF6EF
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 03:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FEC1C21692
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 01:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCCB13792B;
	Fri, 25 Oct 2024 01:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GVNPtT23"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1D42AA4
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 01:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820359; cv=none; b=k7mQI+88LH5eApu054gwIqJLKs10dE1HPSCKFYORtUQXJtPU6+rcAj9mLT6QCm5yk5ITnBjup3IVnLMDmQUFHwx2QziUXlI9LABM4IZv0KcDtd+PqLj2GIjH0fCqyiQt2yHXk4Uw6am5YA4eiVqjjn2X5aBgqK5BVh36DjkYjEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820359; c=relaxed/simple;
	bh=iqA41RXVs1xzczaDnxDFAPA3js1WSK3Q3cbBywEw+KI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iSpmpkquENksDzPfqOKOUgb1lYW6JUQU1zK4uiTNw4uXzXUk8brTv/YF/LuJwHVXCYeTsAKwQ0BrM0SXdmHERxapLLidJLAu82xp+yVW40iptedVSx8zlUHrRd8LuFAr0yzPgZmg30hTQ7PhmuxEBuGmHuA8uF08i9G5rxvL+m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GVNPtT23; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OJVn93007537;
	Fri, 25 Oct 2024 01:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dF5QLYqb/KyYW+MxWkALzv
	O3PgrmZyjPbBY15TO3K9s=; b=GVNPtT23UvVoQVBCXlIhMy0ECDSZUhqGq0Aqmo
	S4Xn9uL47f413S5R0Ff7Dj/4/+M6PoRMBRMRqn5vpiW0usRSICTjTivTDmPGLQUh
	YjPFss18vhDSToRmwMYu6lCrhk1HIiDpgQWL0UsD7gVwCSPosihn6mQhcqciOwbb
	qRjdWUtwZZ+Ff10yb+13aqNkgw1Lb75wzpK96+Ip+OMkE6201lFu0y3JNShnKRfM
	/JL8H7stxasz9+mPZpoRLUWDl0GN9as/RDmly1ihGW9hT1Mn29SbjD5qIASm5ZXk
	+3sNOs9B6IuFM2kD8R8GUPq4kQ+7NY3ucBxolHJhCpR2bXEA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42fk52j9d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 01:39:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49P1dC4b004166
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 01:39:12 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 24 Oct 2024 18:39:11 -0700
From: Muna Sinada <quic_msinada@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v2 0/2] MLO MBSSID Support
Date: Thu, 24 Oct 2024 18:38:55 -0700
Message-ID: <20241025013857.2793346-1-quic_msinada@quicinc.com>
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
X-Proofpoint-GUID: GPtBkOIUsa3cu27WXbBKpTnsj8xEKKL7
X-Proofpoint-ORIG-GUID: GPtBkOIUsa3cu27WXbBKpTnsj8xEKKL7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 adultscore=0 mlxlogscore=456 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250011

Enable MBSSID for Multi-link Operation.

For MLD if transmitting link of an MBSSID group is part of MLD then
link id of TX link BSS along with TX interface index has to be
specified. Add new MBSSID NL attribute to get link id of transmitting
vap link in case TX vap is an MLD

Additinaly for MLD, a pointer to Tx link BSS is needed by non-tx link
BSS. Currently mbssid_tx_vif is inside vif structure which won't
suffice for finding tx link for any non-tx link. Remove mbssid_tx_vif
and add mbssid_tx_bss to link conf.

Update ATH drivers to access mbssid_tx_bss member instead of
mbssid_tx_vif.

---
v2: addressed review comments
 - wifi: nl80211: add link id of transmitted profile for MLO MBSSID
	 - cleaned up commit message
	 - added link id value for non-MLO to documentation
	 - rewrote documentation for link id NL attibute
	 - cleaned up error path
	 - removed usage of tx_netdev
 - wifi: mac80211: restructure vif and link conf for mlo mbssid support
 	 - removed usage of mbssid_tx_vif and mbssid_tx_vif_linkid and added
	   link to Tx link BSS instead
	 - correct accessing rcu protected members

---
Rameshkumar Sundaram (2):
  wifi: nl80211: add link id of transmitted profile for MLO MBSSID
  wifi: mac80211: restructure vif and link conf for mlo mbssid support

 drivers/net/wireless/ath/ath11k/mac.c         | 26 ++---
 drivers/net/wireless/ath/ath12k/mac.c         | 24 ++---
 drivers/net/wireless/virtual/mac80211_hwsim.c |  2 +-
 include/net/cfg80211.h                        |  3 +
 include/net/mac80211.h                        |  6 +-
 include/uapi/linux/nl80211.h                  |  7 ++
 net/mac80211/cfg.c                            | 83 +++++++++++++---
 net/mac80211/ieee80211_i.h                    |  1 +
 net/mac80211/iface.c                          | 98 +++++++++++++++----
 net/wireless/nl80211.c                        | 43 +++++---
 net/wireless/sme.c                            |  4 +-
 11 files changed, 222 insertions(+), 75 deletions(-)

-- 
2.34.1


