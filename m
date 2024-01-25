Return-Path: <linux-wireless+bounces-2459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10C783B92C
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 06:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0FB1C22965
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 05:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C35A101D4;
	Thu, 25 Jan 2024 05:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MSYY5zbX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A8101CE
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 05:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706161870; cv=none; b=ptx70IesQ9wlDZF3IIQh9NiARzkLIZ3hRHypnM8dY6+UChK2VJMZrUkActyomP0dhwHrBZwUeGQq7sAYftvcSTRxs6UB2zHKk9d/2bWeFJedCidtx2z9rEVk1jrUqDElYLWMFu2LlEO5f7zcirafvii3PLkttPm+La4iHxyYqQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706161870; c=relaxed/simple;
	bh=VSTtyMJksoNakMNY8uAc3hTZYYEgNKysqBjIj1UVGZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pDglTccyjQTLys8cC23uThGXALFT7lMeHmE8Y6RIdXeQin5hRYWAT7drA1Qb6CXChGRK2VkFWWAQmOSiw6VJvJrEUWHdrbx56/58LN4hBbqNprsLIpvF7BAwINMXYpclQANnotb/RC+EO+6kawTpV3rpOh2/LFQMGCqEMB67Fik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MSYY5zbX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P58iL5007545;
	Thu, 25 Jan 2024 05:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=BZDnaiT
	ZDBqXeCRXc88PbtK5+KFkkPa7dSFpckohPMQ=; b=MSYY5zbXUiQwaVRFn1gqGVr
	TsZ95cPtix62lo70rd6Xe2XbXsg17rGmeraRnLqigbOKBaKM14JpCG4XKu51qeI7
	Kbh+Bv8mrd4F4WfUxOpGGYpHsNoEvnATtZ63Ucs0dEvrkq2jcgckshrvY6gN1NSm
	1uYNarac6lpitsdy0LlNewbFlvTwWKbqB8ri5VyEFwoyfrb5fY3hykgy7zUo/ddG
	hFZtfpnBdJompKBSvpVSyaj4bi0ddK/rCptYz9CdN0KtYBFJZOzwK1v+4l6PFzAQ
	ub3pyza1qClJ3FSvmzi2PtYaahwzxfRhMxYrtMKs9jc8yPvnzgLWmE2MUmPY/0w=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vufc809a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 05:51:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40P5p2UA025273
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 05:51:02 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Jan 2024 21:51:00 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v4 0/3] wifi: cfg80211/mac80211: add link_id handling in AP channel switch during Multi-Link Operation
Date: Thu, 25 Jan 2024 11:20:36 +0530
Message-ID: <20240125055039.826200-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 8JVENyZgWlw6IU8b-K_d4EtpLqN9eWGT
X-Proofpoint-GUID: 8JVENyZgWlw6IU8b-K_d4EtpLqN9eWGT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_02,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=726 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250037

Currently, during channel switch, deflink (or link_id 0) is always
considered. However, with Multi-Link Operation (MLO), there is a
need to handle link specific data structures based on the actual
operational link_id during channel switch operation.

Hence, add support for the same. Non-MLO based operations will use
link_id as 0 or deflink member as applicable.

While at it, beacon count down now needs to be updated on proper
link_id's beacon, do that as well.

Aditya Kumar Singh (3):
  wifi: cfg80211: send link id in channel_switch ops
  wifi: mac80211: add support for AP channel switch with MLO
  wifi: mac80211: update beacon counters per link basis
---
v4: * fixed compilation issue reported by kernel test robot.
    * rebased on latest ToT.
    * moved link_id arguement into csa_params struct in [1/3]

v3: * splitted [v2 1/2] into [v3 1/3] and [v3 2/3] having simple cfg80211
      changes in 1/3 for easy review. Rest in 2/3 [Johannes]
    * used wiphy_dereference() instead of sdata_dereference() [Johannes]

v2: * reabsed on ToT
    * removed unwanted locking sequence during cancelling CSA work handler
      since now locking is moved to wiphy level, that part is uncessary now.
---
 drivers/net/wireless/ath/ath10k/mac.c         |   4 +-
 drivers/net/wireless/ath/ath10k/wmi.c         |   2 +-
 drivers/net/wireless/ath/ath11k/mac.c         |   2 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |   2 +-
 drivers/net/wireless/ath/ath12k/wmi.c         |   2 +-
 drivers/net/wireless/ath/ath9k/beacon.c       |   2 +-
 .../net/wireless/ath/ath9k/htc_drv_beacon.c   |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   6 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   2 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |   3 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |   2 +-
 drivers/net/wireless/ti/wlcore/event.c        |   2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |   2 +-
 include/net/cfg80211.h                        |   3 +
 include/net/mac80211.h                        |   7 +-
 net/mac80211/cfg.c                            | 110 +++++++++++-------
 net/mac80211/tx.c                             |  14 ++-
 net/wireless/nl80211.c                        |   1 +
 net/wireless/trace.h                          |   7 +-
 22 files changed, 113 insertions(+), 68 deletions(-)


base-commit: acf868ff60b1cd1f2e597f0b15aee2ff43f9fcd3
-- 
2.25.1


