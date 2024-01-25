Return-Path: <linux-wireless+bounces-2484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74F883C325
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 14:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B08E291B5F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841BD58238;
	Thu, 25 Jan 2024 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FnbJXply"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8925821E
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187873; cv=none; b=tFhOtiFQHxkoSkAnP1TNDPkQrnFAXzLgvP8uEPBclGhLWNzRbuWdOn5LgOterRYViLhCBXdVTeeudphJZtlt9ed+cY8Dlcw4A5XP9XnDQVgNwPlj7c6p5MQKnr9l/AlHAo1V26vjm94KJoc0RP7l6HQrB2nLzm7dBmbZs6rfYnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187873; c=relaxed/simple;
	bh=z4fDd7VydTCmzMMNuxoFI69jt4wfa9Zticx/FrHQy1A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ao6K/QXPVxboF1wArA0W/jObSha8he95uIWaFGRfrcClfrFa7cI0Z7QqTmNmA+Rx/QvMJJuMB1UtLbcoK33deoeX5grCJlDPC/LgW7DNUPSHuLNABibclsspE/zw97ciKWtVenzq1TMczUiwQxSSIw8MCmmhzGYKUcCz79O62VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FnbJXply; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PAiutB011725;
	Thu, 25 Jan 2024 13:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=rh3NHLa
	hH101m1s1xoOMCFiIzb2kS7NxNhtDbyK52Yc=; b=FnbJXply5dyhv8Or9tp2A3X
	c9RAAzNKxEY31o0dAItoxMogH6fEqgX8BDewDRbqn2ARuWJ+qV6lAL78r30vYui/
	TTGTivnVOSwRFnhJ+N0GFj49ysx1R7AU1R4lNYZB9yCPMX8ALGbSvSyucWi4+l+o
	qqyvyUcBukzTrSns/w8pwIr02zxoFhwjCmRLJ98oUquY4POBZWZQD58DcCSmSsHt
	8LwIpcvBVr6nemU0nfbAJTAovRCUG9Sww3e8jAyNySq3Du5s3gr6OVlMVpokjXbI
	nzspGDXp1lCxZWBnl3ZSbzFaF6wGzHd2dk+ZoKIqBib4oTYqUUTSGdrU8c6tjLw=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vup5crgac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 13:04:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PD4RiZ016009
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 13:04:27 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jan 2024 05:04:25 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v5 0/3] wifi: cfg80211/mac80211: add link_id handling in AP channel switch during Multi-Link Operation
Date: Thu, 25 Jan 2024 18:34:07 +0530
Message-ID: <20240125130410.827701-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: nryKd1orK26oF2ioH4QFY6Z2i3r1jwsT
X-Proofpoint-ORIG-GUID: nryKd1orK26oF2ioH4QFY6Z2i3r1jwsT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_08,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=742 clxscore=1015
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250090

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
v5: * fixed compilation issue reported by kernel test robot.

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
 drivers/net/wireless/mediatek/mt76/mac80211.c |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |   2 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |   2 +-
 drivers/net/wireless/ti/wlcore/event.c        |   2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |   2 +-
 include/net/cfg80211.h                        |   3 +
 include/net/mac80211.h                        |   7 +-
 net/mac80211/cfg.c                            | 110 +++++++++++-------
 net/mac80211/tx.c                             |  14 ++-
 net/wireless/nl80211.c                        |   1 +
 net/wireless/trace.h                          |   7 +-
 22 files changed, 112 insertions(+), 68 deletions(-)


base-commit: acf868ff60b1cd1f2e597f0b15aee2ff43f9fcd3
-- 
2.25.1


