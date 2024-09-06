Return-Path: <linux-wireless+bounces-12579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AD496EADB
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 08:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC401F24D9A
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 06:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD6213D537;
	Fri,  6 Sep 2024 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jnXSNCGO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C158145FFF
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605093; cv=none; b=fkF1yFncxgciaPWsFsWrvb/cufKpuENNvQl7NaW9sNoo2tWOpndCuNN/NYwpifhQxDlVmzCk8UM+7pTFW9dBXrGXVkkoNUxm/31v1Q438tcl42VNe1OMhKBC7Q3TF26kP+7hgMf/SXjO64E8cT4o5F3VnLHOl/yRSby2J6ED6+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605093; c=relaxed/simple;
	bh=0vU8e3v5F5oeXtlKyYnfJjGtEuF1A9KiI43ZMPpiQrU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kMb+q3vnD0RdKrAMyeLhEEBi+cBXdkd/6eTVgy0tpOSz6fjidjKCazL9v2NUTqY6BAP+6rv6uYBkMAV+mwaVc9f2GhL2/gP2JejvTKuHuU21nI3XCmcsybKsxyRglH+BAZDTJzcpDIz9JNXiZWOtL2oeyxZmTKuBTbLbtMHiSuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jnXSNCGO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IQ0il029435;
	Fri, 6 Sep 2024 06:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QSN/FMKvWqFAcZCBZULuNL
	EkPckrZLBHkUlvq2sPW0k=; b=jnXSNCGO5uiSNyfVbWnjGHHiKdMroHaMIfUW5E
	BIW4E6kUSV/V2It4Czj3w13RrOjqIoZX4YBUJHwUJz4gnZDH9dluE5aYeMefgmzf
	M/gAI5ksrr/s+htYA6r/5Bb0+7RwNDFaZRT1GGNtob0cW6/B+AAwtoMtagsKUu0s
	mJUZ6aAXyMDLEtH0Y0w4XlngKbr6ABIAjIPxVyD4572cMsTPfBC4C+RQiCtpD9sw
	qQy44Z/BA54Hy4cT+AkapK04z9k7AvckcVedzigF9wub9RwtzkICZ0xjMnCYwawg
	nBSxyufBb8QJFRVcJG/ZNwCu3aNmJAc/JBWESta4qMuJ4qIA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwtsbdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 06:44:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4866ii0s020330
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 06:44:44 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Sep 2024 23:44:42 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v6 0/8] wifi: cfg80211/mac80211: add DFS support for MLO
Date: Fri, 6 Sep 2024 12:14:18 +0530
Message-ID: <20240906064426.2101315-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5RfaE1arn-H3Hw9C-kBP8bOoUBTYK1NV
X-Proofpoint-ORIG-GUID: 5RfaE1arn-H3Hw9C-kBP8bOoUBTYK1NV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060048

Currently, Dynamic Frequency Selection (DFS) and its related radar events
are supported only for non-MLO case where deflink (or link_id 0) is always
considered. However, with MLO in place, there is need to handle DFS in
per-link manner instead of always handling it on per device.

Add support to handle DFS interference related events per-link basis.

Aditya Kumar Singh (8):
  Revert "wifi: mac80211: move radar detect work to sdata"
  wifi: mac80211: remove label usage in
    ieee80211_start_radar_detection()
  wifi: trace: unlink rdev_end_cac trace event from wiphy_netdev_evt
    class
  wifi: cfg80211: move DFS related members to links[] in wireless_dev
  wifi: cfg80211: handle DFS per link
  wifi: mac80211: handle DFS per link
  wifi: cfg80211/mac80211: use proper link ID for DFS
  wifi: mac80211: handle ieee80211_radar_detected() for MLO
---
v6: * Rebased on ToT
    * No changes in 1-5 and 7.
    * used link instead of link_data in 6.
    * Used link to get conf.
    * Removed unnecessary typecast in patch 8 function
      ieee80211_radar_mark_chan_ctx_iterator().

v5: * No changes in 1-7.
    * Fixed sparse warning in 8.

v4: * Rebased on ToT
    * No other changes in [1-7]
    * Removed local linked list usage and refactored code to directly
      cancel and notify while iterating over radar detected channel
      context [8]

v3: * Rebased on ToT
    * 12-digit sha1 in [1/8]
    * moved trivial preparation patches on top.
    * changed radar detection handling logic in [8/8]
    * minor commit text changes in in [5/8], [6/8]
    * removed patch [v2 9/9]

v2: * No changes except patch [6/9].
    * In [6/9], removed usage of label and directly used return statements
---
 
 drivers/net/wireless/ath/ath10k/debug.c       |  4 +-
 drivers/net/wireless/ath/ath10k/mac.c         |  2 +-
 drivers/net/wireless/ath/ath10k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath12k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath9k/dfs.c          |  2 +-
 drivers/net/wireless/ath/ath9k/dfs_debug.c    |  2 +-
 drivers/net/wireless/marvell/mwifiex/11h.c    | 11 +--
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  6 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_dfs.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  2 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  2 +-
 .../net/wireless/quantenna/qtnfmac/event.c    | 12 +--
 drivers/net/wireless/ti/wl18xx/event.c        |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  2 +-
 include/net/cfg80211.h                        | 25 +++---
 include/net/mac80211.h                        |  5 +-
 net/mac80211/cfg.c                            | 49 +++++++-----
 net/mac80211/chan.c                           |  1 +
 net/mac80211/ieee80211_i.h                    |  8 +-
 net/mac80211/iface.c                          |  8 +-
 net/mac80211/link.c                           | 12 +++
 net/mac80211/mlme.c                           | 13 +--
 net/mac80211/pm.c                             |  2 +-
 net/mac80211/scan.c                           |  6 +-
 net/mac80211/util.c                           | 80 ++++++++++++++-----
 net/wireless/ibss.c                           |  2 +-
 net/wireless/mesh.c                           |  2 +-
 net/wireless/mlme.c                           | 20 ++---
 net/wireless/nl80211.c                        | 33 +++++---
 net/wireless/rdev-ops.h                       | 13 +--
 net/wireless/reg.c                            | 19 +++--
 net/wireless/trace.h                          | 40 +++++++---
 35 files changed, 254 insertions(+), 145 deletions(-)


base-commit: 43b7724487109368363bb5cda034b3f600278d14
-- 
2.34.1


